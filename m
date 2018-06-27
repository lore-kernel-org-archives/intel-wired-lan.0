From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Wed, 27 Jun 2018 16:42:30 -0700
Subject: [Intel-wired-lan] [PATCH v3 04/11] igc: Add interrupt support
In-Reply-To: <20180624084505.10109-1-sasha.neftin@intel.com>
References: <20180624084505.10109-1-sasha.neftin@intel.com>
Message-ID: <bb91c36c-0a1e-5b13-1233-152918c1908f@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 6/24/2018 1:45 AM, Sasha Neftin wrote:
> This patch set adds interrupt support for the igc interfaces.
> 
> Sasha Neftin (v2):
> fixed comments
> 
> Sasha Neftin (v3):
> minor changes
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>   drivers/net/ethernet/intel/igc/e1000_defines.h |   35 +
>   drivers/net/ethernet/intel/igc/e1000_hw.h      |   84 ++
>   drivers/net/ethernet/intel/igc/e1000_regs.h    |    4 +-
>   drivers/net/ethernet/intel/igc/igc.h           |  131 +++
>   drivers/net/ethernet/intel/igc/igc_main.c      | 1068 +++++++++++++++++++++++-
>   5 files changed, 1305 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/e1000_defines.h b/drivers/net/ethernet/intel/igc/e1000_defines.h
> index 66b05898eb00..1f8bc16c7029 100644
> --- a/drivers/net/ethernet/intel/igc/e1000_defines.h
> +++ b/drivers/net/ethernet/intel/igc/e1000_defines.h
> @@ -62,4 +62,39 @@
>   #define E1000_STATUS_SPEED_100	0x00000040      /* Speed 100Mb/s */
>   #define E1000_STATUS_SPEED_1000	0x00000080      /* Speed 1000Mb/s */
>   
> +/* Interrupt Cause Read */
> +#define E1000_ICR_TXDW		0x00000001 /* Transmit desc written back */
> +#define E1000_ICR_TXQE		0x00000002 /* Transmit Queue empty */
> +#define E1000_ICR_LSC		0x00000004 /* Link Status Change */
> +#define E1000_ICR_RXSEQ		0x00000008 /* Rx sequence error */
> +#define E1000_ICR_RXDMT0	0x00000010 /* Rx desc min. threshold (0) */
> +#define E1000_ICR_RXO		0x00000040 /* Rx overrun */
> +#define E1000_ICR_RXT0		0x00000080 /* Rx timer intr (ring 0) */
> +#define E1000_ICR_DRSTA		0x40000000 /* Device Reset Asserted */
> +#define E1000_ICS_RXT0		E1000_ICR_RXT0      /* Rx timer intr */

An argument might be made that all these bit definitions should be in 
the form of BIT(x), especially when you're using BIT(x) in other 
definitions such as IGC_FLAG_HAS_MSI.

> +
> +#define IMS_ENABLE_MASK ( \

Should have the driver name prefix

> +	E1000_IMS_RXT0   |    \
> +	E1000_IMS_TXDW   |    \
> +	E1000_IMS_RXDMT0 |    \
> +	E1000_IMS_RXSEQ  |    \
> +	E1000_IMS_LSC)
> +
> +/* Interrupt Mask Set */
> +#define E1000_IMS_TXDW		E1000_ICR_TXDW    /* Tx desc written back */
> +#define E1000_IMS_RXSEQ		E1000_ICR_RXSEQ   /* Rx sequence error */
> +#define E1000_IMS_LSC		E1000_ICR_LSC	/* Link Status Change */
> +#define E1000_IMS_DOUTSYNC	E1000_ICR_DOUTSYNC /* NIC DMA out of sync */
> +#define E1000_IMS_DRSTA		E1000_ICR_DRSTA   /* Device Reset Asserted */
> +#define E1000_IMS_RXT0		E1000_ICR_RXT0    /* Rx timer intr */
> +#define E1000_IMS_RXDMT0	E1000_ICR_RXDMT0  /* Rx desc min. threshold */
> +
> +#define E1000_ICR_DOUTSYNC	0x10000000 /* NIC DMA out of sync */
> +#define E1000_EITR_CNT_IGNR	0x80000000 /* Don't reset counters on write */
> +#define E1000_IVAR_VALID	0x80
> +#define E1000_GPIE_NSICR	0x00000001
> +#define E1000_GPIE_MSIX_MODE	0x00000010
> +#define E1000_GPIE_EIAME	0x40000000
> +#define E1000_GPIE_PBA		0x80000000
> +
>   #endif /* _E1000_DEFINES_H_ */
> diff --git a/drivers/net/ethernet/intel/igc/e1000_hw.h b/drivers/net/ethernet/intel/igc/e1000_hw.h
> index 6abe722f0bc4..650c4ac981d9 100644
> --- a/drivers/net/ethernet/intel/igc/e1000_hw.h
> +++ b/drivers/net/ethernet/intel/igc/e1000_hw.h
> @@ -118,6 +118,90 @@ struct e1000_hw {
>   	u8  revision_id;
>   };
>   
> +/* Statistics counters collected by the MAC */
> +struct e1000_hw_stats {
> +	u64 crcerrs;
> +	u64 algnerrc;
> +	u64 symerrs;
> +	u64 rxerrc;
> +	u64 mpc;
> +	u64 scc;
> +	u64 ecol;
> +	u64 mcc;
> +	u64 latecol;
> +	u64 colc;
> +	u64 dc;
> +	u64 tncrs;
> +	u64 sec;
> +	u64 cexterr;
> +	u64 rlec;
> +	u64 xonrxc;
> +	u64 xontxc;
> +	u64 xoffrxc;
> +	u64 xofftxc;
> +	u64 fcruc;
> +	u64 prc64;
> +	u64 prc127;
> +	u64 prc255;
> +	u64 prc511;
> +	u64 prc1023;
> +	u64 prc1522;
> +	u64 gprc;
> +	u64 bprc;
> +	u64 mprc;
> +	u64 gptc;
> +	u64 gorc;
> +	u64 gotc;
> +	u64 rnbc;
> +	u64 ruc;
> +	u64 rfc;
> +	u64 roc;
> +	u64 rjc;
> +	u64 mgprc;
> +	u64 mgpdc;
> +	u64 mgptc;
> +	u64 tor;
> +	u64 tot;
> +	u64 tpr;
> +	u64 tpt;
> +	u64 ptc64;
> +	u64 ptc127;
> +	u64 ptc255;
> +	u64 ptc511;
> +	u64 ptc1023;
> +	u64 ptc1522;
> +	u64 mptc;
> +	u64 bptc;
> +	u64 tsctc;
> +	u64 tsctfc;
> +	u64 iac;
> +	u64 icrxptc;
> +	u64 icrxatc;
> +	u64 ictxptc;
> +	u64 ictxatc;
> +	u64 ictxqec;
> +	u64 ictxqmtc;
> +	u64 icrxdmtc;
> +	u64 icrxoc;
> +	u64 cbtmpc;
> +	u64 htdpmc;
> +	u64 cbrdpc;
> +	u64 cbrmpc;
> +	u64 rpthc;
> +	u64 hgptc;
> +	u64 htcbdpc;
> +	u64 hgorc;
> +	u64 hgotc;
> +	u64 lenerrs;
> +	u64 scvpc;
> +	u64 hrmpc;
> +	u64 doosync;
> +	u64 o2bgptc;
> +	u64 o2bspc;
> +	u64 b2ospc;
> +	u64 b2ogprc;
> +};
> +
>   /* These functions must be implemented by drivers */
>   s32  igc_read_pcie_cap_reg(struct e1000_hw *hw, u32 reg, u16 *value);
>   s32  igc_write_pcie_cap_reg(struct e1000_hw *hw, u32 reg, u16 *value);
> diff --git a/drivers/net/ethernet/intel/igc/e1000_regs.h b/drivers/net/ethernet/intel/igc/e1000_regs.h
> index 4a1da691f42c..5634a01afff3 100644
> --- a/drivers/net/ethernet/intel/igc/e1000_regs.h
> +++ b/drivers/net/ethernet/intel/igc/e1000_regs.h
> @@ -70,8 +70,8 @@
>   #define E1000_IAM		0x01510  /* Intr Ack Auto Mask- RW */
>   /* Intr Throttle - RW */
>   #define E1000_EITR(_n)		(0x01680 + (0x4 * (_n)))
> -/* Interrupt Vector Allocation (array) - RW */
> -#define E1000_IVAR(_n)		(0x01700 + (0x4 * (_n)))
> +/* Interrupt Vector Allocation - RW */
> +#define E1000_IVAR0		0x01700
>   #define E1000_IVAR_MISC		0x01740   /* IVAR for "other" causes - RW */
>   #define E1000_GPIE		0x01514  /* General Purpose Intr Enable - RW */
>   
> diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
> index 29df87285b9b..7cab3e9c8e91 100644
> --- a/drivers/net/ethernet/intel/igc/igc.h
> +++ b/drivers/net/ethernet/intel/igc/igc.h
> @@ -28,6 +28,17 @@
>   extern char igc_driver_name[];
>   extern char igc_driver_version[];
>   
> +/* Interrupt defines */
> +#define IGC_START_ITR			648 /* ~6000 ints/sec */
> +#define IGC_FLAG_HAS_MSI		BIT(0)
> +#define IGC_FLAG_QUEUE_PAIRS		BIT(4)
> +#define IGC_FLAG_HAS_MSIX		BIT(13)
> +
> +#define IGC_START_ITR			648 /* ~6000 ints/sec */
> +#define IGC_4K_ITR			980
> +#define IGC_20K_ITR			196
> +#define IGC_70K_ITR			56
> +
>   /* Transmit and receive queues */
>   #define IGC_MAX_RX_QUEUES                 4
>   #define IGC_MAX_TX_QUEUES                 4
> @@ -42,10 +53,100 @@ enum e1000_state_t {
>   	 __IGC_PTP_TX_IN_PROGRESS,
>   };
>   
> +struct igc_tx_queue_stats {
> +	u64 packets;
> +	u64 bytes;
> +	u64 restart_queue;
> +};
> +
> +struct igc_rx_queue_stats {
> +	u64 packets;
> +	u64 bytes;
> +	u64 drops;
> +	u64 csum_err;
> +	u64 alloc_failed;
> +};
> +
> +struct igc_rx_packet_stats {
> +	u64 ipv4_packets;      /* IPv4 headers processed */
> +	u64 ipv4e_packets;     /* IPv4E headers with extensions processed */
> +	u64 ipv6_packets;      /* IPv6 headers processed */
> +	u64 ipv6e_packets;     /* IPv6E headers with extensions processed */
> +	u64 tcp_packets;       /* TCP headers processed */
> +	u64 udp_packets;       /* UDP headers processed */
> +	u64 sctp_packets;      /* SCTP headers processed */
> +	u64 nfs_packets;       /* NFS headers processe */
> +	u64 other_packets;
> +};
> +
> +struct igc_ring_container {
> +	struct igc_ring *ring;          /* pointer to linked list of rings */
> +	unsigned int total_bytes;       /* total bytes processed this int */
> +	unsigned int total_packets;     /* total packets processed this int */
> +	u16 work_limit;                 /* total work allowed per interrupt */
> +	u8 count;                       /* total number of rings in vector */
> +	u8 itr;                         /* current ITR setting for ring */
> +};
> +
> +struct igc_ring {
> +	struct igc_q_vector *q_vector;  /* backlink to q_vector */
> +	struct net_device *netdev;      /* back pointer to net_device */
> +	struct device *dev;             /* device for dma mapping */
> +	union {                         /* array of buffer info structs */
> +		struct igc_tx_buffer *tx_buffer_info;
> +		struct igc_rx_buffer *rx_buffer_info;
> +	};
> +	void *desc;                     /* descriptor ring memory */
> +	unsigned long flags;            /* ring specific flags */
> +	void __iomem *tail;             /* pointer to ring tail register */
> +	dma_addr_t dma;                 /* phys address of the ring */
> +	unsigned int size;              /* length of desc. ring in bytes */

I'm amused and curious about your mix of long/int and u8/u16/u32.  I'd 
prefer to see a little more consistency in a new driver.  Is there a 
reason for unsigned int here rather than u32?  Or for the long flags 
rather than u64 flags?

> +
> +	u16 count;                      /* number of desc. in the ring */
> +	u8 queue_index;                 /* logical index of the ring*/
> +	u8 reg_idx;                     /* physical index of the ring */
> +
> +	/* everything past this point are written often */
> +	u16 next_to_clean;
> +	u16 next_to_use;
> +	u16 next_to_alloc;
> +
> +	union {
> +		/* TX */
> +		struct {
> +			struct igc_tx_queue_stats tx_stats;
> +		};
> +		/* RX */
> +		struct {
> +			struct igc_rx_queue_stats rx_stats;
> +			struct igc_rx_packet_stats pkt_stats;
> +#ifdef CONFIG_IGC_DISABLE_PACKET_SPLIT
> +			u16 rx_buffer_len;
> +#else
> +			struct sk_buff *skb;
> +#endif
> +		};
> +	};
> +} ____cacheline_internodealigned_in_smp;
> +
>   struct igc_q_vector {
>   	struct igc_adapter *adapter;    /* backlink */
> +	void __iomem *itr_register;
> +	u32 eims_value;                 /* EIMS mask value */
> +
> +	u16 itr_val;
> +	u8 set_itr;
> +
> +	struct igc_ring_container rx, tx;
>   
>   	struct napi_struct napi;
> +
> +	struct rcu_head rcu;    /* to avoid race with update stats on free */
> +	char name[IFNAMSIZ + 9];
> +	struct net_device poll_dev;
> +
> +	/* for dynamic allocation of rings associated with this q_vector */
> +	struct igc_ring ring[0] ____cacheline_internodealigned_in_smp;
>   };
>   
>   struct igc_mac_addr {
> @@ -65,13 +166,35 @@ struct igc_adapter {
>   	unsigned long state;
>   	unsigned int flags;
>   	unsigned int num_q_vectors;
> +
> +	struct msix_entry *msix_entries;
> +
> +	/* TX */
> +	u16 tx_work_limit;
> +	int num_tx_queues;
> +	struct igc_ring *tx_ring[IGC_MAX_TX_QUEUES];
> +
> +	/* RX */
> +	int num_rx_queues;
> +	struct igc_ring *rx_ring[IGC_MAX_RX_QUEUES];
> +
> +	struct timer_list watchdog_timer;
> +	struct timer_list dma_err_timer;
> +	struct timer_list phy_info_timer;
> +
>   	u16 link_speed;
>   	u16 link_duplex;
>   
>   	u8 port_num;
>   
>   	u8 __iomem *io_addr;
> +	/* Interrupt Throttle Rate */
> +	u32 rx_itr_setting;
> +	u32 tx_itr_setting;
> +
> +	struct work_struct reset_task;
>   	struct work_struct watchdog_task;
> +	struct work_struct dma_err_task;
>   
>   	int msg_enable;
>   	u32 max_frame_size;
> @@ -81,8 +204,16 @@ struct igc_adapter {
>   
>   	/* structs defined in e1000_hw.h */
>   	struct e1000_hw hw;
> +	struct e1000_hw_stats stats;
>   
>   	struct igc_q_vector *q_vector[MAX_Q_VECTORS];
> +	u32 eims_enable_mask;
> +	u32 eims_other;
> +
> +	u16 tx_ring_count;
> +	u16 rx_ring_count;
> +
> +	u32 rss_queues;
>   
>   	struct igc_mac_addr *mac_table;
>   };
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index 520f49be8e19..30b778c9b94b 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -33,6 +33,36 @@ static int igc_sw_init(struct igc_adapter *);
>   static void igc_configure(struct igc_adapter *adapter);
>   static void igc_power_down_link(struct igc_adapter *adapter);
>   static void igc_set_default_mac_filter(struct igc_adapter *adapter);
> +static irqreturn_t igc_msix_ring(int irq, void *data);
> +static void igc_write_itr(struct igc_q_vector *q_vector);
> +static int igc_request_msix(struct igc_adapter *adapter);
> +static void igc_assign_vector(struct igc_q_vector *q_vector, int msix_vector);
> +static void igc_free_q_vector(struct igc_adapter *adapter, int v_idx);
> +static int igc_init_interrupt_scheme(struct igc_adapter *adapter, bool msix);
> +static int igc_alloc_q_vectors(struct igc_adapter *adapter);
> +static int igc_poll(struct napi_struct *napi, int budget);
> +static void igc_set_interrupt_capability(struct igc_adapter *adapter,
> +					 bool msix);
> +static void igc_reset_interrupt_capability(struct igc_adapter *adapter);
> +static void igc_reset_q_vector(struct igc_adapter *adapter, int v_idx);
> +static void igc_clear_interrupt_scheme(struct igc_adapter *adapter);
> +static void igc_free_q_vectors(struct igc_adapter *adapter);
> +static void igc_irq_disable(struct igc_adapter *adapter);
> +static void igc_irq_enable(struct igc_adapter *adapter);
> +static void igc_configure_msix(struct igc_adapter *adapter);
> +static void igc_free_irq(struct igc_adapter *adapter);
> +static void igc_ring_irq_enable(struct igc_q_vector *q_vector);
> +static void igc_set_itr(struct igc_q_vector *q_vector);
> +static void igc_update_ring_itr(struct igc_q_vector *q_vector);
> +static void igc_update_itr(struct igc_q_vector *q_vector,
> +			   struct igc_ring_container *ring_container);
> +
> +enum latency_range {
> +	lowest_latency = 0,
> +	low_latency = 1,
> +	bulk_latency = 2,
> +	latency_invalid = 255
> +};
>   
>   void igc_reset(struct igc_adapter *adapter)
>   {
> @@ -146,6 +176,7 @@ static int igc_ioctl(struct net_device *netdev, struct ifreq *ifr, int cmd)
>    **/
>   int igc_up(struct igc_adapter *adapter)
>   {
> +	struct e1000_hw *hw = &adapter->hw;
>   	int i = 0;
>   
>   	/* hardware has been reset, we need to reload some things */
> @@ -156,6 +187,15 @@ int igc_up(struct igc_adapter *adapter)
>   	for (i = 0; i < adapter->num_q_vectors; i++)
>   		napi_enable(&adapter->q_vector[i]->napi);
>   
> +	if (adapter->msix_entries)
> +		igc_configure_msix(adapter);
> +	else
> +		igc_assign_vector(adapter->q_vector[0], 0);
> +
> +	/* Clear any pending interrupts. */
> +	rd32(E1000_ICR);
> +	igc_irq_enable(adapter);
> +
>   	return 0;
>   }
>   
> @@ -303,23 +343,985 @@ static void igc_set_default_mac_filter(struct igc_adapter *adapter)
>   	igc_rar_set_index(adapter, 0);
>   }
>   
> +static irqreturn_t igc_msix_other(int irq, void *data)

Are you going to put header comments on these functions later, or leave 
it with some lacking headers?

> +{
> +	struct igc_adapter *adapter = data;
> +	struct e1000_hw *hw = &adapter->hw;
> +	u32 icr = rd32(E1000_ICR);
> +	/* reading ICR causes bit 31 of EICR to be cleared */
> +
> +	if (icr & E1000_ICR_DRSTA)
> +		schedule_work(&adapter->reset_task);
> +
> +	if (icr & E1000_ICR_DOUTSYNC) {
> +		/* HW is reporting DMA is out of sync */
> +		adapter->stats.doosync++;
> +	}
> +
> +	if (icr & E1000_ICR_LSC) {
> +		hw->mac.get_link_status = 1;
> +		/* guard against interrupt when we're going down */
> +		if (!test_bit(__IGC_DOWN, &adapter->state))
> +			mod_timer(&adapter->watchdog_timer, jiffies + 1);
> +	}
> +
> +	wr32(E1000_EIMS, adapter->eims_other);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +/**
> + *  igc_write_ivar - configure ivar for given MSI-X vector
> + *  @hw: pointer to the HW structure
> + *  @msix_vector: vector number we are allocating to a given ring
> + *  @index: row index of IVAR register to write within IVAR table
> + *  @offset: column offset of in IVAR, should be multiple of 8
> + *
> + *  This function is intended to handle the writing of the IVAR register
> + *  for adapters 82576 and newer.  The IVAR table consists of 2 columns,

I suspect this driver won't be handling 82576.

> + *  each containing an cause allocation for an Rx and Tx ring, and a
> + *  variable number of rows depending on the number of queues supported.
> + **/
> +static void igc_write_ivar(struct e1000_hw *hw, int msix_vector,
> +			   int index, int offset)
> +{
> +	u32 ivar = array_rd32(E1000_IVAR0, index);
> +
> +	/* clear any bits that are currently set */
> +	ivar &= ~((u32)0xFF << offset);
> +
> +	/* write vector and valid bit */
> +	ivar |= (msix_vector | E1000_IVAR_VALID) << offset;
> +
> +	array_wr32(E1000_IVAR0, index, ivar);
> +}
> +
> +#define IGC_N0_QUEUE -1

Put this in a .h file

> +static void igc_assign_vector(struct igc_q_vector *q_vector, int msix_vector)
> +{
> +	struct igc_adapter *adapter = q_vector->adapter;
> +	struct e1000_hw *hw = &adapter->hw;
> +	int rx_queue = IGC_N0_QUEUE;
> +	int tx_queue = IGC_N0_QUEUE;
> +
> +	if (q_vector->rx.ring)
> +		rx_queue = q_vector->rx.ring->reg_idx;
> +	if (q_vector->tx.ring)
> +		tx_queue = q_vector->tx.ring->reg_idx;
> +
> +	switch (hw->mac.type) {
> +	case e1000_i225:
> +		if (rx_queue > IGC_N0_QUEUE)
> +			igc_write_ivar(hw, msix_vector,
> +				       rx_queue >> 1,
> +				       (rx_queue & 0x1) << 4);
> +		if (tx_queue > IGC_N0_QUEUE)
> +			igc_write_ivar(hw, msix_vector,
> +				       tx_queue >> 1,
> +				       ((tx_queue & 0x1) << 4) + 8);
> +		q_vector->eims_value = BIT(msix_vector);
> +		break;
> +	default:
> +		WARN_ON(hw->mac.type != e1000_i225);

You might want to make this a WARN_ONCE

> +		break;
> +	}
> +
> +	/* add q_vector eims value to global eims_enable_mask */
> +	adapter->eims_enable_mask |= q_vector->eims_value;
> +
> +	/* configure q_vector to set itr on first interrupt */
> +	q_vector->set_itr = 1;
> +}
> +
> +/**
> + *  igc_configure_msix - Configure MSI-X hardware
> + *  @adapter: Pointer to adapter structure
> + *
> + *  igc_configure_msix sets up the hardware to properly
> + *  generate MSI-X interrupts.
> + **/
> +static void igc_configure_msix(struct igc_adapter *adapter)
> +{
> +	u32 tmp;
> +	int i, vector = 0;
> +	struct e1000_hw *hw = &adapter->hw;

reverse xmas tree layout

> +
> +	adapter->eims_enable_mask = 0;
> +
> +	/* set vector for other causes, i.e. link changes */
> +	switch (hw->mac.type) {
> +	case e1000_i225:
> +		/* Turn on MSI-X capability first, or our settings
> +		 * won't stick.  And it will take days to debug.
> +		 */
> +		wr32(E1000_GPIE, E1000_GPIE_MSIX_MODE |
> +		     E1000_GPIE_PBA | E1000_GPIE_EIAME |
> +		     E1000_GPIE_NSICR);
> +
> +		/* enable msix_other interrupt */
> +		adapter->eims_other = BIT(vector);
> +		tmp = (vector++ | E1000_IVAR_VALID) << 8;
> +
> +		wr32(E1000_IVAR_MISC, tmp);
> +		break;
> +	default:
> +		/* do nothing, since nothing else supports MSI-X */

Will there be hardware used by this driver that *doesn't* support MSIx? 
If not then this is a misleading comment.  This case is more likely a 
good place for an error message for unexpected HW.

> +		break;
> +	} /* switch (hw->mac.type) */
> +
> +	adapter->eims_enable_mask |= adapter->eims_other;
> +
> +	for (i = 0; i < adapter->num_q_vectors; i++)
> +		igc_assign_vector(adapter->q_vector[i], vector++);
> +
> +	wrfl();
> +}
> +
> +/**
> + *  igc_request_msix - Initialize MSI-X interrupts
> + *  @adapter: Pointer to adapter structure
> + *
> + *  igc_request_msix allocates MSI-X vectors and requests interrupts from the
> + *  kernel.
> + **/
> +static int igc_request_msix(struct igc_adapter *adapter)
> +{
> +	struct net_device *netdev = adapter->netdev;
> +	int i = 0, err = 0, vector = 0, free_vector = 0;

reverse xmas tree

> +
> +	err = request_irq(adapter->msix_entries[vector].vector,
> +			  &igc_msix_other, 0, netdev->name, adapter);
> +	if (err)
> +		goto err_out;
> +
> +	for (i = 0; i < adapter->num_q_vectors; i++) {
> +		struct igc_q_vector *q_vector = adapter->q_vector[i];
> +
> +		vector++;
> +
> +		q_vector->itr_register = adapter->io_addr + E1000_EITR(vector);
> +
> +		if (q_vector->rx.ring && q_vector->tx.ring)
> +			sprintf(q_vector->name, "%s-TxRx-%u", netdev->name,
> +				q_vector->rx.ring->queue_index);
> +		else if (q_vector->tx.ring)
> +			sprintf(q_vector->name, "%s-tx-%u", netdev->name,
> +				q_vector->tx.ring->queue_index);
> +		else if (q_vector->rx.ring)
> +			sprintf(q_vector->name, "%s-rx-%u", netdev->name,
> +				q_vector->rx.ring->queue_index);

Is there any reason to support the tx and rx queues split on different 
interrupts?

> +		else
> +			sprintf(q_vector->name, "%s-unused", netdev->name);
> +
> +		err = request_irq(adapter->msix_entries[vector].vector,
> +				  igc_msix_ring, 0, q_vector->name,
> +				  q_vector);
> +		if (err)
> +			goto err_free;
> +	}
> +
> +	igc_configure_msix(adapter);
> +	return 0;
> +
> +err_free:
> +	/* free already assigned IRQs */
> +	free_irq(adapter->msix_entries[free_vector++].vector, adapter);
> +
> +	vector--;
> +	for (i = 0; i < vector; i++) {
> +		free_irq(adapter->msix_entries[free_vector++].vector,
> +			 adapter->q_vector[i]);
> +	}
> +err_out:
> +	return err;
> +}
> +
> +/**
> + *  igc_reset_q_vector - Reset config for interrupt vector
> + *  @adapter: board private structure to initialize
> + *  @v_idx: Index of vector to be reset
> + *
> + *  If NAPI is enabled it will delete any references to the
> + *  NAPI struct. This is preparation for igc_free_q_vector.
> + **/
> +static void igc_reset_q_vector(struct igc_adapter *adapter, int v_idx)
> +{
> +	struct igc_q_vector *q_vector = adapter->q_vector[v_idx];
> +
> +	/* if we're coming from igc_set_interrupt_capability, the vectors are
> +	 * not yet allocated
> +	 */
> +	if (!q_vector)
> +		return;
> +
> +	if (q_vector->tx.ring)
> +		adapter->tx_ring[q_vector->tx.ring->queue_index] = NULL;
> +
> +	if (q_vector->rx.ring)
> +		adapter->rx_ring[q_vector->rx.ring->queue_index] = NULL;
> +
> +	netif_napi_del(&q_vector->napi);
> +}
> +
> +static void igc_reset_interrupt_capability(struct igc_adapter *adapter)
> +{
> +	int v_idx = adapter->num_q_vectors;
> +
> +	if (adapter->msix_entries) {
> +		pci_disable_msix(adapter->pdev);
> +		kfree(adapter->msix_entries);
> +		adapter->msix_entries = NULL;
> +	} else if (adapter->flags & IGC_FLAG_HAS_MSI) {
> +		pci_disable_msi(adapter->pdev);
> +	}
> +
> +	while (v_idx--)
> +		igc_reset_q_vector(adapter, v_idx);
> +}
> +
>   /**
> - * igc_open - Called when a network interface is made active
> - * @netdev: network interface device structure
> + *  igc_clear_interrupt_scheme - reset the device to a state of no interrupts
> + *  @adapter: Pointer to adapter structure
> + *
> + *  This function resets the device so that it has 0 rx queues, tx queues, and
> + *  MSI-X interrupts allocated.
> + */
> +static void igc_clear_interrupt_scheme(struct igc_adapter *adapter)
> +{
> +	igc_free_q_vectors(adapter);
> +	igc_reset_interrupt_capability(adapter);
> +}
> +
> +/**
> + *  igc_free_q_vectors - Free memory allocated for interrupt vectors
> + *  @adapter: board private structure to initialize
> + *
> + *  This function frees the memory allocated to the q_vectors.  In addition if
> + *  NAPI is enabled it will delete any references to the NAPI struct prior
> + *  to freeing the q_vector.
> + **/
> +static void igc_free_q_vectors(struct igc_adapter *adapter)
> +{
> +	int v_idx = adapter->num_q_vectors;
> +
> +	adapter->num_tx_queues = 0;
> +	adapter->num_rx_queues = 0;
> +	adapter->num_q_vectors = 0;
> +
> +	while (v_idx--) {
> +		igc_reset_q_vector(adapter, v_idx);
> +		igc_free_q_vector(adapter, v_idx);
> +	}
> +}
> +
> +/**
> + *  igc_free_q_vector - Free memory allocated for specific interrupt vector
> + *  @adapter: board private structure to initialize
> + *  @v_idx: Index of vector to be freed
>    *
> - * Returns 0 on success, negative value on failure
> + *  This function frees the memory allocated to the q_vector.
> + **/
> +static void igc_free_q_vector(struct igc_adapter *adapter, int v_idx)
> +{
> +	struct igc_q_vector *q_vector = adapter->q_vector[v_idx];
> +
> +	adapter->q_vector[v_idx] = NULL;
> +
> +	/* igc_get_stats64() might access the rings on this vector,
> +	 * we must wait a grace period before freeing it.
> +	 */
> +	if (q_vector)
> +		kfree_rcu(q_vector, rcu);
> +}
> +
> +/**
> + *  igc_update_ring_itr - update the dynamic ITR value based on packet size
> + *  @q_vector: pointer to q_vector
> + *
> + *  Stores a new ITR value based on strictly on packet size.  This
> + *  algorithm is less sophisticated than that used in igc_update_itr,
> + *  due to the difficulty of synchronizing statistics across multiple
> + *  receive rings.  The divisors and thresholds used by this function
> + *  were determined based on theoretical maximum wire speed and testing
> + *  data, in order to minimize response time while increasing bulk
> + *  throughput.

Was this actually tested with the new HW?  This looks like more simple 
cut-n-paste from igb.  I would assume that the new HW has slightly 
different characteristics.

> + *  This functionality is controlled by the InterruptThrottleRate module
> + *  parameter (see igc_param.c)

Since this is the in-kernel driver, I suspect there won't be an 
InterruptThrottleRate module parameter or a igc_param.c file.

> + *  NOTE: This function is called only when operating in a multiqueue
> + *  receive environment.
> + **/
> +static void igc_update_ring_itr(struct igc_q_vector *q_vector)
> +{
> +	int new_val = q_vector->itr_val;
> +	int avg_wire_size = 0;
> +	struct igc_adapter *adapter = q_vector->adapter;
> +	unsigned int packets;
> +
> +	/* For non-gigabit speeds, just fix the interrupt rate at 4000
> +	 * ints/sec - ITR timer value of 120 ticks.
> +	 */
> +	switch (adapter->link_speed) {
> +	case SPEED_10:
> +	case SPEED_100:
> +		new_val = IGC_4K_ITR;
> +		goto set_itr_val;
> +	default:
> +		break;
> +	}
> +
> +	packets = q_vector->rx.total_packets;
> +	if (packets)
> +		avg_wire_size = q_vector->rx.total_bytes / packets;
> +
> +	packets = q_vector->tx.total_packets;
> +	if (packets)
> +		avg_wire_size = max_t(u32, avg_wire_size,
> +				      q_vector->tx.total_bytes / packets);
> +
> +	/* if avg_wire_size isn't set no work was done */
> +	if (!avg_wire_size)
> +		goto clear_counts;
> +
> +	/* Add 24 bytes to size to account for CRC, preamble, and gap */
> +	avg_wire_size += 24;
> +
> +	/* Don't starve jumbo frames */
> +	avg_wire_size = min(avg_wire_size, 3000);
> +
> +	/* Give a little boost to mid-size frames */
> +	if (avg_wire_size > 300 && avg_wire_size < 1200)
> +		new_val = avg_wire_size / 3;
> +	else
> +		new_val = avg_wire_size / 2;
> +
> +	/* conservative mode (itr 3) eliminates the lowest_latency setting */
> +	if (new_val < IGC_20K_ITR &&
> +	    ((q_vector->rx.ring && adapter->rx_itr_setting == 3) ||
> +	    (!q_vector->rx.ring && adapter->tx_itr_setting == 3)))
> +		new_val = IGC_20K_ITR;
> +
> +set_itr_val:
> +	if (new_val != q_vector->itr_val) {
> +		q_vector->itr_val = new_val;
> +		q_vector->set_itr = 1;
> +	}
> +clear_counts:
> +	q_vector->rx.total_bytes = 0;
> +	q_vector->rx.total_packets = 0;
> +	q_vector->tx.total_bytes = 0;
> +	q_vector->tx.total_packets = 0;
> +}
> +
> +/**
> + *  igc_update_itr - update the dynamic ITR value based on statistics
> + *  @q_vector: pointer to q_vector
> + *  @ring_container: ring info to update the itr for
>    *
> - * The open entry point is called when a network interface is made
> - * active by the system (IFF_UP).  At this point all resources needed
> - * for transmit and receive operations are allocated, the interrupt
> - * handler is registered with the OS, the watchdog timer is started,
> - * and the stack is notified that the interface is ready.
> + *  Stores a new ITR value based on packets and byte
> + *  counts during the last interrupt.  The advantage of per interrupt
> + *  computation is faster updates and more accurate ITR for the current
> + *  traffic pattern.  Constants in this function were computed
> + *  based on theoretical maximum wire speed and thresholds were set based
> + *  on testing data as well as attempting to minimize response time

Again - actual testing data on the new hardware?

> + *  while increasing bulk throughput.
> + *  this functionality is controlled by the InterruptThrottleRate module
> + *  parameter (see igc_param.c)

No module parameter or file in this driver?

> + *  NOTE: These calculations are only valid when operating in a single-
> + *  queue environment.
> + **/
> +static void igc_update_itr(struct igc_q_vector *q_vector,
> +			   struct igc_ring_container *ring_container)
> +{
> +	unsigned int packets = ring_container->total_packets;
> +	unsigned int bytes = ring_container->total_bytes;
> +	u8 itrval = ring_container->itr;
> +
> +	/* no packets, exit with status unchanged */
> +	if (packets == 0)
> +		return;
> +
> +	switch (itrval) {
> +	case lowest_latency:
> +		/* handle TSO and jumbo frames */
> +		if (bytes / packets > 8000)
> +			itrval = bulk_latency;
> +		else if ((packets < 5) && (bytes > 512))
> +			itrval = low_latency;
> +		break;
> +	case low_latency:  /* 50 usec aka 20000 ints/s */
> +		if (bytes > 10000) {
> +			/* this if handles the TSO accounting */
> +			if (bytes / packets > 8000)
> +				itrval = bulk_latency;
> +			else if ((packets < 10) || ((bytes / packets) > 1200))
> +				itrval = bulk_latency;
> +			else if ((packets > 35))
> +				itrval = lowest_latency;
> +		} else if (bytes / packets > 2000) {
> +			itrval = bulk_latency;
> +		} else if (packets <= 2 && bytes < 512) {
> +			itrval = lowest_latency;
> +		}
> +		break;
> +	case bulk_latency: /* 250 usec aka 4000 ints/s */
> +		if (bytes > 25000) {
> +			if (packets > 35)
> +				itrval = low_latency;
> +		} else if (bytes < 1500) {
> +			itrval = low_latency;
> +		}
> +		break;
> +	}
> +
> +	/* clear work counters since we have the values we need */
> +	ring_container->total_bytes = 0;
> +	ring_container->total_packets = 0;
> +
> +	/* write updated itr to ring container */
> +	ring_container->itr = itrval;
> +}
> +
> +static void igc_ring_irq_enable(struct igc_q_vector *q_vector)
> +{
> +	struct igc_adapter *adapter = q_vector->adapter;
> +	struct e1000_hw *hw = &adapter->hw;
> +
> +	if ((q_vector->rx.ring && (adapter->rx_itr_setting & 3)) ||
> +	    (!q_vector->rx.ring && (adapter->tx_itr_setting & 3))) {
> +		if (adapter->num_q_vectors == 1)
> +			igc_set_itr(q_vector);
> +		else
> +			igc_update_ring_itr(q_vector);
> +	}
> +
> +	if (!test_bit(__IGC_DOWN, &adapter->state)) {
> +		if (adapter->msix_entries)
> +			wr32(E1000_EIMS, q_vector->eims_value);
> +		else
> +			igc_irq_enable(adapter);
> +	}
> +}
> +
> +static void igc_set_itr(struct igc_q_vector *q_vector)
> +{
> +	struct igc_adapter *adapter = q_vector->adapter;
> +	u32 new_itr = q_vector->itr_val;
> +	u8 current_itr = 0;
> +
> +	/* for non-gigabit speeds, just fix the interrupt rate at 4000 */
> +	switch (adapter->link_speed) {
> +	case SPEED_10:
> +	case SPEED_100:
> +		current_itr = 0;
> +		new_itr = IGC_4K_ITR;
> +		goto set_itr_now;
> +	default:
> +		break;
> +	}
> +
> +	igc_update_itr(q_vector, &q_vector->tx);
> +	igc_update_itr(q_vector, &q_vector->rx);
> +
> +	current_itr = max(q_vector->rx.itr, q_vector->tx.itr);
> +
> +	/* conservative mode (itr 3) eliminates the lowest_latency setting */
> +	if (current_itr == lowest_latency &&
> +	    ((q_vector->rx.ring && adapter->rx_itr_setting == 3) ||
> +	    (!q_vector->rx.ring && adapter->tx_itr_setting == 3)))
> +		current_itr = low_latency;
> +
> +	switch (current_itr) {
> +	/* counts and packets in update_itr are dependent on these numbers */
> +	case lowest_latency:
> +		new_itr = IGC_70K_ITR; /* 70,000 ints/sec */
> +		break;
> +	case low_latency:
> +		new_itr = IGC_20K_ITR; /* 20,000 ints/sec */
> +		break;
> +	case bulk_latency:
> +		new_itr = IGC_4K_ITR;  /* 4,000 ints/sec */
> +		break;
> +	default:
> +		break;
> +	}
> +
> +set_itr_now:
> +	if (new_itr != q_vector->itr_val) {
> +		/* this attempts to bias the interrupt rate towards Bulk
> +		 * by adding intermediate steps when interrupt rate is
> +		 * increasing
> +		 */
> +		new_itr = new_itr > q_vector->itr_val ?
> +			  max((new_itr * q_vector->itr_val) /
> +			  (new_itr + (q_vector->itr_val >> 2)),
> +			  new_itr) : new_itr;
> +		/* Don't write the value here; it resets the adapter's
> +		 * internal timer, and causes us to delay far longer than
> +		 * we should between interrupts.  Instead, we write the ITR
> +		 * value at the beginning of the next interrupt so the timing
> +		 * ends up being correct.
> +		 */
> +		q_vector->itr_val = new_itr;
> +		q_vector->set_itr = 1;
> +	}
> +}
> +
> +/**
> + *  igc_poll - NAPI Rx polling callback
> + *  @napi: napi polling structure
> + *  @budget: count of how many packets we should handle
> + **/
> +static int igc_poll(struct napi_struct *napi, int budget)
> +{
> +	struct igc_q_vector *q_vector = container_of(napi,
> +						     struct igc_q_vector,
> +						     napi);
> +	bool clean_complete = true;
> +	int work_done = 0;
> +	int cleaned = 0;
> +
> +	/* TODO q->vector->tx_ring: igc_clean_tx_irq */
> +
> +	if (q_vector->rx.ring) {
> +		/* TODO igc_clean_rx_irq */
> +
> +		work_done += cleaned;
> +		if (cleaned >= budget)
> +			clean_complete = false;
> +	}
> +
> +	/* If all work not completed, return budget and keep polling */
> +	if (!clean_complete)
> +		return budget;
> +
> +	/* If not enough Rx work done, exit the polling mode */
> +	napi_complete_done(napi, work_done);
> +	igc_ring_irq_enable(q_vector);
> +
> +	return 0;
> +}
> +
> +/**
> + *  igc_set_interrupt_capability - set MSI or MSI-X if supported
> + *  @adapter: Pointer to adapter structure
> + *
> + *  Attempt to configure interrupts using the best available
> + *  capabilities of the hardware and kernel.
> + **/
> +static void igc_set_interrupt_capability(struct igc_adapter *adapter,
> +					 bool msix)
> +{
> +	int err;
> +	int numvecs, i;
> +
> +	if (!msix)
> +		goto msi_only;
> +	adapter->flags |= IGC_FLAG_HAS_MSIX;
> +
> +	/* Number of supported queues. */
> +	adapter->num_rx_queues = adapter->rss_queues;
> +
> +	adapter->num_tx_queues = adapter->rss_queues;
> +
> +	/* start with one vector for every Rx queue */
> +	numvecs = adapter->num_rx_queues;
> +
> +	/* if Tx handler is separate add 1 for every Tx queue */
> +	if (!(adapter->flags & IGC_FLAG_QUEUE_PAIRS))
> +		numvecs += adapter->num_tx_queues;
> +
> +	/* store the number of vectors reserved for queues */
> +	adapter->num_q_vectors = numvecs;
> +
> +	/* add 1 vector for link status interrupts */
> +	numvecs++;
> +
> +	adapter->msix_entries = kcalloc(numvecs, sizeof(struct msix_entry),
> +					GFP_KERNEL);
> +
> +	if (!adapter->msix_entries)
> +		return;
> +
> +	/*populate entry values*/
> +	for (i = 0; i < numvecs; i++)
> +		adapter->msix_entries[i].entry = i;
> +
> +	err = pci_enable_msix_range(adapter->pdev,
> +				    adapter->msix_entries,
> +				    numvecs,
> +				    numvecs);

Since you have no flexibility here, use pci_enable_msix_exact() instead.

> +	if (err > 0)
> +		return;
> +
> +	kfree(adapter->msix_entries);
> +	adapter->msix_entries = NULL;
> +
> +	igc_reset_interrupt_capability(adapter);
> +
> +msi_only:
> +	adapter->flags &= ~IGC_FLAG_HAS_MSIX;
> +
> +	adapter->rss_queues = 1;
> +	adapter->flags |= IGC_FLAG_QUEUE_PAIRS;
> +	adapter->num_rx_queues = 1;
> +	adapter->num_tx_queues = 1;
> +	adapter->num_q_vectors = 1;
> +	if (!pci_enable_msi(adapter->pdev))
> +		adapter->flags |= IGC_FLAG_HAS_MSI;
> +}
> +
> +static void igc_add_ring(struct igc_ring *ring,
> +			 struct igc_ring_container *head)
> +{
> +	head->ring = ring;
> +	head->count++;
> +}
> +
> +/**
> + *  igc_alloc_q_vector - Allocate memory for a single interrupt vector
> + *  @adapter: board private structure to initialize
> + *  @v_count: q_vectors allocated on adapter, used for ring interleaving
> + *  @v_idx: index of vector in adapter struct
> + *  @txr_count: total number of Tx rings to allocate
> + *  @txr_idx: index of first Tx ring to allocate
> + *  @rxr_count: total number of Rx rings to allocate
> + *  @rxr_idx: index of first Rx ring to allocate
> + *
> + *  We allocate one q_vector.  If allocation fails we return -ENOMEM.
> + **/
> +static int igc_alloc_q_vector(struct igc_adapter *adapter,
> +			      unsigned int v_count, unsigned int v_idx,
> +			      unsigned int txr_count, unsigned int txr_idx,
> +			      unsigned int rxr_count, unsigned int rxr_idx)
> +{
> +	struct igc_q_vector *q_vector;
> +	struct igc_ring *ring;
> +	int ring_count, size;
> +
> +	/* igc only supports 1 Tx and/or 1 Rx queue per vector */
> +	if (txr_count > 1 || rxr_count > 1)
> +		return -ENOMEM;
> +
> +	ring_count = txr_count + rxr_count;
> +	size = sizeof(struct igc_q_vector) +
> +		(sizeof(struct igc_ring) * ring_count);
> +
> +	/* allocate q_vector and rings */
> +	q_vector = adapter->q_vector[v_idx];
> +	if (!q_vector)
> +		q_vector = kzalloc(size, GFP_KERNEL);
> +	else
> +		memset(q_vector, 0, size);
> +	if (!q_vector)
> +		return -ENOMEM;
> +
> +	/* initialize NAPI */
> +	netif_napi_add(adapter->netdev, &q_vector->napi,
> +		       igc_poll, 64);
> +
> +	/* tie q_vector and adapter together */
> +	adapter->q_vector[v_idx] = q_vector;
> +	q_vector->adapter = adapter;
> +
> +	/* initialize work limits */
> +	q_vector->tx.work_limit = adapter->tx_work_limit;
> +
> +	/* initialize ITR configuration */
> +	q_vector->itr_register = adapter->io_addr + E1000_EITR(0);
> +	q_vector->itr_val = IGC_START_ITR;
> +
> +	/* initialize pointer to rings */
> +	ring = q_vector->ring;
> +
> +	/* initialize ITR */
> +	if (rxr_count) {
> +		/* rx or rx/tx vector */
> +		if (!adapter->rx_itr_setting || adapter->rx_itr_setting > 3)
> +			q_vector->itr_val = adapter->rx_itr_setting;
> +	} else {
> +		/* tx only vector */
> +		if (!adapter->tx_itr_setting || adapter->tx_itr_setting > 3)
> +			q_vector->itr_val = adapter->tx_itr_setting;
> +	}
> +
> +	if (txr_count) {
> +		/* assign generic ring traits */
> +		ring->dev = &adapter->pdev->dev;
> +		ring->netdev = adapter->netdev;
> +
> +		/* configure backlink on ring */
> +		ring->q_vector = q_vector;
> +
> +		/* update q_vector Tx values */
> +		igc_add_ring(ring, &q_vector->tx);
> +
> +		/* apply Tx specific ring traits */
> +		ring->count = adapter->tx_ring_count;
> +		ring->queue_index = txr_idx;
> +
> +		/* assign ring to adapter */
> +		adapter->tx_ring[txr_idx] = ring;
> +
> +		/* push pointer to next ring */
> +		ring++;
> +	}
> +
> +	if (rxr_count) {
> +		/* assign generic ring traits */
> +		ring->dev = &adapter->pdev->dev;
> +		ring->netdev = adapter->netdev;
> +
> +		/* configure backlink on ring */
> +		ring->q_vector = q_vector;
> +
> +		/* update q_vector Rx values */
> +		igc_add_ring(ring, &q_vector->rx);
> +
> +		/* apply Rx specific ring traits */
> +		ring->count = adapter->rx_ring_count;
> +		ring->queue_index = rxr_idx;
> +
> +		/* assign ring to adapter */
> +		adapter->rx_ring[rxr_idx] = ring;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + *  igc_alloc_q_vectors - Allocate memory for interrupt vectors
> + *  @adapter: board private structure to initialize
> + *
> + *  We allocate one q_vector per queue interrupt.  If allocation fails we
> + *  return -ENOMEM.
> + **/
> +static int igc_alloc_q_vectors(struct igc_adapter *adapter)
> +{
> +	int q_vectors = adapter->num_q_vectors;
> +	int rxr_remaining = adapter->num_rx_queues;
> +	int txr_remaining = adapter->num_tx_queues;
> +	int rxr_idx = 0, txr_idx = 0, v_idx = 0;
> +	int err;

reverse xmas tree

> +
> +	if (q_vectors >= (rxr_remaining + txr_remaining)) {
> +		for (; rxr_remaining; v_idx++) {
> +			err = igc_alloc_q_vector(adapter, q_vectors, v_idx,
> +						 0, 0, 1, rxr_idx);
> +
> +		if (err)
> +			goto err_out;
> +
> +		/* update counts and index */
> +		rxr_remaining--;
> +		rxr_idx++;
> +		}

There's something funky in your indent here.

> +	}
> +
> +	for (; v_idx < q_vectors; v_idx++) {
> +		int rqpv = DIV_ROUND_UP(rxr_remaining, q_vectors - v_idx);
> +		int tqpv = DIV_ROUND_UP(txr_remaining, q_vectors - v_idx);
> +
> +		err = igc_alloc_q_vector(adapter, q_vectors, v_idx,
> +					 tqpv, txr_idx, rqpv, rxr_idx);
> +
> +		if (err)
> +			goto err_out;
> +
> +		/* update counts and index */
> +		rxr_remaining -= rqpv;
> +		txr_remaining -= tqpv;
> +		rxr_idx++;
> +		txr_idx++;
> +	}
> +
> +	return 0;
> +
> +err_out:
> +	adapter->num_tx_queues = 0;
> +	adapter->num_rx_queues = 0;
> +	adapter->num_q_vectors = 0;
> +
> +	while (v_idx--)
> +		igc_free_q_vector(adapter, v_idx);
> +
> +	return -ENOMEM;
> +}
> +
> +/**
> + *  igc_init_interrupt_scheme - initialize interrupts, allocate queues/vectors
> + *  @adapter: Pointer to adapter structure
> + *
> + *  This function initializes the interrupts and allocates all of the queues.
> + **/
> +static int igc_init_interrupt_scheme(struct igc_adapter *adapter, bool msix)
> +{
> +	struct pci_dev *pdev = adapter->pdev;
> +	int err = 0;
> +
> +	igc_set_interrupt_capability(adapter, msix);
> +
> +	err = igc_alloc_q_vectors(adapter);
> +	if (err) {
> +		dev_err(&pdev->dev, "Unable to allocate memory for vectors\n");
> +		goto err_alloc_q_vectors;
> +	}
> +
> +	/* TODO complete igc_cache_ring_register */
> +
> +	return 0;
> +
> +err_alloc_q_vectors:
> +	igc_reset_interrupt_capability(adapter);
> +	return err;
> +}
> +
> +static void igc_free_irq(struct igc_adapter *adapter)
> +{
> +	if (adapter->msix_entries) {
> +		int vector = 0, i;
> +
> +	free_irq(adapter->msix_entries[vector++].vector, adapter);
> +
> +	for (i = 0; i < adapter->num_q_vectors; i++)
> +		free_irq(adapter->msix_entries[vector++].vector,
> +			 adapter->q_vector[i]);

Check your indent and {}'s

> +	} else {
> +		free_irq(adapter->pdev->irq, adapter);
> +	}
> +}
> +
> +/**
> + *  igc_irq_disable - Mask off interrupt generation on the NIC
> + *  @adapter: board private structure
> + **/
> +static void igc_irq_disable(struct igc_adapter *adapter)
> +{
> +	struct e1000_hw *hw = &adapter->hw;
> +
> +	if (adapter->msix_entries) {
> +		u32 regval = rd32(E1000_EIAM);
> +
> +		wr32(E1000_EIAM, regval & ~adapter->eims_enable_mask);
> +		wr32(E1000_EIMC, adapter->eims_enable_mask);
> +		regval = rd32(E1000_EIAC);
> +		wr32(E1000_EIAC, regval & ~adapter->eims_enable_mask);
> +	}
> +
> +	wr32(E1000_IAM, 0);
> +	wr32(E1000_IMC, ~0);
> +	wrfl();
> +
> +	if (adapter->msix_entries) {
> +		int vector = 0, i;
> +
> +		synchronize_irq(adapter->msix_entries[vector++].vector);
> +
> +		for (i = 0; i < adapter->num_q_vectors; i++)
> +			synchronize_irq(adapter->msix_entries[vector++].vector);
> +	} else {
> +		synchronize_irq(adapter->pdev->irq);
> +	}
> +}
> +
> +/**
> + *  igc_irq_enable - Enable default interrupt generation settings
> + *  @adapter: board private structure
> + **/
> +static void igc_irq_enable(struct igc_adapter *adapter)
> +{
> +	struct e1000_hw *hw = &adapter->hw;
> +
> +	if (adapter->msix_entries) {
> +		u32 ims = E1000_IMS_LSC | E1000_IMS_DOUTSYNC | E1000_IMS_DRSTA;
> +		u32 regval = rd32(E1000_EIAC);
> +
> +		wr32(E1000_EIAC, regval | adapter->eims_enable_mask);
> +		regval = rd32(E1000_EIAM);
> +		wr32(E1000_EIAM, regval | adapter->eims_enable_mask);
> +		wr32(E1000_EIMS, adapter->eims_enable_mask);
> +		wr32(E1000_IMS, ims);
> +	} else {
> +		wr32(E1000_IMS, IMS_ENABLE_MASK | E1000_IMS_DRSTA);
> +		wr32(E1000_IAM, IMS_ENABLE_MASK | E1000_IMS_DRSTA);
> +	}
> +}
> +
> +/**
> + *  igc_request_irq - initialize interrupts
> + *  @adapter: Pointer to adapter structure
> + *
> + *  Attempts to configure interrupts using the best available
> + *  capabilities of the hardware and kernel.
> + **/
> +static int igc_request_irq(struct igc_adapter *adapter)
> +{
> +	int err = 0;
> +
> +	if (adapter->flags & IGC_FLAG_HAS_MSIX) {
> +		err = igc_request_msix(adapter);
> +		if (!err)
> +			goto request_done;
> +		/* fall back to MSI */
> +		/* TODO complete free tx/rx resources */
> +
> +		igc_clear_interrupt_scheme(adapter);
> +		err = igc_init_interrupt_scheme(adapter, false);
> +		if (err)
> +			goto request_done;
> +		/* TODO complete setup tx/rx resources */
> +		igc_configure(adapter);
> +	}
> +
> +request_done:
> +	return err;
> +}
> +
> +static irqreturn_t igc_msix_ring(int irq, void *data)
> +{
> +	struct igc_q_vector *q_vector = data;
> +
> +	/* Write the ITR value calculated from the previous interrupt. */
> +	igc_write_itr(q_vector);
> +
> +	napi_schedule(&q_vector->napi);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static void igc_write_itr(struct igc_q_vector *q_vector)
> +{
> +	u32 itr_val = q_vector->itr_val & 0x7FFC;

Can we use a #define for this mask value?

> +
> +	if (!q_vector->set_itr)
> +		return;
> +
> +	if (!itr_val)
> +		itr_val = 0x4;

It would be nice to have these values as named #defines as well, or 
enums... whatever.

> +
> +	itr_val |= E1000_EITR_CNT_IGNR;
> +
> +	writel(itr_val, q_vector->itr_register);
> +	q_vector->set_itr = 0;
> +}
> +
> +/**
> + *  igc_open - Called when a network interface is made active
> + *  @netdev: network interface device structure
> + *
> + *  Returns 0 on success, negative value on failure
> + *
> + *  The open entry point is called when a network interface is made
> + *  active by the system (IFF_UP).  At this point all resources needed
> + *  for transmit and receive operations are allocated, the interrupt
> + *  handler is registered with the OS, the watchdog timer is started,
> + *  and the stack is notified that the interface is ready.
>    **/
>   static int __igc_open(struct net_device *netdev, bool resuming)
>   {
>   	struct igc_adapter *adapter = netdev_priv(netdev);
>   	struct e1000_hw *hw = &adapter->hw;
>   	int i = 0;
> +	int err = 0;

reverse xmas tree

>   
>   	/* disallow open during test */
>   
> @@ -334,17 +1336,41 @@ static int __igc_open(struct net_device *netdev, bool resuming)
>   
>   	igc_configure(adapter);
>   
> +	err = igc_request_irq(adapter);
> +	if (err)
> +		goto err_req_irq;
> +
> +	/* Notify the stack of the actual queue counts. */
> +	netif_set_real_num_tx_queues(netdev, adapter->num_tx_queues);

Perhaps you can check for a possible error return here as you do for the 
next line?

> +
> +	err = netif_set_real_num_rx_queues(netdev, adapter->num_rx_queues);
> +	if (err)
> +		goto err_set_queues;
> +
>   	/* From here on the code is the same as igc_up() */
>   	clear_bit(__IGC_DOWN, &adapter->state);
>   
>   	for (i = 0; i < adapter->num_q_vectors; i++)
>   		napi_enable(&adapter->q_vector[i]->napi);
>   
> +	/* Clear any pending interrupts. */
> +	rd32(E1000_ICR);
> +	igc_irq_enable(adapter);
> +
>   	/* start the watchdog. */
>   	hw->mac.get_link_status = 1;
>   	schedule_work(&adapter->watchdog_task);
>   
>   	return E1000_SUCCESS;
> +
> +err_set_queues:
> +	igc_free_irq(adapter);
> +err_req_irq:
> +	igc_release_hw_control(adapter);
> +	igc_power_down_link(adapter);
> +	/* TODO complete free_all_rx_resources */
> +
> +	return err;
>   }
>   
>   int igc_open(struct net_device *netdev)
> @@ -353,15 +1379,15 @@ int igc_open(struct net_device *netdev)
>   }
>   
>   /**
> - * igc_close - Disables a network interface
> - * @netdev: network interface device structure
> + *  igc_close - Disables a network interface
> + *  @netdev: network interface device structure
>    *
> - * Returns 0, this is not allowed to fail
> + *  Returns 0, this is not allowed to fail
>    *
> - * The close entry point is called when an interface is de-activated
> - * by the OS.  The hardware is still under the driver's control, but
> - * needs to be disabled.  A global MAC reset is issued to stop the
> - * hardware, and all transmit and receive resources are freed.
> + *  The close entry point is called when an interface is de-activated
> + *  by the OS.  The hardware is still under the driver's control, but
> + *  needs to be disabled.  A global MAC reset is issued to stop the
> + *  hardware, and all transmit and receive resources are freed.
>    **/
>   static int __igc_close(struct net_device *netdev, bool suspending)
>   {
> @@ -373,6 +1399,8 @@ static int __igc_close(struct net_device *netdev, bool suspending)
>   
>   	igc_release_hw_control(adapter);
>   
> +	igc_free_irq(adapter);
> +
>   	return 0;
>   }
>   
> @@ -605,6 +1633,8 @@ static int igc_probe(struct pci_dev *pdev,
>   err_register:
>   	igc_release_hw_control(adapter);
>   err_sw_init:
> +	igc_clear_interrupt_scheme(adapter);
> +	iounmap(adapter->io_addr);
>   err_ioremap:
>   	free_netdev(netdev);
>   err_alloc_etherdev:
> @@ -682,6 +1712,14 @@ static int igc_sw_init(struct igc_adapter *adapter)
>   	adapter->max_frame_size = netdev->mtu + ETH_HLEN + ETH_FCS_LEN +
>   					VLAN_HLEN;
>   
> +	if (igc_init_interrupt_scheme(adapter, true)) {
> +		dev_err(&pdev->dev, "Unable to allocate memory for queues\n");
> +		return -ENOMEM;
> +	}
> +
> +	/* Explicitly disable IRQ since the NIC can be in any state. */
> +	igc_irq_disable(adapter);
> +
>   	set_bit(__IGC_DOWN, &adapter->state);
>   
>   	return 0;
> 
