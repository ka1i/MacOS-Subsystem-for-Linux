//
//  VirtualSystem.swift
//  virtual
//
//  Created by Kenneth Endfinger on 7/28/20.
//

import Foundation
import Virtualization

public class VirtualSystem {
    var kernel: URL // "linux kernel: vmlinuz"
    var initrd: URL // "linux rootfs: initrd.img"

    public init(kernel: URL,initrd: URL){
        self.kernel = kernel
        self.initrd = initrd
    }

    public func show(){
        print(kernel)
        print(initrd)
    }
}
  