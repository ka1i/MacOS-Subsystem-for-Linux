import Foundation
import Virtualization

public func BootLoader(kernel: String, initrd: String, cmdline:String) -> VZBootLoader {
    let kernelURL = URL(fileURLWithPath: kernel, isDirectory: false)
    let bootLoader = VZLinuxBootLoader(kernelURL: kernelURL)

    if !initrd.isEmpty {
        let initrdURL = URL(fileURLWithPath: initrd, isDirectory: false)
        bootLoader.initialRamdiskURL = initrdURL
    }

    // let kernelCommandLineArguments = [
    // // Use the first virtio console device as system console.
    // "console=hvc0,115200",
    // // Stop in the initial ramdisk before attempting to transition to the root file system.
    // // "rd.break=initqueue",
    // "root=/dev/vda"
    // ]

    bootLoader.commandLine = cmdline
    return bootLoader
}