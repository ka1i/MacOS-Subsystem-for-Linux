# linux_virtual_machine
Boot Linux VMs in a single command on macOS using the new [Virtualization.framework](https://developer.apple.com/documentation/virtualization)

官方文档说明：[Documentation > Virtualization > Running Linux in a Virtual Machine](https://developer.apple.com/documentation/virtualization/running_linux_in_a_virtual_machine)

## setup
```
git clone https://github.com/ka1i/linux-virtual-machine.git --recurse-submodules
```

## build
```
make
```

## Run
+ example:[fedora:34](https://mirrors.ustc.edu.cn/fedora/releases/34/Everything/x86_64/os/images/pxeboot/)
kernel+initrd+storage
```
./bin/linux_virtual_machine -k vmlinuz -i initrd.img -s rootfs.img -c "console=hvc root=/dev/vda"
```
kernel+storage
```
./bin/linux_virtual_machine run -k vmlinuz -s rootfs.img -c "console=hvc root=/dev/vda"
```

## Credits

Huge credit to [Khaos Tian](https://github.com/KhaosT) who inspired this project by the creation of [SimpleVM](https://github.com/KhaosT/SimpleVM). & [https://github.com/kendfinger/virtual](https://github.com/kendfinger/virtual)
