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
    var kernel: URL // "linux kernel: vmlinuz"
    var initrd: URL // "linux rootfs: initrd.img"
    let configuration = VZVirtualMachineConfiguration()

    public init(kernel: URL,initrd: URL){
        self.kernel = kernel
        self.initrd = initrd
    }

    public func configure(){
        self.configuration.cpuCount = 2
        self.configuration.memorySize = 2 * 1024 * 1024 * 1024 // 2 GiB
        self.configuration.serialPorts = [ createConsoleConfiguration() ]
        self.configuration.bootLoader = LinuxBootLoader(kernelURL: kernel, initrdURL: initrd)
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

    private func createConsoleConfiguration() -> VZSerialPortConfiguration {
        let consoleConfiguration = VZVirtioConsoleDeviceSerialPortConfiguration()

        let inputFileHandle = FileHandle.standardInput
        let outputFileHandle = FileHandle.standardOutput

        // Put stdin into raw mode, disabling local echo, input canonicalization,
        // and CR-NL mapping.
        var attributes = termios()
        tcgetattr(inputFileHandle.fileDescriptor, &attributes)
        attributes.c_iflag &= ~tcflag_t(ICRNL)
        attributes.c_lflag &= ~tcflag_t(ICANON | ECHO)
        tcsetattr(inputFileHandle.fileDescriptor, TCSANOW, &attributes)

        let stdioAttachment = VZFileHandleSerialPortAttachment(fileHandleForReading: inputFileHandle,
                                                           fileHandleForWriting: outputFileHandle)

        consoleConfiguration.attachment = stdioAttachment

        return consoleConfiguration
    }

    private func LinuxBootLoader(kernelURL: URL, initrdURL: URL) -> VZBootLoader {
        let bootLoader = VZLinuxBootLoader(kernelURL: kernelURL)
        bootLoader.initialRamdiskURL = initrdURL

        let kernelCommandLineArguments = [
            // Use the first virtio console device as system console.
            "console=hvc0",
            // Stop in the initial ramdisk before attempting to transition to the root file system.
            "rd.break=initqueue"
        ]

        bootLoader.commandLine = kernelCommandLineArguments.joined(separator: " ")

        return bootLoader
    }
}
