From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Thu, 6 Apr 2017 09:01:18 -0700
Subject: [Intel-wired-lan] [next S66 v2 08/11] i40e: clean up historic
 deprecated flag definitions
In-Reply-To: <20170405115103.67374-8-alice.michael@intel.com>
References: <20170405115103.67374-1-alice.michael@intel.com>
 <20170405115103.67374-8-alice.michael@intel.com>
Message-ID: <41f615bc-dd27-51da-febd-4c325f300382@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 4/5/2017 4:51 AM, Alice Michael wrote:
> From: Jacob Keller <jacob.e.keller@intel.com>
>
> Since an early commit a few flags have no longer
> been used. Remove these definitions to reduce code clutter.

Why not combine this with the previous patch?
sln

>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Change-ID: I3589be4622574e747013cd4dc403e18b039f4965
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
> index ef64dc6..e987503 100644
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
>
