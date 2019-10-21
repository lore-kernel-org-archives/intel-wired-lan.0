From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 21 Oct 2019 10:42:17 -0700
Subject: [Intel-wired-lan] [PATCH] igb: dont drop packets if rx flow
 control is enabled
In-Reply-To: <20191021163959.17511-1-bob.beckett@collabora.com>
References: <20191021163959.17511-1-bob.beckett@collabora.com>
Message-ID: <CAKgT0UfKKUnb97Wh7kwBpVsZzF2Ust5vg1SSNOeJtjz0jE8fhA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Oct 21, 2019 at 9:44 AM Robert Beckett
<bob.beckett@collabora.com> wrote:
>
> If rx flow control has been enabled (via autoneg or forced), packets
> should not be dropped due to rx descriptor ring exhaustion. Instead
> pause frames should be used to apply back pressure.
>
> Move SRRCTL setup to its own function for easy reuse and only set drop
> enable bit if rx flow control is not enabled.
>
> Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
> ---
>  drivers/net/ethernet/intel/igb/igb.h         |  1 +
>  drivers/net/ethernet/intel/igb/igb_ethtool.c |  8 ++++
>  drivers/net/ethernet/intel/igb/igb_main.c    | 46 ++++++++++++++------
>  3 files changed, 41 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
> index ca54e268d157..49b5fa9d4783 100644
> --- a/drivers/net/ethernet/intel/igb/igb.h
> +++ b/drivers/net/ethernet/intel/igb/igb.h
> @@ -661,6 +661,7 @@ void igb_configure_tx_ring(struct igb_adapter *, struct igb_ring *);
>  void igb_configure_rx_ring(struct igb_adapter *, struct igb_ring *);
>  void igb_setup_tctl(struct igb_adapter *);
>  void igb_setup_rctl(struct igb_adapter *);
> +void igb_setup_srrctl(struct igb_adapter *, struct igb_ring *);
>  netdev_tx_t igb_xmit_frame_ring(struct sk_buff *, struct igb_ring *);
>  void igb_alloc_rx_buffers(struct igb_ring *, u16);
>  void igb_update_stats(struct igb_adapter *);
> diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
> index 5acf3b743876..3c951f363d0e 100644
> --- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
> +++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
> @@ -396,6 +396,7 @@ static int igb_set_pauseparam(struct net_device *netdev,
>         struct igb_adapter *adapter = netdev_priv(netdev);
>         struct e1000_hw *hw = &adapter->hw;
>         int retval = 0;
> +       int i;
>
>         /* 100basefx does not support setting link flow control */
>         if (hw->dev_spec._82575.eth_flags.e100_base_fx)
> @@ -428,6 +429,13 @@ static int igb_set_pauseparam(struct net_device *netdev,
>
>                 retval = ((hw->phy.media_type == e1000_media_type_copper) ?
>                           igb_force_mac_fc(hw) : igb_setup_link(hw));
> +
> +               /* Make sure SRRCTL considers new fc settings for each ring */
> +               for (i = 0; i < adapter->num_rx_queues; i++) {
> +                       struct igb_ring *ring = adapter->rx_ring[i];
> +
> +                       igb_setup_srrctl(adapter, ring);
> +               }
>         }

So one issue here is that this is going through and toggling things in
the case that SR-IOV is enabled. We likely should not be doing that.
If SR-IOV is enabled we should always have the DROP_EN bit set.
Otherwise we run the risk of soft-locking the part since a single
stopped Rx ring can cause both Tx and Rx to fail due to internal
switching of the part.

>
>         clear_bit(__IGB_RESETTING, &adapter->state);
> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> index ffaa6e031632..6b04c961c6e4 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -4488,6 +4488,36 @@ static inline void igb_set_vmolr(struct igb_adapter *adapter,
>         wr32(E1000_VMOLR(vfn), vmolr);
>  }
>
> +/**
> + *  igb_setup_srrctl - configure the split and replication receive control
> + *                    registers
> + *  @adapter: Board private structure
> + *  @ring: receive ring to be configured
> + **/
> +void igb_setup_srrctl(struct igb_adapter *adapter, struct igb_ring *ring)
> +{
> +       struct e1000_hw *hw = &adapter->hw;
> +       int reg_idx = ring->reg_idx;
> +       u32 srrctl;
> +
> +       srrctl = IGB_RX_HDR_LEN << E1000_SRRCTL_BSIZEHDRSIZE_SHIFT;
> +       if (ring_uses_large_buffer(ring))
> +               srrctl |= IGB_RXBUFFER_3072 >> E1000_SRRCTL_BSIZEPKT_SHIFT;
> +       else
> +               srrctl |= IGB_RXBUFFER_2048 >> E1000_SRRCTL_BSIZEPKT_SHIFT;
> +       srrctl |= E1000_SRRCTL_DESCTYPE_ADV_ONEBUF;
> +       if (hw->mac.type >= e1000_82580)
> +               srrctl |= E1000_SRRCTL_TIMESTAMP;
> +       /* Only set Drop Enable if we are supporting multiple queues
> +        * and rx flow control is disabled
> +        */
> +       if (!(hw->fc.current_mode & e1000_fc_rx_pause) &&
> +           (adapter->vfs_allocated_count || adapter->num_rx_queues > 1))
> +               srrctl |= E1000_SRRCTL_DROP_EN;
> +
> +       wr32(E1000_SRRCTL(reg_idx), srrctl);
> +}

I would recommend making the criteria that either you have VFs
allocated or more than one queue and flow control enabled. In the
SR-IOV case I would never recommend letting any Rx queue not have the
DROP_EN bit set. The reason being that Tx can be stopped if it is
waiting on the Rx FIFO to become available for a frame that must be
switched from Tx to Rx.

Also, from everything I have seen this can negatively impact
performance as one overused queue can drag down the performance for
all other queues.
