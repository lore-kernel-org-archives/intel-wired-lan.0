From: Michael S. Tsirkin <mst@redhat.com>
Date: Sun, 14 Mar 2021 04:56:04 -0400
Subject: [Intel-wired-lan] [net-next PATCH 07/10] virtio_net: Update
 driver to use ethtool_sprintf
In-Reply-To: <161557132651.10304.9382850626606060019.stgit@localhost.localdomain>
References: <161557111604.10304.1798900949114188676.stgit@localhost.localdomain>
 <161557132651.10304.9382850626606060019.stgit@localhost.localdomain>
Message-ID: <20210314045559-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, Mar 12, 2021 at 09:48:46AM -0800, Alexander Duyck wrote:
> From: Alexander Duyck <alexanderduyck@fb.com>
> 
> Update the code to replace instances of snprintf and a pointer update with
> just calling ethtool_sprintf.
> 
> Also replace the char pointer with a u8 pointer to avoid having to recast
> the pointer type.
> 
> Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/net/virtio_net.c |   18 +++++++-----------
>  1 file changed, 7 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index e97288dd6e5a..77ba8e2fc11c 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2138,25 +2138,21 @@ static int virtnet_set_channels(struct net_device *dev,
>  static void virtnet_get_strings(struct net_device *dev, u32 stringset, u8 *data)
>  {
>  	struct virtnet_info *vi = netdev_priv(dev);
> -	char *p = (char *)data;
>  	unsigned int i, j;
> +	u8 *p = data;
>  
>  	switch (stringset) {
>  	case ETH_SS_STATS:
>  		for (i = 0; i < vi->curr_queue_pairs; i++) {
> -			for (j = 0; j < VIRTNET_RQ_STATS_LEN; j++) {
> -				snprintf(p, ETH_GSTRING_LEN, "rx_queue_%u_%s",
> -					 i, virtnet_rq_stats_desc[j].desc);
> -				p += ETH_GSTRING_LEN;
> -			}
> +			for (j = 0; j < VIRTNET_RQ_STATS_LEN; j++)
> +				ethtool_sprintf(&p, "rx_queue_%u_%s", i,
> +						virtnet_rq_stats_desc[j].desc);
>  		}
>  
>  		for (i = 0; i < vi->curr_queue_pairs; i++) {
> -			for (j = 0; j < VIRTNET_SQ_STATS_LEN; j++) {
> -				snprintf(p, ETH_GSTRING_LEN, "tx_queue_%u_%s",
> -					 i, virtnet_sq_stats_desc[j].desc);
> -				p += ETH_GSTRING_LEN;
> -			}
> +			for (j = 0; j < VIRTNET_SQ_STATS_LEN; j++)
> +				ethtool_sprintf(&p, "tx_queue_%u_%s", i,
> +						virtnet_sq_stats_desc[j].desc);
>  		}
>  		break;
>  	}
> 

