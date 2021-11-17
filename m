From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Wed, 17 Nov 2021 23:17:13 +0100
Subject: [Intel-wired-lan] [PATCH net-next] ice: Removed unused
 ICE_FLOW_SEG_HDRS_L2_MASK
In-Reply-To: <20211117221038.70579-1-anthony.l.nguyen@intel.com>
References: <20211117221038.70579-1-anthony.l.nguyen@intel.com>
Message-ID: <b06891ed-4e46-d37f-70a3-391026ed7a4d@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Tony,


Am 17.11.21 um 23:10 schrieb Tony Nguyen:
> ICE_FLOW_SEG_HDRS_L2_MASK is not being used; remove the define.

Nit: It?d be great if you used imperative mood (present tense) in the 
summary: Remove unused ?.

> Reported-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>   drivers/net/ethernet/intel/ice/ice_flow.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_flow.c b/drivers/net/ethernet/intel/ice/ice_flow.c
> index 2bfe9d9d7edc..ef10f0941231 100644
> --- a/drivers/net/ethernet/intel/ice/ice_flow.c
> +++ b/drivers/net/ethernet/intel/ice/ice_flow.c
> @@ -609,8 +609,6 @@ struct ice_flow_prof_params {
>   	ICE_FLOW_SEG_HDR_ESP | ICE_FLOW_SEG_HDR_AH | \
>   	ICE_FLOW_SEG_HDR_NAT_T_ESP)
>   
> -#define ICE_FLOW_SEG_HDRS_L2_MASK	\
> -	(ICE_FLOW_SEG_HDR_ETH | ICE_FLOW_SEG_HDR_VLAN)
>   #define ICE_FLOW_SEG_HDRS_L3_MASK	\
>   	(ICE_FLOW_SEG_HDR_IPV4 | ICE_FLOW_SEG_HDR_IPV6 | ICE_FLOW_SEG_HDR_ARP)
>   #define ICE_FLOW_SEG_HDRS_L4_MASK	\
> 

Acked-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
