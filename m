From: JD <jdtxs00@gmail.com>
Date: Fri, 12 Feb 2021 12:39:25 -0600
Subject: [Intel-wired-lan] iavf null packets and arbitrary memory reads
In-Reply-To: <BYAPR11MB3606E2AD589A7E343F32F7B6EF8B9@BYAPR11MB3606.namprd11.prod.outlook.com>
References: <CAMnf+PgVx-bg87KCV0NbtSi_FRMokVVXLEwuA_XCH6UxR57rKQ@mail.gmail.com>
 <e73bcf37b214af6c8267622a49a7c9166522f3d0.camel@intel.com>
 <BYAPR11MB36062A9FC2CF8231B79DE0D1EF8B9@BYAPR11MB3606.namprd11.prod.outlook.com>
 <BYAPR11MB3606E2AD589A7E343F32F7B6EF8B9@BYAPR11MB3606.namprd11.prod.outlook.com>
Message-ID: <CAMnf+PjeJ9rZMbnpxUS7eMzVFDO7syxsV-0NQ=Rups5V9DJfgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

I have some important details to add to this. It appears that
ixgbe/ixgbevf are also affected. I have reviewed some older Intel
based servers and some are showing the behavior as well.

This is a non-AMD server showing the behavior on a different NIC:
OS: CentOS 7.8
Kernel: 4.19.107
NIC: Intel Corporation Ethernet Controller 10G X550T
Driver: ixgbe 5.1.0-k
Vendor P/N: AOC-MTG-i2TM
Firmware-version: 0x80000aee, 1.1876.0
CPU: Intel(R) Xeon(R) Silver 4214 CPU
MOBO: Supermicro X11DPT-PS

The VM on the Intel box above is using kernel 4.19.163 with ixgbevf 4.1.0-k

This is a server with only 1 NIC (though bonding is still setup with
only a single interface for simplification between builds), so I would
assume that bonding isn't relevant to the bug. I will include the
bonding configuration for the AMD servers below anyway in case you
need it.

For repro: I don't know how the issue begins or how to reproduce it on
demand, it happens during normal VM use. I will describe our
environment and go over various settings.

Virtualization type: qemu-kvm
Libvirt version: libvirt-daemon-kvm-4.5.0-36.el7_9.3.x86_6
QEMU version: qemu-kvm-ev-2.12.0-44.1.el7_8.1.x86_64

OS on both guest/host: CentOS 7.8+ (happens on 7.8 and 7.9)
NIC bonding: Bonded and unbonded are affected. However, on bonded
hosts, these options are used:
GUEST: BONDING_OPTS="mode=2 miimon=100 xmit_hash_policy=1"
HOST: BONDING_OPTS="mode=4 miimon=100 xmit_hash_policy=layer3+4"

Bonding is setup in both the guest and host using the configuration
above. 2 VF's are attached to the KVM guest for this.

Here is the QEMU process on the AMD based server:
qemu     35644  232  3.1 9678028 8432068 ?     SLl  Jan21 75000:17
/usr/libexec/qemu-kvm -name guest=VMNAME-REDACTED,debug-threads=on -S
-object secret,id=masterKey0,format=raw,file=/var/lib/libvirt/qemu/domain-27-VMNAME-REDACTED/master-key.aes
-machine pc-i440fx-rhel7.6.0,accel=kvm,usb=off,dump-guest-core=off
-cpu EPYC-IBPB,x2apic=on,tsc-deadline=on,hypervisor=on,tsc_adjust=on,clwb=on,umip=on,spec-ctrl=on,stibp=on,ssbd=on,cmp_legacy=on,perfctr_core=on,monitor=off
-m 8192 -realtime mlock=off -smp 4,sockets=4,cores=1,threads=1 -uuid
6e201ba4-68fe-45be-a86d-fbc46cef5d46 -display none -no-user-config
-nodefaults -chardev socket,id=charmonitor,fd=55,server,nowait -mon
chardev=charmonitor,id=monitor,mode=control -rtc
base=utc,driftfix=slew -global kvm-pit.lost_tick_policy=delay -no-hpet
-no-shutdown -global PIIX4_PM.disable_s3=1 -global
PIIX4_PM.disable_s4=1 -boot strict=on -device
ich9-usb-ehci1,id=usb,bus=pci.0,addr=0x2.0x7 -device
ich9-usb-uhci1,masterbus=usb.0,firstport=0,bus=pci.0,multifunction=on,addr=0x2
-device ich9-usb-uhci2,masterbus=usb.0,firstport=2,bus=pci.0,addr=0x2.0x1
-device ich9-usb-uhci3,masterbus=usb.0,firstport=4,bus=pci.0,addr=0x2.0x2
-device ahci,id=sata0,bus=pci.0,addr=0x3 -drive
file=/imgs/VMNAME-REDACTED/diskname-redacted,format=qcow2,if=none,id=drive-sata0-0-0,cache=none,discard=unmap
-device ide-hd,bus=sata0.0,drive=drive-sata0-0-0,id=sata0-0-0,bootindex=1,write-cache=on
-chardev pty,id=charserial0 -device
isa-serial,chardev=charserial0,id=serial0 -device
vfio-pci,host=81:03.5,id=hostdev0,bus=pci.0,addr=0x5 -device
vfio-pci,host=81:0b.5,id=hostdev1,bus=pci.0,addr=0x6 -device
virtio-balloon-pci,id=balloon0,bus=pci.0,addr=0x4 -sandbox
on,obsolete=deny,elevateprivileges=deny,spawn=deny,resourcecontrol=deny
-msg timestamp=on


Here is the QEMU process on the Intel based server:
qemu     10058  157  8.1 9622376 8017812 ?     SLl  Jan25 40027:35
/usr/libexec/qemu-kvm -name guest=VMNAME-REDACTED,debug-threads=on -S
-object secret,id=masterKey0,format=raw,file=/var/lib/libvirt/qemu/domain-21-VMNAME-REDACTED/master-key.aes
-machine pc-i440fx-rhel7.6.0,accel=kvm,usb=off,dump-guest-core=off
-cpu Skylake-Server-IBRS,ss=on,hypervisor=on,tsc_adjust=on,clflushopt=on,umip=on,pku=on,avx512vnni=on,md-clear=on,stibp=on,ssbd=on,xsaves=on,hle=off,rtm=off
-m 8192 -realtime mlock=off -smp 4,sockets=4,cores=1,threads=1 -uuid
6fc40d77-2872-4717-827b-de634b2a5609 -display none -no-user-config
-nodefaults -chardev socket,id=charmonitor,fd=31,server,nowait -mon
chardev=charmonitor,id=monitor,mode=control -rtc
base=utc,driftfix=slew -global kvm-pit.lost_tick_policy=delay -no-hpet
-no-shutdown -global PIIX4_PM.disable_s3=1 -global
PIIX4_PM.disable_s4=1 -boot strict=on -device
ich9-usb-ehci1,id=usb,bus=pci.0,addr=0x2.0x7 -device
ich9-usb-uhci1,masterbus=usb.0,firstport=0,bus=pci.0,multifunction=on,addr=0x2
-device ich9-usb-uhci2,masterbus=usb.0,firstport=2,bus=pci.0,addr=0x2.0x1
-device ich9-usb-uhci3,masterbus=usb.0,firstport=4,bus=pci.0,addr=0x2.0x2
-device ahci,id=sata0,bus=pci.0,addr=0x3 -drive
file=/imgs/VMNAME-REDACTED/diskname-redacted,format=qcow2,if=none,id=drive-sata0-0-0,cache=none,discard=unmap
-device ide-hd,bus=sata0.0,drive=drive-sata0-0-0,id=sata0-0-0,bootindex=1,write-cache=on
-chardev pty,id=charserial0 -device
isa-serial,chardev=charserial0,id=serial0 -device
vfio-pci,host=18:11.0,id=hostdev0,bus=pci.0,addr=0x5 -device
virtio-balloon-pci,id=balloon0,bus=pci.0,addr=0x4 -sandbox
on,obsolete=deny,elevateprivileges=deny,spawn=deny,resourcecontrol=deny
-msg timestamp=on


Lastly, I have attached some files:
- The dmesg log from the VM with ixgbevf
- The dmesg log from the VM with iavf
- A time series graph for the AMD based server with iavf illustrating
when the issue began. On the AMD-based server, spikes with dropped
packets are normal, but a constant flow isn't. As you can see, a
constant flow of dropped packets begins shortly after 2/06 @ 20:20
UTC.
- A time series graph for the Intel based server with ixgbevf
illustrating when the issue began. On the Intel based server, there's
no drops whatsoever, and as soon as the null packet bug gets
triggered, they spike and remain constant after 2/10 @ 9:00 UTC.

I have analytics for almost everything network related (courtesy of
Prometheus/node_exporter), so if you want insight on any other
keys/values from the kernel or networking stack, please let me know
and I'm happy to provide it.

My thoughts currently: If this issue affects both iavf/ixgbevf, how
much common code/logic is used between those drivers? I think it
should help narrow things down a little more since it doesn't seem to
be specific to a NIC or to iavf in particular.

Thank you.

On Fri, Feb 12, 2021 at 10:05 AM Fujinaka, Todd <todd.fujinaka@intel.com> wrote:
>
> The SW development team has taken a look at this and while they have some comments the next step is to get an internal repro.
>
> Please send the exact repro steps (including commands) including the configuration of bonding.
>
> They're also asking for the full dmesg from the time of boot.
>
> Thanks.
>
> Todd Fujinaka
> Software Application Engineer
> Data Center Group
> Intel Corporation
> todd.fujinaka at intel.com
>
> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Fujinaka, Todd
> Sent: Thursday, February 11, 2021 4:47 PM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; intel-wired-lan at lists.osuosl.org; jdtxs00 at gmail.com
> Subject: Re: [Intel-wired-lan] iavf null packets and arbitrary memory reads
>
> Sorry, top-posting guy.
>
> I'm going to put this in our internal bug tracker to make sure it doesn't get lost.
>
> Todd Fujinaka
> Software Application Engineer
> Data Center Group
> Intel Corporation
> todd.fujinaka at intel.com
>
> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Nguyen, Anthony L
> Sent: Wednesday, February 10, 2021 6:31 PM
> To: intel-wired-lan at lists.osuosl.org; jdtxs00 at gmail.com
> Subject: Re: [Intel-wired-lan] iavf null packets and arbitrary memory reads
>
> On Wed, 2021-02-10 at 14:56 -0600, JD wrote:
> > Hello,
> >
> > I've encountered a NIC driver bug that leads to null packets being
> > transmitted and arbitrary/OOB memory reads by the iavf driver.
> >
> > I'm unfortunately not sure how the issue starts, but it has been
> > happening across many different AMD servers and virtual machines.
> >
> > Running a tcpdump (tcpdump -i bond0 -nne ether host
> > 00:00:00:00:00:00)
> > on bond0 results in these packets being produced at a high rate:
> >
> > 13:04:14.826298 00:00:00:00:00:00 > 00:00:00:00:00:00, 802.3, length
> > 0: LLC, dsap Null (0x00) Individual, ssap Null (0x00) Command, ctrl
> > 0x0000: Information, send seq 0, rcv seq 0, Flags [Command], length
> > 144
> >         0x0000:  0000 0000 0000 0000 0000 0000 0000
> > 0000  ................
> >         0x0010:  0000 0000 0000 0000 0000 0000 0000
> > 0000  ................
> >         0x0020:  0000 0000 0000 0000 0000 0000 0000
> > 0000  ................
> >         0x0030:  0000 0000 0000 0000 0000 0000 0000
> > 0000  ................
> >         0x0040:  0000 0000 0000 0000 0000 0000 0000
> > 0000  ................
> >         0x0050:  0000 0000 0000 0000 0000 0000 0000
> > 0000  ................
> >         0x0060:  0000 0000 0000 0000 0000 0000 0000
> > 0000  ................
> >         0x0070:  0000 0000 0000 0000 0000 0000 0000
> > 0000  ................
> >         0x0080:  0000 0000 0000 0000 0000 0000 0000
> > 0000  ................
> >
> >
> > As you can see, they have a dest/src ether of 00:00:00:00:00:00 and
> > are completely null.  This doesn't happen on every virtual machine,
> > some return absolutely nothing.
> >
> > If I filter the tcpdump command to ignore empty packets (all dots),
> > some other interesting items begin to appear:
> >
> >         0x0500:  0000 0000 0000 0029 0100 071b 0473 656c
> > .......).....sel
> >         0x0510:  696e 7578 7379 7374 656d 5f75 3a6f 626a
> > inuxsystem_u:obj
> >         0x0520:  6563 745f 723a 6269 6e5f 743a 7330
> > 0000  ect_r:bin_t:s0..
> > [...]
> >         0x0080:  0000 2f75 7372 2f6c 6962 3634 2f70
> > 6572  ../usr/lib64/per
> >         0x0090:  6c35 2f76 656e 646f 725f 7065 726c
> > 2f46  l5/vendor_perl/F
> >         0x00a0:  696c 652f 5370 6563 2f55 6e69 782e 706d
> > ile/Spec/Unix.pm
> >
> > To me, that looks like it's reading data from memory and attempting to
> > send from 00:00:00:00:00:00 to 00:00:00:00:00:00.
> >
> > If I run that same tcpdump on a different servers exhibiting the null
> > packets, completely different items show up which also appear to be
> > from memory.
> >
> > Keeping a tcpdump results in the same items from memory being repeated
> > infinitely with no observable variation.
> >
> > So, it seems like the iavf driver is encountering some bug with memory
> > management and ends up transmitting null packets or arbitrary data
> > from memory over bond0.
> >
> > How/why did I notice this behavior? The VM's seem to perform worse
> > over the network when this occurs. They usually exhibit small amounts
> > of packet loss, or poor SSH responsiveness. Oddly, I have seen this
> > bug in the past, and it resulted in dmesg on the parent printing
> > Spoofed packet warnings for the i40e driver. Now it does not, yet the
> > null packets still occur.
> >
> > I would like to help in any way I can to resolve this in the iavf/i40e
> > driver. I'm happy to provide information from the servers if it's
> > needed.
> >
> > For reference, here is the setup on every single AMD server:
> > VM:
> > CentOS 7.9
> > NIC driver: iavf 4.0.1
> > Kernel 4.19.163
> >
> > KVM parent:
> > CentOS 7.9
> > NIC driver: i40e 2.12.6
> > Kernel: 4.19.163
> > 2x Intel XXV710 for 25GbE SFP28 @ 25Gbps BONDED (Mode 4, LACP)
> > Vendor: Supermicro Network Adapter AOC-S25G-i2S Firmware version: 7.20
> > 0x800082b3 1.2585.0
> > MOBO: Supermicro H11DSU-iN
> > CPU: AMD EPYC 7352
> >
> > And here is the dmesg log (grepped for iavf) from a server that has
> > the issue:
> > iavf: loading out-of-tree module taints kernel.
> > iavf: Intel(R) Ethernet Adaptive Virtual Function Network Driver -
> > version 4.0.1 iavf 0000:00:06.0: Multiqueue Enabled: Queue pair count
> > = 4 iavf 0000:00:06.0: MAC address: 52:54:00:7f:bc:39 iavf
> > 0000:00:06.0: GRO is enabled iavf 0000:00:05.0: Multiqueue Enabled:
> > Queue pair count = 4 iavf 0000:00:05.0: MAC address: 52:54:00:a6:3e:62
> > iavf 0000:00:05.0: GRO is enabled iavf 0000:00:06.0 eth0: NIC Link is
> > Up Speed is 25 Gbps Full Duplex iavf 0000:00:05.0 eth1: NIC Link is Up
> > Speed is 25 Gbps Full Duplex
> >
>
> Hi JD,
>
> I will check and see we're aware of this issue or have any information about it. If not, I'll see if we can work on a reproduction.
>
> Thanks,
> Tony
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
-------------- next part --------------
[Mon Jan 25 19:01:45 2021] Linux version 4.19.163-1.el7.x86_64 (redacted) (gcc version 4.8.5 20150623 (Red Hat 4.8.5-44) (GCC)) #1 SMP Wed Dec 16 14:11:11 MST 2020
[Mon Jan 25 19:01:45 2021] Command line: BOOT_IMAGE=/vmlinuz-4.19.163-1.el7.x86_64 root=UUID=33edf4f6-97cb-494b-9233-a2c456ea87a9 ro crashkernel=auto rhgb quiet net.ifnames=0 biosdevname=0 console=ttyS0 LANG=en_US.UTF-8
[Mon Jan 25 19:01:45 2021] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[Mon Jan 25 19:01:45 2021] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[Mon Jan 25 19:01:45 2021] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[Mon Jan 25 19:01:45 2021] x86/fpu: Supporting XSAVE feature 0x008: 'MPX bounds registers'
[Mon Jan 25 19:01:45 2021] x86/fpu: Supporting XSAVE feature 0x010: 'MPX CSR'
[Mon Jan 25 19:01:45 2021] x86/fpu: Supporting XSAVE feature 0x020: 'AVX-512 opmask'
[Mon Jan 25 19:01:45 2021] x86/fpu: Supporting XSAVE feature 0x040: 'AVX-512 Hi256'
[Mon Jan 25 19:01:45 2021] x86/fpu: Supporting XSAVE feature 0x080: 'AVX-512 ZMM_Hi256'
[Mon Jan 25 19:01:45 2021] x86/fpu: Supporting XSAVE feature 0x200: 'Protection Keys User registers'
[Mon Jan 25 19:01:45 2021] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[Mon Jan 25 19:01:45 2021] x86/fpu: xstate_offset[3]:  832, xstate_sizes[3]:   64
[Mon Jan 25 19:01:45 2021] x86/fpu: xstate_offset[4]:  896, xstate_sizes[4]:   64
[Mon Jan 25 19:01:45 2021] x86/fpu: xstate_offset[5]:  960, xstate_sizes[5]:   64
[Mon Jan 25 19:01:45 2021] x86/fpu: xstate_offset[6]: 1024, xstate_sizes[6]:  512
[Mon Jan 25 19:01:45 2021] x86/fpu: xstate_offset[7]: 1536, xstate_sizes[7]: 1024
[Mon Jan 25 19:01:45 2021] x86/fpu: xstate_offset[9]: 2560, xstate_sizes[9]:    8
[Mon Jan 25 19:01:45 2021] x86/fpu: Enabled xstate features 0x2ff, context size is 2568 bytes, using 'compacted' format.
[Mon Jan 25 19:01:45 2021] BIOS-provided physical RAM map:
[Mon Jan 25 19:01:45 2021] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
[Mon Jan 25 19:01:45 2021] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
[Mon Jan 25 19:01:45 2021] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
[Mon Jan 25 19:01:45 2021] BIOS-e820: [mem 0x0000000000100000-0x00000000bffdefff] usable
[Mon Jan 25 19:01:45 2021] BIOS-e820: [mem 0x00000000bffdf000-0x00000000bfffffff] reserved
[Mon Jan 25 19:01:45 2021] BIOS-e820: [mem 0x00000000feffc000-0x00000000feffffff] reserved
[Mon Jan 25 19:01:45 2021] BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] reserved
[Mon Jan 25 19:01:45 2021] BIOS-e820: [mem 0x0000000100000000-0x000000023fffffff] usable
[Mon Jan 25 19:01:45 2021] NX (Execute Disable) protection: active
[Mon Jan 25 19:01:45 2021] SMBIOS 2.8 present.
[Mon Jan 25 19:01:45 2021] DMI: Red Hat KVM, BIOS 1.11.0-2.el7 04/01/2014
[Mon Jan 25 19:01:45 2021] Hypervisor detected: KVM
[Mon Jan 25 19:01:45 2021] kvm-clock: Using msrs 4b564d01 and 4b564d00
[Mon Jan 25 19:01:45 2021] kvm-clock: cpu 0, msr 272b001, primary cpu clock
[Mon Jan 25 19:01:45 2021] kvm-clock: using sched offset of 8315473719 cycles
[Mon Jan 25 19:01:45 2021] clocksource: kvm-clock: mask: 0xffffffffffffffff max_cycles: 0x1cd42e4dffb, max_idle_ns: 881590591483 ns
[Mon Jan 25 19:01:45 2021] tsc: Detected 2199.984 MHz processor
[Mon Jan 25 19:01:45 2021] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[Mon Jan 25 19:01:45 2021] e820: remove [mem 0x000a0000-0x000fffff] usable
[Mon Jan 25 19:01:45 2021] last_pfn = 0x240000 max_arch_pfn = 0x400000000
[Mon Jan 25 19:01:45 2021] MTRR default type: write-back
[Mon Jan 25 19:01:45 2021] MTRR fixed ranges enabled:
[Mon Jan 25 19:01:45 2021]   00000-9FFFF write-back
[Mon Jan 25 19:01:45 2021]   A0000-BFFFF uncachable
[Mon Jan 25 19:01:45 2021]   C0000-FFFFF write-protect
[Mon Jan 25 19:01:45 2021] MTRR variable ranges enabled:
[Mon Jan 25 19:01:45 2021]   0 base 0000C0000000 mask 3FFFC0000000 uncachable
[Mon Jan 25 19:01:45 2021]   1 disabled
[Mon Jan 25 19:01:45 2021]   2 disabled
[Mon Jan 25 19:01:45 2021]   3 disabled
[Mon Jan 25 19:01:45 2021]   4 disabled
[Mon Jan 25 19:01:45 2021]   5 disabled
[Mon Jan 25 19:01:45 2021]   6 disabled
[Mon Jan 25 19:01:45 2021]   7 disabled
[Mon Jan 25 19:01:45 2021] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT
[Mon Jan 25 19:01:45 2021] last_pfn = 0xbffdf max_arch_pfn = 0x400000000
[Mon Jan 25 19:01:45 2021] found SMP MP-table at [mem 0x000f6350-0x000f635f]
[Mon Jan 25 19:01:45 2021] Using GB pages for direct mapping
[Mon Jan 25 19:01:45 2021] RAMDISK: [mem 0x35caf000-0x36e4ffff]
[Mon Jan 25 19:01:45 2021] ACPI: Early table checksum verification disabled
[Mon Jan 25 19:01:45 2021] ACPI: RSDP 0x00000000000F6300 000014 (v00 BOCHS )
[Mon Jan 25 19:01:45 2021] ACPI: RSDT 0x00000000BFFE12F2 00002C (v01 BOCHS  BXPCRSDT 00000001 BXPC 00000001)
[Mon Jan 25 19:01:45 2021] ACPI: FACP 0x00000000BFFE11EE 000074 (v01 BOCHS  BXPCFACP 00000001 BXPC 00000001)
[Mon Jan 25 19:01:45 2021] ACPI: DSDT 0x00000000BFFDFD40 0014AE (v01 BOCHS  BXPCDSDT 00000001 BXPC 00000001)
[Mon Jan 25 19:01:45 2021] ACPI: FACS 0x00000000BFFDFD00 000040
[Mon Jan 25 19:01:45 2021] ACPI: APIC 0x00000000BFFE1262 000090 (v01 BOCHS  BXPCAPIC 00000001 BXPC 00000001)
[Mon Jan 25 19:01:45 2021] ACPI: Local APIC address 0xfee00000
[Mon Jan 25 19:01:45 2021] No NUMA configuration found
[Mon Jan 25 19:01:45 2021] Faking a node at [mem 0x0000000000000000-0x000000023fffffff]
[Mon Jan 25 19:01:45 2021] NODE_DATA(0) allocated [mem 0x23ffd4000-0x23fffdfff]
[Mon Jan 25 19:01:45 2021] crashkernel: memory value expected
[Mon Jan 25 19:01:45 2021] Zone ranges:
[Mon Jan 25 19:01:45 2021]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[Mon Jan 25 19:01:45 2021]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[Mon Jan 25 19:01:45 2021]   Normal   [mem 0x0000000100000000-0x000000023fffffff]
[Mon Jan 25 19:01:45 2021]   Device   empty
[Mon Jan 25 19:01:45 2021] Movable zone start for each node
[Mon Jan 25 19:01:45 2021] Early memory node ranges
[Mon Jan 25 19:01:45 2021]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[Mon Jan 25 19:01:45 2021]   node   0: [mem 0x0000000000100000-0x00000000bffdefff]
[Mon Jan 25 19:01:45 2021]   node   0: [mem 0x0000000100000000-0x000000023fffffff]
[Mon Jan 25 19:01:45 2021] Zeroed struct page in unavailable ranges: 131 pages
[Mon Jan 25 19:01:45 2021] Initmem setup node 0 [mem 0x0000000000001000-0x000000023fffffff]
[Mon Jan 25 19:01:45 2021] On node 0 totalpages: 2097021
[Mon Jan 25 19:01:45 2021]   DMA zone: 64 pages used for memmap
[Mon Jan 25 19:01:45 2021]   DMA zone: 21 pages reserved
[Mon Jan 25 19:01:45 2021]   DMA zone: 3998 pages, LIFO batch:0
[Mon Jan 25 19:01:45 2021]   DMA32 zone: 12224 pages used for memmap
[Mon Jan 25 19:01:45 2021]   DMA32 zone: 782303 pages, LIFO batch:63
[Mon Jan 25 19:01:45 2021]   Normal zone: 20480 pages used for memmap
[Mon Jan 25 19:01:45 2021]   Normal zone: 1310720 pages, LIFO batch:63
[Mon Jan 25 19:01:45 2021] ACPI: PM-Timer IO Port: 0x608
[Mon Jan 25 19:01:45 2021] ACPI: Local APIC address 0xfee00000
[Mon Jan 25 19:01:45 2021] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
[Mon Jan 25 19:01:45 2021] IOAPIC[0]: apic_id 0, version 17, address 0xfec00000, GSI 0-23
[Mon Jan 25 19:01:45 2021] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[Mon Jan 25 19:01:45 2021] ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high level)
[Mon Jan 25 19:01:45 2021] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[Mon Jan 25 19:01:45 2021] ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 high level)
[Mon Jan 25 19:01:45 2021] ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 high level)
[Mon Jan 25 19:01:45 2021] ACPI: IRQ0 used by override.
[Mon Jan 25 19:01:45 2021] ACPI: IRQ5 used by override.
[Mon Jan 25 19:01:45 2021] ACPI: IRQ9 used by override.
[Mon Jan 25 19:01:45 2021] ACPI: IRQ10 used by override.
[Mon Jan 25 19:01:45 2021] ACPI: IRQ11 used by override.
[Mon Jan 25 19:01:45 2021] Using ACPI (MADT) for SMP configuration information
[Mon Jan 25 19:01:45 2021] TSC deadline timer available
[Mon Jan 25 19:01:45 2021] smpboot: Allowing 4 CPUs, 0 hotplug CPUs
[Mon Jan 25 19:01:45 2021] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
[Mon Jan 25 19:01:45 2021] PM: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
[Mon Jan 25 19:01:45 2021] PM: Registered nosave memory: [mem 0x000a0000-0x000effff]
[Mon Jan 25 19:01:45 2021] PM: Registered nosave memory: [mem 0x000f0000-0x000fffff]
[Mon Jan 25 19:01:45 2021] PM: Registered nosave memory: [mem 0xbffdf000-0xbfffffff]
[Mon Jan 25 19:01:45 2021] PM: Registered nosave memory: [mem 0xc0000000-0xfeffbfff]
[Mon Jan 25 19:01:45 2021] PM: Registered nosave memory: [mem 0xfeffc000-0xfeffffff]
[Mon Jan 25 19:01:45 2021] PM: Registered nosave memory: [mem 0xff000000-0xfffbffff]
[Mon Jan 25 19:01:45 2021] PM: Registered nosave memory: [mem 0xfffc0000-0xffffffff]
[Mon Jan 25 19:01:45 2021] [mem 0xc0000000-0xfeffbfff] available for PCI devices
[Mon Jan 25 19:01:45 2021] Booting paravirtualized kernel on KVM
[Mon Jan 25 19:01:45 2021] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[Mon Jan 25 19:01:45 2021] random: get_random_bytes called from start_kernel+0x9b/0x533 with crng_init=0
[Mon Jan 25 19:01:45 2021] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:4 nr_cpu_ids:4 nr_node_ids:1
[Mon Jan 25 19:01:45 2021] percpu: Embedded 45 pages/cpu s145496 r8192 d30632 u524288
[Mon Jan 25 19:01:45 2021] pcpu-alloc: s145496 r8192 d30632 u524288 alloc=1*2097152
[Mon Jan 25 19:01:45 2021] pcpu-alloc: [0] 0 1 2 3
[Mon Jan 25 19:01:45 2021] KVM setup async PF for cpu 0
[Mon Jan 25 19:01:45 2021] kvm-stealtime: cpu 0, msr 237a161c0
[Mon Jan 25 19:01:45 2021] PV qspinlock hash table entries: 256 (order: 0, 4096 bytes)
[Mon Jan 25 19:01:45 2021] Built 1 zonelists, mobility grouping on.  Total pages: 2064232
[Mon Jan 25 19:01:45 2021] Policy zone: Normal
[Mon Jan 25 19:01:45 2021] Kernel command line: BOOT_IMAGE=/vmlinuz-4.19.163-1.el7.x86_64 root=UUID=33edf4f6-97cb-494b-9233-a2c456ea87a9 ro crashkernel=auto rhgb quiet net.ifnames=0 biosdevname=0 console=ttyS0 LANG=en_US.UTF-8
[Mon Jan 25 19:01:45 2021] Memory: 8145120K/8388084K available (12300K kernel code, 2509K rwdata, 3608K rodata, 2356K init, 3220K bss, 242964K reserved, 0K cma-reserved)
[Mon Jan 25 19:01:45 2021] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[Mon Jan 25 19:01:45 2021] Kernel/User page tables isolation: enabled
[Mon Jan 25 19:01:45 2021] ftrace: allocating 36327 entries in 142 pages
[Mon Jan 25 19:01:45 2021] rcu: Hierarchical RCU implementation.
[Mon Jan 25 19:01:45 2021] rcu:         RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=4.
[Mon Jan 25 19:01:45 2021] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
[Mon Jan 25 19:01:45 2021] NR_IRQS: 524544, nr_irqs: 456, preallocated irqs: 16
[Mon Jan 25 19:01:45 2021] Console: colour *CGA 80x25
[Mon Jan 25 19:01:45 2021] console [ttyS0] enabled
[Mon Jan 25 19:01:45 2021] ACPI: Core revision 20180810
[Mon Jan 25 19:01:45 2021] APIC: Switch to symmetric I/O mode setup
[Mon Jan 25 19:01:45 2021] x2apic enabled
[Mon Jan 25 19:01:45 2021] Switched APIC routing to physical x2apic.
[Mon Jan 25 19:01:45 2021] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[Mon Jan 25 19:01:45 2021] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x1fb623c7bdc, max_idle_ns: 440795310953 ns
[Mon Jan 25 19:01:45 2021] Calibrating delay loop (skipped) preset value.. 4399.96 BogoMIPS (lpj=2199984)
[Mon Jan 25 19:01:45 2021] pid_max: default: 32768 minimum: 301
[Mon Jan 25 19:01:45 2021] Security Framework initialized
[Mon Jan 25 19:01:45 2021] SELinux:  Initializing.
[Mon Jan 25 19:01:45 2021] Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
[Mon Jan 25 19:01:45 2021] Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
[Mon Jan 25 19:01:45 2021] Mount-cache hash table entries: 16384 (order: 5, 131072 bytes)
[Mon Jan 25 19:01:45 2021] Mountpoint-cache hash table entries: 16384 (order: 5, 131072 bytes)
[Mon Jan 25 19:01:45 2021] x86/cpu: Activated the Intel User Mode Instruction Prevention (UMIP) CPU feature
[Mon Jan 25 19:01:45 2021] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
[Mon Jan 25 19:01:45 2021] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
[Mon Jan 25 19:01:45 2021] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[Mon Jan 25 19:01:45 2021] Spectre V2 : Mitigation: Full generic retpoline
[Mon Jan 25 19:01:45 2021] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[Mon Jan 25 19:01:45 2021] Spectre V2 : Enabling Restricted Speculation for firmware calls
[Mon Jan 25 19:01:45 2021] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
[Mon Jan 25 19:01:45 2021] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl and seccomp
[Mon Jan 25 19:01:45 2021] MDS: Mitigation: Clear CPU buffers
[Mon Jan 25 19:01:45 2021] Freeing SMP alternatives memory: 32K
[Mon Jan 25 19:01:45 2021] smpboot: CPU0: Intel Xeon Processor (Skylake, IBRS) (family: 0x6, model: 0x55, stepping: 0x4)
[Mon Jan 25 19:01:45 2021] Performance Events: unsupported p6 CPU model 85 no PMU driver, software events only.
[Mon Jan 25 19:01:45 2021] rcu: Hierarchical SRCU implementation.
[Mon Jan 25 19:01:45 2021] NMI watchdog: Perf NMI watchdog permanently disabled
[Mon Jan 25 19:01:45 2021] smp: Bringing up secondary CPUs ...
[Mon Jan 25 19:01:45 2021] x86: Booting SMP configuration:
[Mon Jan 25 19:01:45 2021] .... node  #0, CPUs:      #1
[Mon Jan 25 19:01:45 2021] kvm-clock: cpu 1, msr 272b041, secondary cpu clock
[Mon Jan 25 19:01:45 2021] x86/cpu: Activated the Intel User Mode Instruction Prevention (UMIP) CPU feature
[Mon Jan 25 19:01:45 2021] KVM setup async PF for cpu 1
[Mon Jan 25 19:01:45 2021] kvm-stealtime: cpu 1, msr 237a961c0
[Mon Jan 25 19:01:45 2021]  #2
[Mon Jan 25 19:01:45 2021] kvm-clock: cpu 2, msr 272b081, secondary cpu clock
[Mon Jan 25 19:01:45 2021] x86/cpu: Activated the Intel User Mode Instruction Prevention (UMIP) CPU feature
[Mon Jan 25 19:01:45 2021] KVM setup async PF for cpu 2
[Mon Jan 25 19:01:45 2021] kvm-stealtime: cpu 2, msr 237b161c0
[Mon Jan 25 19:01:45 2021]  #3
[Mon Jan 25 19:01:45 2021] kvm-clock: cpu 3, msr 272b0c1, secondary cpu clock
[Mon Jan 25 19:01:45 2021] x86/cpu: Activated the Intel User Mode Instruction Prevention (UMIP) CPU feature
[Mon Jan 25 19:01:45 2021] KVM setup async PF for cpu 3
[Mon Jan 25 19:01:45 2021] kvm-stealtime: cpu 3, msr 237b961c0
[Mon Jan 25 19:01:45 2021] smp: Brought up 1 node, 4 CPUs
[Mon Jan 25 19:01:45 2021] smpboot: Max logical packages: 4
[Mon Jan 25 19:01:45 2021] smpboot: Total of 4 processors activated (17599.87 BogoMIPS)
[Mon Jan 25 19:01:45 2021] devtmpfs: initialized
[Mon Jan 25 19:01:45 2021] x86/mm: Memory block size: 128MB
[Mon Jan 25 19:01:45 2021] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[Mon Jan 25 19:01:45 2021] futex hash table entries: 1024 (order: 4, 65536 bytes)
[Mon Jan 25 19:01:45 2021] pinctrl core: initialized pinctrl subsystem
[Mon Jan 25 19:01:45 2021] NET: Registered protocol family 16
[Mon Jan 25 19:01:45 2021] audit: initializing netlink subsys (disabled)
[Mon Jan 25 19:01:45 2021] audit: type=2000 audit(1611626505.494:1): state=initialized audit_enabled=0 res=1
[Mon Jan 25 19:01:45 2021] cpuidle: using governor menu
[Mon Jan 25 19:01:45 2021] ACPI: bus type PCI registered
[Mon Jan 25 19:01:45 2021] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[Mon Jan 25 19:01:45 2021] PCI: Using configuration type 1 for base access
[Mon Jan 25 19:01:45 2021] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
[Mon Jan 25 19:01:45 2021] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[Mon Jan 25 19:01:45 2021] ACPI: Added _OSI(Module Device)
[Mon Jan 25 19:01:45 2021] ACPI: Added _OSI(Processor Device)
[Mon Jan 25 19:01:45 2021] ACPI: Added _OSI(3.0 _SCP Extensions)
[Mon Jan 25 19:01:45 2021] ACPI: Added _OSI(Processor Aggregator Device)
[Mon Jan 25 19:01:45 2021] ACPI: Added _OSI(Linux-Dell-Video)
[Mon Jan 25 19:01:45 2021] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[Mon Jan 25 19:01:45 2021] ACPI: 1 ACPI AML tables successfully acquired and loaded
[Mon Jan 25 19:01:45 2021] ACPI: Interpreter enabled
[Mon Jan 25 19:01:45 2021] ACPI: (supports S0 S5)
[Mon Jan 25 19:01:45 2021] ACPI: Using IOAPIC for interrupt routing
[Mon Jan 25 19:01:45 2021] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[Mon Jan 25 19:01:45 2021] ACPI: Enabled 2 GPEs in block 00 to 0F
[Mon Jan 25 19:01:45 2021] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[Mon Jan 25 19:01:45 2021] acpi PNP0A03:00: _OSC: OS supports [ASPM ClockPM Segments MSI]
[Mon Jan 25 19:01:45 2021] acpi PNP0A03:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
[Mon Jan 25 19:01:45 2021] acpi PNP0A03:00: fail to add MMCONFIG information, can't access extended PCI configuration space under this bridge.
[Mon Jan 25 19:01:45 2021] acpiphp: Slot [3] registered
[Mon Jan 25 19:01:45 2021] acpiphp: Slot [4] registered
[Mon Jan 25 19:01:45 2021] acpiphp: Slot [5] registered
[Mon Jan 25 19:01:45 2021] acpiphp: Slot [6] registered
[Mon Jan 25 19:01:45 2021] acpiphp: Slot [7] registered
[Mon Jan 25 19:01:45 2021] acpiphp: Slot [8] registered
[Mon Jan 25 19:01:45 2021] acpiphp: Slot [9] registered
[Mon Jan 25 19:01:45 2021] acpiphp: Slot [10] registered
[Mon Jan 25 19:01:45 2021] acpiphp: Slot [11] registered
[Mon Jan 25 19:01:45 2021] acpiphp: Slot [12] registered
[Mon Jan 25 19:01:45 2021] acpiphp: Slot [13] registered
[Mon Jan 25 19:01:45 2021] acpiphp: Slot [14] registered
[Mon Jan 25 19:01:45 2021] acpiphp: Slot [15] registered
[Mon Jan 25 19:01:45 2021] acpiphp: Slot [16] registered
[Mon Jan 25 19:01:45 2021] acpiphp: Slot [17] registered
[Mon Jan 25 19:01:45 2021] acpiphp: Slot [18] registered
[Mon Jan 25 19:01:45 2021] acpiphp: Slot [19] registered
[Mon Jan 25 19:01:45 2021] acpiphp: Slot [20] registered
[Mon Jan 25 19:01:45 2021] acpiphp: Slot [21] registered
[Mon Jan 25 19:01:45 2021] acpiphp: Slot [22] registered
[Mon Jan 25 19:01:45 2021] acpiphp: Slot [23] registered
[Mon Jan 25 19:01:45 2021] acpiphp: Slot [24] registered
[Mon Jan 25 19:01:45 2021] acpiphp: Slot [25] registered
[Mon Jan 25 19:01:45 2021] acpiphp: Slot [26] registered
[Mon Jan 25 19:01:45 2021] acpiphp: Slot [27] registered
[Mon Jan 25 19:01:45 2021] acpiphp: Slot [28] registered
[Mon Jan 25 19:01:45 2021] acpiphp: Slot [29] registered
[Mon Jan 25 19:01:45 2021] acpiphp: Slot [30] registered
[Mon Jan 25 19:01:45 2021] acpiphp: Slot [31] registered
[Mon Jan 25 19:01:45 2021] PCI host bridge to bus 0000:00
[Mon Jan 25 19:01:45 2021] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[Mon Jan 25 19:01:45 2021] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[Mon Jan 25 19:01:45 2021] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[Mon Jan 25 19:01:45 2021] pci_bus 0000:00: root bus resource [mem 0xc0000000-0xfebfffff window]
[Mon Jan 25 19:01:45 2021] pci_bus 0000:00: root bus resource [mem 0x240000000-0x2bfffffff window]
[Mon Jan 25 19:01:45 2021] pci_bus 0000:00: root bus resource [bus 00-ff]
[Mon Jan 25 19:01:45 2021] pci 0000:00:00.0: [8086:1237] type 00 class 0x060000
[Mon Jan 25 19:01:45 2021] pci 0000:00:01.0: [8086:7000] type 00 class 0x060100
[Mon Jan 25 19:01:45 2021] pci 0000:00:01.1: [8086:7010] type 00 class 0x010180
[Mon Jan 25 19:01:45 2021] pci 0000:00:01.1: reg 0x20: [io  0xc0a0-0xc0af]
[Mon Jan 25 19:01:45 2021] pci 0000:00:01.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
[Mon Jan 25 19:01:45 2021] pci 0000:00:01.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
[Mon Jan 25 19:01:45 2021] pci 0000:00:01.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
[Mon Jan 25 19:01:45 2021] pci 0000:00:01.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
[Mon Jan 25 19:01:45 2021] pci 0000:00:01.3: [8086:7113] type 00 class 0x068000
[Mon Jan 25 19:01:45 2021] pci 0000:00:01.3: quirk: [io  0x0600-0x063f] claimed by PIIX4 ACPI
[Mon Jan 25 19:01:45 2021] pci 0000:00:01.3: quirk: [io  0x0700-0x070f] claimed by PIIX4 SMB
[Mon Jan 25 19:01:45 2021] pci 0000:00:02.0: [8086:2934] type 00 class 0x0c0300
[Mon Jan 25 19:01:45 2021] pci 0000:00:02.0: reg 0x20: [io  0xc000-0xc01f]
[Mon Jan 25 19:01:45 2021] pci 0000:00:02.1: [8086:2935] type 00 class 0x0c0300
[Mon Jan 25 19:01:45 2021] pci 0000:00:02.1: reg 0x20: [io  0xc020-0xc03f]
[Mon Jan 25 19:01:45 2021] pci 0000:00:02.2: [8086:2936] type 00 class 0x0c0300
[Mon Jan 25 19:01:45 2021] pci 0000:00:02.2: reg 0x20: [io  0xc040-0xc05f]
[Mon Jan 25 19:01:45 2021] pci 0000:00:02.7: [8086:293a] type 00 class 0x0c0320
[Mon Jan 25 19:01:45 2021] pci 0000:00:02.7: reg 0x10: [mem 0xfebf8000-0xfebf8fff]
[Mon Jan 25 19:01:45 2021] pci 0000:00:03.0: [8086:2922] type 00 class 0x010601
[Mon Jan 25 19:01:45 2021] pci 0000:00:03.0: reg 0x20: [io  0xc060-0xc07f]
[Mon Jan 25 19:01:45 2021] pci 0000:00:03.0: reg 0x24: [mem 0xfebf9000-0xfebf9fff]
[Mon Jan 25 19:01:45 2021] pci 0000:00:04.0: [1af4:1002] type 00 class 0x00ff00
[Mon Jan 25 19:01:45 2021] pci 0000:00:04.0: reg 0x10: [io  0xc080-0xc09f]
[Mon Jan 25 19:01:45 2021] pci 0000:00:04.0: reg 0x20: [mem 0xfebfc000-0xfebfffff 64bit pref]
[Mon Jan 25 19:01:45 2021] pci 0000:00:05.0: [8086:1565] type 00 class 0x020000
[Mon Jan 25 19:01:45 2021] pci 0000:00:05.0: reg 0x10: [mem 0xfebf0000-0xfebf3fff 64bit]
[Mon Jan 25 19:01:45 2021] pci 0000:00:05.0: reg 0x1c: [mem 0xfebf4000-0xfebf7fff 64bit]
[Mon Jan 25 19:01:45 2021] ACPI: PCI Interrupt Link [LNKA] (IRQs 5 *10 11)
[Mon Jan 25 19:01:45 2021] ACPI: PCI Interrupt Link [LNKB] (IRQs 5 *10 11)
[Mon Jan 25 19:01:45 2021] ACPI: PCI Interrupt Link [LNKC] (IRQs 5 10 *11)
[Mon Jan 25 19:01:45 2021] ACPI: PCI Interrupt Link [LNKD] (IRQs 5 10 *11)
[Mon Jan 25 19:01:45 2021] ACPI: PCI Interrupt Link [LNKS] (IRQs *9)
[Mon Jan 25 19:01:45 2021] vgaarb: loaded
[Mon Jan 25 19:01:45 2021] SCSI subsystem initialized
[Mon Jan 25 19:01:45 2021] ACPI: bus type USB registered
[Mon Jan 25 19:01:45 2021] usbcore: registered new interface driver usbfs
[Mon Jan 25 19:01:45 2021] usbcore: registered new interface driver hub
[Mon Jan 25 19:01:45 2021] usbcore: registered new device driver usb
[Mon Jan 25 19:01:45 2021] EDAC MC: Ver: 3.0.0
[Mon Jan 25 19:01:45 2021] PCI: Using ACPI for IRQ routing
[Mon Jan 25 19:01:45 2021] PCI: pci_cache_line_size set to 64 bytes
[Mon Jan 25 19:01:45 2021] e820: reserve RAM buffer [mem 0x0009fc00-0x0009ffff]
[Mon Jan 25 19:01:45 2021] e820: reserve RAM buffer [mem 0xbffdf000-0xbfffffff]
[Mon Jan 25 19:01:45 2021] NetLabel: Initializing
[Mon Jan 25 19:01:45 2021] NetLabel:  domain hash size = 128
[Mon Jan 25 19:01:45 2021] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[Mon Jan 25 19:01:45 2021] NetLabel:  unlabeled traffic allowed by default
[Mon Jan 25 19:01:45 2021] clocksource: Switched to clocksource kvm-clock
[Mon Jan 25 19:01:45 2021] VFS: Disk quotas dquot_6.6.0
[Mon Jan 25 19:01:45 2021] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[Mon Jan 25 19:01:45 2021] pnp: PnP ACPI init
[Mon Jan 25 19:01:45 2021] pnp 00:00: Plug and Play ACPI device, IDs PNP0b00 (active)
[Mon Jan 25 19:01:45 2021] pnp 00:01: Plug and Play ACPI device, IDs PNP0303 (active)
[Mon Jan 25 19:01:45 2021] pnp 00:02: Plug and Play ACPI device, IDs PNP0f13 (active)
[Mon Jan 25 19:01:45 2021] pnp 00:03: [dma 2]
[Mon Jan 25 19:01:45 2021] pnp 00:03: Plug and Play ACPI device, IDs PNP0700 (active)
[Mon Jan 25 19:01:45 2021] pnp 00:04: Plug and Play ACPI device, IDs PNP0501 (active)
[Mon Jan 25 19:01:45 2021] pnp: PnP ACPI: found 5 devices
[Mon Jan 25 19:01:45 2021] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[Mon Jan 25 19:01:45 2021] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[Mon Jan 25 19:01:45 2021] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[Mon Jan 25 19:01:45 2021] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[Mon Jan 25 19:01:45 2021] pci_bus 0000:00: resource 7 [mem 0xc0000000-0xfebfffff window]
[Mon Jan 25 19:01:45 2021] pci_bus 0000:00: resource 8 [mem 0x240000000-0x2bfffffff window]
[Mon Jan 25 19:01:45 2021] NET: Registered protocol family 2
[Mon Jan 25 19:01:45 2021] tcp_listen_portaddr_hash hash table entries: 4096 (order: 4, 65536 bytes)
[Mon Jan 25 19:01:45 2021] TCP established hash table entries: 65536 (order: 7, 524288 bytes)
[Mon Jan 25 19:01:45 2021] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[Mon Jan 25 19:01:45 2021] TCP: Hash tables configured (established 65536 bind 65536)
[Mon Jan 25 19:01:45 2021] UDP hash table entries: 4096 (order: 5, 131072 bytes)
[Mon Jan 25 19:01:45 2021] UDP-Lite hash table entries: 4096 (order: 5, 131072 bytes)
[Mon Jan 25 19:01:45 2021] NET: Registered protocol family 1
[Mon Jan 25 19:01:45 2021] pci 0000:00:01.0: PIIX3: Enabling Passive Release
[Mon Jan 25 19:01:45 2021] pci 0000:00:00.0: Limiting direct PCI/PCI transfers
[Mon Jan 25 19:01:45 2021] pci 0000:00:01.0: Activating ISA DMA hang workarounds
[Mon Jan 25 19:01:45 2021] PCI Interrupt Link [LNKB] enabled at IRQ 10
[Mon Jan 25 19:01:45 2021] pci 0000:00:02.0: quirk_usb_early_handoff+0x0/0x6d0 took 42886 usecs
[Mon Jan 25 19:01:45 2021] PCI Interrupt Link [LNKC] enabled at IRQ 11
[Mon Jan 25 19:01:45 2021] pci 0000:00:02.1: quirk_usb_early_handoff+0x0/0x6d0 took 42666 usecs
[Mon Jan 25 19:01:45 2021] PCI Interrupt Link [LNKD] enabled at IRQ 11
[Mon Jan 25 19:01:45 2021] pci 0000:00:02.2: quirk_usb_early_handoff+0x0/0x6d0 took 42696 usecs
[Mon Jan 25 19:01:45 2021] PCI Interrupt Link [LNKA] enabled at IRQ 10
[Mon Jan 25 19:01:45 2021] pci 0000:00:02.7: quirk_usb_early_handoff+0x0/0x6d0 took 42673 usecs
[Mon Jan 25 19:01:45 2021] PCI: CLS 0 bytes, default 64
[Mon Jan 25 19:01:45 2021] Unpacking initramfs...
[Mon Jan 25 19:01:45 2021] Freeing initrd memory: 18052K
[Mon Jan 25 19:01:45 2021] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[Mon Jan 25 19:01:45 2021] software IO TLB: mapped [mem 0xbbfdf000-0xbffdf000] (64MB)
[Mon Jan 25 19:01:45 2021] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x1fb623c7bdc, max_idle_ns: 440795310953 ns
[Mon Jan 25 19:01:45 2021] Initialise system trusted keyrings
[Mon Jan 25 19:01:45 2021] workingset: timestamp_bits=36 max_order=21 bucket_order=0
[Mon Jan 25 19:01:45 2021] zbud: loaded
[Mon Jan 25 19:01:45 2021] NET: Registered protocol family 38
[Mon Jan 25 19:01:45 2021] Key type asymmetric registered
[Mon Jan 25 19:01:45 2021] Asymmetric key parser 'x509' registered
[Mon Jan 25 19:01:45 2021] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 247)
[Mon Jan 25 19:01:45 2021] io scheduler noop registered
[Mon Jan 25 19:01:45 2021] io scheduler deadline registered (default)
[Mon Jan 25 19:01:45 2021] io scheduler cfq registered
[Mon Jan 25 19:01:45 2021] intel_idle: Please enable MWAIT in BIOS SETUP
[Mon Jan 25 19:01:45 2021] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
[Mon Jan 25 19:01:45 2021] ACPI: Power Button [PWRF]
[Mon Jan 25 19:01:45 2021] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[Mon Jan 25 19:01:45 2021] 00:04: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[Mon Jan 25 19:01:45 2021] Non-volatile memory driver v1.3
[Mon Jan 25 19:01:45 2021] Linux agpgart interface v0.103
[Mon Jan 25 19:01:45 2021] rdac: device handler registered
[Mon Jan 25 19:01:45 2021] hp_sw: device handler registered
[Mon Jan 25 19:01:45 2021] emc: device handler registered
[Mon Jan 25 19:01:45 2021] alua: device handler registered
[Mon Jan 25 19:01:45 2021] libphy: Fixed MDIO Bus: probed
[Mon Jan 25 19:01:45 2021] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[Mon Jan 25 19:01:45 2021] ehci-pci: EHCI PCI platform driver
[Mon Jan 25 19:01:46 2021] ehci-pci 0000:00:02.7: EHCI Host Controller
[Mon Jan 25 19:01:46 2021] ehci-pci 0000:00:02.7: new USB bus registered, assigned bus number 1
[Mon Jan 25 19:01:46 2021] ehci-pci 0000:00:02.7: irq 10, io mem 0xfebf8000
[Mon Jan 25 19:01:46 2021] ehci-pci 0000:00:02.7: USB 2.0 started, EHCI 1.00
[Mon Jan 25 19:01:46 2021] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 4.19
[Mon Jan 25 19:01:46 2021] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[Mon Jan 25 19:01:46 2021] usb usb1: Product: EHCI Host Controller
[Mon Jan 25 19:01:46 2021] usb usb1: Manufacturer: Linux 4.19.163-1.el7.x86_64 ehci_hcd
[Mon Jan 25 19:01:46 2021] usb usb1: SerialNumber: 0000:00:02.7
[Mon Jan 25 19:01:46 2021] hub 1-0:1.0: USB hub found
[Mon Jan 25 19:01:46 2021] hub 1-0:1.0: 6 ports detected
[Mon Jan 25 19:01:46 2021] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[Mon Jan 25 19:01:46 2021] ohci-pci: OHCI PCI platform driver
[Mon Jan 25 19:01:46 2021] uhci_hcd: USB Universal Host Controller Interface driver
[Mon Jan 25 19:01:46 2021] uhci_hcd 0000:00:02.0: UHCI Host Controller
[Mon Jan 25 19:01:46 2021] uhci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 2
[Mon Jan 25 19:01:46 2021] uhci_hcd 0000:00:02.0: detected 2 ports
[Mon Jan 25 19:01:46 2021] uhci_hcd 0000:00:02.0: irq 10, io base 0x0000c000
[Mon Jan 25 19:01:46 2021] usb usb2: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 4.19
[Mon Jan 25 19:01:46 2021] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[Mon Jan 25 19:01:46 2021] usb usb2: Product: UHCI Host Controller
[Mon Jan 25 19:01:46 2021] usb usb2: Manufacturer: Linux 4.19.163-1.el7.x86_64 uhci_hcd
[Mon Jan 25 19:01:46 2021] usb usb2: SerialNumber: 0000:00:02.0
[Mon Jan 25 19:01:46 2021] hub 2-0:1.0: USB hub found
[Mon Jan 25 19:01:46 2021] hub 2-0:1.0: 2 ports detected
[Mon Jan 25 19:01:46 2021] uhci_hcd 0000:00:02.1: UHCI Host Controller
[Mon Jan 25 19:01:46 2021] uhci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 3
[Mon Jan 25 19:01:46 2021] uhci_hcd 0000:00:02.1: detected 2 ports
[Mon Jan 25 19:01:46 2021] uhci_hcd 0000:00:02.1: irq 11, io base 0x0000c020
[Mon Jan 25 19:01:46 2021] usb usb3: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 4.19
[Mon Jan 25 19:01:46 2021] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[Mon Jan 25 19:01:46 2021] usb usb3: Product: UHCI Host Controller
[Mon Jan 25 19:01:46 2021] usb usb3: Manufacturer: Linux 4.19.163-1.el7.x86_64 uhci_hcd
[Mon Jan 25 19:01:46 2021] usb usb3: SerialNumber: 0000:00:02.1
[Mon Jan 25 19:01:46 2021] hub 3-0:1.0: USB hub found
[Mon Jan 25 19:01:46 2021] hub 3-0:1.0: 2 ports detected
[Mon Jan 25 19:01:46 2021] uhci_hcd 0000:00:02.2: UHCI Host Controller
[Mon Jan 25 19:01:46 2021] uhci_hcd 0000:00:02.2: new USB bus registered, assigned bus number 4
[Mon Jan 25 19:01:46 2021] uhci_hcd 0000:00:02.2: detected 2 ports
[Mon Jan 25 19:01:46 2021] uhci_hcd 0000:00:02.2: irq 11, io base 0x0000c040
[Mon Jan 25 19:01:46 2021] usb usb4: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 4.19
[Mon Jan 25 19:01:46 2021] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[Mon Jan 25 19:01:46 2021] usb usb4: Product: UHCI Host Controller
[Mon Jan 25 19:01:46 2021] usb usb4: Manufacturer: Linux 4.19.163-1.el7.x86_64 uhci_hcd
[Mon Jan 25 19:01:46 2021] usb usb4: SerialNumber: 0000:00:02.2
[Mon Jan 25 19:01:46 2021] hub 4-0:1.0: USB hub found
[Mon Jan 25 19:01:46 2021] hub 4-0:1.0: 2 ports detected
[Mon Jan 25 19:01:46 2021] usbcore: registered new interface driver usbserial_generic
[Mon Jan 25 19:01:46 2021] usbserial: USB Serial support registered for generic
[Mon Jan 25 19:01:46 2021] usbcore: registered new interface driver wishbone_serial
[Mon Jan 25 19:01:46 2021] usbserial: USB Serial support registered for wishbone_serial
[Mon Jan 25 19:01:46 2021] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
[Mon Jan 25 19:01:46 2021] serio: i8042 KBD port at 0x60,0x64 irq 1
[Mon Jan 25 19:01:46 2021] serio: i8042 AUX port at 0x60,0x64 irq 12
[Mon Jan 25 19:01:46 2021] mousedev: PS/2 mouse device common for all mice
[Mon Jan 25 19:01:46 2021] rtc_cmos 00:00: RTC can wake from S4
[Mon Jan 25 19:01:46 2021] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input1
[Mon Jan 25 19:01:46 2021] rtc_cmos 00:00: registered as rtc0
[Mon Jan 25 19:01:46 2021] rtc_cmos 00:00: alarms up to one day, y3k, 114 bytes nvram
[Mon Jan 25 19:01:46 2021] input: VirtualPS/2 VMware VMMouse as /devices/platform/i8042/serio1/input/input4
[Mon Jan 25 19:01:46 2021] ledtrig-cpu: registered to indicate activity on CPUs
[Mon Jan 25 19:01:46 2021] hidraw: raw HID events driver (C) Jiri Kosina
[Mon Jan 25 19:01:46 2021] input: VirtualPS/2 VMware VMMouse as /devices/platform/i8042/serio1/input/input3
[Mon Jan 25 19:01:46 2021] usbcore: registered new interface driver usbhid
[Mon Jan 25 19:01:46 2021] usbhid: USB HID core driver
[Mon Jan 25 19:01:46 2021] drop_monitor: Initializing network drop monitor service
[Mon Jan 25 19:01:46 2021] Initializing XFRM netlink socket
[Mon Jan 25 19:01:46 2021] NET: Registered protocol family 10
[Mon Jan 25 19:01:46 2021] Segment Routing with IPv6
[Mon Jan 25 19:01:46 2021] NET: Registered protocol family 17
[Mon Jan 25 19:01:46 2021] Bridge firewalling registered
[Mon Jan 25 19:01:46 2021] mce: Using 10 MCE banks
[Mon Jan 25 19:01:46 2021] sched_clock: Marking stable (1099211456, 986748)->(1316555649, -216357445)
[Mon Jan 25 19:01:46 2021] registered taskstats version 1
[Mon Jan 25 19:01:46 2021] Loading compiled-in X.509 certificates
[Mon Jan 25 19:01:46 2021] zswap: loaded using pool lzo/zbud
[Mon Jan 25 19:01:46 2021] Key type big_key registered
[Mon Jan 25 19:01:46 2021] Key type trusted registered
[Mon Jan 25 19:01:46 2021] Key type encrypted registered
[Mon Jan 25 19:01:46 2021] ima: No TPM chip found, activating TPM-bypass!
[Mon Jan 25 19:01:46 2021] ima: Allocated hash algorithm: sha1
[Mon Jan 25 19:01:46 2021] evm: Initialising EVM extended attributes:
[Mon Jan 25 19:01:46 2021] evm: security.selinux
[Mon Jan 25 19:01:46 2021] evm: security.ima
[Mon Jan 25 19:01:46 2021] evm: security.capability
[Mon Jan 25 19:01:46 2021] evm: HMAC attrs: 0x1
[Mon Jan 25 19:01:46 2021] rtc_cmos 00:00: setting system clock to 2021-01-26 02:01:46 UTC (1611626506)
[Mon Jan 25 19:01:46 2021] Freeing unused kernel image memory: 2356K
[Mon Jan 25 19:01:46 2021] Write protecting the kernel read-only data: 18432k
[Mon Jan 25 19:01:46 2021] Freeing unused kernel image memory: 2012K
[Mon Jan 25 19:01:46 2021] Freeing unused kernel image memory: 488K
[Mon Jan 25 19:01:46 2021] Run /init as init process
[Mon Jan 25 19:01:46 2021] random: systemd: uninitialized urandom read (16 bytes read)
[Mon Jan 25 19:01:46 2021] random: systemd: uninitialized urandom read (16 bytes read)
[Mon Jan 25 19:01:46 2021] random: systemd: uninitialized urandom read (16 bytes read)
[Mon Jan 25 19:01:46 2021] systemd[1]: systemd 219 running in system mode. (+PAM +AUDIT +SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 -SECCOMP +BLKID +ELFUTILS +KMOD +IDN)
[Mon Jan 25 19:01:46 2021] systemd[1]: Detected virtualization kvm.
[Mon Jan 25 19:01:46 2021] systemd[1]: Detected architecture x86-64.
[Mon Jan 25 19:01:46 2021] systemd[1]: Running in initial RAM disk.
[Mon Jan 25 19:01:46 2021] systemd[1]: Set hostname to <localhost.localdomain>.
[Mon Jan 25 19:01:46 2021] systemd[1]: Created slice Root Slice.
[Mon Jan 25 19:01:46 2021] systemd[1]: Created slice System Slice.
[Mon Jan 25 19:01:46 2021] systemd[1]: Reached target Slices.
[Mon Jan 25 19:01:46 2021] systemd[1]: Listening on Journal Socket.
[Mon Jan 25 19:01:46 2021] systemd[1]: Reached target Local File Systems.
[Mon Jan 25 19:01:46 2021] ixgbevf: Intel(R) 10 Gigabit PCI Express Virtual Function Network Driver - version 4.1.0-k
[Mon Jan 25 19:01:46 2021] ixgbevf: Copyright (c) 2009 - 2015 Intel Corporation.
[Mon Jan 25 19:01:46 2021] libata version 3.00 loaded.
[Mon Jan 25 19:01:46 2021] ata_piix 0000:00:01.1: version 2.13
[Mon Jan 25 19:01:46 2021] scsi host0: ata_piix
[Mon Jan 25 19:01:46 2021] FDC 0 is a S82078B
[Mon Jan 25 19:01:46 2021] ahci 0000:00:03.0: version 3.0
[Mon Jan 25 19:01:46 2021] scsi host1: ata_piix
[Mon Jan 25 19:01:46 2021] ata1: PATA max MWDMA2 cmd 0x1f0 ctl 0x3f6 bmdma 0xc0a0 irq 14
[Mon Jan 25 19:01:46 2021] ata2: PATA max MWDMA2 cmd 0x170 ctl 0x376 bmdma 0xc0a8 irq 15
[Mon Jan 25 19:01:46 2021] ixgbevf 0000:00:05.0: 52:54:00:96:b8:bb
[Mon Jan 25 19:01:46 2021] ixgbevf 0000:00:05.0: MAC: 3
[Mon Jan 25 19:01:46 2021] ixgbevf 0000:00:05.0: Intel(R) X550 Virtual Function
[Mon Jan 25 19:01:46 2021] ahci 0000:00:03.0: AHCI 0001.0000 32 slots 6 ports 1.5 Gbps 0x3f impl SATA mode
[Mon Jan 25 19:01:46 2021] ahci 0000:00:03.0: flags: 64bit ncq only
[Mon Jan 25 19:01:46 2021] scsi host2: ahci
[Mon Jan 25 19:01:46 2021] scsi host3: ahci
[Mon Jan 25 19:01:46 2021] scsi host4: ahci
[Mon Jan 25 19:01:46 2021] scsi host5: ahci
[Mon Jan 25 19:01:46 2021] scsi host6: ahci
[Mon Jan 25 19:01:46 2021] scsi host7: ahci
[Mon Jan 25 19:01:46 2021] ata3: SATA max UDMA/133 abar m4096 at 0xfebf9000 port 0xfebf9100 irq 27
[Mon Jan 25 19:01:46 2021] ata4: SATA max UDMA/133 abar m4096 at 0xfebf9000 port 0xfebf9180 irq 27
[Mon Jan 25 19:01:46 2021] ata5: SATA max UDMA/133 abar m4096 at 0xfebf9000 port 0xfebf9200 irq 27
[Mon Jan 25 19:01:46 2021] ata6: SATA max UDMA/133 abar m4096 at 0xfebf9000 port 0xfebf9280 irq 27
[Mon Jan 25 19:01:46 2021] ata7: SATA max UDMA/133 abar m4096 at 0xfebf9000 port 0xfebf9300 irq 27
[Mon Jan 25 19:01:46 2021] ata8: SATA max UDMA/133 abar m4096 at 0xfebf9000 port 0xfebf9380 irq 27
[Mon Jan 25 19:01:46 2021] ata5: SATA link down (SStatus 0 SControl 300)
[Mon Jan 25 19:01:46 2021] ata4: SATA link down (SStatus 0 SControl 300)
[Mon Jan 25 19:01:46 2021] ata6: SATA link down (SStatus 0 SControl 300)
[Mon Jan 25 19:01:46 2021] ata8: SATA link down (SStatus 0 SControl 300)
[Mon Jan 25 19:01:46 2021] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[Mon Jan 25 19:01:46 2021] ata3.00: ATA-7: QEMU HARDDISK, 2.5+, max UDMA/100
[Mon Jan 25 19:01:46 2021] ata3.00: 104857600 sectors, multi 16: LBA48 NCQ (depth 32)
[Mon Jan 25 19:01:46 2021] ata3.00: applying bridge limits
[Mon Jan 25 19:01:46 2021] ata7: SATA link down (SStatus 0 SControl 300)
[Mon Jan 25 19:01:46 2021] ata3.00: configured for UDMA/100
[Mon Jan 25 19:01:46 2021] scsi 2:0:0:0: Direct-Access     ATA      QEMU HARDDISK    2.5+ PQ: 0 ANSI: 5
[Mon Jan 25 19:01:46 2021] sd 2:0:0:0: [sda] 104857600 512-byte logical blocks: (53.7 GB/50.0 GiB)
[Mon Jan 25 19:01:46 2021] sd 2:0:0:0: [sda] Write Protect is off
[Mon Jan 25 19:01:46 2021] sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
[Mon Jan 25 19:01:46 2021] sd 2:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[Mon Jan 25 19:01:46 2021]  sda: sda1 sda2 sda3
[Mon Jan 25 19:01:46 2021] sd 2:0:0:0: [sda] Attached SCSI disk
[Mon Jan 25 19:01:51 2021] SGI XFS with ACLs, security attributes, no debug enabled
[Mon Jan 25 19:01:51 2021] XFS (sda3): Mounting V4 Filesystem
[Mon Jan 25 19:01:51 2021] XFS (sda3): Ending clean mount
[Mon Jan 25 19:01:51 2021] systemd-journald[149]: Received SIGTERM from PID 1 (systemd).
[Mon Jan 25 19:01:51 2021] random: fast init done
[Mon Jan 25 19:01:51 2021] systemd: 15 output lines suppressed due to ratelimiting
[Mon Jan 25 19:01:52 2021] SELinux:  Disabled at runtime.
[Mon Jan 25 19:01:52 2021] audit: type=1404 audit(1611626512.750:2): enforcing=0 old_enforcing=0 auid=4294967295 ses=4294967295 enabled=0 old-enabled=1 lsm=selinux res=1
[Mon Jan 25 19:01:52 2021] systemd[1]: Inserted module 'ip_tables'
[Mon Jan 25 19:01:52 2021] random: crng init done
[Mon Jan 25 19:01:52 2021] random: 7 urandom warning(s) missed due to ratelimiting
[Mon Jan 25 19:01:53 2021] systemd-journald[435]: Received request to flush runtime journal from PID 1
[Mon Jan 25 19:01:53 2021] piix4_smbus 0000:00:01.3: SMBus Host Controller at 0x700, revision 0
[Mon Jan 25 19:01:53 2021] input: PC Speaker as /devices/platform/pcspkr/input/input5
[Mon Jan 25 19:01:53 2021] sd 2:0:0:0: Attached scsi generic sg0 type 0
[Mon Jan 25 19:01:53 2021] Adding 2098172k swap on /dev/sda2.  Priority:-2 extents:1 across:2098172k FS
[Mon Jan 25 19:01:53 2021] XFS (sda1): Mounting V4 Filesystem
[Mon Jan 25 19:01:53 2021] cryptd: max_cpu_qlen set to 1000
[Mon Jan 25 19:01:53 2021] AVX2 version of gcm_enc/dec engaged.
[Mon Jan 25 19:01:53 2021] AES CTR mode by8 optimization enabled
[Mon Jan 25 19:01:53 2021] alg: No test for pcbc(aes) (pcbc-aes-aesni)
[Mon Jan 25 19:01:54 2021] XFS (sda1): Ending clean mount
[Mon Jan 25 19:01:54 2021] RPC: Registered named UNIX socket transport module.
[Mon Jan 25 19:01:54 2021] RPC: Registered udp transport module.
[Mon Jan 25 19:01:54 2021] RPC: Registered tcp transport module.
[Mon Jan 25 19:01:54 2021] RPC: Registered tcp NFSv4.1 backchannel transport module.
[Mon Jan 25 19:01:54 2021] Ethernet Channel Bonding Driver: v3.7.1 (April 27, 2011)
[Mon Jan 25 19:01:54 2021] bonding: bond0 is being created...
[Mon Jan 25 19:01:54 2021] bonding: bond0 already exists
[Mon Jan 25 19:01:55 2021] IPv6: ADDRCONF(NETDEV_UP): bond0: link is not ready
[Mon Jan 25 19:01:55 2021] ixgbevf 0000:00:05.0: NIC Link is Up 10 Gbps
[Mon Jan 25 19:01:55 2021] bond0: Enslaving eth0 as an active interface with an up link
[Mon Jan 25 19:01:55 2021] IPv6: ADDRCONF(NETDEV_UP): bond0: link is not ready
[Mon Jan 25 19:01:55 2021] IPv6: ADDRCONF(NETDEV_CHANGE): bond0: link becomes ready
[Mon Jan 25 19:02:20 2021] HTB: quantum of class 10010 is big. Consider r2q change.
[Mon Jan 25 19:02:20 2021] u32 classifier
[Mon Jan 25 19:02:20 2021]     Performance counters on
[Mon Jan 25 19:02:20 2021]     input device check on
[Mon Jan 25 19:02:20 2021]     Actions configured
[Mon Jan 25 19:02:20 2021] GACT probability on
[Mon Jan 25 19:02:20 2021] Mirror/redirect action on
[Mon Jan 25 19:02:20 2021] PPP generic driver version 2.4.2
[Mon Jan 25 19:02:20 2021] NET: Registered protocol family 24
[Mon Jan 25 19:02:20 2021] l2tp_core: L2TP core driver, V2.0
[Mon Jan 25 19:02:20 2021] l2tp_netlink: L2TP netlink interface
[Mon Jan 25 19:02:20 2021] l2tp_ppp: PPPoL2TP kernel driver, V2.0
[Mon Jan 25 19:02:20 2021] tun: Universal TUN/TAP device driver, 1.6
[Mon Jan 25 19:02:21 2021] tcrypt: one or more tests failed!
[Mon Jan 25 19:02:21 2021] NET: Registered protocol family 15
[Mon Jan 25 19:02:21 2021] tcrypt: one or more tests failed!
[Mon Jan 25 19:02:34 2021] alg: No test for echainiv(authenc(hmac(sha256),cbc(aes))) (echainiv(pcrypt(authenc(hmac(sha256-generic),cbc-aes-aesni))))
[Mon Jan 25 19:03:57 2021] alg: No test for echainiv(authenc(hmac(sha1),cbc(aes))) (echainiv(pcrypt(authenc(hmac(sha1-generic),cbc-aes-aesni))))
[Mon Jan 25 20:11:33 2021] nf_conntrack: default automatic helper assignment has been turned off for security reasons and CT-based  firewall rule not found. Use the iptables CT target to attach helpers instead.
[Mon Jan 25 21:27:27 2021] TCP: request_sock_TCP: Possible SYN flooding on port 1080. Sending cookies.  Check SNMP counters.
[Mon Jan 25 21:47:10 2021] TCP: bond0: Driver has suspect GRO implementation, TCP performance may be compromised.
[Mon Jan 25 22:27:34 2021] PPP MPPE Compression module registered
[Tue Jan 26 11:49:48 2021] wireguard: WireGuard 1.0.20200908 loaded. See www.wireguard.com for information.
[Tue Jan 26 11:49:48 2021] wireguard: Copyright (C) 2015-2019 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
[Wed Jan 27 09:48:52 2021] htb: too many events!
[Tue Feb  2 05:00:16 2021] audit: audit_backlog=321 > audit_backlog_limit=320
[Tue Feb  2 05:00:16 2021] audit: audit_lost=1 audit_rate_limit=0 audit_backlog_limit=320
[Tue Feb  2 05:00:16 2021] audit: backlog limit exceeded
[Tue Feb  2 05:00:16 2021] audit: audit_backlog=321 > audit_backlog_limit=320
[Tue Feb  2 05:00:16 2021] audit: audit_lost=2 audit_rate_limit=0 audit_backlog_limit=320
[Tue Feb  2 05:00:16 2021] audit: backlog limit exceeded
[Tue Feb  2 05:00:16 2021] audit: audit_backlog=321 > audit_backlog_limit=320
[Tue Feb  2 05:00:16 2021] audit: audit_lost=3 audit_rate_limit=0 audit_backlog_limit=320
[Tue Feb  2 05:00:16 2021] audit: backlog limit exceeded
[Tue Feb  2 05:00:16 2021] audit: audit_backlog=321 > audit_backlog_limit=320
[Mon Feb  8 03:55:00 2021] PPP BSD Compression module registered
[Mon Feb  8 03:55:00 2021] PPP Deflate Compression module registered
[Tue Feb  9 12:03:03 2021] device bond0 entered promiscuous mode
[Tue Feb  9 12:03:03 2021] device eth0 entered promiscuous mode
[Tue Feb  9 12:03:03 2021] device bond0 left promiscuous mode
[Tue Feb  9 12:03:03 2021] device eth0 left promiscuous mode
[Tue Feb  9 12:11:51 2021] device bond0 entered promiscuous mode
[Tue Feb  9 12:11:51 2021] device eth0 entered promiscuous mode
[Tue Feb  9 12:11:51 2021] device bond0 left promiscuous mode
[Tue Feb  9 12:11:51 2021] device eth0 left promiscuous mode
[Tue Feb  9 17:07:35 2021] device bond0 entered promiscuous mode
[Tue Feb  9 17:07:35 2021] device eth0 entered promiscuous mode
[Tue Feb  9 17:07:45 2021] device bond0 left promiscuous mode
[Tue Feb  9 17:07:45 2021] device eth0 left promiscuous mode
[Tue Feb  9 17:07:48 2021] device bond0 entered promiscuous mode
[Tue Feb  9 17:07:48 2021] device eth0 entered promiscuous mode
[Tue Feb  9 17:07:53 2021] device bond0 left promiscuous mode
[Tue Feb  9 17:07:53 2021] device eth0 left promiscuous mode
[Tue Feb  9 17:07:59 2021] device bond0 entered promiscuous mode
[Tue Feb  9 17:07:59 2021] device eth0 entered promiscuous mode
[Tue Feb  9 17:33:15 2021] device bond0 left promiscuous mode
[Tue Feb  9 17:33:15 2021] device eth0 left promiscuous mode
[Wed Feb 10 17:14:43 2021] audit_log_start: 365 callbacks suppressed
[Wed Feb 10 17:14:43 2021] audit: audit_backlog=321 > audit_backlog_limit=320
[Wed Feb 10 17:14:43 2021] audit: audit_lost=126 audit_rate_limit=0 audit_backlog_limit=320
[Wed Feb 10 17:14:43 2021] audit: backlog limit exceeded
[Wed Feb 10 17:14:43 2021] audit: audit_backlog=321 > audit_backlog_limit=320
[Wed Feb 10 17:14:43 2021] audit: audit_lost=127 audit_rate_limit=0 audit_backlog_limit=320
[Wed Feb 10 17:14:43 2021] audit: backlog limit exceeded
[Wed Feb 10 17:14:43 2021] audit: audit_backlog=321 > audit_backlog_limit=320
[Wed Feb 10 17:14:43 2021] audit: audit_lost=128 audit_rate_limit=0 audit_backlog_limit=320
[Wed Feb 10 17:14:43 2021] audit: backlog limit exceeded
[Wed Feb 10 17:14:43 2021] audit: audit_backlog=321 > audit_backlog_limit=320
[Thu Feb 11 19:25:11 2021] device bond0 entered promiscuous mode
[Thu Feb 11 19:25:11 2021] device eth0 entered promiscuous mode
[Thu Feb 11 19:25:11 2021] device bond0 left promiscuous mode
[Thu Feb 11 19:25:11 2021] device eth0 left promiscuous mode
[Thu Feb 11 19:25:33 2021] device bond0 entered promiscuous mode
[Thu Feb 11 19:25:33 2021] device eth0 entered promiscuous mode
[Thu Feb 11 19:25:33 2021] device bond0 left promiscuous mode
[Thu Feb 11 19:25:33 2021] device eth0 left promiscuous mode
[Thu Feb 11 23:37:47 2021] device bond0 entered promiscuous mode
[Thu Feb 11 23:37:47 2021] device eth0 entered promiscuous mode
[Thu Feb 11 23:37:47 2021] device bond0 left promiscuous mode
[Thu Feb 11 23:37:47 2021] device eth0 left promiscuous mode
[Fri Feb 12 04:16:58 2021] TCP: request_sock_TCP: Possible SYN flooding on port 1080. Sending cookies.  Check SNMP counters.
[Fri Feb 12 10:01:28 2021] device bond0 entered promiscuous mode
[Fri Feb 12 10:01:28 2021] device eth0 entered promiscuous mode
[Fri Feb 12 10:01:29 2021] device bond0 left promiscuous mode
[Fri Feb 12 10:01:29 2021] device eth0 left promiscuous mode
[Fri Feb 12 10:42:38 2021] device bond0 entered promiscuous mode
[Fri Feb 12 10:42:38 2021] device eth0 entered promiscuous mode
[Fri Feb 12 10:42:42 2021] device bond0 left promiscuous mode
[Fri Feb 12 10:42:42 2021] device eth0 left promiscuous mode
[Fri Feb 12 10:42:55 2021] device bond0 entered promiscuous mode
[Fri Feb 12 10:42:55 2021] device eth0 entered promiscuous mode
[Fri Feb 12 10:43:16 2021] device bond0 left promiscuous mode
[Fri Feb 12 10:43:16 2021] device eth0 left promiscuous mode
[Fri Feb 12 11:07:44 2021] device bond0 entered promiscuous mode
[Fri Feb 12 11:07:44 2021] device eth0 entered promiscuous mode
[Fri Feb 12 11:07:46 2021] device bond0 left promiscuous mode
[Fri Feb 12 11:07:46 2021] device eth0 left promiscuous mode
[Fri Feb 12 11:07:53 2021] device bond0 entered promiscuous mode
[Fri Feb 12 11:07:53 2021] device eth0 entered promiscuous mode
[Fri Feb 12 11:07:57 2021] device bond0 left promiscuous mode
[Fri Feb 12 11:07:57 2021] device eth0 left promiscuous mode
-------------- next part --------------
[    0.000000] Linux version 4.19.163-1.el7.x86_64 (redacted) (gcc version 4.8.5 20150623 (Red Hat 4.8.5-44) (GCC)) #1 SMP Wed Dec 16 14:11:11 MST 2020
[    0.000000] Command line: BOOT_IMAGE=/vmlinuz-4.19.163-1.el7.x86_64 root=UUID=33edf4f6-97cb-494b-9233-a2c456ea87a9 ro crashkernel=auto rhgb quiet net.ifnames=0 biosdevname=0 console=ttyS0 LANG=en_US.UTF-8
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'standard' format.
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000bffdefff] usable
[    0.000000] BIOS-e820: [mem 0x00000000bffdf000-0x00000000bfffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000feffc000-0x00000000feffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000023fffffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.8 present.
[    0.000000] DMI: Red Hat KVM, BIOS 1.11.0-2.el7 04/01/2014
[    0.000000] Hypervisor detected: KVM
[    0.000000] kvm-clock: Using msrs 4b564d01 and 4b564d00
[    0.000000] kvm-clock: cpu 0, msr 272b001, primary cpu clock
[    0.000000] kvm-clock: using sched offset of 6056013974 cycles
[    0.000002] clocksource: kvm-clock: mask: 0xffffffffffffffff max_cycles: 0x1cd42e4dffb, max_idle_ns: 881590591483 ns
[    0.000004] tsc: Detected 2299.996 MHz processor
[    0.000662] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000663] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000667] last_pfn = 0x240000 max_arch_pfn = 0x400000000
[    0.000705] MTRR default type: write-back
[    0.000706] MTRR fixed ranges enabled:
[    0.000707]   00000-9FFFF write-back
[    0.000707]   A0000-BFFFF uncachable
[    0.000708]   C0000-FFFFF write-protect
[    0.000709] MTRR variable ranges enabled:
[    0.000710]   0 base 0000C0000000 mask FFFFC0000000 uncachable
[    0.000713]   1 disabled
[    0.000714]   2 disabled
[    0.000714]   3 disabled
[    0.000715]   4 disabled
[    0.000715]   5 disabled
[    0.000715]   6 disabled
[    0.000715]   7 disabled
[    0.000730] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT
[    0.000739] last_pfn = 0xbffdf max_arch_pfn = 0x400000000
[    0.003739] found SMP MP-table at [mem 0x000f6350-0x000f635f]
[    0.004049] Using GB pages for direct mapping
[    0.004503] RAMDISK: [mem 0x35caf000-0x36e4ffff]
[    0.004525] ACPI: Early table checksum verification disabled
[    0.004597] ACPI: RSDP 0x00000000000F6300 000014 (v00 BOCHS )
[    0.004601] ACPI: RSDT 0x00000000BFFE12F2 00002C (v01 BOCHS  BXPCRSDT 00000001 BXPC 00000001)
[    0.004608] ACPI: FACP 0x00000000BFFE11EE 000074 (v01 BOCHS  BXPCFACP 00000001 BXPC 00000001)
[    0.004614] ACPI: DSDT 0x00000000BFFDFD40 0014AE (v01 BOCHS  BXPCDSDT 00000001 BXPC 00000001)
[    0.004618] ACPI: FACS 0x00000000BFFDFD00 000040
[    0.004620] ACPI: APIC 0x00000000BFFE1262 000090 (v01 BOCHS  BXPCAPIC 00000001 BXPC 00000001)
[    0.004629] ACPI: Local APIC address 0xfee00000
[    0.005117] No NUMA configuration found
[    0.005119] Faking a node at [mem 0x0000000000000000-0x000000023fffffff]
[    0.005128] NODE_DATA(0) allocated [mem 0x23ffd4000-0x23fffdfff]
[    0.005595] crashkernel: memory value expected
[    0.005629] Zone ranges:
[    0.005630]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.005631]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.005632]   Normal   [mem 0x0000000100000000-0x000000023fffffff]
[    0.005633]   Device   empty
[    0.005635] Movable zone start for each node
[    0.005637] Early memory node ranges
[    0.005638]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.005639]   node   0: [mem 0x0000000000100000-0x00000000bffdefff]
[    0.005640]   node   0: [mem 0x0000000100000000-0x000000023fffffff]
[    0.005678] Zeroed struct page in unavailable ranges: 131 pages
[    0.005680] Initmem setup node 0 [mem 0x0000000000001000-0x000000023fffffff]
[    0.005681] On node 0 totalpages: 2097021
[    0.005682]   DMA zone: 64 pages used for memmap
[    0.005683]   DMA zone: 21 pages reserved
[    0.005684]   DMA zone: 3998 pages, LIFO batch:0
[    0.005952]   DMA32 zone: 12224 pages used for memmap
[    0.005953]   DMA32 zone: 782303 pages, LIFO batch:63
[    0.049570]   Normal zone: 20480 pages used for memmap
[    0.049573]   Normal zone: 1310720 pages, LIFO batch:63
[    0.120182] ACPI: PM-Timer IO Port: 0x608
[    0.120186] ACPI: Local APIC address 0xfee00000
[    0.120197] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
[    0.120238] IOAPIC[0]: apic_id 0, version 17, address 0xfec00000, GSI 0-23
[    0.120240] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.120242] ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high level)
[    0.120243] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.120244] ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 high level)
[    0.120245] ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 high level)
[    0.120246] ACPI: IRQ0 used by override.
[    0.120248] ACPI: IRQ5 used by override.
[    0.120249] ACPI: IRQ9 used by override.
[    0.120249] ACPI: IRQ10 used by override.
[    0.120250] ACPI: IRQ11 used by override.
[    0.120252] Using ACPI (MADT) for SMP configuration information
[    0.120254] TSC deadline timer available
[    0.120257] smpboot: Allowing 4 CPUs, 0 hotplug CPUs
[    0.120282] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.120284] PM: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
[    0.120284] PM: Registered nosave memory: [mem 0x000a0000-0x000effff]
[    0.120285] PM: Registered nosave memory: [mem 0x000f0000-0x000fffff]
[    0.120286] PM: Registered nosave memory: [mem 0xbffdf000-0xbfffffff]
[    0.120287] PM: Registered nosave memory: [mem 0xc0000000-0xfeffbfff]
[    0.120288] PM: Registered nosave memory: [mem 0xfeffc000-0xfeffffff]
[    0.120288] PM: Registered nosave memory: [mem 0xff000000-0xfffbffff]
[    0.120289] PM: Registered nosave memory: [mem 0xfffc0000-0xffffffff]
[    0.120291] [mem 0xc0000000-0xfeffbfff] available for PCI devices
[    0.120292] Booting paravirtualized kernel on KVM
[    0.120295] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.120310] random: get_random_bytes called from start_kernel+0x9b/0x533 with crng_init=0
[    0.120318] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:4 nr_cpu_ids:4 nr_node_ids:1
[    0.121581] percpu: Embedded 45 pages/cpu s145496 r8192 d30632 u524288
[    0.121589] pcpu-alloc: s145496 r8192 d30632 u524288 alloc=1*2097152
[    0.121590] pcpu-alloc: [0] 0 1 2 3
[    0.121625] KVM setup async PF for cpu 0
[    0.121631] kvm-stealtime: cpu 0, msr 237a161c0
[    0.121637] PV qspinlock hash table entries: 256 (order: 0, 4096 bytes)
[    0.121643] Built 1 zonelists, mobility grouping on.  Total pages: 2064232
[    0.121644] Policy zone: Normal
[    0.121645] Kernel command line: BOOT_IMAGE=/vmlinuz-4.19.163-1.el7.x86_64 root=UUID=33edf4f6-97cb-494b-9233-a2c456ea87a9 ro crashkernel=auto rhgb quiet net.ifnames=0 biosdevname=0 console=ttyS0 LANG=en_US.UTF-8
[    0.145435] Memory: 8145120K/8388084K available (12300K kernel code, 2509K rwdata, 3608K rodata, 2356K init, 3220K bss, 242964K reserved, 0K cma-reserved)
[    0.145541] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.145553] ftrace: allocating 36327 entries in 142 pages
[    0.163534] rcu: Hierarchical RCU implementation.
[    0.163536] rcu:     RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=4.
[    0.163538] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
[    0.165942] NR_IRQS: 524544, nr_irqs: 456, preallocated irqs: 16
[    0.166238] Console: colour *CGA 80x25
[    0.166290] console [ttyS0] enabled
[    0.166304] ACPI: Core revision 20180810
[    0.166392] APIC: Switch to symmetric I/O mode setup
[    0.166574] x2apic enabled
[    0.166763] Switched APIC routing to physical x2apic.
[    0.167852] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.167874] tsc: Marking TSC unstable due to TSCs unsynchronized
[    0.167886] Calibrating delay loop (skipped) preset value.. 4599.99 BogoMIPS (lpj=2299996)
[    0.167888] pid_max: default: 32768 minimum: 301
[    0.167918] Security Framework initialized
[    0.167919] SELinux:  Initializing.
[    0.173382] Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
[    0.175779] Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
[    0.175886] Mount-cache hash table entries: 16384 (order: 5, 131072 bytes)
[    0.176038] Mountpoint-cache hash table entries: 16384 (order: 5, 131072 bytes)
[    0.176375] x86/cpu: Activated the Intel User Mode Instruction Prevention (UMIP) CPU feature
[    0.176444] Last level iTLB entries: 4KB 512, 2MB 255, 4MB 127
[    0.176445] Last level dTLB entries: 4KB 512, 2MB 255, 4MB 127, 1GB 0
[    0.176456] unchecked MSR access error: RDMSR from 0x48 at rIP: 0xffffffff8106ab87 (native_read_msr+0x7/0x30)
[    0.176457] Call Trace:
[    0.176462]  check_bugs+0x4a/0xa63
[    0.176465]  start_kernel+0x4eb/0x533
[    0.176467]  ? set_init_arg+0x5a/0x5a
[    0.176469]  x86_64_start_reservations+0x2a/0x2c
[    0.176470]  x86_64_start_kernel+0x72/0x75
[    0.176473]  secondary_startup_64+0xa4/0xb0
[    0.176475] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    0.176478] Spectre V2 : Mitigation: Full AMD retpoline
[    0.176478] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    0.176479] Spectre V2 : Enabling Restricted Speculation for firmware calls
[    0.176486] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
[    0.176488] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl and seccomp
[    0.176781] Freeing SMP alternatives memory: 32K
[    0.179241] smpboot: CPU0: AMD EPYC Processor (with IBPB) (family: 0x17, model: 0x1, stepping: 0x2)
[    0.179377] Performance Events: Fam17h core perfctr, AMD PMU driver.
[    0.179392] ... version:                0
[    0.179393] ... bit width:              48
[    0.179393] ... generic registers:      6
[    0.179394] ... value mask:             0000ffffffffffff
[    0.179394] ... max period:             00007fffffffffff
[    0.179395] ... fixed-purpose events:   0
[    0.179395] ... event mask:             000000000000003f
[    0.179442] rcu: Hierarchical SRCU implementation.
[    0.179875] smp: Bringing up secondary CPUs ...
[    0.180016] x86: Booting SMP configuration:
[    0.180017] .... node  #0, CPUs:      #1
[    0.001775] kvm-clock: cpu 1, msr 272b041, secondary cpu clock
[    0.001775] x86/cpu: Activated the Intel User Mode Instruction Prevention (UMIP) CPU feature
[    0.001775] unchecked MSR access error: WRMSR to 0x48 (tried to write 0x0000000000000000) at rIP: 0xffffffff8106adb4 (native_write_msr+0x4/0x30)
[    0.001775] Call Trace:
[    0.001775]  ? x86_spec_ctrl_setup_ap+0x3a/0x50
[    0.001775]  identify_secondary_cpu+0x5e/0x90
[    0.001775]  smp_store_cpu_info+0x48/0x60
[    0.001775]  start_secondary+0xa6/0x200
[    0.001775]  secondary_startup_64+0xa4/0xb0
[    0.180561] KVM setup async PF for cpu 1
[    0.180561] kvm-stealtime: cpu 1, msr 237a961c0
[    0.180561]  #2
[    0.001775] kvm-clock: cpu 2, msr 272b081, secondary cpu clock
[    0.001775] x86/cpu: Activated the Intel User Mode Instruction Prevention (UMIP) CPU feature
[    0.181177] KVM setup async PF for cpu 2
[    0.181177] kvm-stealtime: cpu 2, msr 237b161c0
[    0.181177]  #3
[    0.001775] kvm-clock: cpu 3, msr 272b0c1, secondary cpu clock
[    0.001775] x86/cpu: Activated the Intel User Mode Instruction Prevention (UMIP) CPU feature
[    0.181541] KVM setup async PF for cpu 3
[    0.181541] kvm-stealtime: cpu 3, msr 237b961c0
[    0.181881] smp: Brought up 1 node, 4 CPUs
[    0.181881] smpboot: Max logical packages: 4
[    0.181881] smpboot: Total of 4 processors activated (18399.96 BogoMIPS)
[    0.189879] devtmpfs: initialized
[    0.189922] x86/mm: Memory block size: 128MB
[    0.190581] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    0.190581] futex hash table entries: 1024 (order: 4, 65536 bytes)
[    0.190924] pinctrl core: initialized pinctrl subsystem
[    0.191880] NET: Registered protocol family 16
[    0.191966] audit: initializing netlink subsys (disabled)
[    0.192012] audit: type=2000 audit(1611215303.408:1): state=initialized audit_enabled=0 res=1
[    0.192028] cpuidle: using governor menu
[    0.193075] ACPI: bus type PCI registered
[    0.193078] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.193232] PCI: Using configuration type 1 for base access
[    0.193233] PCI: Using configuration type 1 for extended access
[    0.194571] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
[    0.194571] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.194947] ACPI: Added _OSI(Module Device)
[    0.194947] ACPI: Added _OSI(Processor Device)
[    0.194948] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.194948] ACPI: Added _OSI(Processor Aggregator Device)
[    0.194949] ACPI: Added _OSI(Linux-Dell-Video)
[    0.194950] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    0.195548] ACPI: 1 ACPI AML tables successfully acquired and loaded
[    0.196630] ACPI: Interpreter enabled
[    0.196649] ACPI: (supports S0 S5)
[    0.196650] ACPI: Using IOAPIC for interrupt routing
[    0.196664] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.196791] ACPI: Enabled 2 GPEs in block 00 to 0F
[    0.199086] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.199089] acpi PNP0A03:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    0.199093] acpi PNP0A03:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    0.199377] acpiphp: Slot [3] registered
[    0.199437] acpiphp: Slot [4] registered
[    0.199495] acpiphp: Slot [5] registered
[    0.199545] acpiphp: Slot [6] registered
[    0.199593] acpiphp: Slot [7] registered
[    0.199638] acpiphp: Slot [8] registered
[    0.199685] acpiphp: Slot [9] registered
[    0.199730] acpiphp: Slot [10] registered
[    0.199771] acpiphp: Slot [11] registered
[    0.199813] acpiphp: Slot [12] registered
[    0.199854] acpiphp: Slot [13] registered
[    0.199894] acpiphp: Slot [14] registered
[    0.199942] acpiphp: Slot [15] registered
[    0.199983] acpiphp: Slot [16] registered
[    0.200020] acpiphp: Slot [17] registered
[    0.200054] acpiphp: Slot [18] registered
[    0.200088] acpiphp: Slot [19] registered
[    0.200123] acpiphp: Slot [20] registered
[    0.200160] acpiphp: Slot [21] registered
[    0.200193] acpiphp: Slot [22] registered
[    0.200230] acpiphp: Slot [23] registered
[    0.200264] acpiphp: Slot [24] registered
[    0.200299] acpiphp: Slot [25] registered
[    0.200343] acpiphp: Slot [26] registered
[    0.200406] acpiphp: Slot [27] registered
[    0.200450] acpiphp: Slot [28] registered
[    0.200496] acpiphp: Slot [29] registered
[    0.200535] acpiphp: Slot [30] registered
[    0.200573] acpiphp: Slot [31] registered
[    0.200586] PCI host bridge to bus 0000:00
[    0.200588] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.200589] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.200590] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.200591] pci_bus 0000:00: root bus resource [mem 0xc0000000-0xfebfffff window]
[    0.200592] pci_bus 0000:00: root bus resource [mem 0x240000000-0x2bfffffff window]
[    0.200593] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.200643] pci 0000:00:00.0: [8086:1237] type 00 class 0x060000
[    0.201438] pci 0000:00:01.0: [8086:7000] type 00 class 0x060100
[    0.202213] pci 0000:00:01.1: [8086:7010] type 00 class 0x010180
[    0.203883] pci 0000:00:01.1: reg 0x20: [io  0xc0a0-0xc0af]
[    0.204712] pci 0000:00:01.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
[    0.204714] pci 0000:00:01.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
[    0.204715] pci 0000:00:01.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
[    0.204716] pci 0000:00:01.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
[    0.204919] pci 0000:00:01.3: [8086:7113] type 00 class 0x068000
[    0.205614] pci 0000:00:01.3: quirk: [io  0x0600-0x063f] claimed by PIIX4 ACPI
[    0.205627] pci 0000:00:01.3: quirk: [io  0x0700-0x070f] claimed by PIIX4 SMB
[    0.205983] pci 0000:00:02.0: [8086:2934] type 00 class 0x0c0300
[    0.208104] pci 0000:00:02.0: reg 0x20: [io  0xc000-0xc01f]
[    0.208962] pci 0000:00:02.1: [8086:2935] type 00 class 0x0c0300
[    0.210556] pci 0000:00:02.1: reg 0x20: [io  0xc020-0xc03f]
[    0.211398] pci 0000:00:02.2: [8086:2936] type 00 class 0x0c0300
[    0.212882] pci 0000:00:02.2: reg 0x20: [io  0xc040-0xc05f]
[    0.213785] pci 0000:00:02.7: [8086:293a] type 00 class 0x0c0320
[    0.214054] pci 0000:00:02.7: reg 0x10: [mem 0xfebfe000-0xfebfefff]
[    0.216120] pci 0000:00:03.0: [8086:2922] type 00 class 0x010601
[    0.218691] pci 0000:00:03.0: reg 0x20: [io  0xc060-0xc07f]
[    0.219163] pci 0000:00:03.0: reg 0x24: [mem 0xfebff000-0xfebfffff]
[    0.220288] pci 0000:00:04.0: [1af4:1002] type 00 class 0x00ff00
[    0.220884] pci 0000:00:04.0: reg 0x10: [io  0xc080-0xc09f]
[    0.223223] pci 0000:00:04.0: reg 0x20: [mem 0xfebf0000-0xfebf3fff 64bit pref]
[    0.224678] pci 0000:00:05.0: [8086:154c] type 00 class 0x020000
[    0.226893] pci 0000:00:05.0: reg 0x10: [mem 0xfebd0000-0xfebdffff 64bit pref]
[    0.228891] pci 0000:00:05.0: reg 0x1c: [mem 0xfebf4000-0xfebf7fff 64bit pref]
[    0.230382] pci 0000:00:05.0: enabling Extended Tags
[    0.231183] pci 0000:00:06.0: [8086:154c] type 00 class 0x020000
[    0.232452] pci 0000:00:06.0: reg 0x10: [mem 0xfebe0000-0xfebeffff 64bit pref]
[    0.234557] pci 0000:00:06.0: reg 0x1c: [mem 0xfebf8000-0xfebfbfff 64bit pref]
[    0.236938] pci 0000:00:06.0: enabling Extended Tags
[    0.238216] ACPI: PCI Interrupt Link [LNKA] (IRQs 5 *10 11)
[    0.238328] ACPI: PCI Interrupt Link [LNKB] (IRQs 5 *10 11)
[    0.238416] ACPI: PCI Interrupt Link [LNKC] (IRQs 5 10 *11)
[    0.238508] ACPI: PCI Interrupt Link [LNKD] (IRQs 5 10 *11)
[    0.238562] ACPI: PCI Interrupt Link [LNKS] (IRQs *9)
[    0.238962] vgaarb: loaded
[    0.239049] SCSI subsystem initialized
[    0.239070] ACPI: bus type USB registered
[    0.239085] usbcore: registered new interface driver usbfs
[    0.239090] usbcore: registered new interface driver hub
[    0.239114] usbcore: registered new device driver usb
[    0.239913] EDAC MC: Ver: 3.0.0
[    0.240240] PCI: Using ACPI for IRQ routing
[    0.240240] PCI: pci_cache_line_size set to 64 bytes
[    0.240240] e820: reserve RAM buffer [mem 0x0009fc00-0x0009ffff]
[    0.240240] e820: reserve RAM buffer [mem 0xbffdf000-0xbfffffff]
[    0.240254] NetLabel: Initializing
[    0.240255] NetLabel:  domain hash size = 128
[    0.240255] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    0.240266] NetLabel:  unlabeled traffic allowed by default
[    0.240993] clocksource: Switched to clocksource kvm-clock
[    0.254872] VFS: Disk quotas dquot_6.6.0
[    0.254903] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.254987] pnp: PnP ACPI init
[    0.255041] pnp 00:00: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.255089] pnp 00:01: Plug and Play ACPI device, IDs PNP0303 (active)
[    0.255104] pnp 00:02: Plug and Play ACPI device, IDs PNP0f13 (active)
[    0.255111] pnp 00:03: [dma 2]
[    0.255120] pnp 00:03: Plug and Play ACPI device, IDs PNP0700 (active)
[    0.255213] pnp 00:04: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.255391] pnp: PnP ACPI: found 5 devices
[    0.262225] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.262235] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.262236] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.262237] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    0.262237] pci_bus 0000:00: resource 7 [mem 0xc0000000-0xfebfffff window]
[    0.262238] pci_bus 0000:00: resource 8 [mem 0x240000000-0x2bfffffff window]
[    0.262280] NET: Registered protocol family 2
[    0.262443] tcp_listen_portaddr_hash hash table entries: 4096 (order: 4, 65536 bytes)
[    0.262494] TCP established hash table entries: 65536 (order: 7, 524288 bytes)
[    0.262824] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    0.263373] TCP: Hash tables configured (established 65536 bind 65536)
[    0.263473] UDP hash table entries: 4096 (order: 5, 131072 bytes)
[    0.263554] UDP-Lite hash table entries: 4096 (order: 5, 131072 bytes)
[    0.263669] NET: Registered protocol family 1
[    0.263695] pci 0000:00:01.0: PIIX3: Enabling Passive Release
[    0.263709] pci 0000:00:00.0: Limiting direct PCI/PCI transfers
[    0.263721] pci 0000:00:01.0: Activating ISA DMA hang workarounds
[    0.278757] PCI Interrupt Link [LNKB] enabled at IRQ 10
[    0.293630] pci 0000:00:02.0: quirk_usb_early_handoff+0x0/0x6d0 took 29168 usecs
[    0.310962] PCI Interrupt Link [LNKC] enabled at IRQ 11
[    0.329461] pci 0000:00:02.1: quirk_usb_early_handoff+0x0/0x6d0 took 34943 usecs
[    0.346963] PCI Interrupt Link [LNKD] enabled at IRQ 11
[    0.362424] pci 0000:00:02.2: quirk_usb_early_handoff+0x0/0x6d0 took 32153 usecs
[    0.378307] PCI Interrupt Link [LNKA] enabled at IRQ 10
[    0.394699] pci 0000:00:02.7: quirk_usb_early_handoff+0x0/0x6d0 took 31481 usecs
[    0.394796] PCI: CLS 0 bytes, default 64
[    0.394903] Unpacking initramfs...
[    0.672618] Freeing initrd memory: 18052K
[    0.672676] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.672677] software IO TLB: mapped [mem 0xbbfdf000-0xbffdf000] (64MB)
[    0.674356] Initialise system trusted keyrings
[    0.674465] workingset: timestamp_bits=36 max_order=21 bucket_order=0
[    0.675694] zbud: loaded
[    0.947356] NET: Registered protocol family 38
[    0.947365] Key type asymmetric registered
[    0.947366] Asymmetric key parser 'x509' registered
[    0.947385] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 247)
[    0.947457] io scheduler noop registered
[    0.947461] io scheduler deadline registered (default)
[    0.947513] io scheduler cfq registered
[    0.947872] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
[    0.947904] ACPI: Power Button [PWRF]
[    0.948346] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.973984] 00:04: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    0.974601] Non-volatile memory driver v1.3
[    0.974636] Linux agpgart interface v0.103
[    0.975151] rdac: device handler registered
[    0.975203] hp_sw: device handler registered
[    0.975203] emc: device handler registered
[    0.975255] alua: device handler registered
[    0.975482] libphy: Fixed MDIO Bus: probed
[    0.975531] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    0.975534] ehci-pci: EHCI PCI platform driver
[    0.993920] ehci-pci 0000:00:02.7: EHCI Host Controller
[    0.994026] ehci-pci 0000:00:02.7: new USB bus registered, assigned bus number 1
[    0.994312] ehci-pci 0000:00:02.7: irq 10, io mem 0xfebfe000
[    1.000951] ehci-pci 0000:00:02.7: USB 2.0 started, EHCI 1.00
[    1.001046] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 4.19
[    1.001048] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.001049] usb usb1: Product: EHCI Host Controller
[    1.001050] usb usb1: Manufacturer: Linux 4.19.163-1.el7.x86_64 ehci_hcd
[    1.001051] usb usb1: SerialNumber: 0000:00:02.7
[    1.001206] hub 1-0:1.0: USB hub found
[    1.001213] hub 1-0:1.0: 6 ports detected
[    1.001449] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    1.001454] ohci-pci: OHCI PCI platform driver
[    1.001463] uhci_hcd: USB Universal Host Controller Interface driver
[    1.019391] uhci_hcd 0000:00:02.0: UHCI Host Controller
[    1.019532] uhci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 2
[    1.019558] uhci_hcd 0000:00:02.0: detected 2 ports
[    1.019666] uhci_hcd 0000:00:02.0: irq 10, io base 0x0000c000
[    1.019781] usb usb2: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 4.19
[    1.019782] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.019784] usb usb2: Product: UHCI Host Controller
[    1.019785] usb usb2: Manufacturer: Linux 4.19.163-1.el7.x86_64 uhci_hcd
[    1.019785] usb usb2: SerialNumber: 0000:00:02.0
[    1.019921] hub 2-0:1.0: USB hub found
[    1.019926] hub 2-0:1.0: 2 ports detected
[    1.039107] uhci_hcd 0000:00:02.1: UHCI Host Controller
[    1.039174] uhci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 3
[    1.039195] uhci_hcd 0000:00:02.1: detected 2 ports
[    1.039332] uhci_hcd 0000:00:02.1: irq 11, io base 0x0000c020
[    1.039413] usb usb3: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 4.19
[    1.039414] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.039415] usb usb3: Product: UHCI Host Controller
[    1.039416] usb usb3: Manufacturer: Linux 4.19.163-1.el7.x86_64 uhci_hcd
[    1.039416] usb usb3: SerialNumber: 0000:00:02.1
[    1.039509] hub 3-0:1.0: USB hub found
[    1.039512] hub 3-0:1.0: 2 ports detected
[    1.057839] uhci_hcd 0000:00:02.2: UHCI Host Controller
[    1.057949] uhci_hcd 0000:00:02.2: new USB bus registered, assigned bus number 4
[    1.057972] uhci_hcd 0000:00:02.2: detected 2 ports
[    1.058042] uhci_hcd 0000:00:02.2: irq 11, io base 0x0000c040
[    1.058133] usb usb4: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 4.19
[    1.058134] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.058135] usb usb4: Product: UHCI Host Controller
[    1.058136] usb usb4: Manufacturer: Linux 4.19.163-1.el7.x86_64 uhci_hcd
[    1.058137] usb usb4: SerialNumber: 0000:00:02.2
[    1.058242] hub 4-0:1.0: USB hub found
[    1.058246] hub 4-0:1.0: 2 ports detected
[    1.058410] usbcore: registered new interface driver usbserial_generic
[    1.058412] usbserial: USB Serial support registered for generic
[    1.058417] usbcore: registered new interface driver wishbone_serial
[    1.058419] usbserial: USB Serial support registered for wishbone_serial
[    1.058442] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
[    1.059378] serio: i8042 KBD port at 0x60,0x64 irq 1
[    1.059414] serio: i8042 AUX port at 0x60,0x64 irq 12
[    1.059507] mousedev: PS/2 mouse device common for all mice
[    1.059812] rtc_cmos 00:00: RTC can wake from S4
[    1.060376] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input1
[    1.061485] input: VirtualPS/2 VMware VMMouse as /devices/platform/i8042/serio1/input/input4
[    1.061540] rtc_cmos 00:00: registered as rtc0
[    1.061840] input: VirtualPS/2 VMware VMMouse as /devices/platform/i8042/serio1/input/input3
[    1.061874] rtc_cmos 00:00: alarms up to one day, y3k, 114 bytes nvram
[    1.062076] ledtrig-cpu: registered to indicate activity on CPUs
[    1.062162] hidraw: raw HID events driver (C) Jiri Kosina
[    1.062273] usbcore: registered new interface driver usbhid
[    1.062274] usbhid: USB HID core driver
[    1.062334] drop_monitor: Initializing network drop monitor service
[    1.062432] Initializing XFRM netlink socket
[    1.062591] NET: Registered protocol family 10
[    1.062995] Segment Routing with IPv6
[    1.063013] NET: Registered protocol family 17
[    1.063024] Bridge firewalling registered
[    1.063366] mce: Using 10 MCE banks
[    1.063383] sched_clock: Marking stable (1062541509, 775973)->(1074085630, -10768148)
[    1.063706] registered taskstats version 1
[    1.063709] Loading compiled-in X.509 certificates
[    1.063728] zswap: loaded using pool lzo/zbud
[    1.066338] Key type big_key registered
[    1.068016] Key type trusted registered
[    1.069892] Key type encrypted registered
[    1.069905] ima: No TPM chip found, activating TPM-bypass!
[    1.069914] ima: Allocated hash algorithm: sha1
[    1.069943] evm: Initialising EVM extended attributes:
[    1.069944] evm: security.selinux
[    1.069945] evm: security.ima
[    1.069945] evm: security.capability
[    1.069945] evm: HMAC attrs: 0x1
[    1.070352] rtc_cmos 00:00: setting system clock to 2021-01-21 07:48:23 UTC (1611215303)
[    1.072865] Freeing unused kernel image memory: 2356K
[    1.081909] Write protecting the kernel read-only data: 18432k
[    1.082598] Freeing unused kernel image memory: 2012K
[    1.082743] Freeing unused kernel image memory: 488K
[    1.082757] Run /init as init process
[    1.085733] random: systemd: uninitialized urandom read (16 bytes read)
[    1.086111] random: systemd: uninitialized urandom read (16 bytes read)
[    1.086121] random: systemd: uninitialized urandom read (16 bytes read)
[    1.089749] systemd[1]: systemd 219 running in system mode. (+PAM +AUDIT +SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 -SECCOMP +BLKID +ELFUTILS +KMOD +IDN)
[    1.089774] systemd[1]: Detected virtualization kvm.
[    1.089778] systemd[1]: Detected architecture x86-64.
[    1.089780] systemd[1]: Running in initial RAM disk.
[    1.089811] systemd[1]: Set hostname to <localhost.localdomain>.
[    1.123966] systemd[1]: Reached target Swap.
[    1.124013] systemd[1]: Reached target Timers.
[    1.124021] systemd[1]: Reached target Local File Systems.
[    1.124528] systemd[1]: Created slice Root Slice.
[    1.124553] systemd[1]: Listening on udev Kernel Socket.
[    1.246456] libata version 3.00 loaded.
[    1.247122] ata_piix 0000:00:01.1: version 2.13
[    1.250700] ahci 0000:00:03.0: version 3.0
[    1.251013] scsi host0: ata_piix
[    1.251750] scsi host1: ata_piix
[    1.251784] ata1: PATA max MWDMA2 cmd 0x1f0 ctl 0x3f6 bmdma 0xc0a0 irq 14
[    1.251785] ata2: PATA max MWDMA2 cmd 0x170 ctl 0x376 bmdma 0xc0a8 irq 15
[    1.274544] FDC 0 is a S82078B
[    1.296305] ahci 0000:00:03.0: AHCI 0001.0000 32 slots 6 ports 1.5 Gbps 0x3f impl SATA mode
[    1.296308] ahci 0000:00:03.0: flags: 64bit ncq only
[    1.298306] scsi host2: ahci
[    1.298406] scsi host3: ahci
[    1.298545] scsi host4: ahci
[    1.298691] scsi host5: ahci
[    1.298823] scsi host6: ahci
[    1.299358] scsi host7: ahci
[    1.299407] ata3: SATA max UDMA/133 abar m4096 at 0xfebff000 port 0xfebff100 irq 24
[    1.299413] ata4: SATA max UDMA/133 abar m4096 at 0xfebff000 port 0xfebff180 irq 24
[    1.299420] ata5: SATA max UDMA/133 abar m4096 at 0xfebff000 port 0xfebff200 irq 24
[    1.299426] ata6: SATA max UDMA/133 abar m4096 at 0xfebff000 port 0xfebff280 irq 24
[    1.299432] ata7: SATA max UDMA/133 abar m4096 at 0xfebff000 port 0xfebff300 irq 24
[    1.299437] ata8: SATA max UDMA/133 abar m4096 at 0xfebff000 port 0xfebff380 irq 24
[    1.604009] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    1.604174] ata3.00: ATA-7: QEMU HARDDISK, 2.5+, max UDMA/100
[    1.604175] ata3.00: 104857600 sectors, multi 16: LBA48 NCQ (depth 32)
[    1.604177] ata3.00: applying bridge limits
[    1.604324] ata4: SATA link down (SStatus 0 SControl 300)
[    1.604438] ata3.00: configured for UDMA/100
[    1.604627] scsi 2:0:0:0: Direct-Access     ATA      QEMU HARDDISK    2.5+ PQ: 0 ANSI: 5
[    1.611972] ata7: SATA link down (SStatus 0 SControl 300)
[    1.612183] ata6: SATA link down (SStatus 0 SControl 300)
[    1.612391] ata5: SATA link down (SStatus 0 SControl 300)
[    1.612619] ata8: SATA link down (SStatus 0 SControl 300)
[    1.619556] sd 2:0:0:0: [sda] 104857600 512-byte logical blocks: (53.7 GB/50.0 GiB)
[    1.619564] sd 2:0:0:0: [sda] Write Protect is off
[    1.619565] sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    1.619574] sd 2:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    1.620587]  sda: sda1 sda2 sda3
[    1.620812] sd 2:0:0:0: [sda] Attached SCSI disk
[    6.347942] SGI XFS with ACLs, security attributes, no debug enabled
[    6.350698] XFS (sda3): Mounting V4 Filesystem
[    6.370324] XFS (sda3): Ending clean mount
[    6.602418] systemd-journald[153]: Received SIGTERM from PID 1 (systemd).
[    6.623557] systemd: 15 output lines suppressed due to ratelimiting
[    6.625986] random: fast init done
[    6.655018] SELinux:  Disabled at runtime.
[    6.679922] audit: type=1404 audit(1611215309.109:2): enforcing=0 old_enforcing=0 auid=4294967295 ses=4294967295 enabled=0 old-enabled=1 lsm=selinux res=1
[    6.704718] systemd[1]: Inserted module 'ip_tables'
[    6.836782] systemd-journald[432]: Received request to flush runtime journal from PID 1
[    7.257216] piix4_smbus 0000:00:01.3: SMBus Host Controller at 0x700, revision 0
[    7.262799] input: PC Speaker as /devices/platform/pcspkr/input/input5
[    7.264026] sd 2:0:0:0: Attached scsi generic sg0 type 0
[    7.273855] iavf: loading out-of-tree module taints kernel.
[    7.279835] iavf: Intel(R) Ethernet Adaptive Virtual Function Network Driver - version 4.0.1
[    7.279836] Copyright (c) 2013, Intel Corporation.
[    7.280669] cryptd: max_cpu_qlen set to 1000
[    7.301362] Adding 2098172k swap on /dev/sda2.  Priority:-2 extents:1 across:2098172k FS
[    7.303664] AVX2 version of gcm_enc/dec engaged.
[    7.303665] AES CTR mode by8 optimization enabled
[    7.308132] XFS (sda1): Mounting V4 Filesystem
[    7.333606] alg: No test for pcbc(aes) (pcbc-aes-aesni)
[    7.337248] XFS (sda1): Ending clean mount
[    7.344032] iavf 0000:00:05.0: Multiqueue Enabled: Queue pair count = 4
[    7.344738] iavf 0000:00:05.0: MAC address: 52:54:00:1b:cc:9e
[    7.344740] iavf 0000:00:05.0: GRO is enabled
[    7.347577] iavf 0000:00:06.0: Multiqueue Enabled: Queue pair count = 4
[    7.348135] iavf 0000:00:06.0: MAC address: 52:54:00:e4:40:2c
[    7.348137] iavf 0000:00:06.0: GRO is enabled
[    7.359710] Decoding supported only on Scalable MCA processors.
[    7.372274] Decoding supported only on Scalable MCA processors.
[    7.386027] Decoding supported only on Scalable MCA processors.
[    7.386134] RPC: Registered named UNIX socket transport module.
[    7.386135] RPC: Registered udp transport module.
[    7.386136] RPC: Registered tcp transport module.
[    7.386136] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    7.395908] Decoding supported only on Scalable MCA processors.
[    7.632397] random: crng init done
[    7.632399] random: 7 urandom warning(s) missed due to ratelimiting
[    7.691133] Ethernet Channel Bonding Driver: v3.7.1 (April 27, 2011)
[    7.692625] bonding: bond0 is being created...
[    7.692634] bonding: bond0 already exists
[    7.761627] IPv6: ADDRCONF(NETDEV_UP): bond0: link is not ready
[    7.796810] bond0: Enslaving eth0 as an active interface with a down link
[    7.841326] bond0: Enslaving eth1 as an active interface with a down link
[    7.849218] IPv6: ADDRCONF(NETDEV_UP): bond0: link is not ready
[    7.859212] iavf 0000:00:05.0 eth0: NIC Link is Up Speed is 25 Gbps Full Duplex
[    7.904193] iavf 0000:00:06.0 eth1: NIC Link is Up Speed is 25 Gbps Full Duplex
[    7.949952] bond0: link status definitely up for interface eth0, 25000 Mbps full duplex
[    7.949960] bond0: first active interface up!
[    7.949969] bond0: link status definitely up for interface eth1, 25000 Mbps full duplex
[    7.949980] IPv6: ADDRCONF(NETDEV_CHANGE): bond0: link becomes ready
[   64.968243] HTB: quantum of class 10010 is big. Consider r2q change.
[   65.020168] u32 classifier
[   65.020169]     Performance counters on
[   65.020170]     input device check on
[   65.020170]     Actions configured
[   65.031382] GACT probability on
[   65.046760] Mirror/redirect action on
[   65.094258] PPP generic driver version 2.4.2
[   65.096199] NET: Registered protocol family 24
[   65.098740] l2tp_core: L2TP core driver, V2.0
[   65.099841] l2tp_netlink: L2TP netlink interface
[   65.101122] l2tp_ppp: PPPoL2TP kernel driver, V2.0
[   65.148256] tun: Universal TUN/TAP device driver, 1.6
[   65.320723] NET: Registered protocol family 15
[   65.383618] tcrypt: one or more tests failed!
[   65.809403] tcrypt: one or more tests failed!
[   67.810774] nf_conntrack: default automatic helper assignment has been turned off for security reasons and CT-based  firewall rule not found. Use the iptables CT target to attach helpers instead.
[  116.448394] alg: No test for echainiv(authenc(hmac(sha1),cbc(aes))) (echainiv(pcrypt(authenc(hmac(sha1-generic),cbc-aes-aesni))))
[  118.773702] alg: No test for echainiv(authenc(hmac(sha256),cbc(aes))) (echainiv(pcrypt(authenc(hmac(sha256-generic),cbc-aes-aesni))))
[  700.568064] PPP MPPE Compression module registered
[14552.789312] htb: too many events!
[16201.083338] PPP BSD Compression module registered
[16201.085200] PPP Deflate Compression module registered
[25184.362164] floppy0: unexpected interrupt
[25184.362211] floppy0: sensei repl[0]=80
[37613.801887] floppy0: unexpected interrupt
[37613.801923] floppy0: sensei repl[0]=80
[38613.102067] wireguard: WireGuard 1.0.20200908 loaded. See www.wireguard.com for information.
[38613.102069] wireguard: Copyright (C) 2015-2019 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
[41957.154864] TCP: request_sock_TCP: Possible SYN flooding on port 53. Sending cookies.  Check SNMP counters.
[43063.657589] floppy0: unexpected interrupt
[43063.657623] floppy0: sensei repl[0]=80
[107301.992610] floppy0: unexpected interrupt
[107301.992646] floppy0: sensei repl[0]=80
[112111.868897] floppy0: unexpected interrupt
[112111.868933] floppy0: sensei repl[0]=80
[121180.672964] TCP: request_sock_TCP: Possible SYN flooding on port 1080. Sending cookies.  Check SNMP counters.
[145271.010856] floppy0: unexpected interrupt
[145271.010901] floppy0: sensei repl[0]=80
[228278.886283] floppy0: unexpected interrupt
[228278.886313] floppy0: sensei repl[0]=80
[350615.723981] floppy0: unexpected interrupt
[350615.724048] floppy0: sensei repl[0]=80
[432553.624535] floppy0: unexpected interrupt
[432553.624565] floppy0: sensei repl[0]=80
[432583.002331] TCP: request_sock_TCP: Possible SYN flooding on port 53. Sending cookies.  Check SNMP counters.
[475962.614120] floppy0: unexpected interrupt
[475962.614159] floppy0: sensei repl[0]=80
[486102.467827] floppy0: unexpected interrupt
[486102.467859] floppy0: sensei repl[0]=80
[522441.414045] floppy0: unexpected interrupt
[522441.414103] floppy0: sensei repl[0]=80
[525441.213995] floppy0: unexpected interrupt
[525441.214024] floppy0: sensei repl[0]=80
[526831.461463] floppy0: unexpected interrupt
[526831.461518] floppy0: sensei repl[0]=80
[537941.319528] floppy0: unexpected interrupt
[537941.319563] floppy0: sensei repl[0]=80
[543220.725620] floppy0: unexpected interrupt
[543220.725653] floppy0: sensei repl[0]=80
[575499.987447] floppy0: unexpected interrupt
[575499.987596] floppy0: sensei repl[0]=80
[608199.059824] floppy0: unexpected interrupt
[608199.059861] floppy0: sensei repl[0]=80
[642908.209562] floppy0: unexpected interrupt
[642908.209668] floppy0: sensei repl[0]=80
[709966.652082] floppy0: unexpected interrupt
[709966.652135] floppy0: sensei repl[0]=80
[724916.152941] floppy0: unexpected interrupt
[724916.153015] floppy0: sensei repl[0]=80
[726366.047424] floppy0: unexpected interrupt
[726366.047452] floppy0: sensei repl[0]=80
[743445.558335] floppy0: unexpected interrupt
[743445.558411] floppy0: sensei repl[0]=80
[769594.933883] floppy0: unexpected interrupt
[769594.933925] floppy0: sensei repl[0]=80
[800514.088014] floppy0: unexpected interrupt
[800514.088075] floppy0: sensei repl[0]=80
[802584.042034] floppy0: unexpected interrupt
[802584.042087] floppy0: sensei repl[0]=80
[804654.007254] floppy0: unexpected interrupt
[804654.007293] floppy0: sensei repl[0]=80
[822133.641811] floppy0: unexpected interrupt
[822133.641854] floppy0: sensei repl[0]=80
[843913.161462] floppy0: unexpected interrupt
[843913.161501] floppy0: sensei repl[0]=80
[845103.017941] floppy0: unexpected interrupt
[845103.018078] floppy0: sensei repl[0]=80
[849922.825207] floppy0: unexpected interrupt
[849922.825253] floppy0: sensei repl[0]=80
[851032.848860] floppy0: unexpected interrupt
[851032.848910] floppy0: sensei repl[0]=80
[860242.637480] floppy0: unexpected interrupt
[860242.637521] floppy0: sensei repl[0]=80
[876782.194636] floppy0: unexpected interrupt
[876782.194724] floppy0: sensei repl[0]=80
[896531.606800] floppy0: unexpected interrupt
[896531.606836] floppy0: sensei repl[0]=80
[918631.040671] floppy0: unexpected interrupt
[918631.040741] floppy0: sensei repl[0]=80
[958909.991213] floppy0: unexpected interrupt
[958909.991251] floppy0: sensei repl[0]=80
[974629.579471] floppy0: unexpected interrupt
[974629.579506] floppy0: sensei repl[0]=80
[997329.003774] floppy0: unexpected interrupt
[997329.003842] floppy0: sensei repl[0]=80
[1012708.614964] floppy0: unexpected interrupt
[1012708.615005] floppy0: sensei repl[0]=80
[1017608.479703] floppy0: unexpected interrupt
[1017608.479757] floppy0: sensei repl[0]=80
[1084706.722234] floppy0: unexpected interrupt
[1084706.722272] floppy0: sensei repl[0]=80
[1144655.162838] floppy0: unexpected interrupt
[1144655.162875] floppy0: sensei repl[0]=80
[1145495.128579] floppy0: unexpected interrupt
[1145495.128747] floppy0: sensei repl[0]=80
[1151054.984418] floppy0: unexpected interrupt
[1151054.984458] floppy0: sensei repl[0]=80
[1153694.915610] floppy0: unexpected interrupt
[1153694.915645] floppy0: sensei repl[0]=80
[1154964.883073] floppy0: unexpected interrupt
[1154964.883110] floppy0: sensei repl[0]=80
[1169234.512356] floppy0: unexpected interrupt
[1169234.512407] floppy0: sensei repl[0]=80
[1186034.071613] floppy0: unexpected interrupt
[1186034.071665] floppy0: sensei repl[0]=80
[1198913.739756] floppy0: unexpected interrupt
[1198913.739803] floppy0: sensei repl[0]=80
[1225353.048156] floppy0: unexpected interrupt
[1225353.048192] floppy0: sensei repl[0]=80
[1227143.001821] floppy0: unexpected interrupt
[1227143.001848] floppy0: sensei repl[0]=80
[1273321.803679] floppy0: unexpected interrupt
[1273321.803713] floppy0: sensei repl[0]=80
[1301471.069147] floppy0: unexpected interrupt
[1301471.069179] floppy0: sensei repl[0]=80
[1353759.714541] floppy0: unexpected interrupt
[1353759.714579] floppy0: sensei repl[0]=80
[1368769.328829] floppy0: unexpected interrupt
[1368769.328894] floppy0: sensei repl[0]=80
[1369159.315898] floppy0: unexpected interrupt
[1369159.315926] floppy0: sensei repl[0]=80
[1394558.656204] floppy0: unexpected interrupt
[1394558.656240] floppy0: sensei repl[0]=80
[1397418.590462] floppy0: unexpected interrupt
[1397418.590499] floppy0: sensei repl[0]=80
[1406478.336870] floppy0: unexpected interrupt
[1406478.336903] floppy0: sensei repl[0]=80
[1409358.259738] floppy0: unexpected interrupt
[1409358.259798] floppy0: sensei repl[0]=80
[1415338.109859] floppy0: unexpected interrupt
[1415338.109899] floppy0: sensei repl[0]=80
[1419577.993748] floppy0: unexpected interrupt
[1419577.993793] floppy0: sensei repl[0]=80
[1421898.914670] TCP: request_sock_TCP: Possible SYN flooding on port 1080. Sending cookies.  Check SNMP counters.
[1422317.921375] floppy0: unexpected interrupt
[1422317.921421] floppy0: sensei repl[0]=80
[1424597.860249] floppy0: unexpected interrupt
[1424597.860298] floppy0: sensei repl[0]=80
[1436797.537940] floppy0: unexpected interrupt
[1436797.538007] floppy0: sensei repl[0]=80
[1438597.490608] floppy0: unexpected interrupt
[1438597.490652] floppy0: sensei repl[0]=80
[1438727.490769] floppy0: unexpected interrupt
[1438727.490802] floppy0: sensei repl[0]=80
[1439577.465863] floppy0: unexpected interrupt
[1439577.465943] floppy0: sensei repl[0]=80
[1441167.424726] floppy0: unexpected interrupt
[1441167.424773] floppy0: sensei repl[0]=80
[1447567.257786] floppy0: unexpected interrupt
[1447567.257825] floppy0: sensei repl[0]=80
[1448637.231749] floppy0: unexpected interrupt
[1448637.231875] floppy0: sensei repl[0]=80
[1451017.170912] floppy0: unexpected interrupt
[1451017.170963] floppy0: sensei repl[0]=80
[1454317.084621] floppy0: unexpected interrupt
[1454317.084686] floppy0: sensei repl[0]=80
[1468916.704603] floppy0: unexpected interrupt
[1468916.704675] floppy0: sensei repl[0]=80
[1478576.449919] floppy0: unexpected interrupt
[1478576.449963] floppy0: sensei repl[0]=80
[1478946.442613] floppy0: unexpected interrupt
[1478946.442641] floppy0: sensei repl[0]=80
[1484516.292743] floppy0: unexpected interrupt
[1484516.292777] floppy0: sensei repl[0]=80
[1543264.766214] floppy0: unexpected interrupt
[1543264.766248] floppy0: sensei repl[0]=80
[1545364.711316] floppy0: unexpected interrupt
[1545364.711365] floppy0: sensei repl[0]=80
[1551284.557662] floppy0: unexpected interrupt
[1551284.557695] floppy0: sensei repl[0]=80
[1557144.400219] floppy0: unexpected interrupt
[1557144.400261] floppy0: sensei repl[0]=80
[1559654.333993] floppy0: unexpected interrupt
[1559654.334066] floppy0: sensei repl[0]=80
[1560224.321187] floppy0: unexpected interrupt
[1560224.321236] floppy0: sensei repl[0]=80
[1560324.316509] floppy0: unexpected interrupt
[1560324.316539] floppy0: sensei repl[0]=80
[1560604.310595] floppy0: unexpected interrupt
[1560604.310643] floppy0: sensei repl[0]=80
[1583793.700743] floppy0: unexpected interrupt
[1583793.700848] floppy0: sensei repl[0]=80
[1583883.701219] floppy0: unexpected interrupt
[1583883.701253] floppy0: sensei repl[0]=80
[1588743.579792] floppy0: unexpected interrupt
[1588743.579825] floppy0: sensei repl[0]=80
[1619292.783426] floppy0: unexpected interrupt
[1619292.783461] floppy0: sensei repl[0]=80
[1630802.484308] floppy0: unexpected interrupt
[1630802.484350] floppy0: sensei repl[0]=80
[1636722.329300] floppy0: unexpected interrupt
[1636722.329342] floppy0: sensei repl[0]=80
[1663521.621688] floppy0: unexpected interrupt
[1663521.621732] floppy0: sensei repl[0]=80
[1664251.602666] floppy0: unexpected interrupt
[1664251.603141] floppy0: sensei repl[0]=80
[1667221.524590] floppy0: unexpected interrupt
[1667221.524629] floppy0: sensei repl[0]=80
[1668131.501622] floppy0: unexpected interrupt
[1668131.501669] floppy0: sensei repl[0]=80
[1676241.289548] floppy0: unexpected interrupt
[1676241.289617] floppy0: sensei repl[0]=80
[1679551.206823] floppy0: unexpected interrupt
[1679551.206862] floppy0: sensei repl[0]=80
[1680171.189634] floppy0: unexpected interrupt
[1680171.189668] floppy0: sensei repl[0]=80
[1682033.491589] device bond0 entered promiscuous mode
[1682033.491609] device eth0 entered promiscuous mode
[1682033.491647] device eth1 entered promiscuous mode
[1682033.532577] iavf 0000:00:05.0: Entering promiscuous mode
[1682033.532608] iavf 0000:00:05.0: eth0 is entering multicast promiscuous mode
[1682035.517606] iavf 0000:00:06.0: Entering promiscuous mode
[1682035.517608] iavf 0000:00:06.0: eth1 is entering multicast promiscuous mode
[1682035.523569] device bond0 left promiscuous mode
[1682035.523580] device eth0 left promiscuous mode
[1682035.523619] device eth1 left promiscuous mode
[1682035.580529] iavf 0000:00:05.0: Leaving promiscuous mode
[1682035.580532] iavf 0000:00:05.0: eth0 is leaving multicast promiscuous mode
[1682037.564448] iavf 0000:00:06.0: Leaving promiscuous mode
[1682037.564451] iavf 0000:00:06.0: eth1 is leaving multicast promiscuous mode
[1682561.513831] device bond0 entered promiscuous mode
[1682561.513845] device eth0 entered promiscuous mode
[1682561.513882] device eth1 entered promiscuous mode
[1682561.839540] iavf 0000:00:06.0: Entering promiscuous mode
[1682561.839542] iavf 0000:00:06.0: eth1 is entering multicast promiscuous mode
[1682561.903801] iavf 0000:00:05.0: Entering promiscuous mode
[1682561.903803] iavf 0000:00:05.0: eth0 is entering multicast promiscuous mode
[1682563.568614] device bond0 left promiscuous mode
[1682563.568627] device eth0 left promiscuous mode
[1682563.568662] device eth1 left promiscuous mode
[1682563.896796] iavf 0000:00:06.0: Leaving promiscuous mode
[1682563.896798] iavf 0000:00:06.0: eth1 is leaving multicast promiscuous mode
[1682563.950796] iavf 0000:00:05.0: Leaving promiscuous mode
[1682563.950803] iavf 0000:00:05.0: eth0 is leaving multicast promiscuous mode
[1709710.413195] floppy0: unexpected interrupt
[1709710.413229] floppy0: sensei repl[0]=80
[1761737.599289] device bond0 entered promiscuous mode
[1761737.599303] device eth0 entered promiscuous mode
[1761737.599339] device eth1 entered promiscuous mode
[1761739.534232] iavf 0000:00:06.0: Entering promiscuous mode
[1761739.534267] iavf 0000:00:06.0: eth1 is entering multicast promiscuous mode
[1761739.598230] iavf 0000:00:05.0: Entering promiscuous mode
[1761739.598239] iavf 0000:00:05.0: eth0 is entering multicast promiscuous mode
[1761946.878166] device bond0 left promiscuous mode
[1761946.878181] device eth0 left promiscuous mode
[1761946.878221] device eth1 left promiscuous mode
[1761948.424773] iavf 0000:00:06.0: Leaving promiscuous mode
[1761948.424779] iavf 0000:00:06.0: eth1 is leaving multicast promiscuous mode
[1761948.488760] iavf 0000:00:05.0: Leaving promiscuous mode
[1761948.488767] iavf 0000:00:05.0: eth0 is leaving multicast promiscuous mode
[1761978.448002] device bond0 entered promiscuous mode
[1761978.448013] device eth0 entered promiscuous mode
[1761978.448076] device eth1 entered promiscuous mode
[1761979.144024] iavf 0000:00:06.0: Entering promiscuous mode
[1761979.144027] iavf 0000:00:06.0: eth1 is entering multicast promiscuous mode
[1761979.207990] iavf 0000:00:05.0: Entering promiscuous mode
[1761979.208026] iavf 0000:00:05.0: eth0 is entering multicast promiscuous mode
[1764668.968579] floppy0: unexpected interrupt
[1764668.968667] floppy0: sensei repl[0]=80
[1765678.941296] floppy0: unexpected interrupt
[1765678.941333] floppy0: sensei repl[0]=80
[1767958.881645] floppy0: unexpected interrupt
[1767958.881703] floppy0: sensei repl[0]=80
[1769881.609714] device bond0 left promiscuous mode
[1769881.609728] device eth0 left promiscuous mode
[1769881.609770] device eth1 left promiscuous mode
[1769882.167974] iavf 0000:00:06.0: Leaving promiscuous mode
[1769882.167983] iavf 0000:00:06.0: eth1 is leaving multicast promiscuous mode
[1769882.231930] iavf 0000:00:05.0: Leaving promiscuous mode
[1769882.231932] iavf 0000:00:05.0: eth0 is leaving multicast promiscuous mode
[1772088.542488] device bond0 entered promiscuous mode
[1772088.542497] device eth0 entered promiscuous mode
[1772088.542530] device eth1 entered promiscuous mode
[1772089.853464] iavf 0000:00:06.0: Entering promiscuous mode
[1772089.853471] iavf 0000:00:06.0: eth1 is entering multicast promiscuous mode
[1772089.917465] iavf 0000:00:05.0: Entering promiscuous mode
[1772089.917467] iavf 0000:00:05.0: eth0 is entering multicast promiscuous mode
[1772096.120076] device bond0 left promiscuous mode
[1772096.120090] device eth0 left promiscuous mode
[1772096.120128] device eth1 left promiscuous mode
[1772098.045236] iavf 0000:00:06.0: Leaving promiscuous mode
[1772098.045239] iavf 0000:00:06.0: eth1 is leaving multicast promiscuous mode
[1772098.110221] iavf 0000:00:05.0: Leaving promiscuous mode
[1772098.110223] iavf 0000:00:05.0: eth0 is leaving multicast promiscuous mode
[1772102.224142] device bond0 entered promiscuous mode
[1772102.224154] device eth0 entered promiscuous mode
[1772102.224197] device eth1 entered promiscuous mode
[1772104.189067] iavf 0000:00:06.0: Entering promiscuous mode
[1772104.189071] iavf 0000:00:06.0: eth1 is entering multicast promiscuous mode
[1772104.253067] iavf 0000:00:05.0: Entering promiscuous mode
[1772104.253069] iavf 0000:00:05.0: eth0 is entering multicast promiscuous mode
[1772105.830123] device bond0 left promiscuous mode
[1772105.830134] device eth0 left promiscuous mode
[1772105.830172] device eth1 left promiscuous mode
[1772106.237020] iavf 0000:00:06.0: Leaving promiscuous mode
[1772106.237022] iavf 0000:00:06.0: eth1 is leaving multicast promiscuous mode
[1772106.301012] iavf 0000:00:05.0: Leaving promiscuous mode
[1772106.301014] iavf 0000:00:05.0: eth0 is leaving multicast promiscuous mode
[1772143.117044] device bond0 entered promiscuous mode
[1772143.117058] device eth0 entered promiscuous mode
[1772143.117095] device eth1 entered promiscuous mode
[1772143.164035] iavf 0000:00:05.0: Entering promiscuous mode
[1772143.164038] iavf 0000:00:05.0: eth0 is entering multicast promiscuous mode
[1772145.147982] iavf 0000:00:06.0: Entering promiscuous mode
[1772145.147985] iavf 0000:00:06.0: eth1 is entering multicast promiscuous mode
[1772156.908400] device bond0 left promiscuous mode
[1772156.908409] device eth0 left promiscuous mode
[1772156.908442] device eth1 left promiscuous mode
[1772157.435679] iavf 0000:00:06.0: Leaving promiscuous mode
[1772157.435803] iavf 0000:00:06.0: eth1 is leaving multicast promiscuous mode
[1772157.499720] iavf 0000:00:05.0: Leaving promiscuous mode
[1772157.499722] iavf 0000:00:05.0: eth0 is leaving multicast promiscuous mode
[1772158.533637] device bond0 entered promiscuous mode
[1772158.533646] device eth0 entered promiscuous mode
[1772158.533680] device eth1 entered promiscuous mode
[1772159.483784] iavf 0000:00:06.0: Entering promiscuous mode
[1772159.483787] iavf 0000:00:06.0: eth1 is entering multicast promiscuous mode
[1772159.548786] iavf 0000:00:05.0: Entering promiscuous mode
[1772159.548789] iavf 0000:00:05.0: eth0 is entering multicast promiscuous mode
[1772207.299566] device bond0 left promiscuous mode
[1772207.299585] device eth0 left promiscuous mode
[1772207.299645] device eth1 left promiscuous mode
[1772208.634316] iavf 0000:00:06.0: Leaving promiscuous mode
[1772208.634319] iavf 0000:00:06.0: eth1 is leaving multicast promiscuous mode
[1772208.698293] iavf 0000:00:05.0: Leaving promiscuous mode
[1772208.698296] iavf 0000:00:05.0: eth0 is leaving multicast promiscuous mode
[1773738.728190] floppy0: unexpected interrupt
[1773738.728234] floppy0: sensei repl[0]=80
[1782548.488780] TCP: request_sock_TCP: Possible SYN flooding on port 53. Sending cookies.  Check SNMP counters.
[1795448.157937] floppy0: unexpected interrupt
[1795448.157980] floppy0: sensei repl[0]=80
[1796928.119227] floppy0: unexpected interrupt
[1796928.119279] floppy0: sensei repl[0]=80
[1797298.110679] floppy0: unexpected interrupt
[1797298.110779] floppy0: sensei repl[0]=80
[1799418.055558] floppy0: unexpected interrupt
[1799418.055605] floppy0: sensei repl[0]=80
[1801478.003567] floppy0: unexpected interrupt
[1801478.003648] floppy0: sensei repl[0]=80
[1849526.746681] floppy0: unexpected interrupt
[1849526.746798] floppy0: sensei repl[0]=80
[1875376.075412] floppy0: unexpected interrupt
[1875376.075481] floppy0: sensei repl[0]=80
[1878305.998101] floppy0: unexpected interrupt
[1878305.998162] floppy0: sensei repl[0]=80
[1881352.344975] device bond0 entered promiscuous mode
[1881352.344992] device eth0 entered promiscuous mode
[1881352.345026] device eth1 entered promiscuous mode
[1881353.170537] device bond0 left promiscuous mode
[1881353.170550] device eth0 left promiscuous mode
[1881353.170647] device eth1 left promiscuous mode
[1881353.944442] iavf 0000:00:06.0: Entering promiscuous mode
[1881353.944452] iavf 0000:00:06.0: eth1 is entering multicast promiscuous mode
[1881354.008883] iavf 0000:00:05.0: Entering promiscuous mode
[1881354.008886] iavf 0000:00:05.0: eth0 is entering multicast promiscuous mode
[1881377.504361] device bond0 entered promiscuous mode
[1881377.504372] device eth0 entered promiscuous mode
[1881377.504407] device eth1 entered promiscuous mode
[1881378.519251] iavf 0000:00:06.0: Leaving promiscuous mode
[1881378.519254] iavf 0000:00:06.0: eth1 is leaving multicast promiscuous mode
[1881378.526453] device bond0 left promiscuous mode
[1881378.526464] device eth0 left promiscuous mode
[1881378.526502] device eth1 left promiscuous mode
[1881378.583614] iavf 0000:00:05.0: Leaving promiscuous mode
[1881378.583617] iavf 0000:00:05.0: eth0 is leaving multicast promiscuous mode
[1883535.862206] floppy0: unexpected interrupt
[1883535.862252] floppy0: sensei repl[0]=80
[1896511.304387] device bond0 entered promiscuous mode
[1896511.304399] device eth0 entered promiscuous mode
[1896511.304442] device eth1 entered promiscuous mode
[1896512.847330] iavf 0000:00:06.0: Entering promiscuous mode
[1896512.847350] iavf 0000:00:06.0: eth1 is entering multicast promiscuous mode
[1896512.911349] iavf 0000:00:05.0: Entering promiscuous mode
[1896512.911351] iavf 0000:00:05.0: eth0 is entering multicast promiscuous mode
[1896513.104392] device bond0 left promiscuous mode
[1896513.104399] device eth0 left promiscuous mode
[1896513.104453] device eth1 left promiscuous mode
[1896514.894271] iavf 0000:00:06.0: Leaving promiscuous mode
[1896514.894274] iavf 0000:00:06.0: eth1 is leaving multicast promiscuous mode
[1896514.958326] iavf 0000:00:05.0: Leaving promiscuous mode
[1896514.958328] iavf 0000:00:05.0: eth0 is leaving multicast promiscuous mode
[1897285.505181] floppy0: unexpected interrupt
[1897285.505221] floppy0: sensei repl[0]=80
[1897865.490275] floppy0: unexpected interrupt
[1897865.490315] floppy0: sensei repl[0]=80
[1923896.008614] audit: audit_backlog=321 > audit_backlog_limit=320
[1923896.008617] audit: audit_lost=1 audit_rate_limit=0 audit_backlog_limit=320
[1923896.008618] audit: backlog limit exceeded
[1923896.009684] audit: audit_backlog=321 > audit_backlog_limit=320
[1923896.009685] audit: audit_lost=2 audit_rate_limit=0 audit_backlog_limit=320
[1923896.009686] audit: backlog limit exceeded
[1923896.010720] audit: audit_backlog=321 > audit_backlog_limit=320
[1923896.010721] audit: audit_lost=3 audit_rate_limit=0 audit_backlog_limit=320
[1923896.010722] audit: backlog limit exceeded
[1923896.011625] audit: audit_backlog=321 > audit_backlog_limit=320
[1923902.280297] audit_log_start: 101 callbacks suppressed
[1923902.280298] audit: audit_backlog=321 > audit_backlog_limit=320
[1923902.280301] audit: audit_lost=38 audit_rate_limit=0 audit_backlog_limit=320
[1923902.280302] audit: backlog limit exceeded
[1923902.281836] audit: audit_backlog=321 > audit_backlog_limit=320
[1923902.281837] audit: audit_lost=39 audit_rate_limit=0 audit_backlog_limit=320
[1923902.281837] audit: backlog limit exceeded
[1923902.283089] audit: audit_backlog=321 > audit_backlog_limit=320
[1923902.283090] audit: audit_lost=40 audit_rate_limit=0 audit_backlog_limit=320
[1923902.283091] audit: backlog limit exceeded
[1923902.284314] audit: audit_backlog=321 > audit_backlog_limit=320
[1924239.708050] audit_log_start: 20 callbacks suppressed
[1924239.708051] audit: audit_backlog=321 > audit_backlog_limit=320
[1924239.708053] audit: audit_lost=48 audit_rate_limit=0 audit_backlog_limit=320
[1924239.708054] audit: backlog limit exceeded
[1924239.709270] audit: audit_backlog=321 > audit_backlog_limit=320
[1924239.709271] audit: audit_lost=49 audit_rate_limit=0 audit_backlog_limit=320
[1924239.709271] audit: backlog limit exceeded
[1924239.710419] audit: audit_backlog=321 > audit_backlog_limit=320
[1924239.710420] audit: audit_lost=50 audit_rate_limit=0 audit_backlog_limit=320
[1924239.710421] audit: backlog limit exceeded
[1924239.711506] audit: audit_backlog=321 > audit_backlog_limit=320
[1924282.897577] audit_log_start: 5 callbacks suppressed
[1924282.897578] audit: audit_backlog=321 > audit_backlog_limit=320
[1924282.897580] audit: audit_lost=53 audit_rate_limit=0 audit_backlog_limit=320
[1924282.897580] audit: backlog limit exceeded
[1924282.898594] audit: audit_backlog=321 > audit_backlog_limit=320
[1924282.898596] audit: audit_lost=54 audit_rate_limit=0 audit_backlog_limit=320
[1924282.898600] audit: backlog limit exceeded
[1924282.899574] audit: audit_backlog=321 > audit_backlog_limit=320
[1924282.899576] audit: audit_lost=55 audit_rate_limit=0 audit_backlog_limit=320
[1924282.899577] audit: backlog limit exceeded
[1924282.900831] audit: audit_backlog=321 > audit_backlog_limit=320
[1933931.927698] device bond0 entered promiscuous mode
[1933931.927708] device eth0 entered promiscuous mode
[1933931.927748] device eth1 entered promiscuous mode
[1933932.921641] iavf 0000:00:06.0: Entering promiscuous mode
[1933932.921672] iavf 0000:00:06.0: eth1 is entering multicast promiscuous mode
[1933932.985694] iavf 0000:00:05.0: Entering promiscuous mode
[1933932.985697] iavf 0000:00:05.0: eth0 is entering multicast promiscuous mode
[1933934.013879] device bond0 left promiscuous mode
[1933934.013889] device eth0 left promiscuous mode
[1933934.013925] device eth1 left promiscuous mode
[1933934.969598] iavf 0000:00:06.0: Leaving promiscuous mode
[1933934.969606] iavf 0000:00:06.0: eth1 is leaving multicast promiscuous mode
[1933935.033597] iavf 0000:00:05.0: Leaving promiscuous mode
[1933935.033599] iavf 0000:00:05.0: eth0 is leaving multicast promiscuous mod
-------------- next part --------------
A non-text attachment was scrubbed...
Name: Intel-ixgbevf.png
Type: image/png
Size: 70527 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20210212/e500c678/attachment-0002.png>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: AMD-iavf.png
Type: image/png
Size: 91340 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20210212/e500c678/attachment-0003.png>
