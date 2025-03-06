# ipxe

tftp and web servers for ipxe
This images runs as root since in.tftpd does nnto support running unprivileged.

TODO: swithc to another tftp solution

pxe dirextory structure:
~~~
.
├── coreos
│  .
│  .
│  .
│   ├── fedora-coreos-{{ FCos Version }}-live-initramfs.x86_64.img
│   ├── fedora-coreos-{{ FCos Version }}-live-kernel-x86_64
│   └── fedora-coreos-{{ FCos Version }}-live-rootfs.x86_64.img
├── pxe
│   ├── ipxe.efi
│   ├── machine-default.ipxe
│   ├── machine-specific-chain.ipxe
│   └── undionly.kpxe
└── sample.domain.tld
    └── launch.ipxe
~~~

Adding machine follows *sample.domain.tld* directory structure.
launch.ipxe can be populated with anything.