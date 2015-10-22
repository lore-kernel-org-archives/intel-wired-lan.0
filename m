From: walter harms <wharms@bfs.de>
Date: Thu, 22 Oct 2015 13:52:38 +0200
Subject: [Intel-wired-lan] [patch] igbvf: integer overflow in
	igbvf_change_mtu()
In-Reply-To: <20151022091013.GC9202@mwanda>
References: <20151022091013.GC9202@mwanda>
Message-ID: <5628CE06.4070601@bfs.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



Am 22.10.2015 11:10, schrieb Dan Carpenter:
> The "new_mtu" is between 0 and INT_MAX but when we add ETH_HLEN and
> ETH_FCS_LEN to it then it could overflow so "max_frame" is negative.  We
> cap the upper bound of "max_frame" but we don't check for negative
> values.  This leads to a static checker warning.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> diff --git a/drivers/net/ethernet/intel/igbvf/netdev.c b/drivers/net/ethernet/intel/igbvf/netdev.c
> index 297af80..fa338e0 100644
> --- a/drivers/net/ethernet/intel/igbvf/netdev.c
> +++ b/drivers/net/ethernet/intel/igbvf/netdev.c
> @@ -2350,7 +2350,7 @@ static struct net_device_stats *igbvf_get_stats(struct net_device *netdev)
>  static int igbvf_change_mtu(struct net_device *netdev, int new_mtu)
>  {
>  	struct igbvf_adapter *adapter = netdev_priv(netdev);
> -	int max_frame = new_mtu + ETH_HLEN + ETH_FCS_LEN;
> +	unsigned int max_frame = new_mtu + ETH_HLEN + ETH_FCS_LEN;
>  
>  	if (new_mtu < 68 || new_mtu > INT_MAX - ETH_HLEN - ETH_FCS_LEN ||
>  	    max_frame > MAX_JUMBO_FRAME_SIZE)

Perhaps it is better to use MAX_JUMBO_FRAME_SIZE.

max_frame = new_mtu + ETH_HLEN + ETH_FCS_LEN = MAX_JUMBO_FRAME_SIZE // max valid

new_mtu=MAX_JUMBO_FRAME_SIZE-ETH_HLEN-ETH_FCS_LEN

so you can avoid adding a "new" variable INT_MAX into this context.

Note: perhaps it would be better for the flow the check new_mtu before
calculating max_frame.

btw: can someone add a comment about the magic 68 ? is there something like a min_frame_size ?
(it is a real question i have no idea)

re,
 wh

> --
> To unsubscribe from this list: send the line "unsubscribe kernel-janitors" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
