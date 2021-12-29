From: Niklas Schnelle <schnelle@linux.ibm.com>
Date: Wed, 29 Dec 2021 17:55:33 +0100
Subject: [Intel-wired-lan] [RFC 01/32] Kconfig: introduce and depend on
 LEGACY_PCI
In-Reply-To: <20211229160317.GA1681139@bhelgaas>
References: <20211229160317.GA1681139@bhelgaas>
Message-ID: <e0877e91d7d50299ea5a3ffcee2cf1016458ce10.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2021-12-29 at 10:03 -0600, Bjorn Helgaas wrote:
> On Wed, Dec 29, 2021 at 01:12:07PM +0100, Mauro Carvalho Chehab wrote:
> > Em Wed, 29 Dec 2021 12:45:38 +0100
> > Niklas Schnelle <schnelle@linux.ibm.com> escreveu:
> > > ...
> > > I do think we agree that once done correctly there is value in
> > > such an option independent of HAS_IOPORT only gating inb() etc uses.
> 
> I'm not sure I'm convinced about this.  For s390, you could do this
> patch series, where you don't define inb() at all, and you add new
> dependencies to prevent compile errors.  Or you could define inb() to
> return ~0, which is what happens on other platforms when the device is
> not present.
> 
> > Personally, I don't see much value on a Kconfig var for legacy PCI I/O 
> > space. From maintenance PoV, bots won't be triggered if someone use
> > HAS_IOPORT instead of the PCI specific one - or vice-versa. So, we
> > could end having a mix of both at the wrong places, in long term.
> > 
> > Also, assuming that PCIe hardware will some day abandon support for 
> > "legacy" PCI I/O space, I guess some runtime logic would be needed, 
> > in order to work with both kinds of PCIe controllers. So, having a
> > Kconfig option won't help much, IMO.
> > 
> > So, my personal preference would be to have just one Kconfig var, but
> > I'm ok if the PCI maintainers decide otherwise.
> 
> I don't really like the "LEGACY_PCI" Kconfig option.  "Legacy" just
> means something old and out of favor; it doesn't say *what* that
> something is.
> 
> I think you're specifically interested in I/O port space usage, and it
> seems that you want all PCI drivers that *only* use I/O port space to
> depend on LEGACY_PCI?  Drivers that can use either I/O or memory
> space or both would not depend on LEGACY_PCI?  This seems a little
> murky and error-prone.

I'd like to hear Arnd's opinion on this but you're the PCI maintainer
so of course your buy-in would be quite important for such an option.

> 
> What if you used the approach from [1] but just dropped the warning?
> The inb() would return ~0 if the platform doesn't support I/O port
> space.  Drivers should be prepared to handle that because that's what
> happens if the device doesn't exist.

Hmm, in that mail Linus very clearly and specifically asked for this to
be a compile-time thing. So, if we do want to make it compile-time but
keep the potential errors to a minimum I guess just having HAS_IOPORT
might be valid compromise. It gets caught by bots through allyesconfig
or randconfig on HAS_IOPORT=n architectures. Also it has a nice
symmetry with the existing HAS_IOMEM. 

>  
> 
> HAS_IOPORT and LEGACY_PCI is a lot of Kconfiggery that basically just
> avoids building drivers that aren't useful on s390.  I'm not sure the
> benefit outweighs the complication.
> 
> Bjorn
> 
> [1] https://lore.kernel.org/lkml/CAHk-=wg80je=K7madF4e7WrRNp37e3qh6y10Svhdc7O8SZ_-8g at mail.gmail.com/
> 

Despite s390 I believe it would also affect nds32, um, h8300, nios2,
openrisc, hexagon, csky, and xtensa. But yes none of these is any less
niche than us. I do wonder if we will see a new drivers using I/O
ports?

