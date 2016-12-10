From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Sat, 10 Dec 2016 00:39:17 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: Fix reporting of 100Mb
 capability
In-Reply-To: <CAN1OqpxmGiiMEwm_E+GNQCCJOns8-DEG7cgoBWVs9XGoziXdrw@mail.gmail.com>
References: <CAN1OqpxmGiiMEwm_E+GNQCCJOns8-DEG7cgoBWVs9XGoziXdrw@mail.gmail.com>
Message-ID: <4C5EDC162D52824D9E7FB1446983F3EE9AFAA0A6@ORSMSX116.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Ryan Schaefer
> Sent: Thursday, December 08, 2016 8:32 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] ixgbe: Fix reporting of 100Mb capability
> 
> > BaseT adapters that are capable of supporting 100Mb are not reporting
> > this capability.  This patch corrects the reporting so that 100Mb is
> > shown as supported on those adapters.
> >
> > Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> > ---
> >  drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
> > b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
> > index fd192bf..8789f21 100644
> > --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
> > +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
> > @@ -199,7 +199,7 @@ static int ixgbe_get_settings(struct net_device
> *netdev,
> >   if (supported_link & IXGBE_LINK_SPEED_100_FULL)
> >   ecmd->supported |= ixgbe_isbackplane(hw->phy.media_type) ?
> >     SUPPORTED_1000baseKX_Full :
> > -   SUPPORTED_1000baseT_Full;
> > +   SUPPORTED_100baseT_Full;
> >
> >   /* default advertised speed if phy.autoneg_advertised isn't set */
> >   ecmd->advertising = ecmd->supported;
> > --
> > 2.4.0
> 
> 
> This patch should also remove the erroneously set
> SUPPORTED_1000baseKX_Full bit as well. [PATCH] ixgbe: Switch to
> ETHTOOL_xLINKSETTINGS API adds this fix.

Jeff,

Can you drop this patch?  Ryan's patch contains both fixes so I'll drop mine instead of doing a v2.

Thanks,
Tony
