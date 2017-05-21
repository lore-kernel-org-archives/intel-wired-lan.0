From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Sun, 21 May 2017 16:02:34 -0700
Subject: [Intel-wired-lan] [PATCH] ixgbe: prevent driver configuration
 changes while XDP is loaded
In-Reply-To: <20170502050634.7459.50968.stgit@john-Precision-Tower-5810>
References: <20170502050634.7459.50968.stgit@john-Precision-Tower-5810>
Message-ID: <CAKgT0UdXLpTb6LchTDs3th=6ka4x_6QPcf4PY_-u+ZeMTiGM=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, May 1, 2017 at 10:06 PM, John Fastabend
<john.fastabend@gmail.com> wrote:
> XDP checks to ensure the MTU is valid and LRO is disabled when it is
> loaded. But user configuration after XDP is loaded could change these
> and cause a misconfiguration.
>
> This patch adds checks to ensure config changes are valid.
>
> Signed-off-by: John Fastabend <john.r.fastabend@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> index ee20a2b..156357e 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> @@ -6437,6 +6437,19 @@ static void ixgbe_free_all_rx_resources(struct ixgbe_adapter *adapter)
>  static int ixgbe_change_mtu(struct net_device *netdev, int new_mtu)
>  {
>         struct ixgbe_adapter *adapter = netdev_priv(netdev);
> +       int i, frame_size = new_mtu + ETH_HLEN + ETH_FCS_LEN + VLAN_HLEN;
> +
> +       /* If XDP is running enforce MTU limitations */
> +       for (i = 0; i < adapter->num_rx_queues; i++) {
> +               struct ixgbe_ring *ring = adapter->rx_ring[i];
> +
> +               if (frame_size > ixgbe_rx_bufsz(ring)) {
> +                       e_warn(probe,
> +                              "Setting MTU > %i with XDP is not supported\n",
> +                              ixgbe_rx_bufsz(ring));
> +                       return -EINVAL;
> +               }
> +       }
>

There are a few issues with this piece.

First the Rx buffer size gets updated depending on if we are using
jumbo frames or not. We either use 1.5K or 3K to hold the contents of
the frame. Instead of using ixgbe_rx_bufsz you might just make it so
that you use IXGBE_MAX_FRAME_BUILD_SKB if the adapter flag for
LEGACY_RX is not set, otherwise you can probably just use
IXGBE_RXBUFFER_2K.

Also you should only be performing this check if xdp_prog is set and
it doesn't look like you are checking for that.

>         /*
>          * For 82599EB we cannot allow legacy VFs to enable their receive
> @@ -9291,6 +9304,10 @@ static netdev_features_t ixgbe_fix_features(struct net_device *netdev,
>         if (!(adapter->flags2 & IXGBE_FLAG2_RSC_CAPABLE))
>                 features &= ~NETIF_F_LRO;
>
> +       /* If XDP is enabled we can not enable LRO */
> +       if (adapter->xdp_prog)
> +               features &= ~NETIF_F_LRO;
> +
>         return features;
>  }
>
>
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at lists.osuosl.org
> http://lists.osuosl.org/mailman/listinfo/intel-wired-lan
