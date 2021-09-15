//
//  VirtualSystem.swift
//  virtual
//
//  Created by Kenneth Endfinger on 7/28/20.
//

import Foundation
import Virtualization

class Delegate: NSObject {
}

extension Delegate: VZVirtualMachineDelegate {
    func guestDidStop(_ virtualMachine: VZVirtualMachine) {
        print("The guest shut down. Exiting.")
        exit(EXIT_SUCCESS)
    }
}


public class VirtualSystem {
    var kernel: URL
    var initrd: URL
    var storage: URL

    let configuration = VZVirtualMachineConfiguration()

    public init(kernel: URL, initrd: URL, storage: URL){
        self.kernel = kernel
        self.initrd = initrd
        self.storage = storage
    }

    public func configure(){
        let entropy = VZVirtioEntropyDeviceConfiguration()
        let memoryBalloon = VZVirtioTraditionalMemoryBalloonDeviceConfiguration()

        self.configuration.cpuCount = 2
        self.configuration.memorySize = 2 * 1024 * 1024 * 1024 // 2 GiB
        self.configuration.serialPorts = [ LinuxTerminalSerial() ]
        self.configuration.bootLoader = LinuxBootLoader(kernelURL: kernel, initrdURL: initrd)
        self.configuration.entropyDevices = [ entropy ]
        self.configuration.storageDevices = SystemStorageDevice()
        self.configuration.memoryBalloonDevices = [ memoryBalloon ]
        do {
            try self.configuration.validate()
        } catch {
            print("Failed to validate the virtual machine configuration. \(error)")
            exit(EXIT_FAILURE)
        }
    }

    public func system(){
        let virtualMachine = VZVirtualMachine(configuration: self.configuration)
        let delegate = Delegate()
        virtualMachine.delegate = delegate
        virtualMachine.start { (result) in
            if case let .failure(error) = result {
                print("Failed to start the virtual machine. \(error)")
                exit(EXIT_FAILURE)
            }
        }
        RunLoop.main.run(until: Date.distantFuture)
    }

    private func LinuxTerminalSerial() -> VZSerialPortConfiguration {
        let serial = VZVirtioConsoleDeviceSerialPortConfiguration()

        let stdin = FileHandle.standardInput
        let stdout = FileHandle.standardOutput

        serial.attachment = VZFileHandleSerialPortAttachment(fileHandleForReading: stdin,fileHandleForWriting: stdout)

        return serial
    }

    private func LinuxBootLoader(kernelURL: URL, initrdURL: URL) -> VZBootLoader {
        let bootLoader = VZLinuxBootLoader(kernelURL: kernelURL)
        bootLoader.initialRamdiskURL = initrdURL

        let kernelCommandLineArguments = [
            // Use the first virtio console device as system console.
            "console=hvc0,115200",
            // Stop in the initial ramdisk before attempting to transition to the root file system.
            "rd.break=initqueue",
            "root=/dev/vda"
        ]

        bootLoader.commandLine = kernelCommandLineArguments.joined(separator: " ")
        return bootLoader
    }

    private func SystemStorageDevice() -> [VZStorageDeviceConfiguration] {
        var storageDevice: [VZStorageDeviceConfiguration] = []
        do {
            let blockAttachment = try VZDiskImageStorageDeviceAttachment(url: self.storage, readOnly: false)
            let blockDevice = VZVirtioBlockDeviceConfiguration(attachment: blockAttachment)
            storageDevice.append(blockDevice)
        } catch {}
        
        return storageDevice
    }
}
