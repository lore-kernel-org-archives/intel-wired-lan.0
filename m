From: Williams, Mitch A <mitch.a.williams@intel.com>
Date: Fri, 1 Apr 2016 17:32:20 +0000
Subject: [Intel-wired-lan] [next PATCH] i40evf: properly handle VLAN
 features
In-Reply-To: <CAKgT0UecOja5TgA365Zo_rayZ7-oh7rNvZ2trbTyW87Oh7gMZA@mail.gmail.com>
References: <1459445708-20029-1-git-send-email-mitch.a.williams@intel.com>
 <CAKgT0UecOja5TgA365Zo_rayZ7-oh7rNvZ2trbTyW87Oh7gMZA@mail.gmail.com>
Message-ID: <AAEA33E297BCAC4B9BB20A7C2DF0AB8D7856CBC9@FMSMSX113.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Alexander Duyck [mailto:alexander.duyck at gmail.com]
> Sent: Thursday, March 31, 2016 1:50 PM
> To: Williams, Mitch A <mitch.a.williams@intel.com>
> Cc: intel-wired-lan <intel-wired-lan@lists.osuosl.org>
> Subject: Re: [Intel-wired-lan] [next PATCH] i40evf: properly handle VLAN
> features
> 
> On Thu, Mar 31, 2016 at 10:35 AM, Mitch Williams
> <mitch.a.williams@intel.com> wrote:
> > Correctly set the VLAN feature flags after setting the rest of the
> > netdev flags. And don't set them in hw_features, because these can't be
> > controlled by the VF driver.
> >
> > Testing Hints: Make sure VLAN offloads work correctly when not using
> > port VLANs, and make sure they're not availble when using port VLANs.
> >
> > Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> > ---
> >  drivers/net/ethernet/intel/i40evf/i40evf_main.c | 21 +++++++++++---------
> -
> >  1 file changed, 11 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
> b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
> > index 4b70aae..039bbd2 100644
> > --- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
> > +++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
> > @@ -2259,6 +2259,10 @@ static int i40evf_change_mtu(struct net_device
> *netdev, int new_mtu)
> >         return 0;
> >  }
> >
> > +#define I40EVF_VLAN_FEATURES (NETIF_F_HW_VLAN_CTAG_TX |\
> > +                              NETIF_F_HW_VLAN_CTAG_RX |\
> > +                              NETIF_F_HW_VLAN_CTAG_FILTER)
> > +
> >  static const struct net_device_ops i40evf_netdev_ops = {
> >         .ndo_open               = i40evf_open,
> >         .ndo_stop               = i40evf_close,
> > @@ -2320,16 +2324,6 @@ int i40evf_process_config(struct i40evf_adapter
> *adapter)
> >                 return -ENODEV;
> >         }
> >
> > -       if (adapter->vf_res->vf_offload_flags
> > -           & I40E_VIRTCHNL_VF_OFFLOAD_VLAN) {
> > -               netdev->vlan_features = netdev->features &
> > -                                       ~(NETIF_F_HW_VLAN_CTAG_TX |
> > -                                         NETIF_F_HW_VLAN_CTAG_RX |
> > -                                         NETIF_F_HW_VLAN_CTAG_FILTER);
> > -               netdev->features |= NETIF_F_HW_VLAN_CTAG_TX |
> > -                                   NETIF_F_HW_VLAN_CTAG_RX |
> > -                                   NETIF_F_HW_VLAN_CTAG_FILTER;
> > -       }
> >         netdev->features |= NETIF_F_HIGHDMA |
> >                             NETIF_F_SG |
> >                             NETIF_F_IP_CSUM |
> > @@ -2358,6 +2352,13 @@ int i40evf_process_config(struct i40evf_adapter
> *adapter)
> >         /* copy netdev features into list of user selectable features */
> >         netdev->hw_features |= netdev->features;
> 
> This line here is actually a bit problematic.  I found while working
> on NETIF_F_GSO_PARTIAL that we end up calling i40evf_process_config
> multiple times.  What ends up happening is that features end up
> bleeding through into hw_features.  Same thing if you try going the
> other way.  Your best bend ends up actually being to populate
> hw_enc_features and then feed that into features and hw_features.
> 
> >         netdev->hw_features &= ~NETIF_F_RXCSUM;
> 
> I never noticed before but why are you clearing the NETIF_F_RXCSUM
> flag?  That is a feature you control via software isn't it?  You could
> just ignore the results from the hardware.  Why lock this feature for
> a VF?
> 
> > +       netdev->hw_features &= ~(I40EVF_VLAN_FEATURES);
> 
> There is no need to mask hw_features if you never set it.  I assume
> this is needed to deal with the bleeding through issue I referenced
> above where you are writing hw_features from features.
> 
> > +       netdev->features &= ~(I40EVF_VLAN_FEATURES);
> > +
> > +       if (vfres->vf_offload_flags & I40E_VIRTCHNL_VF_OFFLOAD_VLAN) {
> > +               netdev->vlan_features = netdev->features;
> > +               netdev->features |= I40EVF_VLAN_FEATURES;
> > +       }
> >
> >         adapter->vsi.id = adapter->vsi_res->vsi_id;
> 
> You can probably just set vlan_features always.  As far as I know the
> i40e/i40evf hardware doesn't penalize you if you have some extra data
> like a VLAN tag in the L2 header so TSO and checksums should all still
> work.
> 
> - Alex

This looks like it's causing build problems, so let's drop it and I'll respin. Again.
