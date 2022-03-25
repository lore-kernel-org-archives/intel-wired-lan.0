From: Ivan Vecera <ivecera@redhat.com>
Date: Fri, 25 Mar 2022 14:04:24 +0100
Subject: [Intel-wired-lan] [PATCH net] ice: Fix broken IFF_ALLMULTI
 handling
In-Reply-To: <eb6538d9-4667-f1f5-492c-e1e113a6da35@linux.intel.com>
References: <20220321191731.2596414-1-ivecera@redhat.com>
 <eb6538d9-4667-f1f5-492c-e1e113a6da35@linux.intel.com>
Message-ID: <20220325140424.696e8abc@ceranb>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 23 Mar 2022 21:05:20 +0100
Marcin Szycik <marcin.szycik@linux.intel.com> wrote:

> > @@ -3482,18 +3503,44 @@ ice_vlan_rx_kill_vid(struct net_device *netdev, __always_unused __be16 proto,
> >  	if (!vid)
> >  		return 0;
> >  
> > +	while (test_and_set_bit(ICE_CFG_BUSY, vsi->state))
> > +		usleep_range(1000, 2000);
> > +
> >  	/* Make sure ice_vsi_kill_vlan is successful before updating VLAN
> >  	 * information
> >  	 */
> >  	ret = ice_vsi_kill_vlan(vsi, vid);
> >  	if (ret)
> > -		return ret;
> > +		goto finish;
> >  
> > -	/* Disable pruning when VLAN 0 is the only VLAN rule */
> > -	if (vsi->num_vlan == 1 && ice_vsi_is_vlan_pruning_ena(vsi))
> > -		ret = ice_cfg_vlan_pruning(vsi, false);
> > +	/* Remove multicast promisc rule for the removed VLAN ID if
> > +	 * all-multicast is enabled.
> > +	 */
> > +	if (vsi->current_netdev_flags & IFF_ALLMULTI)
> > +		ice_fltr_clear_vsi_promisc(&vsi->back->hw, vsi->idx,
> > +					   ICE_MCAST_VLAN_PROMISC_BITS, vid);
> > +
> > +	if (vsi->num_vlan == 1) {
> > +		/* Disable pruning when VLAN 0 is the only VLAN rule */
> > +		if (ice_vsi_is_vlan_pruning_ena(vsi))
> > +			ice_cfg_vlan_pruning(vsi, false);  
> 
> Why was `ret = ...` removed here?

Because we are in ice_vlan_rx_kill_vid() that is used to remove VLAN and at this
the VLAN ID was removed from VLAN filter so we cannot return value other than 0.
Network stack would think that the VLAN ID is still present in VLAN filter.

Ivan

