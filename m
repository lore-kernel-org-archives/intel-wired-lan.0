From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Thu, 11 Feb 2021 02:30:37 +0000
Subject: [Intel-wired-lan] iavf null packets and arbitrary memory reads
In-Reply-To: <CAMnf+PgVx-bg87KCV0NbtSi_FRMokVVXLEwuA_XCH6UxR57rKQ@mail.gmail.com>
References: <CAMnf+PgVx-bg87KCV0NbtSi_FRMokVVXLEwuA_XCH6UxR57rKQ@mail.gmail.com>
Message-ID: <e73bcf37b214af6c8267622a49a7c9166522f3d0.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2021-02-10 at 14:56 -0600, JD wrote:
> Hello,
> 
> I've encountered a NIC driver bug that leads to null packets being
> transmitted and arbitrary/OOB memory reads by the iavf driver.
> 
> I'm unfortunately not sure how the issue starts, but it has been
> happening across many different AMD servers and virtual machines.
> 
> Running a tcpdump (tcpdump -i bond0 -nne ether host
> 00:00:00:00:00:00)
> on bond0 results in these packets being produced at a high rate:
> 
> 13:04:14.826298 00:00:00:00:00:00 > 00:00:00:00:00:00, 802.3, length
> 0: LLC, dsap Null (0x00) Individual, ssap Null (0x00) Command, ctrl
> 0x0000: Information, send seq 0, rcv seq 0, Flags [Command], length
> 144
>         0x0000:  0000 0000 0000 0000 0000 0000 0000
> 0000  ................
>         0x0010:  0000 0000 0000 0000 0000 0000 0000
> 0000  ................
>         0x0020:  0000 0000 0000 0000 0000 0000 0000
> 0000  ................
>         0x0030:  0000 0000 0000 0000 0000 0000 0000
> 0000  ................
>         0x0040:  0000 0000 0000 0000 0000 0000 0000
> 0000  ................
>         0x0050:  0000 0000 0000 0000 0000 0000 0000
> 0000  ................
>         0x0060:  0000 0000 0000 0000 0000 0000 0000
> 0000  ................
>         0x0070:  0000 0000 0000 0000 0000 0000 0000
> 0000  ................
>         0x0080:  0000 0000 0000 0000 0000 0000 0000
> 0000  ................
> 
> 
> As you can see, they have a dest/src ether of 00:00:00:00:00:00 and
> are completely null.  This doesn't happen on every virtual machine,
> some return absolutely nothing.
> 
> If I filter the tcpdump command to ignore empty packets (all dots),
> some other interesting items begin to appear:
> 
>         0x0500:  0000 0000 0000 0029 0100 071b 0473
> 656c  .......).....sel
>         0x0510:  696e 7578 7379 7374 656d 5f75 3a6f
> 626a  inuxsystem_u:obj
>         0x0520:  6563 745f 723a 6269 6e5f 743a 7330
> 0000  ect_r:bin_t:s0..
> [...]
>         0x0080:  0000 2f75 7372 2f6c 6962 3634 2f70
> 6572  ../usr/lib64/per
>         0x0090:  6c35 2f76 656e 646f 725f 7065 726c
> 2f46  l5/vendor_perl/F
>         0x00a0:  696c 652f 5370 6563 2f55 6e69 782e
> 706d  ile/Spec/Unix.pm
> 
> To me, that looks like it's reading data from memory and attempting
> to
> send from 00:00:00:00:00:00 to 00:00:00:00:00:00.
> 
> If I run that same tcpdump on a different servers exhibiting the null
> packets, completely different items show up which also appear to be
> from memory.
> 
> Keeping a tcpdump results in the same items from memory being
> repeated
> infinitely with no observable variation.
> 
> So, it seems like the iavf driver is encountering some bug with
> memory
> management and ends up transmitting null packets or arbitrary data
> from memory over bond0.
> 
> How/why did I notice this behavior? The VM's seem to perform worse
> over the network when this occurs. They usually exhibit small amounts
> of packet loss, or poor SSH responsiveness. Oddly, I have seen this
> bug in the past, and it resulted in dmesg on the parent printing
> Spoofed packet warnings for the i40e driver. Now it does not, yet the
> null packets still occur.
> 
> I would like to help in any way I can to resolve this in the
> iavf/i40e
> driver. I'm happy to provide information from the servers if it's
> needed.
> 
> For reference, here is the setup on every single AMD server:
> VM:
> CentOS 7.9
> NIC driver: iavf 4.0.1
> Kernel 4.19.163
> 
> KVM parent:
> CentOS 7.9
> NIC driver: i40e 2.12.6
> Kernel: 4.19.163
> 2x Intel XXV710 for 25GbE SFP28 @ 25Gbps BONDED (Mode 4, LACP)
> Vendor: Supermicro Network Adapter AOC-S25G-i2S
> Firmware version: 7.20 0x800082b3 1.2585.0
> MOBO: Supermicro H11DSU-iN
> CPU: AMD EPYC 7352
> 
> And here is the dmesg log (grepped for iavf) from a server that has
> the issue:
> iavf: loading out-of-tree module taints kernel.
> iavf: Intel(R) Ethernet Adaptive Virtual Function Network Driver -
> version 4.0.1
> iavf 0000:00:06.0: Multiqueue Enabled: Queue pair count = 4
> iavf 0000:00:06.0: MAC address: 52:54:00:7f:bc:39
> iavf 0000:00:06.0: GRO is enabled
> iavf 0000:00:05.0: Multiqueue Enabled: Queue pair count = 4
> iavf 0000:00:05.0: MAC address: 52:54:00:a6:3e:62
> iavf 0000:00:05.0: GRO is enabled
> iavf 0000:00:06.0 eth0: NIC Link is Up Speed is 25 Gbps Full Duplex
> iavf 0000:00:05.0 eth1: NIC Link is Up Speed is 25 Gbps Full Duplex
> 

Hi JD,

I will check and see we're aware of this issue or have any information
about it. If not, I'll see if we can work on a reproduction.

Thanks,
Tony
