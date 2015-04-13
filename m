From: Alexander Duyck <alexander.h.duyck@redhat.com>
Date: Mon, 13 Apr 2015 08:27:46 -0700
Subject: [Intel-wired-lan] [PATCH v4] e1000e i219 fix unit hang on reset
 and runtime D3
In-Reply-To: <1428793566-14375-1-git-send-email-yanirx.lubetkin@intel.com>
References: <1428793566-14375-1-git-send-email-yanirx.lubetkin@intel.com>
Message-ID: <552BE072.5080509@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 04/11/2015 04:06 PM, Yanir Lubetkin wrote:
> unit hang may occur if multiple descriptors are available in the rings during
> reset or runtime suspend. This state can be detected by testing the PCI config
> space register FEXTNVM7 bit 8 (0x100 mask). if this bit is on, and there are
> pending descriptors in one of the rings, we must flush them prior to reset.
> same goes for entering runtime suspend.
>
> Signed-off-by: Yanir Lubetkin <yanirx.lubetkin@intel.com>
> ---
>   drivers/net/ethernet/intel/e1000e/ich8lan.h |   5 ++
>   drivers/net/ethernet/intel/e1000e/netdev.c  | 101 ++++++++++++++++++++++++++++
>   drivers/net/ethernet/intel/e1000e/regs.h    |   1 +
>   3 files changed, 107 insertions(+)
>
> diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.h b/drivers/net/ethernet/intel/e1000e/ich8lan.h
> index 770a573..69c4dbe 100644
> --- a/drivers/net/ethernet/intel/e1000e/ich8lan.h
> +++ b/drivers/net/ethernet/intel/e1000e/ich8lan.h
> @@ -100,6 +100,11 @@
>   #define E1000_FEXTNVM7_DISABLE_PB_READ	0x00040000
>   
>   #define E1000_FEXTNVM7_DISABLE_SMB_PERST	0x00000020
> +#define E1000_FEXTNVM7_NEED_DESCRING_FLUSH     0x00000100
> +#define E1000_FEXTNVM11_DISABLE_MULR_FIX       0x00002000
> +
> +/* bit24: RXDCTL thresholds granularity: 0 - cache lines, 1 - descriptors */
> +#define E1000_RXDCTL_THRESH_UNIT_DESC 0x01000000
>   
>   #define K1_ENTRY_LATENCY	0
>   #define K1_MIN_TIME		1
> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
> index 74ec185..4880a23 100644
> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> @@ -3788,6 +3788,105 @@ static void e1000_power_down_phy(struct e1000_adapter *adapter)
>   }
>   
>   /**
> + * e1000_flush_tx_ring - remove all descriptors from the tx_ring
> + *
> + * We want to clear all pending descriptors from the TX ring.
> + * zeroing happens when the HW reads the regs. We  assign the ring itself as
> + * the data of the next descriptor. We don't care about the data we are about
> + * to reset the HW.
> + */
> +static void e1000_flush_tx_ring(struct e1000_adapter *adapter)
> +{
> +	struct e1000_hw *hw = &adapter->hw;
> +	struct e1000_ring *tx_ring = adapter->tx_ring;
> +	struct e1000_tx_desc *tx_desc = NULL;
> +	u32 tctl, txd_lower = E1000_TXD_CMD_IFCS;
> +	u16 size = 512;
> +
> +	tctl = er32(TCTL);
> +	ew32(TCTL, tctl | E1000_TCTL_EN);
> +
> +	tx_desc =  E1000_TX_DESC(*tx_ring, tx_ring->next_to_use);
> +	tx_desc->buffer_addr = tx_ring->dma;
> +
> +	tx_desc->lower.data = cpu_to_le32(txd_lower | size);
> +	tx_desc->upper.data = 0;
> +	/* flush descriptors to memory before notifying the HW */
> +	wmb();
> +	tx_ring->next_to_use++;
> +	if (tx_ring->next_to_use == tx_ring->count)
> +		tx_ring->next_to_use = 0;
> +	ew32(TDT(0), tx_ring->next_to_use);
> +	mmiowb();
> +	usleep_range(200, 250);
> +}
> +

My concern here is what would guarantee TDT is equal to 
tx_ring->next_to_use before you start?  You seem to indicate this is 
meant to flush a stuck ring, but in the process you are only adding one 
descriptor to the end of the queue.  What is to prevent the Tx DMA 
engine from using stale data to try and read addresses that no longer 
belongs to buffers assigned to the device.

I'm not sure if it is possible, but have you considered what happens if 
you have a situation where the ring was full when this workaround is 
triggered?

This is why I still think these ring flush functions would be much 
better of being placed in e1000e_flush_descriptors.

> +/**
> + * e1000_flush_rx_ring - remove all descriptors from the rx_ring
> + *
> + * Mark all descriptors in the RX ring as consumed and disable the rx ring
> + */
> +static void e1000_flush_rx_ring(struct e1000_adapter *adapter)
> +{
> +	u32 rctl, rxdctl;
> +	struct e1000_hw *hw = &adapter->hw;
> +
> +	rctl = er32(RCTL);
> +	ew32(RCTL, rctl & ~E1000_RCTL_EN);
> +	mmiowb();
> +	usleep_range(100, 150);
> +

The proper barrier here would be an e1e_flush, not an mmiowb.

> +	rxdctl = er32(RXDCTL(0));
> +	/* zero the lower 14 bits (prefetch and host thresholds) */
> +	rxdctl &= 0xffffc000;
> +
> +	/* update thresholds: prefetch threshold to 31, host threshold to 1
> +	 * and make sure the granularity is "descriptors" and not "cache lines"
> +	 */
> +	rxdctl |= (0x1F | (1 << 8) | E1000_RXDCTL_THRESH_UNIT_DESC);
> +
> +	ew32(RXDCTL(0), rxdctl);
> +	/* momentarily enable the RX ring for the changes to take effect */
> +	ew32(RCTL, rctl | E1000_RCTL_EN);
> +	mmiowb();
> +	usleep_range(100, 150);
> +	ew32(RCTL, rctl & ~E1000_RCTL_EN);
> +}
> +

Same thing here, e1e_flush.  The mmiowb is only needed on certain 
architectures such as IA64 where writes to MMIO from one CPU can get out 
of order with others even if you use something like a spinlock. An 
e1e_flush is just a PCIe read meant to force any PCIe writes to be 
flushed to the device before you resume execution.

I'm also not sure what this is supposed to get you.  I thought in most 
cases the Rx DMA engine wouldn't do anything until a tail write 
occurred.  In the case of the Tx you are enabling things with a write to 
the tail, I'm just wondering if you need something similar for the Rx.

Also same rule here about the stale data.  What is to prevent the Rx DMA 
engine from trying to write to a skb it no longer owns?

> +/**
> + * e1000_flush_desc_rings - remove all descriptors from the descriptor rings
> + *
> + * In i219, the descriptor rings must be emptied before resetting the HW
> + * or before changing the device state to D3 during runtime (runtime PM).
> + *
> + * Failure to do this will cause the HW to enter a unit hang state which can
> + * only be released by PCI reset on the device
> + *
> + */
> +
> +static void e1000_flush_desc_rings(struct e1000_adapter *adapter)
> +{
> +	u32 hang_state;
> +	u32 fext_nvm11, tdlen;
> +	struct e1000_hw *hw = &adapter->hw;
> +
> +	/* First, disable MULR fix in FEXTNVM11 */
> +	fext_nvm11 = er32(FEXTNVM11);
> +	fext_nvm11 |= E1000_FEXTNVM11_DISABLE_MULR_FIX;
> +	ew32(FEXTNVM11, fext_nvm11);
> +	/* do nothing if we're not in faulty state, or if the queue is empty */
> +	tdlen = er32(TDLEN(0));
> +	hang_state = er32(FEXTNVM7);
> +	if ((hang_state & E1000_FEXTNVM7_NEED_DESCRING_FLUSH) || tdlen)
> +		return;
> +	e1000_flush_tx_ring(adapter);
> +	/* recheck, maybe the fault is caused by the rx ring */
> +	hang_state = er32(FEXTNVM7);
> +	if (hang_state & E1000_FEXTNVM7_NEED_DESCRING_FLUSH)
> +		e1000_flush_rx_ring(adapter);
> +}
> +
> +/**
>    * e1000e_reset - bring the hardware into a known good state
>    *
>    * This function boots the hardware and enables some settings that
> @@ -3943,6 +4042,8 @@ void e1000e_reset(struct e1000_adapter *adapter)
>   		}
>   	}
>   
> +	if (hw->mac.type == e1000_pch_spt)
> +		e1000_flush_desc_rings(adapter);
>   	/* Allow time for pending master requests to run */
>   	mac->ops.reset_hw(hw);
>   
> diff --git a/drivers/net/ethernet/intel/e1000e/regs.h b/drivers/net/ethernet/intel/e1000e/regs.h
> index 85eefc4..fdaac8e 100644
> --- a/drivers/net/ethernet/intel/e1000e/regs.h
> +++ b/drivers/net/ethernet/intel/e1000e/regs.h
> @@ -38,6 +38,7 @@
>   #define E1000_FEXTNVM4	0x00024	/* Future Extended NVM 4 - RW */
>   #define E1000_FEXTNVM6	0x00010	/* Future Extended NVM 6 - RW */
>   #define E1000_FEXTNVM7	0x000E4	/* Future Extended NVM 7 - RW */
> +#define E1000_FEXTNVM11        0x5BBC  /* Future Extended NVM 11 - RW */
>   #define E1000_PCIEANACFG	0x00F18	/* PCIE Analog Config */
>   #define E1000_FCT	0x00030	/* Flow Control Type - RW */
>   #define E1000_VET	0x00038	/* VLAN Ether Type - RW */

