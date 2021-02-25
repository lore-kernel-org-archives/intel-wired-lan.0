From: Fujinaka, Todd <todd.fujinaka@intel.com>
Date: Thu, 25 Feb 2021 22:26:25 +0000
Subject: [Intel-wired-lan] iavf null packets and arbitrary memory reads
In-Reply-To: <BYAPR11MB360644089232F26D5F0E1BB7EF8B9@BYAPR11MB3606.namprd11.prod.outlook.com>
References: <CAMnf+PgVx-bg87KCV0NbtSi_FRMokVVXLEwuA_XCH6UxR57rKQ@mail.gmail.com>
 <e73bcf37b214af6c8267622a49a7c9166522f3d0.camel@intel.com>
 <BYAPR11MB36062A9FC2CF8231B79DE0D1EF8B9@BYAPR11MB3606.namprd11.prod.outlook.com>
 <BYAPR11MB3606E2AD589A7E343F32F7B6EF8B9@BYAPR11MB3606.namprd11.prod.outlook.com>
 <CAMnf+PjeJ9rZMbnpxUS7eMzVFDO7syxsV-0NQ=Rups5V9DJfgA@mail.gmail.com>
 <BYAPR11MB360644089232F26D5F0E1BB7EF8B9@BYAPR11MB3606.namprd11.prod.outlook.com>
Message-ID: <BYAPR11MB36068D4844EB706F9BBD1AFFEF9E9@BYAPR11MB3606.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Just to let you know, we didn't get a reproduction with the latest RHEL 8.3, but that's not what you were using. I'm going to remind our tester of the version numbers you gave us.

In any case, we are looking at this.

Todd Fujinaka
Software Application Engineer
Data Center Group
Intel Corporation
todd.fujinaka at intel.com

-----Original Message-----
From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Fujinaka, Todd
Sent: Friday, February 12, 2021 1:46 PM
To: JD <jdtxs00@gmail.com>
Cc: intel-wired-lan at lists.osuosl.org
Subject: Re: [Intel-wired-lan] iavf null packets and arbitrary memory reads

There is no common code between iavf and ixgbevf. The speculation is that this is all from the bonding driver, but the repro hasn't started yet.

Todd Fujinaka
Software Application Engineer
Data Center Group
Intel Corporation
todd.fujinaka at intel.com

-----Original Message-----
From: JD <jdtxs00@gmail.com>
Sent: Friday, February 12, 2021 10:39 AM
To: Fujinaka, Todd <todd.fujinaka@intel.com>
Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; intel-wired-lan at lists.osuosl.org
Subject: Re: [Intel-wired-lan] iavf null packets and arbitrary memory reads

I have some important details to add to this. It appears that ixgbe/ixgbevf are also affected. I have reviewed some older Intel based servers and some are showing the behavior as well.

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

This is a server with only 1 NIC (though bonding is still setup with only a single interface for simplification between builds), so I would assume that bonding isn't relevant to the bug. I will include the bonding configuration for the AMD servers below anyway in case you need it.

For repro: I don't know how the issue begins or how to reproduce it on demand, it happens during normal VM use. I will describe our environment and go over various settings.

Virtualization type: qemu-kvm
Libvirt version: libvirt-daemon-kvm-4.5.0-36.el7_9.3.x86_6
QEMU version: qemu-kvm-ev-2.12.0-44.1.el7_8.1.x86_64

OS on both guest/host: CentOS 7.8+ (happens on 7.8 and 7.9) NIC bonding: Bonded and unbonded are affected. However, on bonded hosts, these options are used:
GUEST: BONDING_OPTS="mode=2 miimon=100 xmit_hash_policy=1"
HOST: BONDING_OPTS="mode=4 miimon=100 xmit_hash_policy=layer3+4"

Bonding is setup in both the guest and host using the configuration above. 2 VF's are attached to the KVM guest for this.

Here is the QEMU process on the AMD based server:
qemu     35644  232  3.1 9678028 8432068 ?     SLl  Jan21 75000:17
/usr/libexec/qemu-kvm -name guest=VMNAME-REDACTED,debug-threads=on -S -object secret,id=masterKey0,format=raw,file=/var/lib/libvirt/qemu/domain-27-VMNAME-REDACTED/master-key.aes
-machine pc-i440fx-rhel7.6.0,accel=kvm,usb=off,dump-guest-core=off
-cpu EPYC-IBPB,x2apic=on,tsc-deadline=on,hypervisor=on,tsc_adjust=on,clwb=on,umip=on,spec-ctrl=on,stibp=on,ssbd=on,cmp_legacy=on,perfctr_core=on,monitor=off
-m 8192 -realtime mlock=off -smp 4,sockets=4,cores=1,threads=1 -uuid
6e201ba4-68fe-45be-a86d-fbc46cef5d46 -display none -no-user-config -nodefaults -chardev socket,id=charmonitor,fd=55,server,nowait -mon chardev=charmonitor,id=monitor,mode=control -rtc base=utc,driftfix=slew -global kvm-pit.lost_tick_policy=delay -no-hpet -no-shutdown -global PIIX4_PM.disable_s3=1 -global
PIIX4_PM.disable_s4=1 -boot strict=on -device
ich9-usb-ehci1,id=usb,bus=pci.0,addr=0x2.0x7 -device
ich9-usb-uhci1,masterbus=usb.0,firstport=0,bus=pci.0,multifunction=on,addr=0x2
-device ich9-usb-uhci2,masterbus=usb.0,firstport=2,bus=pci.0,addr=0x2.0x1
-device ich9-usb-uhci3,masterbus=usb.0,firstport=4,bus=pci.0,addr=0x2.0x2
-device ahci,id=sata0,bus=pci.0,addr=0x3 -drive file=/imgs/VMNAME-REDACTED/diskname-redacted,format=qcow2,if=none,id=drive-sata0-0-0,cache=none,discard=unmap
-device ide-hd,bus=sata0.0,drive=drive-sata0-0-0,id=sata0-0-0,bootindex=1,write-cache=on
-chardev pty,id=charserial0 -device
isa-serial,chardev=charserial0,id=serial0 -device
vfio-pci,host=81:03.5,id=hostdev0,bus=pci.0,addr=0x5 -device
vfio-pci,host=81:0b.5,id=hostdev1,bus=pci.0,addr=0x6 -device
virtio-balloon-pci,id=balloon0,bus=pci.0,addr=0x4 -sandbox on,obsolete=deny,elevateprivileges=deny,spawn=deny,resourcecontrol=deny
-msg timestamp=on


Here is the QEMU process on the Intel based server:
qemu     10058  157  8.1 9622376 8017812 ?     SLl  Jan25 40027:35
/usr/libexec/qemu-kvm -name guest=VMNAME-REDACTED,debug-threads=on -S -object secret,id=masterKey0,format=raw,file=/var/lib/libvirt/qemu/domain-21-VMNAME-REDACTED/master-key.aes
-machine pc-i440fx-rhel7.6.0,accel=kvm,usb=off,dump-guest-core=off
-cpu Skylake-Server-IBRS,ss=on,hypervisor=on,tsc_adjust=on,clflushopt=on,umip=on,pku=on,avx512vnni=on,md-clear=on,stibp=on,ssbd=on,xsaves=on,hle=off,rtm=off
-m 8192 -realtime mlock=off -smp 4,sockets=4,cores=1,threads=1 -uuid
6fc40d77-2872-4717-827b-de634b2a5609 -display none -no-user-config -nodefaults -chardev socket,id=charmonitor,fd=31,server,nowait -mon chardev=charmonitor,id=monitor,mode=control -rtc base=utc,driftfix=slew -global kvm-pit.lost_tick_policy=delay -no-hpet -no-shutdown -global PIIX4_PM.disable_s3=1 -global
PIIX4_PM.disable_s4=1 -boot strict=on -device
ich9-usb-ehci1,id=usb,bus=pci.0,addr=0x2.0x7 -device
ich9-usb-uhci1,masterbus=usb.0,firstport=0,bus=pci.0,multifunction=on,addr=0x2
-device ich9-usb-uhci2,masterbus=usb.0,firstport=2,bus=pci.0,addr=0x2.0x1
-device ich9-usb-uhci3,masterbus=usb.0,firstport=4,bus=pci.0,addr=0x2.0x2
-device ahci,id=sata0,bus=pci.0,addr=0x3 -drive file=/imgs/VMNAME-REDACTED/diskname-redacted,format=qcow2,if=none,id=drive-sata0-0-0,cache=none,discard=unmap
-device ide-hd,bus=sata0.0,drive=drive-sata0-0-0,id=sata0-0-0,bootindex=1,write-cache=on
-chardev pty,id=charserial0 -device
isa-serial,chardev=charserial0,id=serial0 -device
vfio-pci,host=18:11.0,id=hostdev0,bus=pci.0,addr=0x5 -device
virtio-balloon-pci,id=balloon0,bus=pci.0,addr=0x4 -sandbox on,obsolete=deny,elevateprivileges=deny,spawn=deny,resourcecontrol=deny
-msg timestamp=on


Lastly, I have attached some files:
- The dmesg log from the VM with ixgbevf
- The dmesg log from the VM with iavf
- A time series graph for the AMD based server with iavf illustrating when the issue began. On the AMD-based server, spikes with dropped packets are normal, but a constant flow isn't. As you can see, a constant flow of dropped packets begins shortly after 2/06 @ 20:20 UTC.
- A time series graph for the Intel based server with ixgbevf illustrating when the issue began. On the Intel based server, there's no drops whatsoever, and as soon as the null packet bug gets triggered, they spike and remain constant after 2/10 @ 9:00 UTC.

I have analytics for almost everything network related (courtesy of Prometheus/node_exporter), so if you want insight on any other keys/values from the kernel or networking stack, please let me know and I'm happy to provide it.

My thoughts currently: If this issue affects both iavf/ixgbevf, how much common code/logic is used between those drivers? I think it should help narrow things down a little more since it doesn't seem to be specific to a NIC or to iavf in particular.

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
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf 
> Of Fujinaka, Todd
> Sent: Thursday, February 11, 2021 4:47 PM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; 
> intel-wired-lan at lists.osuosl.org; jdtxs00 at gmail.com
> Subject: Re: [Intel-wired-lan] iavf null packets and arbitrary memory 
> reads
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
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf 
> Of Nguyen, Anthony L
> Sent: Wednesday, February 10, 2021 6:31 PM
> To: intel-wired-lan at lists.osuosl.org; jdtxs00 at gmail.com
> Subject: Re: [Intel-wired-lan] iavf null packets and arbitrary memory 
> reads
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
> > To me, that looks like it's reading data from memory and attempting 
> > to send from 00:00:00:00:00:00 to 00:00:00:00:00:00.
> >
> > If I run that same tcpdump on a different servers exhibiting the 
> > null packets, completely different items show up which also appear 
> > to be from memory.
> >
> > Keeping a tcpdump results in the same items from memory being 
> > repeated infinitely with no observable variation.
> >
> > So, it seems like the iavf driver is encountering some bug with 
> > memory management and ends up transmitting null packets or arbitrary 
> > data from memory over bond0.
> >
> > How/why did I notice this behavior? The VM's seem to perform worse 
> > over the network when this occurs. They usually exhibit small 
> > amounts of packet loss, or poor SSH responsiveness. Oddly, I have 
> > seen this bug in the past, and it resulted in dmesg on the parent 
> > printing Spoofed packet warnings for the i40e driver. Now it does 
> > not, yet the null packets still occur.
> >
> > I would like to help in any way I can to resolve this in the 
> > iavf/i40e driver. I'm happy to provide information from the servers 
> > if it's needed.
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
> > Vendor: Supermicro Network Adapter AOC-S25G-i2S Firmware version: 
> > 7.20
> > 0x800082b3 1.2585.0
> > MOBO: Supermicro H11DSU-iN
> > CPU: AMD EPYC 7352
> >
> > And here is the dmesg log (grepped for iavf) from a server that has 
> > the issue:
> > iavf: loading out-of-tree module taints kernel.
> > iavf: Intel(R) Ethernet Adaptive Virtual Function Network Driver - 
> > version 4.0.1 iavf 0000:00:06.0: Multiqueue Enabled: Queue pair 
> > count = 4 iavf 0000:00:06.0: MAC address: 52:54:00:7f:bc:39 iavf
> > 0000:00:06.0: GRO is enabled iavf 0000:00:05.0: Multiqueue Enabled:
> > Queue pair count = 4 iavf 0000:00:05.0: MAC address: 
> > 52:54:00:a6:3e:62 iavf 0000:00:05.0: GRO is enabled iavf
> > 0000:00:06.0 eth0: NIC Link is Up Speed is 25 Gbps Full Duplex iavf
> > 0000:00:05.0 eth1: NIC Link is Up Speed is 25 Gbps Full Duplex
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
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan at osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
