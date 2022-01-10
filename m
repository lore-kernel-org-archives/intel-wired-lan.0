From: Niklas Schnelle <schnelle@linux.ibm.com>
Date: Mon, 10 Jan 2022 10:34:34 +0100
Subject: [Intel-wired-lan] [RFC 01/32] Kconfig: introduce and depend on
 LEGACY_PCI
In-Reply-To: <74bf4fde-3972-1c36-ca04-58089da0d82b@huawei.com>
References: <20220105194748.GA215560@bhelgaas>
 <74bf4fde-3972-1c36-ca04-58089da0d82b@huawei.com>
Message-ID: <822ad0da702f0953b7aae1febd2c4dfcc4707864.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 2022-01-06 at 17:41 +0000, John Garry wrote:
> On 05/01/2022 19:47, Bjorn Helgaas wrote:
> > > > > >   ok if the PCI maintainers decide otherwise.
> > > > > I don't really like the "LEGACY_PCI" Kconfig option.  "Legacy" just
> > > > > means something old and out of favor; it doesn't say*what*  that
> > > > > something is.
> > > > > 
> > > > > I think you're specifically interested in I/O port space usage, and it
> > > > > seems that you want all PCI drivers that*only*  use I/O port space to
> > > > > depend on LEGACY_PCI?  Drivers that can use either I/O or memory
> > > > > space or both would not depend on LEGACY_PCI?  This seems a little
> > > > > murky and error-prone.
> > > > I'd like to hear Arnd's opinion on this but you're the PCI maintainer
> > > > so of course your buy-in would be quite important for such an option.
> > I'd like to hear Arnd's opinion, too.  If we do add LEGACY_PCI, I
> > think we need a clear guide for when to use it, e.g., "a PCI driver
> > that uses inb() must depend on LEGACY_PCI" or whatever it is.
> > 
> > I must be missing something because I don't see what we gain from
> > this.  We have PCI drivers, e.g., megaraid [1], for devices that have
> > either MEM or I/O BARs.  I think we want to build drivers like that on
> > any arch that supports PCI.
> > 
> > If the arch doesn't support I/O port space, devices that only have I/O
> > BARs won't work, of course, and hopefully the PCI core and driver can
> > figure that out and gracefully fail the probe.
> > 
> > But that same driver should still work with devices that have MEM
> > BARs.  If inb() isn't always present, I guess we could litter these
> > drivers with #ifdefs, but that would be pretty ugly.

I think this is the big question here. If we do go with a compile-time
solution as requested by Linus we will either get a lot of #ifdeffery,
coarse driver dependencies or as proposed by Alan Stern for the USB
#ifdefs might end up turning inb() into a compile-time nop.

The originally proposed change that returned ~0 from inb() and printed
a warning clearly is the simpler change and sure we could also drop the
warning. I'm honestly torn, I do agree with Linus that we shouldn't
have run-time things that we know at compile-time will not work but I
also dislike all the #ifdeffery a compile-time solution requires. Sadly
C really doesn't give us any better tools here.

Also I 100% agree with you Bjorn how likely it is to see a device on a
platform really shouldn't matter. Without going into details, on s390
we have already beneffited from PCI drivers working with 0 changes to
support devices we previously didn't have on the platform or
anticipated we would get in the future. Consequently drivers that could
work in principle should be built.

> >  
> 
> There were some ifdefs added to the 8250 drivers in Arnd's original 
> patch [0], but it does not seem included here.
> 
> Niklas, what happened to the 8250 and the other driver changes?

I missed it during the rebase, likely because the changed files compile
depend on !S390 via config SERIAL_8250 and thus didn't cause any errors
for my allyesconfig. That !S390 dependency is of course not really what
we want if the driver can use MEM BARs.


