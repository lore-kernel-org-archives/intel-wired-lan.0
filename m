From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Thu, 09 Apr 2015 20:41:58 -0700
Subject: [Intel-wired-lan] [PATCH] e1000e i219 fix unit hang on reset
 and runtime D3
In-Reply-To: <978966243-11032-1-git-send-email-yanirx.lubetkin@intel.com>
References: <978966243-11032-1-git-send-email-yanirx.lubetkin@intel.com>
Message-ID: <1428637318.2729.65.camel@jtkirshe-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 2001-01-08 at 17:04 +0200, Yanir Lubetkin wrote:
> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> @@ -3788,6 +3788,98 @@ static void e1000_power_down_phy(struct
> e1000_adapter *adapter)
>  }
>  
>  /**
> + * e1000_flush_tx_ring - remove all descriptors from the tx_ring
> + *
> + * force the hardware to read all the descriptors and discard them
> + * we put a descriptor with the ring itself as its data. reading
> + * the descripto contents is performing a read on all the ring

descriptor is mis-spelled above

>  entries and
> + * causes a ring flush
> + */
> +static void e1000_flush_tx_ring(struct e1000_adapter *adapter)
> +{
> +       struct e1000_hw *hw = &adapter->hw;
> +       struct e1000_ring *tx_ring = adapter->tx_ring;
> +       struct e1000_tx_desc *tx_desc = NULL;
> +       u32 txd_lower = E1000_TXD_CMD_IFCS;
> +       u32 tctl, tdbal, tdbah;
> +       int i;
> +       u16 size = 512;
> +
> +       tctl = er32(TCTL);
> +       ew32(TCTL, tctl | E1000_TCTL_EN);
> +       tdbal = er32(TDBAL(0));
> +       tdbah = er32(TDBAH(0));
> +       i = tx_ring->next_to_use;
> +       tx_desc = E1000_TX_DESC(*tx_ring, i);
> +       tx_desc->buffer_addr = cpu_to_le64(((u64)tdbah << 32) |
> tdbal);
> +       tx_desc->lower.data = cpu_to_le32(txd_lower | size);
> +       tx_desc->upper.data = 0;
> +       /* in case other processors access the descriptor ring */
> +       wmb();

Alex has recently added kernel interfaces dma_wmb() to replace wmb() for
at least networking drivers.  So we should be using dma_wmb() instead
here.

> +       i++;
> +       if (i == tx_ring->count)
> +               i = 0;
> +       ew32(TDT(0), i);
> +       mmiowb();
> +       usleep_range(200);
> +}
> +

The above function is written like it is looping through reading each
descriptor in a ring, but it does not loop at all.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150409/f39d54e1/attachment.asc>
