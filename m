From: Jesper Dangaard Brouer <jbrouer@redhat.com>
Date: Tue, 24 Aug 2021 15:32:40 +0200
Subject: [Intel-wired-lan] [PATCH] ixgbe: let the xdpdrv work with more
 than 64 cpus
In-Reply-To: <20210824104918.7930-1-kerneljasonxing@gmail.com>
References: <20210824104918.7930-1-kerneljasonxing@gmail.com>
Message-ID: <59dff551-2d52-5ecc-14ac-4a6ada5b1275@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 24/08/2021 12.49, kerneljasonxing at gmail.com wrote:
> From: Jason Xing <xingwanli@kuaishou.com>
> 
> Originally, ixgbe driver doesn't allow the mounting of xdpdrv if the
> server is equipped with more than 64 cpus online. So it turns out that
> the loading of xdpdrv causes the "NOMEM" failure.
> 
> Actually, we can adjust the algorithm and then make it work, which has
> no harm at all, only if we set the maxmium number of xdp queues.

This is not true, it can cause harm, because XDP transmission queues are 
used without locking. See drivers ndo_xdp_xmit function ixgbe_xdp_xmit().
As driver assumption is that each CPU have its own XDP TX-queue.

This patch is not a proper fix.

I do think we need a proper fix for this issue on ixgbe.


> Fixes: 33fdc82f08 ("ixgbe: add support for XDP_TX action")
> Co-developed-by: Shujin Li <lishujin@kuaishou.com>
> Signed-off-by: Shujin Li <lishujin@kuaishou.com>
> Signed-off-by: Jason Xing <xingwanli@kuaishou.com>
> ---
>   drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c  | 2 +-
>   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 3 ---
>   2 files changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
> index 0218f6c..5953996 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
> @@ -299,7 +299,7 @@ static void ixgbe_cache_ring_register(struct ixgbe_adapter *adapter)
>   
>   static int ixgbe_xdp_queues(struct ixgbe_adapter *adapter)
>   {
> -	return adapter->xdp_prog ? nr_cpu_ids : 0;
> +	return adapter->xdp_prog ? min_t(int, MAX_XDP_QUEUES, nr_cpu_ids) : 0;
>   }
>   
>   #define IXGBE_RSS_64Q_MASK	0x3F
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> index 14aea40..b36d16b 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> @@ -10130,9 +10130,6 @@ static int ixgbe_xdp_setup(struct net_device *dev, struct bpf_prog *prog)
>   			return -EINVAL;
>   	}
>   
> -	if (nr_cpu_ids > MAX_XDP_QUEUES)
> -		return -ENOMEM;
> -
>   	old_prog = xchg(&adapter->xdp_prog, prog);
>   	need_reset = (!!prog != !!old_prog);
>   
> 

