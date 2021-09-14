# linux_virtual_machine
Boot Linux VMs in a single command on macOS using the new [Virtualization.framework](https://developer.apple.com/documentation/virtualization)

## build
```
make
```

## Run
+ example:[fedora:34](https://mirrors.ustc.edu.cn/fedora/releases/34/Everything/x86_64/os/images/pxeboot/)

```
./bin/linux_virtual_machine vmlinuz initrd.img
```

## Credits

Huge credit to [Khaos Tian](https://github.com/KhaosT) who inspired this project by the creation of [SimpleVM](https://github.com/KhaosT/SimpleVM). & [https://github.com/kendfinger/virtual](https://github.com/kendfinger/virtual)
