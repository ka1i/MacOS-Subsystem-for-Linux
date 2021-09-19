import Foundation
import Virtualization

public class VirtualKit {
    var kernel: String
    var initrd: String
    var storage: [ String ]
    var cmdline: String

    var processors: UInt64 = 2
    var memory: UInt64 = 2048

    var network: Bool = false

    let configuration = VZVirtualMachineConfiguration()

    public init(kernel: String, initrd: String, storage: [ String ], cmdline: String){
        self.kernel = kernel
        self.initrd = initrd
        self.storage = storage
        self.cmdline = cmdline
    }

    public func performance(processors:UInt64, memory:UInt64){
        self.processors = processors
        self.memory = memory
    }

    public func peripherals(network: Bool){
        self.network = network
    }

    public func lvm(){
        let configuration = Configure(kernel:kernel,initrd:initrd,storage:storage,cmdline:cmdline,processors:processors,memory:memory,network: network)
        let virtualMachine = VZVirtualMachine(configuration: configuration)
        
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
}
