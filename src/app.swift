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

    @Argument(help: "linux storage file")
    var storage: String?

    mutating func run() throws {
        if version {
            showVer()
            return
        }
        if (kernel != nil) && (initrd != nil) && (storage != nil) {
            if let k = kernel, let i = initrd, let s = storage{
                let vmlinuz = URL(fileURLWithPath: k, isDirectory: false)
                let initfs = URL(fileURLWithPath: i, isDirectory: false)
                let rootfs = URL(fileURLWithPath: s, isDirectory: false)
                
                let vs = VirtualSystem(kernel: vmlinuz,initrd: initfs,storage: rootfs)
                vs.configure()
                vs.system()
            }
        }
    }
}
