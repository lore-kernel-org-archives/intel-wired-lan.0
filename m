From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Tue, 22 Jun 2021 21:39:44 +0000
Subject: [Intel-wired-lan] [PATCH next-queue v1 2/5] igc: Integrate flex
 filter into ethtool ops
In-Reply-To: <20210611003924.492853-3-vinicius.gomes@intel.com>
References: <20210611003924.492853-1-vinicius.gomes@intel.com>
 <20210611003924.492853-3-vinicius.gomes@intel.com>
Message-ID: <a9c671aa107bb1436b924dd91e802ff642591468.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 2021-06-10 at 17:39 -0700, Vinicius Costa Gomes wrote:
> From: Kurt Kanzenbach <kurt@linutronix.de>
> 
> Use the flex filter mechanism to extend the current ethtool filter
> operations by intercoperating the user data. This allows to match
> eight more bytes within a Ethernet frame in addition to macs, ether
> types and vlan.
> 
> The matching pattern looks like this:
> 
>  * dest_mac [6]
>  * src_mac [6]
>  * tpid [2]
>  * vlan tci [2]
>  * ether type [2]
>  * user data [8]
> 
> This can be used to match Profinet traffic classes by FrameID range.
> 
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---

I was preparing these patches for a pull request and came across a
couple warnings. Could you address them before I send these on?

<snip>

> @@ -1215,6 +1221,20 @@ static void igc_ethtool_init_nfc_rule(struct
> igc_nfc_rule *rule,
>  		ether_addr_copy(rule->filter.dst_addr,
>  				fsp->h_u.ether_spec.h_dest);
>  	}
> +
> +	/* Check for user defined data */
> +	if ((fsp->flow_type & FLOW_EXT) &&
> +	    (fsp->h_ext.data[0] || fsp->h_ext.data[1])) {
> +		rule->filter.match_flags |= IGC_FILTER_FLAG_USER_DATA;
> +		memcpy(rule->filter.user_data, fsp->h_ext.data,
> sizeof(fsp->h_ext.data));
> +		memcpy(rule->filter.user_mask, fsp->m_ext.data,
> sizeof(fsp->m_ext.data));
> +
> +		/* VLAN etype matching is only valid using flex filter
> */
> +		if ((fsp->flow_type & FLOW_EXT) && fsp-
> >h_ext.vlan_etype) {
> +			rule->filter.vlan_etype = fsp-
> >h_ext.vlan_etype;
> +			rule->filter.match_flags |=
> IGC_FILTER_FLAG_VLAN_ETYPE;

drivers/net/ethernet/intel/igc/igc_ethtool.c:1234:49: warning:
incorrect type in assignment (different base types)
drivers/net/ethernet/intel/igc/igc_ethtool.c:1234:49:    expected
unsigned short [usertype] vlan_etype
drivers/net/ethernet/intel/igc/igc_ethtool.c:1234:49:    got restricted
__be16 const [usertype] vlan_etype

<snip>

> +static int igc_add_flex_filter(struct igc_adapter *adapter,
> +			       struct igc_nfc_rule *rule)
> +{
> +	struct igc_flex_filter flex = { };
> +	struct igc_nfc_filter *filter = &rule->filter;
> +	unsigned int eth_offset, user_offset;
> +	int ret, index;
> +	bool vlan;
> +
> +	index = igc_find_avail_flex_filter_slot(adapter);
> +	if (index < 0)
> +		return -ENOSPC;
> +
> +	/* Construct the flex filter:
> +	 *  -> dest_mac [6]
> +	 *  -> src_mac [6]
> +	 *  -> tpid [2]
> +	 *  -> vlan tci [2]
> +	 *  -> ether type [2]
> +	 *  -> user data [8]
> +	 *  -> = 26 bytes => 32 length
> +	 */
> +	flex.index    = index;
> +	flex.length   = 32;
> +	flex.rx_queue = rule->action;
> +
> +	vlan = rule->filter.vlan_tci || rule->filter.vlan_etype;
> +	eth_offset = vlan ? 16 : 12;
> +	user_offset = vlan ? 18 : 14;
> +
> +	/* Add destination MAC  */
> +	if (rule->filter.match_flags & IGC_FILTER_FLAG_DST_MAC_ADDR)
> +		igc_flex_filter_add_field(&flex, &filter->dst_addr, 0,
> +					  ETH_ALEN, NULL);
> +
> +	/* Add source MAC */
> +	if (rule->filter.match_flags & IGC_FILTER_FLAG_SRC_MAC_ADDR)
> +		igc_flex_filter_add_field(&flex, &filter->src_addr, 6,
> +					  ETH_ALEN, NULL);
> +
> +	/* Add VLAN etype */
> +	if (rule->filter.match_flags & IGC_FILTER_FLAG_VLAN_ETYPE)
> +		igc_flex_filter_add_field(&flex, &filter->vlan_etype,
> 12,
> +					  sizeof(filter->vlan_etype),
> +					  NULL);
> +
> +	/* Add VLAN TCI */
> +	if (rule->filter.match_flags & IGC_FILTER_FLAG_VLAN_TCI)
> +		igc_flex_filter_add_field(&flex, &filter->vlan_tci, 14,
> +					  sizeof(filter->vlan_tci),
> NULL);
> +
> +	/* Add Ether type */
> +	if (rule->filter.match_flags & IGC_FILTER_FLAG_ETHER_TYPE) {
> +		u16 etype = cpu_to_be16(filter->etype);

drivers/net/ethernet/intel/igc/igc_main.c:3332:29: warning: incorrect
type in initializer (different base types)
drivers/net/ethernet/intel/igc/igc_main.c:3332:29:    expected unsigned
short [usertype] etype
drivers/net/ethernet/intel/igc/igc_main.c:3332:29:    got restricted
__be16 [usertype]


> +		igc_flex_filter_add_field(&flex, &etype, eth_offset,
> +					  sizeof(etype), NULL);
> +	}
>  
