import Foundation
import Virtualization

class Delegate: NSObject {}

extension Delegate: VZVirtualMachineDelegate {
    func guestDidStop(_ virtualMachine: VZVirtualMachine) {
        print("The guest shut down. Exiting.")
        exit(EXIT_SUCCESS)
    }
}
