From: Bixuan Cui <cuibixuan@huawei.com>
Date: Wed, 23 Sep 2020 09:44:38 +0800
Subject: [Intel-wired-lan] [PATCH -next v2] net: ice: Fix pointer cast
 warnings
In-Reply-To: <5af7c5af-c45d-2174-de89-8b89eddb4f4d@huawei.com>
References: <20200731105721.18511-1-cuibixuan@huawei.com>
 <5af7c5af-c45d-2174-de89-8b89eddb4f4d@huawei.com>
Message-ID: <9ba08d48-a192-bf9d-b37e-e7f3c9699970@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

ping~

On 2020/7/31 18:07, Bixuan Cui wrote:
> pointers should be casted to unsigned long to avoid
> -Wpointer-to-int-cast warnings:
> 
> drivers/net/ethernet/intel/ice/ice_flow.h:197:33: warning:
>     cast from pointer to integer of different size
> drivers/net/ethernet/intel/ice/ice_flow.h:198:32: warning:
>     cast to pointer from integer of different size
> 
> Signed-off-by: Bixuan Cui <cuibixuan@huawei.com>
> ---
> v2->v1: add fix:
>  ice_flow.h:198:32: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>  #define ICE_FLOW_ENTRY_PTR(h) ((struct ice_flow_entry *)(h))
> 
>  drivers/net/ethernet/intel/ice/ice_flow.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_flow.h b/drivers/net/ethernet/intel/ice/ice_flow.h
> index 3913da2116d2..829f90b1e998 100644
> --- a/drivers/net/ethernet/intel/ice/ice_flow.h
> +++ b/drivers/net/ethernet/intel/ice/ice_flow.h
> @@ -194,8 +194,8 @@ struct ice_flow_entry {
>  	u16 entry_sz;
>  };
> 
> -#define ICE_FLOW_ENTRY_HNDL(e)	((u64)e)
> -#define ICE_FLOW_ENTRY_PTR(h)	((struct ice_flow_entry *)(h))
> +#define ICE_FLOW_ENTRY_HNDL(e)	((u64)(uintptr_t)e)
> +#define ICE_FLOW_ENTRY_PTR(h)	((struct ice_flow_entry *)(uintptr_t)(h))
> 
>  struct ice_flow_prof {
>  	struct list_head l_entry;
> --
> 2.17.1
> 
> 
> .
> 
