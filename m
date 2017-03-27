From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Mon, 27 Mar 2017 23:43:43 +0000
Subject: [Intel-wired-lan] [next PATCH S65 09/13] i40e: clean up
 historic deprecated flag definitions
In-Reply-To: <20170327094759.58321-10-alice.michael@intel.com>
References: <20170327094759.58321-1-alice.michael@intel.com>
 <20170327094759.58321-10-alice.michael@intel.com>
Message-ID: <02874ECE860811409154E81DA85FBB5857DE7AE9@ORSMSX115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

ACK

> -----Original Message-----
> From: Michael, Alice
> Sent: Monday, March 27, 2017 2:48 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Keller, Jacob E <jacob.e.keller@intel.com>
> Subject: [next PATCH S65 09/13] i40e: clean up historic deprecated flag definitions
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> Since an early commit a few flags have no longer
> been used. Remove these definitions to reduce code clutter.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Change-ID: I3589be4622574e747013cd4dc403e18b039f4965
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h          | 3 ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c     | 2 +-
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c | 2 +-
>  3 files changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e.h
> b/drivers/net/ethernet/intel/i40e/i40e.h
> index fc91ffd..2c12900 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e.h
> @@ -390,11 +390,8 @@ struct i40e_pf {
>  #define I40E_FLAG_RSS_ENABLED			BIT_ULL(6)
>  #define I40E_FLAG_VMDQ_ENABLED			BIT_ULL(7)
>  #define I40E_FLAG_IWARP_ENABLED			BIT_ULL(10)
> -#define I40E_FLAG_CLEAN_ADMINQ			BIT_ULL(14)
>  #define I40E_FLAG_FILTER_SYNC			BIT_ULL(15)
>  #define I40E_FLAG_SERVICE_CLIENT_REQUESTED	BIT_ULL(16)
> -#define I40E_FLAG_PROCESS_MDD_EVENT		BIT_ULL(17)
> -#define I40E_FLAG_PROCESS_VFLR_EVENT		BIT_ULL(18)
>  #define I40E_FLAG_SRIOV_ENABLED			BIT_ULL(19)
>  #define I40E_FLAG_DCB_ENABLED			BIT_ULL(20)
>  #define I40E_FLAG_FD_SB_ENABLED			BIT_ULL(21)
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c
> b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index f5f5bbe..b5ce68f 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -41,7 +41,7 @@ static const char i40e_driver_string[] =
> 
>  #define DRV_VERSION_MAJOR 2
>  #define DRV_VERSION_MINOR 1
> -#define DRV_VERSION_BUILD 10
> +#define DRV_VERSION_BUILD 11
>  #define DRV_VERSION __stringify(DRV_VERSION_MAJOR) "." \
>  	     __stringify(DRV_VERSION_MINOR) "." \
>  	     __stringify(DRV_VERSION_BUILD)    DRV_KERN
> diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
> b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
> index 8c029c7..3b2f91a 100644
> --- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
> +++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
> @@ -39,7 +39,7 @@ static const char i40evf_driver_string[] =
> 
>  #define DRV_VERSION_MAJOR 2
>  #define DRV_VERSION_MINOR 1
> -#define DRV_VERSION_BUILD 10
> +#define DRV_VERSION_BUILD 11
>  #define DRV_VERSION __stringify(DRV_VERSION_MAJOR) "." \
>  	     __stringify(DRV_VERSION_MINOR) "." \
>  	     __stringify(DRV_VERSION_BUILD) \
> --
> 2.9.3

