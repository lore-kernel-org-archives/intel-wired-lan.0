From: Aaron Sierra <asierra@xes-inc.com>
Date: Fri, 2 Feb 2018 12:54:27 -0600 (CST)
Subject: [Intel-wired-lan] regression in igb driver from commit
 182785335447
In-Reply-To: <20180201124732.udjgedoktitzqqdm@unicorn.suse.cz>
References: <20180201124732.udjgedoktitzqqdm@unicorn.suse.cz>
Message-ID: <385186179.438363.1517597667391.JavaMail.zimbra@xes-inc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

----- Original Message -----
> From: "Michal Kubecek" <mkubecek@suse.cz>
> Sent: Thursday, February 1, 2018 6:47:32 AM

Michal,

> one of my colleagues observed a regression in recent 4.4.x kernels on
> one of test machines with 82575EB NIC (rev 02, 8086:10a7, firmware
> version 1.6.5). On boot, first port fails to initialize and only the net
> device for second is created. Kernel log looks like
> 
> [   13.710535] igb: Intel(R) Gigabit Ethernet Network Driver - version 5.4.0-k
> [   13.710538] igb: Copyright (c) 2007-2014 Intel Corporation.
> [   13.710584] igb 0000:08:00.0: PCI->APIC IRQ transform: INT A -> IRQ 56
> [   13.712126] igb: probe of 0000:08:00.0 failed with error -2
> [   13.712152] igb 0000:08:00.1: PCI->APIC IRQ transform: INT B -> IRQ 70
> [   13.904537] igb 0000:08:00.1: Intel(R) Gigabit Ethernet Network Connection
> [   13.904545] igb 0000:08:00.1: eth0: (PCIe:2.5Gb/s:Width x4) 00:30:48:7b:5d:37
> [   13.904547] igb 0000:08:00.1: eth0: PBA No: Unknown
> [   13.904556] igb 0000:08:00.1: Using MSI-X interrupts. 4 rx queue(s), 4 tx
> queue(s)
> [   13.927029] igb 0000:08:00.1 eth1: renamed from eth0

Can you share whether (and which versions of) Intel Boot Agent was enabled
for these ports. Does the behavior change if Intel Boot Agent is in the
opposite state? Was the failing device used for network booting?

I'm not sure that I have an 82575EB NIC available for testing, but I will try
to track one down.

-Aaron

> Checking the changelog led us to a stable-4.4.y backport of mainline
> commit 182785335447 ("igb: reset the PHY before reading the PHY ID") as
> the most promising suspect and reverting it fixed the issue.
> 
> I also reproduced the issue with 4.15 kernel, except this time both
> ports of the card failed to probe:
> 
> [   16.826649] igb: Intel(R) Gigabit Ethernet Network Driver - version 5.4.0-k
> [   16.840784] igb: Copyright (c) 2007-2014 Intel Corporation.
> [   16.852176] igb 0000:08:00.0: PCI->APIC IRQ transform: INT A -> IRQ 56
> [   16.867919] igb: probe of 0000:08:00.0 failed with error -2
> [   16.879254] igb 0000:08:00.1: PCI->APIC IRQ transform: INT B -> IRQ 70
> [   16.898178] igb: probe of 0000:08:00.1 failed with error -2
> 
> Reverting commit 182785335447 fixed the issue here as well.
> 
> Michal Kubecek
