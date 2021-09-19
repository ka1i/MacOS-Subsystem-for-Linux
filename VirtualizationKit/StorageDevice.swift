import Foundation
import Virtualization

public func StorageDevice(storage: [String]) -> [VZStorageDeviceConfiguration] {
    var storageDevice: [VZStorageDeviceConfiguration] = []
    do {
        for vda in storage{
            let disk = URL(fileURLWithPath: vda, isDirectory: false)
            let blockAttachment = try VZDiskImageStorageDeviceAttachment(url: disk, readOnly: false)
            let blockDevice = VZVirtioBlockDeviceConfiguration(attachment: blockAttachment)
            storageDevice.append(blockDevice)
        }       
    } catch {}
    return storageDevice
}
