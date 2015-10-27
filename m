From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Tue, 27 Oct 2015 19:28:27 +0000
Subject: [Intel-wired-lan] [next-queue v2] fm10k: conditionally compile
 DCB and DebugFS support
In-Reply-To: <804857E1F29AAC47BF68C404FC60A1847EC6BCFF@ORSMSX105.amr.corp.intel.com>
References: <1445897893-19723-1-git-send-email-jacob.e.keller@intel.com>
 <804857E1F29AAC47BF68C404FC60A1847EC6BCFF@ORSMSX105.amr.corp.intel.com>
Message-ID: <02874ECE860811409154E81DA85FBB58577C2355@ORSMSX115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Allan, Bruce W
> Sent: Tuesday, October 27, 2015 11:57 AM
> To: Keller, Jacob E; Intel Wired LAN
> Subject: RE: [next-queue v2] fm10k: conditionally compile DCB and DebugFS
> support
> 
> > -----Original Message-----
> > From: Keller, Jacob E
> > Sent: Monday, October 26, 2015 3:18 PM
> > To: Intel Wired LAN
> > Cc: Keller, Jacob E; Allan, Bruce W
> > Subject: [next-queue v2] fm10k: conditionally compile DCB and DebugFS
> > support
> >
> > Rather than wrapping fm10k_dcbnl.c and fm10k_debugfs.c support with
> >  #ifdef blocks, just conditionally include the .o files in the Makefile.
> > Also, since we're modifying it, update the copyright year on the
> > Makefile.
> >
> > Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> > Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
> > ---
> > This replaces in-place the previous version of the patch currently in
> > the queue, fixing a compilation error
> >
> > -v2
> > * Fix issue when DCB is disabled, since the function didn't take the
> >   same parameters.
> >
> >  drivers/net/ethernet/intel/fm10k/Makefile        | 20 +++++++++++++++----
> > -
> >  drivers/net/ethernet/intel/fm10k/fm10k.h         |  4 ++++
> >  drivers/net/ethernet/intel/fm10k/fm10k_dcbnl.c   |  4 ----
> >  drivers/net/ethernet/intel/fm10k/fm10k_debugfs.c |  4 ----
> >  4 files changed, 19 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/intel/fm10k/Makefile
> > b/drivers/net/ethernet/intel/fm10k/Makefile
> > index 08859dd220a8..b006ff66d028 100644
> > --- a/drivers/net/ethernet/intel/fm10k/Makefile
> > +++ b/drivers/net/ethernet/intel/fm10k/Makefile
> > @@ -1,7 +1,7 @@
> >
> > ##########################################################
> > ######################
> >  #
> >  # Intel Ethernet Switch Host Interface Driver
> > -# Copyright(c) 2013 - 2014 Intel Corporation.
> > +# Copyright(c) 2013 - 2015 Intel Corporation.
> >  #
> >  # This program is free software; you can redistribute it and/or modify it
> >  # under the terms and conditions of the GNU General Public License,
> > @@ -27,7 +27,17 @@
> >
> >  obj-$(CONFIG_FM10K) += fm10k.o
> >
> > -fm10k-objs := fm10k_main.o fm10k_common.o fm10k_pci.o \
> > -	      fm10k_netdev.o fm10k_ethtool.o fm10k_pf.o fm10k_vf.o \
> > -	      fm10k_mbx.o fm10k_iov.o fm10k_tlv.o \
> > -	      fm10k_debugfs.o fm10k_ptp.o fm10k_dcbnl.o
> > +fm10k-y := fm10k_main.o \
> > +	   fm10k_common.o \
> > +	   fm10k_pci.o \
> > +	   fm10k_ptp.o \
> > +	   fm10k_netdev.o \
> > +	   fm10k_ethtool.o \
> > +	   fm10k_pf.o \
> > +	   fm10k_vf.o \
> > +	   fm10k_mbx.o \
> > +	   fm10k_iov.o \
> > +	   fm10k_tlv.o
> > +
> > +fm10k-$(CONFIG_DEBUG_FS) += fm10k_debugfs.o
> > +fm10k-$(CONFIG_DCB) += fm10k_dcbnl.o
> > diff --git a/drivers/net/ethernet/intel/fm10k/fm10k.h
> > b/drivers/net/ethernet/intel/fm10k/fm10k.h
> > index 48809e5d3f79..2e1e3e9c59c9 100644
> > --- a/drivers/net/ethernet/intel/fm10k/fm10k.h
> > +++ b/drivers/net/ethernet/intel/fm10k/fm10k.h
> > @@ -551,5 +551,9 @@ int fm10k_get_ts_config(struct net_device
> *netdev,
> > struct ifreq *ifr);
> >  int fm10k_set_ts_config(struct net_device *netdev, struct ifreq *ifr);
> >
> >  /* DCB */
> > +#ifdef CONFIG_DCB
> >  void fm10k_dcbnl_set_ops(struct net_device *dev);
> > +#else
> > +static inline void fm10k_dcbnl_set_ops(struct net_device
> > __always_unused *dev) {}
> 
> "__always_unused" is unnecessary.
> 

Not sure I agree..? This version of the function would otherwise complain under W=1 with warn about unused parameters, and I believe in keeping W=1 pretty clean of these sort of things to make it more useful.

Regards,
Jake

