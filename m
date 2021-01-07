From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 7 Jan 2021 10:47:16 -0800
Subject: [Intel-wired-lan] [PATCH net-next v1 1/2] net: core: count
 drops from GRO
In-Reply-To: <20210106215539.2103688-2-jesse.brandeburg@intel.com>
References: <20210106215539.2103688-1-jesse.brandeburg@intel.com>
 <20210106215539.2103688-2-jesse.brandeburg@intel.com>
Message-ID: <5badc441-6de9-54cf-2b72-d67572cbb105@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 1/6/2021 1:55 PM, Jesse Brandeburg wrote:
> When drivers call the various receive upcalls to receive an skb
> to the stack, sometimes that stack can drop the packet. The good
> news is that the return code is given to all the drivers of
> NET_RX_DROP or GRO_DROP. The bad news is that no drivers except
> the one "ice" driver that I changed, check the stat and increment
> the dropped count. This is currently leading to packets that
> arrive at the edge interface and are fully handled by the driver
> and then mysteriously disappear.
> 
> Rather than fix all drivers to increment the drop stat when
> handling the return code, emulate the already existing statistic
> update for NET_RX_DROP events for the two GRO_DROP locations, and
> increment the dev->rx_dropped associated with the skb.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jamal Hadi Salim <jhs@mojatatu.com>
> ---
>  net/core/dev.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 8fa739259041..ef34043a9550 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -6071,6 +6071,7 @@ static gro_result_t napi_skb_finish(struct napi_struct *napi,
>  		break;
>  
>  	case GRO_DROP:
> +		atomic_long_inc(&skb->dev->rx_dropped);
>  		kfree_skb(skb);
>  		break;

Would it makes sense to have this be a different stat? or is it really
basically the same as the existing rx_dropped, so treating it
differently wouldn't make much sense..

>  
> @@ -6159,6 +6160,7 @@ static gro_result_t napi_frags_finish(struct napi_struct *napi,
>  		break;
>  
>  	case GRO_DROP:
> +		atomic_long_inc(&skb->dev->rx_dropped);
>  		napi_reuse_skb(napi, skb);
>  		break;
>  
> 
