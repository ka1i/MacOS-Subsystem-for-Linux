import Foundation
import Virtualization

public func NetworkDevice() -> VZVirtioNetworkDeviceConfiguration {
    let networkDevice = VZVirtioNetworkDeviceConfiguration()
    networkDevice.attachment = VZNATNetworkDeviceAttachment()
    return networkDevice
}