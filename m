From: Alexander Duyck <alexander.h.duyck@redhat.com>
Date: Fri, 10 Apr 2015 09:54:24 -0700
Subject: [Intel-wired-lan] [PATCH v2] e1000e i219 fix unit hang on reset
 and runtime D3
In-Reply-To: <979014366-12063-1-git-send-email-yanirx.lubetkin@intel.com>
References: <979014366-12063-1-git-send-email-yanirx.lubetkin@intel.com>
Message-ID: <55280040.3040306@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 01/08/2001 08:26 PM, Yanir Lubetkin wrote:
> From: Yanir Lubetkin <yanir@galilsoft.com>
>
> unit hang may occur if multiple descriptors are available in the rings during
> reset or runtime suspend. This state can be detected by testing the PCI config
> space register FEXTNVM7 bit 8 (0x100 mask). if this bit is on, and there are
> pending descriptors in one of the rings, we must flush them prior to reset.
> same goes for entering runtime suspend.
>
> Signed-off-by: Yanir Lubetkin <yanir@galilsoft.com>
> ---
>   drivers/net/ethernet/intel/e1000e/ich8lan.h |  2 +
>   drivers/net/ethernet/intel/e1000e/netdev.c  | 94 +++++++++++++++++++++++++++++
>   drivers/net/ethernet/intel/e1000e/regs.h    |  1 +
>   3 files changed, 97 insertions(+)
>
> diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.h b/drivers/net/ethernet/intel/e1000e/ich8lan.h
> index 770a573..68314db 100644
> --- a/drivers/net/ethernet/intel/e1000e/ich8lan.h
> +++ b/drivers/net/ethernet/intel/e1000e/ich8lan.h
> @@ -101,6 +101,8 @@
>
>   #define E1000_FEXTNVM7_DISABLE_SMB_PERST	0x00000020
>
> +#define E1000_FEXTNVM11_DISABLE_MULR_FIX       0x00002000
> +
>   #define K1_ENTRY_LATENCY	0
>   #define K1_MIN_TIME		1
>   #define NVM_SIZE_MULTIPLIER 4096	/*multiplier for NVMS field */
> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
> index 74ec185..9ba0d7e 100644
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
> + * the descriptor contents is performing a read on all the ring entries and
> + * causes a ring flush
> + */
> +static void e1000_flush_tx_ring(struct e1000_adapter *adapter)
> +{
> +       struct e1000_hw *hw = &adapter->hw;
> +       struct e1000_ring *tx_ring = adapter->tx_ring;
> +       struct e1000_tx_desc *tx_desc = NULL;
> +       u32 txd_lower = E1000_TXD_CMD_IFCS;
> +       u32 tctl, tdbal, tdbah;
> +       int next_to_use;
> +       u16 size = 512;
> +
> +       tctl = er32(TCTL);
> +       ew32(TCTL, tctl | E1000_TCTL_EN);
> +       tdbal = er32(TDBAL(0));
> +       tdbah = er32(TDBAH(0));
> +       next_to_use = tx_ring->next_to_use;
> +       tx_desc = E1000_TX_DESC(*tx_ring, next_to_use);
> +       tx_desc->buffer_addr = cpu_to_le64(((u64)tdbah << 32) | tdbal);
> +       tx_desc->lower.data = cpu_to_le32(txd_lower | size);
> +       tx_desc->upper.data = 0;
> +       /* in case other processors access the descriptor ring */
> +       dma_wmb();

You had it right the first time.  It should be wmb(), but the comment is 
wrong.  It is supposed to be there to guarantee the descriptor write is 
complete before notifying the device of new descriptors.

- Alex
