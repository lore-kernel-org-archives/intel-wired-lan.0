From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@intel.com>
Date: Mon, 11 Jan 2021 20:47:38 +0100
Subject: [Intel-wired-lan] [PATCH net] i40e: fix potential NULL pointer
 dereferencing
In-Reply-To: <20210111181138.49757-1-cristian.dumitrescu@intel.com>
References: <20210111181138.49757-1-cristian.dumitrescu@intel.com>
Message-ID: <ac36b7b2-bf0e-c58c-754b-d9ab4dbb9cae@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 2021-01-11 19:11, Cristian Dumitrescu wrote:
> Currently, the function i40e_construct_skb_zc only frees the input xdp
> buffer when the output skb is successfully built. On error, the
> function i40e_clean_rx_irq_zc does not commit anything for the current
> packet descriptor and simply exits the packet descriptor processing
> loop, with the plan to restart the processing of this descriptor on
> the next invocation. Therefore, on error the ring next-to-clean
> pointer should not advance, the xdp i.e. *bi buffer should not be
> freed and the current buffer info should not be invalidated by setting
> *bi to NULL. Therefore, the *bi should only be set to NULL when the
> function i40e_construct_skb_zc is successful, otherwise a NULL *bi
> will be dereferenced when the work for the current descriptor is
> eventually restarted.
> 
> Fixes: 3b4f0b66c2b3 ("i40e, xsk: Migrate to new MEM_TYPE_XSK_BUFF_POOL")
> Signed-off-by: Cristian Dumitrescu <cristian.dumitrescu@intel.com>

Thanks for finding and fixing this, Cristian!

Acked-by: Bj?rn T?pel <bjorn.topel@intel.com>

> ---
>   drivers/net/ethernet/intel/i40e/i40e_xsk.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> index 47eb9c584a12..492ce213208d 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> @@ -348,12 +348,12 @@ int i40e_clean_rx_irq_zc(struct i40e_ring *rx_ring, int budget)
>   		 * SBP is *not* set in PRT_SBPVSI (default not set).
>   		 */
>   		skb = i40e_construct_skb_zc(rx_ring, *bi);
> -		*bi = NULL;
>   		if (!skb) {
>   			rx_ring->rx_stats.alloc_buff_failed++;
>   			break;
>   		}
>   
> +		*bi = NULL;
>   		cleaned_count++;
>   		i40e_inc_ntc(rx_ring);
>   
> 
