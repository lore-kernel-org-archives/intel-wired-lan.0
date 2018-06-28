From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Wed, 27 Jun 2018 17:56:47 -0700
Subject: [Intel-wired-lan] [PATCH v3 11/11] igc: Add watchdog
In-Reply-To: <20180624084528.10419-1-sasha.neftin@intel.com>
References: <20180624084528.10419-1-sasha.neftin@intel.com>
Message-ID: <2d5a04db-b0fa-ba52-89b1-e728e2483b88@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 6/24/2018 1:45 AM, Sasha Neftin wrote:
> Code completion, remove obsolete code
> Add watchdog methods
> 
> Sasha Neftin (v2):
> minor cosmetic changes
> 
> Sasha Neftin (v3):
> resolve conflict and code optimization
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>   drivers/net/ethernet/intel/igc/e1000_defines.h |  12 ++
>   drivers/net/ethernet/intel/igc/e1000_hw.h      |   2 +
>   drivers/net/ethernet/intel/igc/igc.h           |  12 ++
>   drivers/net/ethernet/intel/igc/igc_main.c      | 235 +++++++++++++++++++++++++
>   4 files changed, 261 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/igc/e1000_defines.h b/drivers/net/ethernet/intel/igc/e1000_defines.h
> index 24c24c197d6b..5e13a606712b 100644
> --- a/drivers/net/ethernet/intel/igc/e1000_defines.h
> +++ b/drivers/net/ethernet/intel/igc/e1000_defines.h
> @@ -86,6 +86,9 @@
>   #define E1000_CTRL_RFCE		0x08000000  /* Receive Flow Control enable */
>   #define E1000_CTRL_TFCE		0x10000000  /* Transmit flow control enable */
>   
> +#define E1000_CONNSW_AUTOSENSE_CONF	0x2
> +#define E1000_CONNSW_AUTOSENSE_EN	0x1
> +
>   /* PBA constants */
>   #define E1000_PBA_34K			0x0022
>   
> @@ -128,6 +131,10 @@
>   #define CR_1000T_HD_CAPS	0x0100 /* Advertise 1000T HD capability */
>   #define CR_1000T_FD_CAPS	0x0200 /* Advertise 1000T FD capability  */
>   
> +/* 1000BASE-T Status Register */
> +#define SR_1000T_REMOTE_RX_STATUS	0x1000 /* Remote receiver OK */
> +#define SR_1000T_LOCAL_RX_STATUS	0x2000 /* Local receiver OK */
> +
>   /* PHY GPY 211 registers */
>   #define STANDARD_AN_REG_MASK	0x0007 /* MMD */
>   #define ANEG_MULTIGBT_AN_CTRL	0x0020 /* MULTI GBT AN Control Register */
> @@ -270,6 +277,11 @@
>   #define E1000_IMS_RXT0		E1000_ICR_RXT0    /* Rx timer intr */
>   #define E1000_IMS_RXDMT0	E1000_ICR_RXDMT0  /* Rx desc min. threshold */
>   
> +/* Interrupt Cause Set */
> +#define E1000_ICS_LSC		E1000_ICR_LSC       /* Link Status Change */
> +#define E1000_ICS_RXDMT0	E1000_ICR_RXDMT0    /* rx desc min. threshold */
> +#define E1000_ICS_DRSTA		E1000_ICR_DRSTA     /* Device Reset Aserted */
> +
>   #define E1000_ICR_DOUTSYNC	0x10000000 /* NIC DMA out of sync */
>   #define E1000_EITR_CNT_IGNR	0x80000000 /* Don't reset counters on write */
>   #define E1000_IVAR_VALID	0x80
> diff --git a/drivers/net/ethernet/intel/igc/e1000_hw.h b/drivers/net/ethernet/intel/igc/e1000_hw.h
> index d8fc6fa9eda2..df948840df3b 100644
> --- a/drivers/net/ethernet/intel/igc/e1000_hw.h
> +++ b/drivers/net/ethernet/intel/igc/e1000_hw.h
> @@ -229,6 +229,8 @@ struct e1000_dev_spec_base {
>   	bool clear_semaphore_once;
>   	bool module_plugged;
>   	u8 media_port;
> +	bool media_changed;
> +	bool mas_capable;
>   };
>   
>   struct e1000_hw {
> diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
> index 99bc2344b7ff..36685d07c765 100644
> --- a/drivers/net/ethernet/intel/igc/igc.h
> +++ b/drivers/net/ethernet/intel/igc/igc.h
> @@ -33,6 +33,8 @@ extern char igc_driver_version[];
>   #define IGC_FLAG_HAS_MSI		BIT(0)
>   #define IGC_FLAG_QUEUE_PAIRS		BIT(4)
>   #define IGC_FLAG_NEED_LINK_UPDATE	BIT(9)
> +#define IGC_FLAG_MEDIA_RESET		BIT(10)
> +#define IGC_FLAG_MAS_ENABLE		BIT(12)
>   #define IGC_FLAG_HAS_MSIX		BIT(13)
>   #define IGC_FLAG_VLAN_PROMISC		BIT(15)
>   
> @@ -296,6 +298,7 @@ struct igc_adapter {
>   
>   	/* TX */
>   	u16 tx_work_limit;
> +	u32 tx_timeout_count;
>   	int num_tx_queues;
>   	struct igc_ring *tx_ring[IGC_MAX_TX_QUEUES];
>   
> @@ -354,6 +357,7 @@ struct igc_adapter {
>   
>   	struct igc_mac_addr *mac_table;
>   
> +	unsigned long link_check_timeout;
>   	struct e1000_info ei;
>   };
>   
> @@ -423,6 +427,14 @@ static inline unsigned int igc_rx_pg_order(struct igc_ring *ring)
>   	return 0;
>   }
>   
> +static inline s32 igc_read_phy_reg(struct e1000_hw *hw, u32 offset, u16 *data)
> +{
> +	if (hw->phy.ops.read_reg)
> +		return hw->phy.ops.read_reg(hw, offset, data);
> +
> +	return 0;
> +}
> +
>   #define igc_rx_pg_size(_ring) (PAGE_SIZE << igc_rx_pg_order(_ring))
>   
>   #define IGC_TXD_DCMD	(E1000_ADVTXD_DCMD_EOP | E1000_ADVTXD_DCMD_RS)
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index 563612910b3f..7fb21af955ec 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -129,6 +129,14 @@ static void igc_power_down_link(struct igc_adapter *adapter)
>   }
>   
>   /**
> + *  Detect and switch function for Media Auto Sense
> + *  @adapter: address of the board private structure
> + **/
> +static void igc_check_swap_media(struct igc_adapter *adapter)
> +{
> +}
> +
> +/**
>    *  igc_release_hw_control - release control of the h/w to f/w
>    *  @adapter: address of board private structure
>    *
> @@ -2323,6 +2331,45 @@ static void igc_free_q_vector(struct igc_adapter *adapter, int v_idx)
>   }
>   
>   /**
> + *  igc_has_link - check shared code for link and determine up/down
> + *  @adapter: pointer to driver private info
> + **/
> +bool igc_has_link(struct igc_adapter *adapter)
> +{
> +	struct e1000_hw *hw = &adapter->hw;
> +	bool link_active = false;
> +
> +	/* get_link_status is set on LSC (link status) interrupt or
> +	 * rx sequence error interrupt.  get_link_status will stay
> +	 * false until the e1000_check_for_link establishes link
> +	 * for copper adapters ONLY
> +	 */
> +	switch (hw->phy.media_type) {
> +	case e1000_media_type_copper:
> +		if (!hw->mac.get_link_status)
> +			return true;
> +		hw->mac.ops.check_for_link(hw);
> +		link_active = !hw->mac.get_link_status;
> +		break;
> +	default:
> +	case e1000_media_type_unknown:
> +		break;
> +	}
> +
> +	if (hw->mac.type == e1000_i225 &&
> +	    hw->phy.id == I225_I_PHY_ID) {
> +		if (!netif_carrier_ok(adapter->netdev)) {
> +			adapter->flags &= ~IGC_FLAG_NEED_LINK_UPDATE;
> +		} else if (!(adapter->flags & IGC_FLAG_NEED_LINK_UPDATE)) {
> +			adapter->flags |= IGC_FLAG_NEED_LINK_UPDATE;
> +			adapter->link_check_timeout = jiffies;
> +		}
> +	}
> +
> +	return link_active;
> +}
> +
> +/**
>    *  igc_watchdog - Timer Call-back
>    *  @data: pointer to adapter cast into an unsigned long
>    **/
> @@ -2333,6 +2380,190 @@ static void igc_watchdog(struct timer_list *t)
>   	schedule_work(&adapter->watchdog_task);
>   }
>   
> +static void igc_watchdog_task(struct work_struct *work)
> +{
> +	struct igc_adapter *adapter = container_of(work,
> +						   struct igc_adapter,
> +						   watchdog_task);
> +	struct e1000_hw *hw = &adapter->hw;
> +	struct e1000_phy_info *phy = &hw->phy;
> +	struct net_device *netdev = adapter->netdev;
> +	u32 link;
> +	int i;
> +	u32 connsw;
> +	u16 phy_data, retry_count = 20;

reverse xmas tree

> +
> +	link = igc_has_link(adapter);
> +
> +	if (adapter->flags & IGC_FLAG_NEED_LINK_UPDATE) {
> +		if (time_after(jiffies, (adapter->link_check_timeout + HZ)))
> +			adapter->flags &= ~IGC_FLAG_NEED_LINK_UPDATE;
> +		else
> +			link = false;
> +	}
> +
> +	/* Force link down if we have fiber to swap to */
> +	if (adapter->flags & IGC_FLAG_MAS_ENABLE) {
> +		if (hw->phy.media_type == e1000_media_type_copper) {
> +			connsw = rd32(E1000_CONNSW);
> +			if (!(connsw & E1000_CONNSW_AUTOSENSE_EN))
> +				link = 0;
> +		}
> +	}
> +	if (link) {
> +		/* Perform a reset if the media type changed. */
> +		if (hw->dev_spec._base.media_changed) {
> +			hw->dev_spec._base.media_changed = false;
> +			adapter->flags |= IGC_FLAG_MEDIA_RESET;
> +			igc_reset(adapter);

Down below is a comment "(Do the reset outside of interrupt context)." 
and a call to schedule_work(&adapter->reset_task);  Should this happen 
here rather than a direct call to reset?

> +		}
> +
> +		if (!netif_carrier_ok(netdev)) {
> +			u32 ctrl;
> +
> +			hw->mac.ops.get_speed_and_duplex(hw,
> +							 &adapter->link_speed,
> +							 &adapter->link_duplex);
> +
> +			ctrl = rd32(E1000_CTRL);
> +			/* Links status message must follow this format */
> +			netdev_info(netdev,
> +				    "igc: %s NIC Link is Up %d Mbps %s Duplex, Flow Control: %s\n",
> +				    netdev->name,
> +				    adapter->link_speed,
> +				    adapter->link_duplex == FULL_DUPLEX ?
> +				    "Full" : "Half",
> +				    (ctrl & E1000_CTRL_TFCE) &&
> +				    (ctrl & E1000_CTRL_RFCE) ? "RX/TX" :
> +				    (ctrl & E1000_CTRL_RFCE) ?  "RX" :
> +				    (ctrl & E1000_CTRL_TFCE) ?  "TX" : "None");
> +
> +			/* check if SmartSpeed worked */
> +			igc_check_downshift(hw);
> +			if (phy->speed_downgraded)
> +				netdev_warn(netdev, "Link Speed was downgraded by SmartSpeed\n");
> +
> +			/* adjust timeout factor according to speed/duplex */
> +			adapter->tx_timeout_factor = 1;
> +			switch (adapter->link_speed) {
> +			case SPEED_10:
> +				adapter->tx_timeout_factor = 14;
> +				break;
> +			case SPEED_100:
> +				/* maybe add some timeout factor ? */
> +				break;
> +			}
> +
> +			if (adapter->link_speed != SPEED_1000)
> +				goto no_wait;
> +
> +			/* wait for Remote receiver status OK */
> +retry_read_status:
> +			if (!igc_read_phy_reg(hw, PHY_1000T_STATUS,
> +					      &phy_data)) {
> +				if (!(phy_data & SR_1000T_REMOTE_RX_STATUS) &&
> +				    retry_count) {
> +					msleep(100);
> +					retry_count--;
> +					goto retry_read_status;
> +				} else if (!retry_count) {
> +					dev_err(&adapter->pdev->dev, "exceed max 2 second\n");
> +				}
> +			} else {
> +				dev_err(&adapter->pdev->dev, "read 1000Base-T Status Reg\n");
> +			}
> +no_wait:
> +			netif_carrier_on(netdev);
> +
> +			/* link state has changed, schedule phy info update */
> +			if (!test_bit(__IGC_DOWN, &adapter->state))
> +				mod_timer(&adapter->phy_info_timer,
> +					  round_jiffies(jiffies + 2 * HZ));
> +		}
> +	} else {
> +		if (netif_carrier_ok(netdev)) {
> +			adapter->link_speed = 0;
> +			adapter->link_duplex = 0;
> +
> +			/* Links status message must follow this format */

s/Links/Link/

> +			netdev_info(netdev, "igc: %s NIC Link is Down\n",
> +				    netdev->name);
> +			netif_carrier_off(netdev);
> +
> +			/* link state has changed, schedule phy info update */
> +			if (!test_bit(__IGC_DOWN, &adapter->state))
> +				mod_timer(&adapter->phy_info_timer,
> +					  round_jiffies(jiffies + 2 * HZ));
> +
> +			/* link is down, time to check for alternate media */
> +			if (adapter->flags & IGC_FLAG_MAS_ENABLE) {
> +				igc_check_swap_media(adapter);
> +				if (adapter->flags & IGC_FLAG_MEDIA_RESET) {
> +					schedule_work(&adapter->reset_task);
> +					/* return immediately */
> +					return;
> +				}
> +			}
> +
> +		/* also check for alternate media here */
> +		} else if (!netif_carrier_ok(netdev) &&
> +			   (adapter->flags & IGC_FLAG_MAS_ENABLE)) {
> +			igc_check_swap_media(adapter);
> +			if (adapter->flags & IGC_FLAG_MEDIA_RESET) {
> +				schedule_work(&adapter->reset_task);
> +				/* return immediately */
> +				return;
> +			}
> +		}
> +	}
> +
> +	spin_lock(&adapter->stats64_lock);
> +	igc_update_stats(adapter);
> +	spin_unlock(&adapter->stats64_lock);
> +
> +	for (i = 0; i < adapter->num_tx_queues; i++) {
> +		struct igc_ring *tx_ring = adapter->tx_ring[i];
> +
> +		if (!netif_carrier_ok(netdev)) {
> +			/* We've lost link, so the controller stops DMA,
> +			 * but we've got queued Tx work that's never going
> +			 * to get done, so reset controller to flush Tx.
> +			 * (Do the reset outside of interrupt context).
> +			 */
> +			if (igc_desc_unused(tx_ring) + 1 < tx_ring->count) {
> +				adapter->tx_timeout_count++;
> +				schedule_work(&adapter->reset_task);
> +				/* return immediately since reset is imminent */
> +				return;
> +			}
> +		}
> +
> +		/* Force detection of hung controller every watchdog period */
> +		set_bit(IGC_RING_FLAG_TX_DETECT_HANG, &tx_ring->flags);
> +	}
> +
> +	/* Cause software interrupt to ensure Rx ring is cleaned */
> +	if (adapter->flags & IGC_FLAG_HAS_MSIX) {
> +		u32 eics = 0;
> +
> +		for (i = 0; i < adapter->num_q_vectors; i++)
> +			eics |= adapter->q_vector[i]->eims_value;
> +		wr32(E1000_EICS, eics);
> +	} else {
> +		wr32(E1000_ICS, E1000_ICS_RXDMT0);
> +	}
> +
> +	/* Reset the timer */
> +	if (!test_bit(__IGC_DOWN, &adapter->state)) {
> +		if (adapter->flags & IGC_FLAG_NEED_LINK_UPDATE)
> +			mod_timer(&adapter->watchdog_timer,
> +				  round_jiffies(jiffies +  HZ));
> +		else
> +			mod_timer(&adapter->watchdog_timer,
> +				  round_jiffies(jiffies + 2 * HZ));
> +	}
> +}
> +
>   /**
>    *  igc_update_ring_itr - update the dynamic ITR value based on packet size
>    *  @q_vector: pointer to q_vector
> @@ -3195,6 +3426,8 @@ static int __igc_open(struct net_device *netdev, bool resuming)
>   	/* start the watchdog. */
>   	hw->mac.get_link_status = 1;
>   
> +	schedule_work(&adapter->watchdog_task);
> +
>   	return E1000_SUCCESS;
>   
>   err_set_queues:
> @@ -3477,6 +3710,7 @@ static int igc_probe(struct pci_dev *pdev,
>   	timer_setup(&adapter->watchdog_timer, igc_watchdog, 0);
>   
>   	INIT_WORK(&adapter->reset_task, igc_reset_task);
> +	INIT_WORK(&adapter->watchdog_task, igc_watchdog_task);
>   
>   	/* Initialize link properties that are user-changeable */
>   	adapter->fc_autoneg = true;
> @@ -3562,6 +3796,7 @@ static void igc_remove(struct pci_dev *pdev)
>   	del_timer_sync(&adapter->watchdog_timer);
>   
>   	cancel_work_sync(&adapter->reset_task);
> +	cancel_work_sync(&adapter->watchdog_task);
>   
>   	/* Release control of h/w to f/w.  If f/w is AMT enabled, this
>   	 * would have already happened in close and is redundant.
> 
