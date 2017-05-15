From: Duyck, Alexander H <alexander.h.duyck@intel.com>
Date: Mon, 15 May 2017 16:57:43 +0000
Subject: [Intel-wired-lan] [PATCH net v2] i40e/i40evf: proper update of
 the page_offset field
In-Reply-To: <20170515045200.27789-1-bjorn.topel@gmail.com>
References: <20170515045200.27789-1-bjorn.topel@gmail.com>
Message-ID: <1494867458.20114.168.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 2017-05-15 at 06:52 +0200, Bj?rn T?pel wrote:
> From: Bj?rn T?pel <bjorn.topel@intel.com>
> 
> In f8b45b74cc62 ("i40e/i40evf: Use build_skb to build frames")
> i40e_build_skb updates the page_offset field with an incorrect offset,
> which can lead to data corruption. This patch updates page_offset
> correctly, by properly setting truesize.
> 
> Note that the bug only appears on architectures where PAGE_SIZE is
> 8192 or larger.
> 
> Fixes: f8b45b74cc62 ("i40e/i40evf: Use build_skb to build frames")
> Signed-off-by: Bj?rn T?pel <bjorn.topel@intel.com>

Acked-by: Alexander Duyck <alexander.h.duyck@intel.com>

> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 3 ++-
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> index 29321a6167a6..cd894f4023b1 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> @@ -1854,7 +1854,8 @@ static struct sk_buff *i40e_build_skb(struct i40e_ring *rx_ring,
>  #if (PAGE_SIZE < 8192)
>  	unsigned int truesize = i40e_rx_pg_size(rx_ring) / 2;
>  #else
> -	unsigned int truesize = SKB_DATA_ALIGN(size);
> +	unsigned int truesize = SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) +
> +				SKB_DATA_ALIGN(I40E_SKB_PAD + size);
>  #endif
>  	struct sk_buff *skb;
>  
> diff --git a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
> index dfe241a12ad0..12b02e530503 100644
> --- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
> +++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
> @@ -1190,7 +1190,8 @@ static struct sk_buff *i40e_build_skb(struct i40e_ring *rx_ring,
>  #if (PAGE_SIZE < 8192)
>  	unsigned int truesize = i40e_rx_pg_size(rx_ring) / 2;
>  #else
> -	unsigned int truesize = SKB_DATA_ALIGN(size);
> +	unsigned int truesize = SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) +
> +				SKB_DATA_ALIGN(I40E_SKB_PAD + size);
>  #endif
>  	struct sk_buff *skb;
>  
