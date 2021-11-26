From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Date: Fri, 26 Nov 2021 16:25:04 +0100
Subject: [Intel-wired-lan] [PATCH net-next 1/2] igc: AF_XDP zero-copy
 metadata adjust breaks SKBs on XDP_PASS
In-Reply-To: <163700858579.565980.15265721798644582439.stgit@firesoul>
References: <163700856423.565980.10162564921347693758.stgit@firesoul>
 <163700858579.565980.15265721798644582439.stgit@firesoul>
Message-ID: <YaD8UHOxHasBkqEW@boxer>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Nov 15, 2021 at 09:36:25PM +0100, Jesper Dangaard Brouer wrote:
> Driver already implicitly supports XDP metadata access in AF_XDP
> zero-copy mode, as xsk_buff_pool's xp_alloc() naturally set xdp_buff
> data_meta equal data.
> 
> This works fine for XDP and AF_XDP, but if a BPF-prog adjust via
> bpf_xdp_adjust_meta() and choose to call XDP_PASS, then igc function
> igc_construct_skb_zc() will construct an invalid SKB packet. The
> function correctly include the xdp->data_meta area in the memcpy, but
> forgot to pull header to take metasize into account.
> 
> Fixes: fc9df2a0b520 ("igc: Enable RX via AF_XDP zero-copy")
> Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>

Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Great catch. Will take a look at other ZC enabled Intel drivers if they
are affected as well.

Thanks!

> ---
>  drivers/net/ethernet/intel/igc/igc_main.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index 8e448288ee26..76b0a7311369 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -2448,8 +2448,10 @@ static struct sk_buff *igc_construct_skb_zc(struct igc_ring *ring,
>  
>  	skb_reserve(skb, xdp->data_meta - xdp->data_hard_start);
>  	memcpy(__skb_put(skb, totalsize), xdp->data_meta, totalsize);
> -	if (metasize)
> +	if (metasize) {
>  		skb_metadata_set(skb, metasize);
> +		__skb_pull(skb, metasize);
> +	}
>  
>  	return skb;
>  }
> 
> 
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
