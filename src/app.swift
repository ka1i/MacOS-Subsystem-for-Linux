import Foundation
import ArgumentParser
import VirtualizationKit

struct LinuxVirtualMachine: ParsableCommand {
    static var configuration = CommandConfiguration(
        commandName: "linux-virtual-machine",
        abstract: "Run a Linux Virtual Machine on MacOS"
    )

    @Flag(name: .shortAndLong,help: "Show app version.")
    var version:Bool = false

    @Argument(help: "linux kernel file")
    var kernel: String?

    @Argument(help: "linux initrd file")
    var initrd: String?

    mutating func run() throws {
        if version {
            showVer()
            return
        }
        if (kernel != nil) && (initrd != nil) {
            if let k = kernel,let i = initrd {
                let vmlinuz = URL(fileURLWithPath: k, isDirectory: false)
                let rootfs = URL(fileURLWithPath: i, isDirectory: false)
                
                let vs = VirtualSystem(kernel: vmlinuz,initrd: rootfs)
                vs.show()
            }
        }
    }
}
