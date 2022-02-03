From: Alexander Lobakin <alexandr.lobakin@intel.com>
Date: Thu,  3 Feb 2022 16:55:24 +0100
Subject: [Intel-wired-lan] [PATCH net-next 08/19] iecm: add interrupts
 and configure netdev
In-Reply-To: <CO1PR11MB5186871FE0AD93739C834B3D8F279@CO1PR11MB5186.namprd11.prod.outlook.com>
References: <20220128001009.721392-1-alan.brady@intel.com>
 <20220128001009.721392-9-alan.brady@intel.com>
 <20220128133447.22242-1-alexandr.lobakin@intel.com>
 <CO1PR11MB5186871FE0AD93739C834B3D8F279@CO1PR11MB5186.namprd11.prod.outlook.com>
Message-ID: <20220203155524.12315-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alan Brady <alan.brady@intel.com>
Date: Thu, 3 Feb 2022 00:17:37 +0100

> > -----Original Message-----
> > From: Lobakin, Alexandr <alexandr.lobakin@intel.com>
> > Sent: Friday, January 28, 2022 5:35 AM
> > To: Brady, Alan <alan.brady@intel.com>
> > Cc: Lobakin, Alexandr <alexandr.lobakin@intel.com>; intel-wired-
> > lan at lists.osuosl.org; Linga, Pavan Kumar <pavan.kumar.linga@intel.com>;
> > Chittim, Madhu <madhu.chittim@intel.com>; Burra, Phani R
> > <phani.r.burra@intel.com>
> > Subject: Re: [Intel-wired-lan] [PATCH net-next 08/19] iecm: add interrupts and
> > configure netdev
> > 
> > From: Alan Brady <alan.brady@intel.com>
> > Date: Thu, 27 Jan 2022 16:09:58 -0800
> > 
> > > This finishes implementing init_task by adding everything we need to
> > > configure the netdevice for the vport and setup its interrupts.
> > >
> > > Signed-off-by: Phani Burra <phani.r.burra@intel.com>
> > > Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
> > > Signed-off-by: Madhu Chittim <madhu.chittim@intel.com>
> > > Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> > > Signed-off-by: Alice Michael <alice.michael@intel.com>
> > > Signed-off-by: Alan Brady <alan.brady@intel.com>
> > > ---
> > >  drivers/net/ethernet/intel/iecm/iecm_lib.c    | 813 +++++++++++++++++-
> > >  drivers/net/ethernet/intel/iecm/iecm_txrx.c   |  17 +
> > >  .../net/ethernet/intel/iecm/iecm_virtchnl.c   | 165 ++++
> > >  drivers/net/ethernet/intel/include/iecm.h     | 112 ++-
> > >  .../net/ethernet/intel/include/iecm_txrx.h    |   2 +
> > >  5 files changed, 1104 insertions(+), 5 deletions(-)
> > >

--- 8< ---

> > > +/**
> > > + * iecm_find_mac_filter - Search filter list for specific mac filter
> > > + * @vport: main vport structure
> > > + * @macaddr: the MAC address
> > > + *
> > > + * Returns ptr to the filter object or NULL. Must be called while
> > > +holding the
> > > + * mac_filter_list_lock.
> > > + **/
> > > +static struct
> > > +iecm_mac_filter *iecm_find_mac_filter(struct iecm_vport *vport,
> > > +				      const u8 *macaddr)
> > > +{
> > > +	struct iecm_adapter *adapter = vport->adapter;
> > > +	struct iecm_mac_filter *f;
> > > +
> > > +	if (!macaddr)
> > > +		return NULL;
> > > +
> > > +	list_for_each_entry(f, &adapter->config_data.mac_filter_list, list) {
> > > +		if (ether_addr_equal(macaddr, f->macaddr))
> > > +			return f;
> > > +	}
> > 
> > Excessive braces again.
> > 
> 
> Will not fix.

I'd like to remind here that it's a technical discussion in a public
list, and every participant should keep it sane, with sane arguments
and reasoning.

My arguments are:
 * it adds chars and locs for no reason;
 * it adds code complexity -> lowers readability a tiny bit;
 * checkpatch and/or cocchinelle may complain on this.

I'd double-check the last bullet at first. If it's the case, there's
no other choice except for deleting them. Otherwise I'd like to hear
reasoning for keeping those braces and some other folks' opinions as
well.

> 
> > > +	return NULL;
> > > +}
> > > +
> > > +/**
> > > + * __iecm_add_mac_filter - Add mac filter helper function

--- 8< ---

> > > +		dflt_features |= NETIF_F_TSO6;
> > > +	if (iecm_is_cap_ena_all(adapter, IECM_SEG_CAPS,
> > > +				VIRTCHNL2_CAP_SEG_IPV4_UDP |
> > > +				VIRTCHNL2_CAP_SEG_IPV6_UDP))
> > > +		dflt_features |= NETIF_F_GSO_UDP_L4;
> > > +	if (iecm_is_cap_ena_all(adapter, IECM_RSC_CAPS, IECM_CAP_RSC))
> > > +		offloads |= NETIF_F_GRO_HW;
> > 
> > I see `offloads` being used only here, |= -> =.
> > 
> 
> It makes it easier to add others in future or if some happen to get stripped in/out in the future it makes the code more resilient.  We prefer to keep it this way.

Ah, again.
It's not that usual in the kernel to make some thing more
complicated due to some kind of a hypothetical case in the future.
That case may never happen, while code burden will still be there.

Also, a problem might occur *only* if someone places `offloads`
modification before this sentence. If it gets deleted, if `offloads`
gets modified later, assignment is still correct here.
And it's a developer's duty then to check for this.

The last thing. Assignment is a pure single store. OR is load +
store, 2 operations. Compilers *probably* optimize this on -O2,
but that's up to them.
The function itself is cold, yet still this is avoidable.

> 
> > > +	netdev->features |= dflt_features;
> > > +	netdev->hw_features |= dflt_features | offloads;
> > > +	netdev->hw_enc_features |= dflt_features | offloads;

--- 8< ---

> > > +	.ndo_set_mac_address = NULL,
> > > +	.ndo_change_mtu = NULL,
> > > +	.ndo_get_stats64 = NULL,
> > > +	.ndo_fix_features = NULL,
> > > +	.ndo_set_features = NULL,
> > > +	.ndo_vlan_rx_add_vid = NULL,
> > > +	.ndo_vlan_rx_kill_vid = NULL,
> > > +	.ndo_setup_tc = NULL,
> > 
> > Non-initialized members get zeroed by default, NULLing them is excessive.
> > 
> 
> The next patches will add these, they're placeholders. I left it like that because as you read the patches you can know what functions are there yet (as well as a checklist for myself as made the patches).

As I wrote in one of my prevous replies, each patch is
a self-contained/self-complete entity.
With those NULLs being present newly implemented callbacks
will result in

 .ndo_old_function_1 = iecm_old_function_1,
-.ndo_new_function_2 = NULL,
-.ndo_new_function_3 = NULL,
+.ndo_new_function_2 = iecm_new_function_2,
+.ndo_new_function_3 = iecm_new_function_3,
 .ndo_old_function_4 = iecm_old_function_4,

instead of

 .ndo_old_function_1 = iecm_old_function_1,
+.ndo_new_function_2 = iecm_new_function_2,
+.ndo_new_function_3 = iecm_new_function_3,
 .ndo_old_function_4 = iecm_old_function_4,

This makes a lot of sense, at least to me.

> 
> > > +};
> > > +
> > > +static const struct net_device_ops iecm_netdev_ops_singleq = {
> > > +	.ndo_open = NULL,
> > > +	.ndo_stop = NULL,
> > > +	.ndo_start_xmit = NULL,
> > > +	.ndo_set_rx_mode = NULL,
> > > +	.ndo_validate_addr = eth_validate_addr,
> > > +	.ndo_set_mac_address = NULL,
> > > +	.ndo_change_mtu = NULL,
> > > +	.ndo_get_stats64 = NULL,
> > > +	.ndo_fix_features = NULL,
> > > +	.ndo_set_features = NULL,
> > > +	.ndo_vlan_rx_add_vid = NULL,
> > > +	.ndo_vlan_rx_kill_vid = NULL,
> > > +	.ndo_setup_tc           = NULL,
> > 
> > Same 2 previous points.
> > 
> > .ndo_setup_tc assignment indentation is weird. Either align all the initializers
> > with tabs or don't align at all (both are valid cases).
> > 
> > > +};

--- 8< ---

> > > --
> > > 2.33.0
> > 
> > Thanks,
> > Al

Thanks,
Al
