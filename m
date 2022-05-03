From: Niklas Schnelle <schnelle@linux.ibm.com>
Date: Tue, 03 May 2022 14:45:21 +0200
Subject: [Intel-wired-lan] [RFC v2 21/39] net: add HAS_IOPORT
 dependencies
In-Reply-To: <alpine.DEB.2.21.2205012324130.9383@angie.orcam.me.uk>
References: <20220429135108.2781579-1-schnelle@linux.ibm.com>
 <20220429135108.2781579-36-schnelle@linux.ibm.com>
 <alpine.DEB.2.21.2205012324130.9383@angie.orcam.me.uk>
Message-ID: <867e70df01fc938abf93ffa15a3f1989a8fb136b.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Sun, 2022-05-01 at 23:48 +0100, Maciej W. Rozycki wrote:
> On Fri, 29 Apr 2022, Niklas Schnelle wrote:
> 
> > In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
> > not being declared. We thus need to add HAS_IOPORT as dependency for
> > those drivers using them. It also turns out that with HAS_IOPORT handled
> > explicitly HAMRADIO does not need the !S390 dependency and successfully
> > builds the bpqether driver.
> [...]
> > diff --git a/drivers/net/fddi/Kconfig b/drivers/net/fddi/Kconfig
> > index 846bf41c2717..fa3f1e0fe143 100644
> > --- a/drivers/net/fddi/Kconfig
> > +++ b/drivers/net/fddi/Kconfig
> > @@ -29,7 +29,7 @@ config DEFZA
> >  
> >  config DEFXX
> >  	tristate "Digital DEFTA/DEFEA/DEFPA adapter support"
> > -	depends on FDDI && (PCI || EISA || TC)
> > +	depends on FDDI && (PCI || EISA || TC) && HAS_IOPORT
> >  	help
> >  	  This is support for the DIGITAL series of TURBOchannel (DEFTA),
> >  	  EISA (DEFEA) and PCI (DEFPA) controllers which can connect you
> 
>  NAK, this has to be sorted out differently (and I think we discussed it 
> before).
> 
>  The driver works just fine with MMIO where available, so if `inb'/`outb' 
> do get removed, then only parts that rely on port I/O need to be disabled.  
> In fact there's already such provision there in drivers/net/fddi/defxx.c 
> for TURBOchannel systems (CONFIG_TC), which have no port I/O space either:
> 
> #if defined(CONFIG_EISA) || defined(CONFIG_PCI)
> #define dfx_use_mmio bp->mmio
> #else
> #define dfx_use_mmio true
> #endif
> 
> so I guess it's just the conditional that will have to be changed to:
> 
> #ifdef CONFIG_HAS_IOPORT
> 
> replacing the current explicit bus dependency list.  The compiler will 
> then optimise away all the port I/O stuff (though I suspect dummy function 
> declarations may be required for `inb'/`outb', etc.).
> 
>  I can verify a suitable change with a TURBOchannel configuration once the 
> MIPS part has been sorted.
> 
>   Maciej

With dfx_use_mmio changed as you propose above things compile on s390
which previously ran into missing (now __compile_error()) inl() via
dfx_port_read_long() -> dfx_inl() ->  inl().

Looking at the other uses of dfx_use_mmio I notice however that in
dfx_get_bars(), inb() actually gets called when dfx_use_mmio is true.
This happens if dfx_bus_eisa is also true. Now that variable is just
the cached result of DFX_BUS_EISA(dev) which is defined to 0 if
CONFIG_EISA is unset. I'm not 100% sure if going through a local
variable is still considered trivial enough dead code elimination, at
least it works for me?. I did also check the GCC docs and they
explicitly say that __attribute__(error) is supposed to be used when
dead code elimination gets rid of the error paths.

I think we also need a "depends on HAS_IOPORT" for "config HAVE_EISA"
just as I'm adding for "config ISA".

