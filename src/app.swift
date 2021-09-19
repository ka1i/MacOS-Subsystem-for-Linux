import Foundation
import ArgumentParser
import VirtualizationKit

public class App {
    public init(){
        struct Flags: ParsableCommand {
            static var configuration = CommandConfiguration(
                commandName: "linux-virtual-machine",
                abstract: "Linux Virtual Machine for MacOS",
                subcommands: [
                    appRun.self
                ]
                //defaultSubcommand: appUsage.self
            )
            @OptionGroup()
            var version: Version
        }
        Flags.main()
    }

    public func lvm() -> Int32 {
        showVer()
        print("plz check argument: [-h]")
        return 0
    }
}

struct appRun: ParsableCommand {
    static var configuration = CommandConfiguration(
    commandName: "run",
    abstract: "Run a Linux Virtual Machine"
  )

    @Option(name: .shortAndLong, help: "kernel file")
    var kernel: String = "vmlinuz"

    @Option(name: .shortAndLong, help: "initrd file")
    var initrd: String = ""

    @Option(name: .shortAndLong, help: "storage image")
    var storage: [String] = []

    @Option(name: .shortAndLong, help: "Kernel Command Line")
    var cmdline: String = "console=hvc0,115200"

    @Option(name: .shortAndLong, help: "CPU Core")
    var processors: UInt64 = 2

    @Option(name: .shortAndLong, help: "Memory Size")
    var memory: UInt64 = 2048

    @Flag(name: .shortAndLong, help: "Enable NAT Networking")
    var network: Bool = false

    // if not specified, will generate at random
    @Option(name: [.customShort("a"), .long], help: "MAC Address")
    var macaddr: String = ""

    @OptionGroup()
    var version: Version

    mutating func run() throws {
        let vs = VirtualKit(kernel: kernel,initrd: initrd,storage: storage, cmdline: cmdline)
        vs.performance(processors: processors, memory: memory)
        vs.peripherals(network:network)
        vs.lvm()
    }
}
