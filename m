From: Williams, Mitch A <mitch.a.williams@intel.com>
Date: Fri, 17 Jun 2016 15:53:41 +0000
Subject: [Intel-wired-lan] [next PATCH S38 6/7] i40e: refactor rx filter
 handling
In-Reply-To: <57620EDD.2070407@onemain.com>
References: <1466034139-11828-1-git-send-email-bimmy.pujari@intel.com>
 <1466034139-11828-7-git-send-email-bimmy.pujari@intel.com>
 <57620EDD.2070407@onemain.com>
Message-ID: <AAEA33E297BCAC4B9BB20A7C2DF0AB8D79927A7F@FMSMSX113.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Shannon Nelson
> Sent: Wednesday, June 15, 2016 7:29 PM
> To: Pujari, Bimmy <bimmy.pujari@intel.com>; intel-wired-lan at lists.osuosl.org
> Subject: Re: [Intel-wired-lan] [next PATCH S38 6/7] i40e: refactor rx filter
> handling
> 
> 
> 
> On 06/15/2016 04:42 PM, Bimmy Pujari wrote:
> > From: Mitch Williams <mitch.a.williams@intel.com>
> >
> > Properly track filter adds and deletes so the driver doesn't lose filters
> > during resets and up/down cycles. Add a tracking mechanism so that the
> > driver knows when to enter and leave promiscuous mode.
> 
> Thanks, this was sorely needed.

Yes, it was needed, but you should NOT CARE.

> 
> >
> > Implement a simple state machine so the driver can track the status of
> each
> > filter throughout its lifecycle. Properly manage the overflow promiscuous
> > state for the each VSI, and provide a way for the driver to detect when to
> > exit overflow promiscuous mode.
> >
> > Remove all possible default MAC filters that the firmware may have set up
> > so that the driver can manage these correctly, particularly when VLANs
> come
> > into play.
> >
> > Finally, add the state of each filter to debugfs output so we can see
> what's
> > going on inside the driver's pointy little head
> >
> > Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> > Change-ID: I97c5e366fac2254fa01eaff4f65c0af61dcf2e1f
> > ---
> > Testing Hints : Add many filters. Remove many filters. Reset. Change
> 
> Some concept for "many" would be useful here.  How many will it take to
> trip the thing into promiscuous mode given 1 port or 4 ports or some
> number of VFs running?

We can update the commit message for this but our validation guys typically hit the limits without trying. In this case "many" means over 1500 for the entire device, which isn't hard to do.


> 
> > MAC address. Reset some more. Do VLANish stuff Check debugfs to make
> > sure filter count and state are as expected.
> >
> >   drivers/net/ethernet/intel/i40e/i40e.h         |  14 +-
> >   drivers/net/ethernet/intel/i40e/i40e_debugfs.c |  16 +-
> >   drivers/net/ethernet/intel/i40e/i40e_main.c    | 513 +++++++++++--------
> ------
> >   3 files changed, 257 insertions(+), 286 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/intel/i40e/i40e.h
> b/drivers/net/ethernet/intel/i40e/i40e.h
> > index e83fc8a..2a88291 100644
> > --- a/drivers/net/ethernet/intel/i40e/i40e.h
> > +++ b/drivers/net/ethernet/intel/i40e/i40e.h
> > @@ -448,6 +448,14 @@ struct i40e_pf {
> >   	u16 phy_led_val;
> >   };
> >
> > +enum i40e_filter_state {
> > +	I40E_FILTER_INVALID = 0,	/* Invalid state */
> > +	I40E_FILTER_NEW,		/* New, not sent to FW yet */
> > +	I40E_FILTER_ACTIVE,		/* Added to switch by FW */
> > +	I40E_FILTER_FAILED,		/* Rejected by FW */
> > +	I40E_FILTER_REMOVE,		/* To be removed */
> > +/* There is no 'removed' state; the filter struct is freed */
> > +};
> >   struct i40e_mac_filter {
> >   	struct list_head list;
> >   	u8 macaddr[ETH_ALEN];
> > @@ -456,8 +464,7 @@ struct i40e_mac_filter {
> >   	u8 counter;		/* number of instances of this filter */
> >   	bool is_vf;		/* filter belongs to a VF */
> >   	bool is_netdev;		/* filter belongs to a netdev */
> > -	bool changed;		/* filter needs to be sync'd to the HW */
> > -	bool is_laa;		/* filter is a Locally Administered Address */
> 
> So you're dumping LAA support?  Or is this extra work no longer needed?
> I would have expected some discussion of this in the commit notes.

I'll update the commit message. It's currently looking like we don't need this code.


> 
> > +	enum i40e_filter_state state;
> >   };
> >
> >   struct i40e_veb {
> > @@ -523,6 +530,9 @@ struct i40e_vsi {
> >   	struct i40e_ring **rx_rings;
> >   	struct i40e_ring **tx_rings;
> >
> > +	u32  active_filters;
> > +	u32  promisc_threshold;
> > +
> >   	u16 work_limit;
> >   	u16 int_rate_limit;  /* value in usecs */
> >
> > diff --git a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
> b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
> > index e6af8c8..05cf9a7 100644
> > --- a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
> > +++ b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
> > @@ -116,6 +116,14 @@ static ssize_t i40e_dbg_command_read(struct file
> *filp, char __user *buffer,
> >   	return len;
> >   }
> >
> > +static char *i40e_filter_state_string[] = {
> > +	"INVALID",
> > +	"NEW",
> > +	"ACTIVE",
> > +	"FAILED",
> > +	"REMOVE",
> > +};
> > +
> >   /**
> >    * i40e_dbg_dump_vsi_seid - handles dump vsi seid write into command
> datum
> >    * @pf: the i40e_pf created in command write
> > @@ -160,10 +168,14 @@ static void i40e_dbg_dump_vsi_seid(struct i40e_pf
> *pf, int seid)
> >   			 pf->hw.mac.port_addr);
> >   	list_for_each_entry(f, &vsi->mac_filter_list, list) {
> >   		dev_info(&pf->pdev->dev,
> > -			 "    mac_filter_list: %pM vid=%d, is_netdev=%d is_vf=%d
> counter=%d\n",
> > +			 "    mac_filter_list: %pM vid=%d, is_netdev=%d is_vf=%d
> counter=%d, state %s\n",
> >   			 f->macaddr, f->vlan, f->is_netdev, f->is_vf,
> > -			 f->counter);
> > +			 f->counter, i40e_filter_state_string[f->state]);
> >   	}
> > +	dev_info(&pf->pdev->dev, "    active_filters %d, promisc_threshold %d,
> overflow promisc %s\n",
> > +		 vsi->active_filters, vsi->promisc_threshold,
> > +		 (test_bit(__I40E_FILTER_OVERFLOW_PROMISC, &vsi->state) ?
> > +		  "ON" : "OFF"));
> >   	nstat = i40e_get_vsi_stats_struct(vsi);
> >   	dev_info(&pf->pdev->dev,
> >   		 "    net_stats: rx_packets = %lu, rx_bytes = %lu, rx_errors =
> %lu, rx_dropped = %lu\n",
> > diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c
> b/drivers/net/ethernet/intel/i40e/i40e_main.c
> > index 0898c9d..fe4aa9c 100644
> > --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> > +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> > @@ -1279,8 +1279,9 @@ int i40e_del_mac_all_vlan(struct i40e_vsi *vsi, u8
> *macaddr,
> >   		    (is_vf == f->is_vf) &&
> >   		    (is_netdev == f->is_netdev)) {
> >   			f->counter--;
> > -			f->changed = true;
> >   			changed = 1;
> > +			if (f->counter == 0)
> > +				f->state = I40E_FILTER_REMOVE;
> >   		}
> >   	}
> >   	if (changed) {
> > @@ -1296,29 +1297,32 @@ int i40e_del_mac_all_vlan(struct i40e_vsi *vsi, u8
> *macaddr,
> >    * @vsi: the PF Main VSI - inappropriate for any other VSI
> >    * @macaddr: the MAC address
> >    *
> > - * Some older firmware configurations set up a default promiscuous VLAN
> > - * filter that needs to be removed.
> > + * Remove whatever filter the firmware set up so the driver can manage
> > + * its own filtering intelligently.
> >    **/
> > -static int i40e_rm_default_mac_filter(struct i40e_vsi *vsi, u8 *macaddr)
> > +static void i40e_rm_default_mac_filter(struct i40e_vsi *vsi, u8 *macaddr)
> >   {
> >   	struct i40e_aqc_remove_macvlan_element_data element;
> >   	struct i40e_pf *pf = vsi->back;
> > -	i40e_status ret;
> >
> >   	/* Only appropriate for the PF main VSI */
> >   	if (vsi->type != I40E_VSI_MAIN)
> > -		return -EINVAL;
> > +		return;
> >
> >   	memset(&element, 0, sizeof(element));
> >   	ether_addr_copy(element.mac_addr, macaddr);
> >   	element.vlan_tag = 0;
> > -	element.flags = I40E_AQC_MACVLAN_DEL_PERFECT_MATCH |
> > -			I40E_AQC_MACVLAN_DEL_IGNORE_VLAN;
> > -	ret = i40e_aq_remove_macvlan(&pf->hw, vsi->seid, &element, 1, NULL);
> > -	if (ret)
> > -		return -ENOENT;
> > +	/* Ignore error returns, some firmware does it this way... */
> > +	element.flags = I40E_AQC_MACVLAN_DEL_PERFECT_MATCH;
> > +	i40e_aq_remove_macvlan(&pf->hw, vsi->seid, &element, 1, NULL);
> >
> > -	return 0;
> > +	memset(&element, 0, sizeof(element));
> > +	ether_addr_copy(element.mac_addr, macaddr);
> > +	element.vlan_tag = 0;
> > +	/* ...and some firmware does it this way. */
> > +	element.flags = I40E_AQC_MACVLAN_DEL_PERFECT_MATCH |
> > +			I40E_AQC_MACVLAN_ADD_IGNORE_VLAN;
> > +	i40e_aq_remove_macvlan(&pf->hw, vsi->seid, &element, 1, NULL);
> >   }
> >
> >   /**
> > @@ -1339,6 +1343,7 @@ struct i40e_mac_filter *i40e_add_filter(struct
> i40e_vsi *vsi,
> >   					bool is_vf, bool is_netdev)
> >   {
> >   	struct i40e_mac_filter *f;
> > +	int changed = false;
> >
> >   	if (!vsi || !macaddr)
> >   		return NULL;
> > @@ -1358,8 +1363,15 @@ struct i40e_mac_filter *i40e_add_filter(struct
> i40e_vsi *vsi,
> >
> >   		ether_addr_copy(f->macaddr, macaddr);
> >   		f->vlan = vlan;
> > -		f->changed = true;
> > -
> > +		/* If we're in overflow promisc mode, set the state directly
> > +		 * to failed, so we don't bother to try sending the filter
> > +		 * to the hardware.
> > +		 */
> > +		if (test_bit(__I40E_FILTER_OVERFLOW_PROMISC, &vsi->state))
> > +			f->state = I40E_FILTER_FAILED;
> > +		else
> > +			f->state = I40E_FILTER_NEW;
> > +		changed = true;
> >   		INIT_LIST_HEAD(&f->list);
> >   		list_add_tail(&f->list, &vsi->mac_filter_list);
> >   	}
> > @@ -1379,10 +1391,7 @@ struct i40e_mac_filter *i40e_add_filter(struct
> i40e_vsi *vsi,
> >   		f->counter++;
> >   	}
> >
> > -	/* changed tells sync_filters_subtask to
> > -	 * push the filter down to the firmware
> > -	 */
> > -	if (f->changed) {
> > +	if (changed) {
> >   		vsi->flags |= I40E_VSI_FLAG_FILTER_CHANGED;
> >   		vsi->back->flags |= I40E_FLAG_FILTER_SYNC;
> >   	}
> > @@ -1401,6 +1410,9 @@ add_filter_out:
> >    *
> >    * NOTE: This function is expected to be called with
> mac_filter_list_lock
> >    * being held.
> > + * ANOTHER NOTE: This function MUST be called from within the context of
> > + * the "safe" variants of any list iterators, e.g.
> list_for_each_entry_safe()
> > + * instead of list_for_each_entry().
> >    **/
> >   void i40e_del_filter(struct i40e_vsi *vsi,
> >   		     u8 *macaddr, s16 vlan,
> > @@ -1440,9 +1452,18 @@ void i40e_del_filter(struct i40e_vsi *vsi,
> >   	 * remove the filter from the firmware's list
> >   	 */
> >   	if (f->counter == 0) {
> > -		f->changed = true;
> > -		vsi->flags |= I40E_VSI_FLAG_FILTER_CHANGED;
> > -		vsi->back->flags |= I40E_FLAG_FILTER_SYNC;
> > +		if ((f->state == I40E_FILTER_FAILED) ||
> > +		    (f->state == I40E_FILTER_NEW)) {
> > +			/* this one never got added by the FW. Just remove it,
> > +			 * no need to sync anything.
> > +			 */
> > +			list_del(&f->list);
> > +			kfree(f);
> > +		} else {
> > +			f->state = I40E_FILTER_REMOVE;
> > +			vsi->flags |= I40E_VSI_FLAG_FILTER_CHANGED;
> > +			vsi->back->flags |= I40E_FLAG_FILTER_SYNC;
> > +		}
> >   	}
> >   }
> >
> > @@ -1464,7 +1485,6 @@ static int i40e_set_mac(struct net_device *netdev,
> void *p)
> >   	struct i40e_pf *pf = vsi->back;
> >   	struct i40e_hw *hw = &pf->hw;
> >   	struct sockaddr *addr = p;
> > -	struct i40e_mac_filter *f;
> >
> >   	if (!is_valid_ether_addr(addr->sa_data))
> >   		return -EADDRNOTAVAIL;
> > @@ -1485,50 +1505,10 @@ static int i40e_set_mac(struct net_device *netdev,
> void *p)
> >   	else
> >   		netdev_info(netdev, "set new mac address %pM\n", addr->sa_data);
> >
> > -	if (vsi->type == I40E_VSI_MAIN) {
> > -		i40e_status ret;
> > -
> > -		ret = i40e_aq_mac_address_write(&vsi->back->hw,
> > -						I40E_AQC_WRITE_TYPE_LAA_WOL,
> > -						addr->sa_data, NULL);
> > -		if (ret) {
> > -			netdev_info(netdev,
> > -				    "Addr change for Main VSI failed: %d\n",
> > -				    ret);
> > -			return -EADDRNOTAVAIL;
> > -		}
> > -	}
> > -
> > -	if (ether_addr_equal(netdev->dev_addr, hw->mac.addr)) {
> > -		struct i40e_aqc_remove_macvlan_element_data element;
> > -
> > -		memset(&element, 0, sizeof(element));
> > -		ether_addr_copy(element.mac_addr, netdev->dev_addr);
> > -		element.flags = I40E_AQC_MACVLAN_DEL_PERFECT_MATCH;
> > -		i40e_aq_remove_macvlan(&pf->hw, vsi->seid, &element, 1, NULL);
> > -	} else {
> > -		spin_lock_bh(&vsi->mac_filter_list_lock);
> > -		i40e_del_filter(vsi, netdev->dev_addr, I40E_VLAN_ANY,
> > -				false, false);
> > -		spin_unlock_bh(&vsi->mac_filter_list_lock);
> > -	}
> > -
> > -	if (ether_addr_equal(addr->sa_data, hw->mac.addr)) {
> > -		struct i40e_aqc_add_macvlan_element_data element;
> > -
> > -		memset(&element, 0, sizeof(element));
> > -		ether_addr_copy(element.mac_addr, hw->mac.addr);
> > -		element.flags = cpu_to_le16(I40E_AQC_MACVLAN_ADD_PERFECT_MATCH);
> > -		i40e_aq_add_macvlan(&pf->hw, vsi->seid, &element, 1, NULL);
> > -	} else {
> > -		spin_lock_bh(&vsi->mac_filter_list_lock);
> > -		f = i40e_add_filter(vsi, addr->sa_data, I40E_VLAN_ANY,
> > -				    false, false);
> > -		if (f)
> > -			f->is_laa = true;
> > -		spin_unlock_bh(&vsi->mac_filter_list_lock);
> > -	}
> > -
> > +	spin_lock_bh(&vsi->mac_filter_list_lock);
> > +	i40e_del_mac_all_vlan(vsi, netdev->dev_addr, false, true);
> > +	i40e_put_mac_in_vlan(vsi, addr->sa_data, false, true);
> > +	spin_unlock_bh(&vsi->mac_filter_list_lock);
> >   	ether_addr_copy(netdev->dev_addr, addr->sa_data);
> >
> >   	/* schedule our worker thread which will take care of
> > @@ -1761,28 +1741,6 @@ bottom_of_search_loop:
> >   }
> >
> >   /**
> > - * i40e_mac_filter_entry_clone - Clones a MAC filter entry
> > - * @src: source MAC filter entry to be clones
> > - *
> > - * Returns the pointer to newly cloned MAC filter entry or NULL
> > - * in case of error
> > - **/
> > -static struct i40e_mac_filter *i40e_mac_filter_entry_clone(
> > -					struct i40e_mac_filter *src)
> > -{
> > -	struct i40e_mac_filter *f;
> > -
> > -	f = kzalloc(sizeof(*f), GFP_ATOMIC);
> > -	if (!f)
> > -		return NULL;
> > -	*f = *src;
> > -
> > -	INIT_LIST_HEAD(&f->list);
> > -
> > -	return f;
> > -}
> > -
> > -/**
> >    * i40e_undo_del_filter_entries - Undo the changes made to MAC filter
> entries
> >    * @vsi: pointer to vsi struct
> >    * @from: Pointer to list which contains MAC filter entries - changes to
> > @@ -1796,41 +1754,61 @@ static void i40e_undo_del_filter_entries(struct
> i40e_vsi *vsi,
> >   	struct i40e_mac_filter *f, *ftmp;
> >
> >   	list_for_each_entry_safe(f, ftmp, from, list) {
> > -		f->changed = true;
> >   		/* Move the element back into MAC filter list*/
> >   		list_move_tail(&f->list, &vsi->mac_filter_list);
> >   	}
> >   }
> >
> >   /**
> > - * i40e_undo_add_filter_entries - Undo the changes made to MAC filter
> entries
> > - * @vsi: pointer to vsi struct
> > + * i40e_update_filter_state - Update filter state based on return data
> > + * from firmware
> 
> The description should be a single line.

Well, it is a single line, it just has an embedded newline. Simple!

Thanks for your review. I really didn't expect it.

-M


> 
> sln
> 
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at lists.osuosl.org
> http://lists.osuosl.org/mailman/listinfo/intel-wired-lan
