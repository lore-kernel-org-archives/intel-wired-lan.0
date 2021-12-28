From: Niklas Schnelle <schnelle@linux.ibm.com>
Date: Tue, 28 Dec 2021 16:06:44 +0100
Subject: [Intel-wired-lan] [RFC 01/32] Kconfig: introduce and depend on
 LEGACY_PCI
In-Reply-To: <20211228135425.0a69168c@coco.lan>
References: <20211227164317.4146918-1-schnelle@linux.ibm.com>
 <20211227164317.4146918-2-schnelle@linux.ibm.com>
 <YcrJAwsKIxxX18pW@kroah.com> <20211228101435.3a55b983@coco.lan>
 <b1475f6aecb752a858941f44a957b2183cd68405.camel@linux.ibm.com>
 <20211228135425.0a69168c@coco.lan>
Message-ID: <4b630b7b87bd983291f628c42a1394fc0d2d86bd.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2021-12-28 at 13:54 +0100, Mauro Carvalho Chehab wrote:
>
---8<---
>   
> > > > All you really care about is the "legacy" I/O spaces here, this isn't
> > > > tied to PCI specifically at all, right?
> > > > 
> > > > So why not just have a OLD_STYLE_IO config option or something like
> > > > that, to show that it's the i/o functions we care about here, not PCI at
> > > > all?
> > > > 
> > > > And maybe not call it "old" or "legacy" as time constantly goes forward,
> > > > just describe it as it is, "DIRECT_IO"?  
> > > 
> > > Agreed. HAVE_PCI_DIRECT_IO (or something similar) seems a more appropriate
> > > name for it.
> > > 
> > > Thanks,
> > > Mauro  
> > 
> > Hmm, I might be missing something here but that sounds a lot like the
> > HAS_IOPORT option added in patch 02.
> > 
> > We add both LEGACY_PCI and HAS_IOPORT to differentiate between two
> > cases. HAS_IOPORT is for PC-style devices that are not on a PCI card
> > while LEGACY_PCI is for PCI drivers that require port I/O. 
> 
> I didn't look at the other patches on this series, but why it is needed
> to deal with them on a separate way? Won't "PCI" and "HAS_IOPORT" be enough? 
> 
> I mean, are there any architecture where HAVE_PCI=y and HAS_IOPORT=y
> where LEGACY_PCI shall be "n"?

In the current patch set LEGACY_PCI is not currently selected by
architectures, though of course it could be if we know that an
architecture requires it. We should probably also set it in any
defconfig that has devices depending on it so as not to break these.

Other than that it would be set during kernel configuration if one
wants/needs support for legacy PCI devices. For testing I ran with
HAVE_PCI=y, HAS_IOPORT=y and LEGACY_PCI=n on both my local Ryzen 3990X
based workstation and Raspberry Pi 4 (DT). I guess at the moment it
would make most sense for special configs such as those tailored for
vitualization guets but in the end that would be something for
distributions to decide.

Arnd described the options here:
https://lore.kernel.org/lkml/CAK8P3a3HHeP+Gw_k2P7Qtig0OmErf0HN30G22+qHic_uZTh11Q at mail.gmail.com/

> 
> > This
> > includes pre-PCIe devices as well as PCIe devices which require
> > features like I/O spaces. The "legacy" naming is comes from the PCIe
> > spec which in section 2.1.1.2 says "PCI Express supports I/O Space for
> > compatibility with legacy devices which require their use. Future
> > revisions of this specification may deprecate the use of I/O Space."
> 
> I would still avoid calling it LEGACY_PCI, as this sounds too generic.
> 
> I didn't read the PCI/PCIe specs, but I suspect that are a lot more
> features that were/will be deprecated on PCI specs as time goes by.
> 
> So, I would, instead, use something like PCI_LEGACY_IO_SPACE or 
> HAVE_PCI_LEGACY_IO_SPACE, in order to let it clear what "legacy"
> means.

Hmm, I'd like to hear Bjorn's opinion on this. Personally I feel like
LEGACY_PCI is pretty clear since most devices are either pre-PCIe
devices or a compatibility feature allowing drivers for a pre-PCIe
device to work with a PCIe device.

> 
> > These two separate config options allow us to compile without support
> > for these legacy PCI devices even on a system where inb()/outb() and
> > friends are required for some PC style devices and for example ACPI.
> 
> Hmm... why this patch make SND_BT87X dependent on LEGACY_PCI?
> 
> > @@ -172,6 +177,7 @@ config SND_AZT3328
> >  
> >  config SND_BT87X
> >  	tristate "Bt87x Audio Capture"
> > +	depends on LEGACY_PCI
> >  	select SND_PCM
> >  	help
> >  	  If you want to record audio from TV cards based on
> 
> I couldn't find any usage of inb/outb & friends on it:
> 
> 	$ grep -E '(inb|outb|inw|outw|inl|outl)\b' ./sound/pci/bt87x.c
> 
> It uses, instead, readl/writel:
> 
> 	static inline u32 snd_bt87x_readl(struct snd_bt87x *chip, u32 reg)
> 	{
> 	        return readl(chip->mmio + reg);
> 	}
> 
> 	static inline void snd_bt87x_writel(struct snd_bt87x *chip, u32 reg, u32 value)
> 	{
> 	        writel(value, chip->mmio + reg);
> 	}
> 
> I failed to see what makes it different from VIDEO_BT848 and
> DVB_BT8XX drivers. They all support exactly the same chipset:
> Brooktree/Conexant BT8xx. On those devices, depending on the exact
> model, up to three separate interfaces are provided, each one with
> its own Kconfig var:
> 
> 	- audio I/O (SND_BT87X);
> 	- video I/O (VIDEO_BT848);
> 	- MPEG-TS I/O (DVB_BT8XX).
> 
> Thanks,
> Mauro

You're right, that makes no sense this doesn't seem to require
LEGACY_PCI. Maybe this was added by Arnd because it lacks a "depends on
PCI" which could have caused issues with HAVE_PCI=n rand configs.

