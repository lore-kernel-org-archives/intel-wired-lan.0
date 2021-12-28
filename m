From: Mauro Carvalho Chehab <mchehab@kernel.org>
Date: Tue, 28 Dec 2021 10:15:16 +0100
Subject: [Intel-wired-lan] [RFC 01/32] Kconfig: introduce and depend on
 LEGACY_PCI
In-Reply-To: <YcrJAwsKIxxX18pW@kroah.com>
References: <20211227164317.4146918-1-schnelle@linux.ibm.com>
 <20211227164317.4146918-2-schnelle@linux.ibm.com>
 <YcrJAwsKIxxX18pW@kroah.com>
Message-ID: <20211228101435.3a55b983@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Em Tue, 28 Dec 2021 09:21:23 +0100
Greg Kroah-Hartman <gregkh@linuxfoundation.org> escreveu:

> On Mon, Dec 27, 2021 at 05:42:46PM +0100, Niklas Schnelle wrote:
> > --- a/drivers/pci/Kconfig
> > +++ b/drivers/pci/Kconfig
> > @@ -23,6 +23,17 @@ menuconfig PCI
> >  
> >  if PCI
> >  
> > +config LEGACY_PCI
> > +	bool "Enable support for legacy PCI devices"
> > +	depends on HAVE_PCI
> > +	help
> > +	   This option enables support for legacy PCI devices. This includes
> > +	   PCI devices attached directly or via a bridge on a PCI Express bus.
> > +	   It also includes compatibility features on PCI Express devices which
> > +	   make use of legacy I/O spaces.  

This Kconfig doesn't seem what it is needed there, as this should be an 
arch-dependent feature, and not something that the poor user should be
aware if a given architecture supports it or not. Also, the above will keep
causing warnings or errors with randconfigs.

Also, the "depends on HAVE_CPI" is bogus, as PCI already depends on 
HAVE_PCI:

	menuconfig PCI
	bool "PCI support"
	depends on HAVE_PCI
	help
	  This option enables support for the PCI local bus, including
	  support for PCI-X and the foundations for PCI Express support.
	  Say 'Y' here unless you know what you are doing.

So, instead, I would expect that a new HAVE_xxx option would be
added at arch/*/Kconfig, like:

	config X86
		...
		select HAVE_PCI_DIRECT_IO

It would also make sense to document it at Documentation/features/.

> 
> All you really care about is the "legacy" I/O spaces here, this isn't
> tied to PCI specifically at all, right?
> 
> So why not just have a OLD_STYLE_IO config option or something like
> that, to show that it's the i/o functions we care about here, not PCI at
> all?
> 
> And maybe not call it "old" or "legacy" as time constantly goes forward,
> just describe it as it is, "DIRECT_IO"?

Agreed. HAVE_PCI_DIRECT_IO (or something similar) seems a more appropriate
name for it.

Thanks,
Mauro
