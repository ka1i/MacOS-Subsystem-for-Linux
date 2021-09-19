import Foundation
import Virtualization

public func Configure(kernel:String, initrd:String, storage:[String], cmdline:String,processors:UInt64, memory:UInt64,network: Bool) -> VZVirtualMachineConfiguration {
    let configuration = VZVirtualMachineConfiguration()
    let entropy = VZVirtioEntropyDeviceConfiguration()
    let memoryBalloon = VZVirtioTraditionalMemoryBalloonDeviceConfiguration()
        
    configuration.cpuCount = Int(processors)
    configuration.memorySize = memory * 1024 * 1024 // memory(M)
    configuration.serialPorts = [ TerminalSerial() ]
    if !storage.isEmpty {
        configuration.storageDevices = StorageDevice(storage:storage)
    }
    if network {
        configuration.networkDevices = [NetworkDevice()]
    }
    configuration.bootLoader = BootLoader(kernel: kernel, initrd: initrd, cmdline:cmdline)
    configuration.entropyDevices = [ entropy ]
    configuration.memoryBalloonDevices = [ memoryBalloon ]
    do {
        try configuration.validate()
    } catch {
        print("configure lvm failed. \(error)")
        exit(EXIT_FAILURE)
    }
    return configuration
}
