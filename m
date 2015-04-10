From: Alexander Duyck <alexander.h.duyck@redhat.com>
Date: Fri, 10 Apr 2015 09:47:35 -0700
Subject: [Intel-wired-lan] [PATCH] e1000e i219 fix unit hang on reset
 and runtime D3
In-Reply-To: <978966243-11032-1-git-send-email-yanirx.lubetkin@intel.com>
References: <978966243-11032-1-git-send-email-yanirx.lubetkin@intel.com>
Message-ID: <5527FEA7.1060200@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 01/08/2001 07:04 AM, Yanir Lubetkin wrote:

Please set your system clock before sending a patch.  This went straight 
to my archive since my mail client though the message was over 14 years old.

> unit hang may occur if multiple descriptors are available in the rings during
> reset or runtime suspend. This state can be detected by testing the PCI config
> space register FEXTNVM7 bit 8 (0x100 mask). if this bit is on, and there are
> pending descriptors in one of the rings, we must flush them prior to reset.
> same goes for entering runtime suspend.
>
> Signed-off-by: Yanir Lubetkin <yanirx.lubetkin@intel.com>
> ---
>   drivers/net/ethernet/intel/e1000e/ich8lan.h |  2 +
>   drivers/net/ethernet/intel/e1000e/netdev.c  | 94 +++++++++++++++++++++++++++++
>   drivers/net/ethernet/intel/e1000e/regs.h    |  1 +
>   3 files changed, 97 insertions(+)
>
> diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.h b/drivers/net/ethernet/intel/e1000e/ich8lan.h
> index 770a573..703f808 100644
> --- a/drivers/net/ethernet/intel/e1000e/ich8lan.h
> +++ b/drivers/net/ethernet/intel/e1000e/ich8lan.h
> @@ -101,6 +101,8 @@
>
>   #define E1000_FEXTNVM7_DISABLE_SMB_PERST	0x00000020
>
> +#define E1000_FEXTNVM11_DISABLE_MULR_FIX	0x00002000
> +
>   #define K1_ENTRY_LATENCY	0
>   #define K1_MIN_TIME		1
>   #define NVM_SIZE_MULTIPLIER 4096	/*multiplier for NVMS field */
> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
> index 4e56c31..46b5702 100644
> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> @@ -3788,6 +3788,98 @@ static void e1000_power_down_phy(struct e1000_adapter *adapter)
>   }
>
>   /**
> + * e1000_flush_tx_ring - remove all descriptors from the tx_ring
> + *
> + * force the hardware to read all the descriptors and discard them
> + * we put a descriptor with the ring itself as its data. reading
> + * the descripto contents is performing a read on all the ring entries and
> + * causes a ring flush
> + */

This description is bogus.  Based on the code below all you are doing is 
loading one descriptor with the descriptor ring as data.

> +static void e1000_flush_tx_ring(struct e1000_adapter *adapter)
> +{
> +	struct e1000_hw *hw = &adapter->hw;
> +	struct e1000_ring *tx_ring = adapter->tx_ring;
> +	struct e1000_tx_desc *tx_desc = NULL;
> +	u32 txd_lower = E1000_TXD_CMD_IFCS;
> +	u32 tctl, tdbal, tdbah;
> +	int i;
> +	u16 size = 512;
> +
> +	tctl = er32(TCTL);
> +	ew32(TCTL, tctl | E1000_TCTL_EN);

Should there be any sort of sleep after enabling the queue?

> +	tdbal = er32(TDBAL(0));
> +	tdbah = er32(TDBAH(0));

This seems problematic at best.  How can you guarantee that TDH and TDT 
are even valid?  Maybe you should use the value actually stored in 
tx_ring->dma and not trust register reads, or at least make sure the 
values match.

What guarantees that tx_ring->next_to_use is actually in sync with TDH 
and TDT?

> +	i = tx_ring->next_to_use;
> +	tx_desc = E1000_TX_DESC(*tx_ring, i);
> +	tx_desc->buffer_addr = cpu_to_le64(((u64)tdbah << 32) | tdbal);
> +	tx_desc->lower.data = cpu_to_le32(txd_lower | size);
> +	tx_desc->upper.data = 0;
> +	/* in case other processors access the descriptor ring */
> +	wmb();

The description here is invalid.  The wmb() should be here to push the 
descriptors to memory before you notify the device via an MMIO write.

> +	i++;
> +	if (i == tx_ring->count)
> +		i = 0;
> +	ew32(TDT(0), i);
> +	mmiowb();
> +	usleep_range(200);
> +}
> +

Does the value need to be stored anywhere after you have updated TDT? 
For example what happens if you call flush twice?

> +/**
> + * e1000_flush_rx_ring - remove all descriptors from the tx_ring
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

You might want to do a write flush here to guarantee the write is 
completed before you start the sleep.

> +	usleep_range(100);
> +	rxdctl = er32(RXDCTL(0));

Or you could swap the position of these two lines and get the same effect.

> +	rxdctl &= 0xffffc000;
> +	rxdctl |= (0x1F | (1 << 8) | (1 << 24));

First, please don't use magic numbers, or if you must please try to 
explain them as occurs in E1000_RXDCTL_DMA_BURST_ENABLE.  BTW the 
descriptions in E1000_RXDCTL_DMA_BURST_ENABLE appear to be wrong as well 
though the values appear to be correct.  The error is that hthresh and 
pthresh is swapped in the description.

You should probably get rid of the &= and just assign the value directly 
since your mask and the values you are setting overlap so I suspect 
either one or the other is wrong.

> +	ew32(RXDCTL(0), rxdctl);
> +	ew32(RCTL, rctl | E1000_RCTL_EN);
> +	usleep_range(100);
> +	ew32(RCTL, rctl & ~E1000_RCTL_EN);
> +}
> +

You need some write flushes before the sleep.  Otherwise this can toggle 
so fast there is no guarantee that things will occur in the correct 
order as the first write could be potentially stalled if there are other 
MMIO requests on the interface from other processors.

Also I suspect this has the potential to trigger memory corruption. 
Have you tried testing this fix w/ an IOMMU (VTd) enabled on the 
platform?  I would expect that enabling the Rx ring with uninitialized 
values, or stale values would open you up to the risk of writing garbage.

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
> +	u16 hang_state;
> +	u32 fext_nvm11, tdlen;
> +	struct e1000_hw *hw = &adapter->hw;
> +
> +	/* First, disable MULR fix in FEXTNVM11 */

Any explanation on what MULR means?  By any chance is this related to 
the Multiple Requests (MULR) workaround that was needed for TSO on 82583v?

> +	fext_nvm11 = er32(FEXTNVM11);
> +	fext_nvm11 |= E1000_FEXTNVM11_DISABLE_MULR_FIX;
> +	ew32(FEXTNVM11, fext_nvm11);

So the other FEXT registers appear to only be reset at power-on.  I'm 
assuming it is the same for this register as well.  Does this mean the 
fix that is disabled here is permanent?  If so is there any explanation 
anywhere on what the side effects will be?

> +	/* do nothing if we're not in faulty state, or if the queue is empty */
> +	tdlen = er32(TDLEN(0));

So I am assuming this is the "queue is empty" portion of the tests.  Is 
this what you are using to try and determine if the descriptor rings are 
still in sync or not?

> +	pci_read_config_word(adapter->pdev, E1000_FEXTNVM7, &hang_state);
> +	if ((hang_state & E1000_FEXTNVM7_MULR_NEED_DESCRING_FLUSH) || tdlen)
> +		return;
> +	e1000_flush_tx_ring(adapter);
> +	/* recheck, maybe the fault is caused by the rx ring */
> +	pci_read_config_word(adapter->pdev, E1000_FEXTNVM7, &hang_state);
> +	if (hang_state & E1000_FEXTNVM7_MULR_NEED_DESCRING_FLUSH)
> +		e1000_flush_rx_ring(adapter);
> +}
> +
> +/**
>    * e1000e_reset - bring the hardware into a known good state
>    *
>    * This function boots the hardware and enables some settings that
> @@ -3943,6 +4035,8 @@ void e1000e_reset(struct e1000_adapter *adapter)
>   		}
>   	}
>
> +	if (hw->mac.type == e1000_pch_spt)
> +		e1000_flush_desc_rings(adapter);
>   	/* Allow time for pending master requests to run */
>   	mac->ops.reset_hw(hw);
>
> diff --git a/drivers/net/ethernet/intel/e1000e/regs.h b/drivers/net/ethernet/intel/e1000e/regs.h
> index 85eefc4..4648754 100644
> --- a/drivers/net/ethernet/intel/e1000e/regs.h
> +++ b/drivers/net/ethernet/intel/e1000e/regs.h
> @@ -38,6 +38,7 @@
>   #define E1000_FEXTNVM4	0x00024	/* Future Extended NVM 4 - RW */
>   #define E1000_FEXTNVM6	0x00010	/* Future Extended NVM 6 - RW */
>   #define E1000_FEXTNVM7	0x000E4	/* Future Extended NVM 7 - RW */
> +#define E1000_FEXTNVM11	0x5BBC	/* Future Extended NVM 11 - RW */
>   #define E1000_PCIEANACFG	0x00F18	/* PCIE Analog Config */
>   #define E1000_FCT	0x00030	/* Flow Control Type - RW */
>   #define E1000_VET	0x00038	/* VLAN Ether Type - RW */
>

Should probably pad the value out with an extra 0 at the start in order 
to get it to align with the other values in the list.
