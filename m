From: Saeed Mahameed <saeedm@dev.mellanox.co.il>
Date: Wed, 20 Apr 2016 20:40:22 +0300
Subject: [Intel-wired-lan] [RFC PATCH 2/5] mlx5: Add support for UDP
 tunnel segmentation with outer checksum offload
In-Reply-To: <20160419190603.11723.31623.stgit@ahduyck-xeon-server>
References: <20160419185949.11723.50506.stgit@ahduyck-xeon-server>
 <20160419190603.11723.31623.stgit@ahduyck-xeon-server>
Message-ID: <CALzJLG-8enmxxvjbVbcygVgM0VhX7Eo=6B=2pZF5jQzN9L9YEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Apr 19, 2016 at 10:06 PM, Alexander Duyck <aduyck@mirantis.com> wrote:
> This patch assumes that the mlx5 hardware will ignore existing IPv4/v6
> header fields for length and checksum as well as the length and checksum
> fields for outer UDP headers.
>
> I have no means of testing this as I do not have any mlx5 hardware but
> thought I would submit it as an RFC to see if anyone out there wants to
> test this and see if this does in fact enable this functionality allowing
> us to to segment UDP tunneled frames that have an outer checksum.
>
> Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/en_main.c |    7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> index e0adb604f461..57d8da796d50 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> @@ -2390,13 +2390,18 @@ static void mlx5e_build_netdev(struct net_device *netdev)
>         netdev->hw_features      |= NETIF_F_HW_VLAN_CTAG_FILTER;
>
>         if (mlx5e_vxlan_allowed(mdev)) {
> -               netdev->hw_features     |= NETIF_F_GSO_UDP_TUNNEL;
> +               netdev->hw_features     |= NETIF_F_GSO_UDP_TUNNEL |
> +                                          NETIF_F_GSO_UDP_TUNNEL_CSUM |
> +                                          NETIF_F_GSO_PARTIAL;
>                 netdev->hw_enc_features |= NETIF_F_IP_CSUM;
>                 netdev->hw_enc_features |= NETIF_F_RXCSUM;
>                 netdev->hw_enc_features |= NETIF_F_TSO;
>                 netdev->hw_enc_features |= NETIF_F_TSO6;
>                 netdev->hw_enc_features |= NETIF_F_RXHASH;
>                 netdev->hw_enc_features |= NETIF_F_GSO_UDP_TUNNEL;
> +               netdev->hw_enc_features |= NETIF_F_GSO_UDP_TUNNEL_CSUM |
> +                                          NETIF_F_GSO_PARTIAL;
> +               netdev->gso_partial_features = NETIF_F_GSO_UDP_TUNNEL_CSUM;
>         }
>
>         netdev->features          = netdev->hw_features;
>

Hi Alex,

Adding Matt, VxLAN feature owner from Mellanox,
Matt please correct me if am wrong, but We already tested GSO VxLAN
and we saw the TCP/IP checksum offloads for both inner and outer
headers handled by the hardware.

And looking at mlx5e_sq_xmit:

if (likely(skb->ip_summed == CHECKSUM_PARTIAL)) {
        eseg->cs_flags = MLX5_ETH_WQE_L3_CSUM;
if (skb->encapsulation) {
        eseg->cs_flags |= MLX5_ETH_WQE_L3_INNER_CSUM |
MLX5_ETH_WQE_L4_INNER_CSUM;
        sq->stats.csum_offload_inner++;
} else {
        eseg->cs_flags |= MLX5_ETH_WQE_L4_CSUM;
}

We enable inner/outer hardware checksumming unconditionally without
looking at the features Alex is suggesting in this patch,
Alex, can you elaborate more on the meaning of those features ? and
why would it work for us without declaring them ?
