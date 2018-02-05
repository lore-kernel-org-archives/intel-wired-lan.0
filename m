From: Michal Kubecek <mkubecek@suse.cz>
Date: Mon, 5 Feb 2018 17:02:40 +0100
Subject: [Intel-wired-lan] regression in igb driver from commit
 182785335447
In-Reply-To: <385186179.438363.1517597667391.JavaMail.zimbra@xes-inc.com>
References: <20180201124732.udjgedoktitzqqdm@unicorn.suse.cz>
 <385186179.438363.1517597667391.JavaMail.zimbra@xes-inc.com>
Message-ID: <20180205160240.ammcr6a6iqrqglsd@unicorn.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, Feb 02, 2018 at 12:54:27PM -0600, Aaron Sierra wrote:
> > From: "Michal Kubecek" <mkubecek@suse.cz>
> > Sent: Thursday, February 1, 2018 6:47:32 AM
> > [   13.710535] igb: Intel(R) Gigabit Ethernet Network Driver - version 5.4.0-k
> > [   13.710538] igb: Copyright (c) 2007-2014 Intel Corporation.
> > [   13.710584] igb 0000:08:00.0: PCI->APIC IRQ transform: INT A -> IRQ 56
> > [   13.712126] igb: probe of 0000:08:00.0 failed with error -2
> > [   13.712152] igb 0000:08:00.1: PCI->APIC IRQ transform: INT B -> IRQ 70
> > [   13.904537] igb 0000:08:00.1: Intel(R) Gigabit Ethernet Network Connection
> > [   13.904545] igb 0000:08:00.1: eth0: (PCIe:2.5Gb/s:Width x4) 00:30:48:7b:5d:37
> > [   13.904547] igb 0000:08:00.1: eth0: PBA No: Unknown
> > [   13.904556] igb 0000:08:00.1: Using MSI-X interrupts. 4 rx queue(s), 4 tx
> > queue(s)
> > [   13.927029] igb 0000:08:00.1 eth1: renamed from eth0
> 
> Can you share whether (and which versions of) Intel Boot Agent was enabled
> for these ports.

It certainly was, first port is used for PXE boot.

This is what I caught on serial console on boot:

------------------------------------------------------------------------
Initializing Intel(R) Boot Agent GE v0.0.13
*** DEVELOPMENT BUILD - NOT FOR PRODUCTION USE!!! ***
*** DEVELOPMENT BUILD - NOT FOR PRODUCTION USE!!! ***
*** DEVELOPMENT BUILD - NOT FOR PRODUCTION USE!!! ***
PXE 2.1 Build 086 (WfM 2.0)                      
                                                           
                                          
Initializing Intel(R) Boot Agent GE v0.0.13
*** DEVELOPMENT BUILD - NOT FOR PRODUCTION USE!!! ***
*** DEVELOPMENT BUILD - NOT FOR PRODUCTION USE!!! ***
*** DEVELOPMENT BUILD - NOT FOR PRODUCTION USE!!! ***
PXE 2.1 Build 086 (WfM 2.0)
Press Ctrl+S to enter the Setup Menu..               
------------------------------------------------------------------------

Doesn't look wery trustworthy. :-( I'll check if I can find another
machine with the same card but more reasonable Intel Boot Agent.

>                  Does the behavior change if Intel Boot Agent is in the
> opposite state? Was the failing device used for network booting?

This may be a bit tricky, the machine is in a test lab and I have only
remote access to it. I'll check if I can disable the Intel Boot Agent
using the serial console.

Michal Kubecek
