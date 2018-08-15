From: Wyborny, Carolyn <carolyn.wyborny@intel.com>
Date: Wed, 15 Aug 2018 23:54:13 +0000
Subject: [Intel-wired-lan] [BUG] Kernel Oops and crash using i40e VF
 devices
In-Reply-To: <20180815225346.GE2354@libmpq.org>
References: <20180815142346.GC2354@libmpq.org>
 <9BBC4E0CF881AA4299206E2E1412B6267C5EA4D6@ORSMSX102.amr.corp.intel.com>
 <20180815225346.GE2354@libmpq.org>
Message-ID: <9BBC4E0CF881AA4299206E2E1412B6267C5EAB0D@ORSMSX102.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Maik Broemme [mailto:mbroemme at libmpq.org]
> Sent: Wednesday, August 15, 2018 3:54 PM
> To: Wyborny, Carolyn <carolyn.wyborny@intel.com>
> Cc: netdev <netdev@vger.kernel.org>; linux-kernel <linux-
> kernel at vger.kernel.org>
> Subject: Re: [BUG] Kernel Oops and crash using i40e VF devices
> 
Thanks for this info.  I have some questions below.

> Hi Carolyn,
[..]
> > > Hi,
> > >
> > > I have a SuperMicro X11SPM-F mainboard with two Intel X722 devices
> > > which
> > > support up to 32 VF devices per PF device. They are running with i40e
> > > driver. Whenever I try to use the VF devices in Xen VMs, the host kernel
> > > got an Oops or crash. In all cases the PF running on the host
> > > immediately loses network connection. I can reproduce this always
> > > running the following:
> > >
> > We have some known issues around this problem.  I'll need some more
> info to debug it.
[..]
> After boot I have a script which runs a set of commands to create all
> the VFs, assign MACs to VFs, enable trust on VFs and add them to pciback
> driver for Xen. This runs all fine. After that I start VMs via xl create
> command.
> 
> > What drivers are loaded on all ports?
> 
> The X11SPM-F has only 2x 1 GbE ports and they are both using 'i40e.ko'
> module as driver. Also I've blacklisted the 'i40evf.ko' module on Xen
> host (Dom0) to not load it when VF devices are created as they will be
> assigned to 'xen-pciback.ko' with pciback driver.
[..]
> > Do you have any virtualization configured in your setup?
> 
> Yes, I'm using Xen 4.11.0 from Arch Linux. I'm maintainer of the
> package.
> 
> > If so, what exactly and how are the ethernet devices configured in that?
> 
> Inside VMs I use either 4.17.x (+PREEMPT) or 4.14.x LTS (-PREEMPT)
> version. Both are using stock kernel version of 'i40evf.ko' module.

[CMW]Above you said you blacklist the i40evf driver and use the xen-pciback driver.  Do you load the i40evf driver again then at a later time?
This isn't a configuration I'm familiar with.  Can I get the full dmesg log from a system showing the problem?  You can post it in a bug at SourceForge, pastebin or something like that to save space on this thread.

[CMW]To find out exactly what kind of MDD error is occurring involves some complicated debug operations because of a register issue in the part.  If  you want to do that, we should go offlist for the details due to the length, not because its anything private or hidden.  However, the most common reason is because of some traffic patterns and a configuration detail in our drivers that was not complete at release.  I will investigate the combination of driver and patches to see if there may be some driver patches you'll need to apply.
> 
> >
> > Thanks,
> >
> > Carolyn
> >
> > Carolyn Wyborny
> > Linux Development
> > Networking Division
> > Intel Corporation
> >
> >
> 
> --Maik
