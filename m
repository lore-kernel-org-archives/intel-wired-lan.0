From: Andreas K. Huettel <andreas.huettel@ur.de>
Date: Fri, 15 Oct 2021 16:00:59 +0200
Subject: [Intel-wired-lan] [EXT] Re: Intel I350 regression 5.10 -> 5.14
 ("The NVM Checksum Is Not Valid") [8086:1521]
In-Reply-To: <CAJZ5v0icUwksYVjKW0H5G0DNpfVHSyfm4oC782+Fsy56mQ330A@mail.gmail.com>
References: <1823864.tdWV9SEqCh@kailua> <9965462.DAOxP5AVGn@pinacolada>
 <CAJZ5v0icUwksYVjKW0H5G0DNpfVHSyfm4oC782+Fsy56mQ330A@mail.gmail.com>
Message-ID: <4697216.31r3eYUQgx@kailua>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Am Donnerstag, 14. Oktober 2021, 14:09:39 CEST schrieb Rafael J. Wysocki:
> > > > >>> huettel at pinacolada ~/tmp $ cat kernel-messages-5.10.59.txt |grep igb
> > > > >>> Oct  5 15:11:18 dilfridge kernel: [    2.090675] igb: Intel(R) Gigabit Ethernet Network Driver
> > > > >>> Oct  5 15:11:18 dilfridge kernel: [    2.090676] igb: Copyright (c) 2007-2014 Intel Corporation.
> > > > >>> Oct  5 15:11:18 dilfridge kernel: [    2.090728] igb 0000:01:00.0: enabling device (0000 -> 0002)
> > > > >>
> > > > >> This line is missing below, it indicates that the kernel couldn't or
> > > > >> didn't power up the PCIe for some reason. We're looking for something
> > > > >> like ACPI or PCI patches (possibly PCI-Power management) to be the
> > > > >> culprit here.
> > > > >
> > > > > So I did a git bisect from linux-v5.10 (good) to linux-v5.14.11 (bad).
> > > > >
> > > > > The result was:
> > > > >
> > > > > dilfridge /usr/src/linux-git # git bisect bad
> > > > > 6381195ad7d06ef979528c7452f3ff93659f86b1 is the first bad commit
> > > > > commit 6381195ad7d06ef979528c7452f3ff93659f86b1
> > > > > Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > > Date:   Mon May 24 17:26:16 2021 +0200
> > > > >
> > > > >      ACPI: power: Rework turning off unused power resources
> > > > > [...]
> > > > >
> > > > > I tried naive reverting of this commit on top of 5.14.11. That applies nearly cleanly,
> > > > > and after a reboot the additional ethernet interfaces show up with their MAC in the
> > > > > boot messages.
> > > > >
> > > > > (Not knowing how safe that experiment was, I did not go further than single mode and
> > > > > immediately rebooted into 5.10 afterwards.)
> > >
> > > Reverting this is rather not an option, because the code before it was
> > > a one-off fix of an earlier issue, but it should be fixable given some
> > > more information.
> > >
> > > Basically, I need a boot log from both the good and bad cases and the
> > > acpidump output from the affected machine.
> > >
> >
> > https://dev.gentoo.org/~dilfridge/igb/
> >
> > ^ Should all be here now.
> >
> > 5.10 -> "good" log (the errors are caused by missing support for my i915 graphics and hopefully unrelated)
> > 5.14 -> "bad" log
> >
> > Thank you for looking at this. If you need anything else, just ask.
> 
> You're welcome.
> 
> Please test the attached patch and let me know if it helps.
> 

It helps (*); the second ethernet adaptor is initialized, and works normally as far as I can see.

(*) The debug output line following the if-condition apparently changed in the meantime, so I had 
to apply the change in the if-condition "manually".

igb: Intel(R) Gigabit Ethernet Network Driver
igb: Copyright (c) 2007-2014 Intel Corporation.
igb 0000:01:00.0: enabling device (0000 -> 0002)
igb 0000:01:00.0: added PHC on eth1
igb 0000:01:00.0: Intel(R) Gigabit Ethernet Network Connection
igb 0000:01:00.0: eth1: (PCIe:5.0Gb/s:Width x4) 6c:b3:11:23:d4:4c
igb 0000:01:00.0: eth1: PBA No: H47819-001
igb 0000:01:00.0: Using MSI-X interrupts. 8 rx queue(s), 8 tx queue(s)
igb 0000:01:00.1: enabling device (0000 -> 0002)
igb 0000:01:00.1: added PHC on eth2
igb 0000:01:00.1: Intel(R) Gigabit Ethernet Network Connection
igb 0000:01:00.1: eth2: (PCIe:5.0Gb/s:Width x4) 6c:b3:11:23:d4:4d
igb 0000:01:00.1: eth2: PBA No: H47819-001
igb 0000:01:00.1: Using MSI-X interrupts. 8 rx queue(s), 8 tx queue(s)

The full boot log is at https://dev.gentoo.org/~dilfridge/igb/ as 5.14.11-*.txt

Thanks,
Andreas


-- 
PD Dr. Andreas K. Huettel
Institute for Experimental and Applied Physics
University of Regensburg
93040 Regensburg
Germany

e-mail andreas.huettel at ur.de
http://www.akhuettel.de/
http://www.physik.uni-r.de/forschung/huettel/
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 981 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20211015/29d9cbd2/attachment.asc>
