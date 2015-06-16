From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Tue, 16 Jun 2015 21:38:55 +0000
Subject: [Intel-wired-lan] [PATCH] fm10k: Don't assume page fragments
 are page size
In-Reply-To: <20150616184712.1966.44790.stgit@ahduyck-vm-fedora22>
References: <20150616184712.1966.44790.stgit@ahduyck-vm-fedora22>
Message-ID: <1434490735.12272.5.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Acked-by: Jacob Keller <jacob.e.keller@intel.com>

Regards,
Jake

On Tue, 2015-06-16 at 11:47 -0700, Alexander Duyck wrote:
> This change pulls out the optimization that assumed that all 
> fragments
> would be limited to page size.  That hasn't been the case for some 
> time now
> and to assume this is incorrect as the TCP allocator can provide up 
> to a
> 32K page fragment.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@redhat.com>
> ---
>  drivers/net/ethernet/intel/fm10k/fm10k_main.c |    7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_main.c 
> b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
> index 982fdcdc795b..620ff5e9dc59 100644
> --- a/drivers/net/ethernet/intel/fm10k/fm10k_main.c
> +++ b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
> @@ -1079,9 +1079,7 @@ netdev_tx_t fm10k_xmit_frame_ring(struct 
> sk_buff *skb,
>       struct fm10k_tx_buffer *first;
>       int tso;
>       u32 tx_flags = 0;
> -#if PAGE_SIZE > FM10K_MAX_DATA_PER_TXD
>       unsigned short f;
> -#endif
>       u16 count = TXD_USE_COUNT(skb_headlen(skb));
>  
>       /* need: 1 descriptor per page * 
> PAGE_SIZE/FM10K_MAX_DATA_PER_TXD,
> @@ -1089,12 +1087,9 @@ netdev_tx_t fm10k_xmit_frame_ring(struct 
> sk_buff *skb,
>        *       + 2 desc gap to keep tail from touching head
>        * otherwise try next time
>        */
> -#if PAGE_SIZE > FM10K_MAX_DATA_PER_TXD
>       for (f = 0; f < skb_shinfo(skb)->nr_frags; f++)
>               count += TXD_USE_COUNT(skb_shinfo(skb)
> ->frags[f].size);
> -#else
> -     count += skb_shinfo(skb)->nr_frags;
> -#endif
> +
>       if (fm10k_maybe_stop_tx(tx_ring, count + 3)) {
>               tx_ring->tx_stats.tx_busy++;
>               return NETDEV_TX_BUSY;
> 
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at lists.osuosl.org
> http://lists.osuosl.org/mailman/listinfo/intel-wired-lan
