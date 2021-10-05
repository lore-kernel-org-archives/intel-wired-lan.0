From: Andreas K. Huettel <andreas.huettel@ur.de>
Date: Tue, 05 Oct 2021 15:43:08 +0200
Subject: [Intel-wired-lan] [EXT] Re: Intel I350 regression 5.10 -> 5.14
 ("The NVM Checksum Is Not Valid") [8086:1521]
In-Reply-To: <35dfc9e8-431c-362d-450e-4c6ac1e55434@molgen.mpg.de>
References: <1823864.tdWV9SEqCh@kailua>
 <20211004074814.5900791a@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <35dfc9e8-431c-362d-450e-4c6ac1e55434@molgen.mpg.de>
Message-ID: <2944777.ktpJ11cQ8Q@pinacolada>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> 
> What messages are new compared to the working Linux 5.10.59?
> 

I've uploaded the full boot logs to https://dev.gentoo.org/~dilfridge/igb/
(both in a version with and without timestamps, for easy diff).

* I can't see anything that immediately points to the igb device (like a PCI id etc.) before the module is loaded. 
* The main difference between the logs is many unrelated (?) i915 warnings in 5.10.59 because of the nonfunctional graphics.

The messages easily identifiable are:

huettel at pinacolada ~/tmp $ cat kernel-messages-5.10.59.txt |grep igb
Oct  5 15:11:18 dilfridge kernel: [    2.090675] igb: Intel(R) Gigabit Ethernet Network Driver
Oct  5 15:11:18 dilfridge kernel: [    2.090676] igb: Copyright (c) 2007-2014 Intel Corporation.
Oct  5 15:11:18 dilfridge kernel: [    2.090728] igb 0000:01:00.0: enabling device (0000 -> 0002)
Oct  5 15:11:18 dilfridge kernel: [    2.094438] Modules linked in: igb(+) i915(+) iosf_mbi acpi_pad efivarfs
Oct  5 15:11:18 dilfridge kernel: [    2.097287] Modules linked in: igb(+) i915(+) iosf_mbi acpi_pad efivarfs
Oct  5 15:11:18 dilfridge kernel: [    2.098492] Modules linked in: igb(+) i915(+) iosf_mbi acpi_pad efivarfs
Oct  5 15:11:18 dilfridge kernel: [    2.098787] Modules linked in: igb(+) i915(+) iosf_mbi acpi_pad efivarfs
Oct  5 15:11:18 dilfridge kernel: [    2.173386] igb 0000:01:00.0: added PHC on eth0
Oct  5 15:11:18 dilfridge kernel: [    2.173391] igb 0000:01:00.0: Intel(R) Gigabit Ethernet Network Connection
Oct  5 15:11:18 dilfridge kernel: [    2.173395] igb 0000:01:00.0: eth0: (PCIe:5.0Gb/s:Width x4) 6c:b3:11:23:d4:4c
Oct  5 15:11:18 dilfridge kernel: [    2.173991] igb 0000:01:00.0: eth0: PBA No: H47819-001
Oct  5 15:11:18 dilfridge kernel: [    2.173994] igb 0000:01:00.0: Using MSI-X interrupts. 8 rx queue(s), 8 tx queue(s)
Oct  5 15:11:18 dilfridge kernel: [    2.174199] igb 0000:01:00.1: enabling device (0000 -> 0002)
Oct  5 15:11:18 dilfridge kernel: [    2.261029] igb 0000:01:00.1: added PHC on eth1
Oct  5 15:11:18 dilfridge kernel: [    2.261034] igb 0000:01:00.1: Intel(R) Gigabit Ethernet Network Connection
Oct  5 15:11:18 dilfridge kernel: [    2.261038] igb 0000:01:00.1: eth1: (PCIe:5.0Gb/s:Width x4) 6c:b3:11:23:d4:4d
Oct  5 15:11:18 dilfridge kernel: [    2.261772] igb 0000:01:00.1: eth1: PBA No: H47819-001
Oct  5 15:11:18 dilfridge kernel: [    2.261776] igb 0000:01:00.1: Using MSI-X interrupts. 8 rx queue(s), 8 tx queue(s)
Oct  5 15:11:18 dilfridge kernel: [    2.265376] igb 0000:01:00.1 enp1s0f1: renamed from eth1
Oct  5 15:11:18 dilfridge kernel: [    2.282514] igb 0000:01:00.0 enp1s0f0: renamed from eth0
Oct  5 15:11:31 dilfridge kernel: [   17.585202] igb 0000:01:00.0 enp1s0f0: igb: enp1s0f0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX

huettel at pinacolada ~/tmp $ cat kernel-messages-5.14.9.txt |grep igb
Oct  5 02:38:31 dilfridge kernel: [    2.108606] igb: Intel(R) Gigabit Ethernet Network Driver
Oct  5 02:38:31 dilfridge kernel: [    2.108608] igb: Copyright (c) 2007-2014 Intel Corporation.
Oct  5 02:38:31 dilfridge kernel: [    2.108622] igb 0000:01:00.0: can't change power state from D3cold to D0 (config space inaccessible)
Oct  5 02:38:31 dilfridge kernel: [    2.108918] igb 0000:01:00.0 0000:01:00.0 (uninitialized): PCIe link lost
Oct  5 02:38:31 dilfridge kernel: [    2.418724] igb 0000:01:00.0: PHY reset is blocked due to SOL/IDER session.
Oct  5 02:38:31 dilfridge kernel: [    4.148163] igb 0000:01:00.0: The NVM Checksum Is Not Valid
Oct  5 02:38:31 dilfridge kernel: [    4.154891] igb: probe of 0000:01:00.0 failed with error -5
Oct  5 02:38:31 dilfridge kernel: [    4.154904] igb 0000:01:00.1: can't change power state from D3cold to D0 (config space inaccessible)
Oct  5 02:38:31 dilfridge kernel: [    4.155146] igb 0000:01:00.1 0000:01:00.1 (uninitialized): PCIe link lost
Oct  5 02:38:31 dilfridge kernel: [    4.466904] igb 0000:01:00.1: PHY reset is blocked due to SOL/IDER session.
Oct  5 02:38:31 dilfridge kernel: [    6.195528] igb 0000:01:00.1: The NVM Checksum Is Not Valid
Oct  5 02:38:31 dilfridge kernel: [    6.200863] igb: probe of 0000:01:00.1 failed with error -5


> >> Any advice on how to proceed? Willing to test patches and provide additional debug info.
> 
> Without any ideas about the issue, please bisect the issue to find the 
> commit introducing the regression, so it can be reverted/fixed to not 
> violate Linux? no-regression policy.

I'll start going through kernel versions (and later revisions) end of the week.

Thanks a lot,
Andreas


-- 
PD Dr. Andreas K. Huettel
Institute for Experimental and Applied Physics
University of Regensburg
93040 Regensburg
Germany
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 981 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20211005/8dcdb430/attachment.asc>
