From: John Garry <john.garry@huawei.com>
Date: Thu, 6 Jan 2022 17:41:00 +0000
Subject: [Intel-wired-lan] [RFC 01/32] Kconfig: introduce and depend on
 LEGACY_PCI
In-Reply-To: <20220105194748.GA215560@bhelgaas>
References: <20220105194748.GA215560@bhelgaas>
Message-ID: <74bf4fde-3972-1c36-ca04-58089da0d82b@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 05/01/2022 19:47, Bjorn Helgaas wrote:
>>>>>   ok if the PCI maintainers decide otherwise.
>>>> I don't really like the "LEGACY_PCI" Kconfig option.  "Legacy" just
>>>> means something old and out of favor; it doesn't say*what*  that
>>>> something is.
>>>>
>>>> I think you're specifically interested in I/O port space usage, and it
>>>> seems that you want all PCI drivers that*only*  use I/O port space to
>>>> depend on LEGACY_PCI?  Drivers that can use either I/O or memory
>>>> space or both would not depend on LEGACY_PCI?  This seems a little
>>>> murky and error-prone.
>>> I'd like to hear Arnd's opinion on this but you're the PCI maintainer
>>> so of course your buy-in would be quite important for such an option.
> I'd like to hear Arnd's opinion, too.  If we do add LEGACY_PCI, I
> think we need a clear guide for when to use it, e.g., "a PCI driver
> that uses inb() must depend on LEGACY_PCI" or whatever it is.
> 
> I must be missing something because I don't see what we gain from
> this.  We have PCI drivers, e.g., megaraid [1], for devices that have
> either MEM or I/O BARs.  I think we want to build drivers like that on
> any arch that supports PCI.
> 
> If the arch doesn't support I/O port space, devices that only have I/O
> BARs won't work, of course, and hopefully the PCI core and driver can
> figure that out and gracefully fail the probe.
> 
> But that same driver should still work with devices that have MEM
> BARs.  If inb() isn't always present, I guess we could litter these
> drivers with #ifdefs, but that would be pretty ugly. 

There were some ifdefs added to the 8250 drivers in Arnd's original 
patch [0], but it does not seem included here.

Niklas, what happened to the 8250 and the other driver changes?

[0] 
https://lore.kernel.org/lkml/CAK8P3a0MNbx-iuzW_-=0ab6-TTZzwV-PT_6gAC1Gp5PgYyHcrA at mail.gmail.com/

> IMO inb() should
> be present but do something innocuous like return ~0, as it would if
> I/O port space is supported but there's no device at that address.
> 
> [1]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/scsi/megaraid.c?id=v5.15#n4210
> 

That driver would prob not be used on systems which does not support 
PIO, and so could have a HAS_IOPORT dependency. But it is not strictly 
necessary.

Anyway, it would be good to have an idea of how much ifdeffery is 
required in drivers.

Thanks,
John
