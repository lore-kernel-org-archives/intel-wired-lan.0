From: Neftin, Sasha <sasha.neftin@intel.com>
Date: Wed, 1 Apr 2020 08:44:57 +0300
Subject: [Intel-wired-lan] [PATCH 08/12] igc: Remove
 IGC_MAC_STATE_QUEUE_STEERING
In-Reply-To: <20200318230102.36952-9-andre.guedes@intel.com>
References: <20200318230102.36952-1-andre.guedes@intel.com>
 <20200318230102.36952-9-andre.guedes@intel.com>
Message-ID: <42aff8f7-4ee8-e753-10b3-8783105b0abe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 3/19/2020 01:00, Andre Guedes wrote:
> The IGC_MAC_STATE_QUEUE_STEERING bit in mac_table[i].state is
> utilized to indicate that frames matching the filter are assigned to
> mac_table[i].queue. This bit is not strictly necessary since we can
> convey the same information as follows: queue == -1 means queue
> assignment is disabled, otherwise it is enabled.
> 
> In addition to make the code simpler, this change fixes some awkward
> situations where we pass a complete misleading 'queue' value such as in
> igc_uc_sync().
> 
> So this patch removes IGC_MAC_STATE_QUEUE_STEERING and also takes the
> opportunity to improve the igc_add_mac_filter documentation.
> 
> Signed-off-by: Andre Guedes <andre.guedes@intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc.h      |  3 +-
>   drivers/net/ethernet/intel/igc/igc_main.c | 34 +++++++++++++----------
>   2 files changed, 21 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
> index e743f92a27c6..192cef07bdf7 100644
> --- a/drivers/net/ethernet/intel/igc/igc.h
> +++ b/drivers/net/ethernet/intel/igc/igc.h
> @@ -470,14 +470,13 @@ struct igc_nfc_filter {
>   
>   struct igc_mac_addr {
>   	u8 addr[ETH_ALEN];
> -	u8 queue;
> +	s8 queue;
>   	u8 state; /* bitmask */
>   };
>   
>   #define IGC_MAC_STATE_DEFAULT		0x1
>   #define IGC_MAC_STATE_IN_USE		0x2
>   #define IGC_MAC_STATE_SRC_ADDR		0x4
> -#define IGC_MAC_STATE_QUEUE_STEERING	0x8
>   
>   #define IGC_MAX_RXNFC_FILTERS		16
>   
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index 8a3cae2367d4..273817252823 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -820,8 +820,9 @@ static void igc_set_default_mac_filter(struct igc_adapter *adapter)
>   
>   	ether_addr_copy(mac_table->addr, adapter->hw.mac.addr);
>   	mac_table->state = IGC_MAC_STATE_DEFAULT | IGC_MAC_STATE_IN_USE;
> +	mac_table->queue = -1;
>   
> -	igc_set_mac_filter_hw(adapter, 0, mac_table->addr, -1);
> +	igc_set_mac_filter_hw(adapter, 0, mac_table->addr, mac_table->queue);
>   }
>   
>   /**
> @@ -2197,13 +2198,20 @@ static bool igc_mac_entry_can_be_used(const struct igc_mac_addr *entry,
>   	return true;
>   }
>   
> -/* Add a MAC filter for 'addr' directing matching traffic to 'queue',
> - * 'flags' is used to indicate what kind of match is made, match is by
> - * default for the destination address, if matching by source address
> - * is desired the flag IGC_MAC_STATE_SRC_ADDR can be used.
> - */
Please, add /** before declaration (as we discussed in prev patches review)
> +/* Add MAC address filter to adapter.
> + *
> + * @adapter: Pointer to adapter where the filter should be added.
> + * @addr: MAC address.
> + * @queue: If non-negative, queue assignment feature is enabled and frames
> + * matching the filter are enqueued onto 'queue'. Otherwise, queue assignment
> + * is disabled.
> + * @flags: Set IGC_MAC_STATE_SRC_ADDR bit to indicate @address is a source
> + * address.
> + *
> + * In case of success, returns 0. Otherwise, it returns a negative errno code.
> +  */
>   static int igc_add_mac_filter(struct igc_adapter *adapter, const u8 *addr,
> -			      const u8 queue, const u8 flags)
> +			      const s8 queue, const u8 flags)
>   {
>   	struct igc_hw *hw = &adapter->hw;
>   	int rar_entries = hw->mac.rar_entry_count;
> @@ -2267,11 +2275,11 @@ static int igc_del_mac_filter(struct igc_adapter *adapter, const u8 *addr,
>   		if (adapter->mac_table[i].state & IGC_MAC_STATE_DEFAULT) {
>   			adapter->mac_table[i].state =
>   				IGC_MAC_STATE_DEFAULT | IGC_MAC_STATE_IN_USE;
> -			adapter->mac_table[i].queue = 0;
> +			adapter->mac_table[i].queue = -1;
>   			igc_set_mac_filter_hw(adapter, 0, addr, -1);
>   		} else {
>   			adapter->mac_table[i].state = 0;
> -			adapter->mac_table[i].queue = 0;
> +			adapter->mac_table[i].queue = -1;
>   			memset(adapter->mac_table[i].addr, 0, ETH_ALEN);
>   			igc_clear_mac_filter_hw(adapter, i);
>   		}
> @@ -2286,7 +2294,7 @@ static int igc_uc_sync(struct net_device *netdev, const unsigned char *addr)
>   {
>   	struct igc_adapter *adapter = netdev_priv(netdev);
>   
> -	return igc_add_mac_filter(adapter, addr, adapter->num_rx_queues, 0);
> +	return igc_add_mac_filter(adapter, addr, -1, 0);
>   }
>   
>   static int igc_uc_unsync(struct net_device *netdev, const unsigned char *addr)
> @@ -3731,15 +3739,13 @@ igc_features_check(struct sk_buff *skb, struct net_device *dev,
>   int igc_add_mac_steering_filter(struct igc_adapter *adapter,
>   				const u8 *addr, u8 queue, u8 flags)
>   {
> -	return igc_add_mac_filter(adapter, addr, queue,
> -				  IGC_MAC_STATE_QUEUE_STEERING | flags);
> +	return igc_add_mac_filter(adapter, addr, queue, flags);
>   }
>   
>   int igc_del_mac_steering_filter(struct igc_adapter *adapter,
>   				const u8 *addr, u8 queue, u8 flags)
>   {
> -	return igc_del_mac_filter(adapter, addr,
> -				  IGC_MAC_STATE_QUEUE_STEERING | flags);
> +	return igc_del_mac_filter(adapter, addr, flags);
>   }
>   
>   static void igc_tsync_interrupt(struct igc_adapter *adapter)
> 

