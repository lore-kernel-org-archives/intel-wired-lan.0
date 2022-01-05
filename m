From: Bjorn Helgaas <helgaas@kernel.org>
Date: Wed, 5 Jan 2022 13:47:48 -0600
Subject: [Intel-wired-lan] [RFC 01/32] Kconfig: introduce and depend on
 LEGACY_PCI
In-Reply-To: <3f39d8a2-2e57-a671-2926-eb4f2bf20c76@huawei.com>
Message-ID: <20220105194748.GA215560@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Jan 05, 2022 at 05:42:16PM +0000, John Garry wrote:
> On 29/12/2021 16:55, Niklas Schnelle wrote:
> > On Wed, 2021-12-29 at 10:03 -0600, Bjorn Helgaas wrote:
> > > On Wed, Dec 29, 2021 at 01:12:07PM +0100, Mauro Carvalho Chehab wrote:
> > > > Em Wed, 29 Dec 2021 12:45:38 +0100
> > > > Niklas Schnelle<schnelle@linux.ibm.com>  escreveu:
> > > > > ...
> > > > > I do think we agree that once done correctly there is value in
> > > > > such an option independent of HAS_IOPORT only gating inb() etc uses.
> > > I'm not sure I'm convinced about this.  For s390, you could do this
> > > patch series, where you don't define inb() at all, and you add new
> > > dependencies to prevent compile errors.  Or you could define inb() to
> > > return ~0, which is what happens on other platforms when the device is
> > > not present.
> > > 
> > > > Personally, I don't see much value on a Kconfig var for legacy PCI I/O
> > > > space. From maintenance PoV, bots won't be triggered if someone use
> > > > HAS_IOPORT instead of the PCI specific one - or vice-versa. So, we
> > > > could end having a mix of both at the wrong places, in long term.
> > > > 
> > > > Also, assuming that PCIe hardware will some day abandon support for
> > > > "legacy" PCI I/O space, I guess some runtime logic would be needed,
> > > > in order to work with both kinds of PCIe controllers. So, having a
> > > > Kconfig option won't help much, IMO.
> > > > 
> > > > So, my personal preference would be to have just one Kconfig var, but
> > > > I'm ok if the PCI maintainers decide otherwise.
> > > I don't really like the "LEGACY_PCI" Kconfig option.  "Legacy" just
> > > means something old and out of favor; it doesn't say*what*  that
> > > something is.
> > > 
> > > I think you're specifically interested in I/O port space usage, and it
> > > seems that you want all PCI drivers that *only* use I/O port space to
> > > depend on LEGACY_PCI?  Drivers that can use either I/O or memory
> > > space or both would not depend on LEGACY_PCI?  This seems a little
> > > murky and error-prone.
> > I'd like to hear Arnd's opinion on this but you're the PCI maintainer
> > so of course your buy-in would be quite important for such an option.

I'd like to hear Arnd's opinion, too.  If we do add LEGACY_PCI, I
think we need a clear guide for when to use it, e.g., "a PCI driver
that uses inb() must depend on LEGACY_PCI" or whatever it is.

I must be missing something because I don't see what we gain from
this.  We have PCI drivers, e.g., megaraid [1], for devices that have
either MEM or I/O BARs.  I think we want to build drivers like that on
any arch that supports PCI.

If the arch doesn't support I/O port space, devices that only have I/O
BARs won't work, of course, and hopefully the PCI core and driver can
figure that out and gracefully fail the probe.

But that same driver should still work with devices that have MEM
BARs.  If inb() isn't always present, I guess we could litter these
drivers with #ifdefs, but that would be pretty ugly.  IMO inb() should
be present but do something innocuous like return ~0, as it would if
I/O port space is supported but there's no device at that address.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/scsi/megaraid.c?id=v5.15#n4210

> I can't see the value in the LEGACY_PCI config - however I don't really
> understand Arnd's original intention.
> 
> It was written that it would allow us to control "whether we have any
> pre-PCIe devices or those PCIe drivers that need PIO accessors other than
> ioport_map()/pci_iomap()".
> 
> However I just don't see why CONFIG_PCI=y and CONFIG_HAS_IOPORT=y aren't
> always the gating factor here. Arnd?
> 
> Thanks,
> John
