From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Tue, 21 Aug 2018 09:28:00 -0700
Subject: [Intel-wired-lan] [next PATCH S95 09/12] i40e: use correct
 length for strncpy
In-Reply-To: <20180820151233.14629-9-alice.michael@intel.com>
References: <20180820151233.14629-1-alice.michael@intel.com>
 <20180820151233.14629-9-alice.michael@intel.com>
Message-ID: <a7c5ac53-3cb6-4fe5-d281-a46e1ead12a1@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 8/20/2018 8:12 AM, Alice Michael wrote:
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> Caught by gcc 8. When we provide a length for strncpy, we should not
> include the terminating null. So we must tell it one less than the size
> of the destination buffer.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> ---
>   drivers/net/ethernet/intel/i40e/i40e_ptp.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_ptp.c b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> index 35f2866..1199f05 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> @@ -694,7 +694,8 @@ static long i40e_ptp_create_clock(struct i40e_pf *pf)
>   	if (!IS_ERR_OR_NULL(pf->ptp_clock))
>   		return 0;
>   
> -	strncpy(pf->ptp_caps.name, i40e_driver_name, sizeof(pf->ptp_caps.name));
> +	strncpy(pf->ptp_caps.name, i40e_driver_name,
> +		sizeof(pf->ptp_caps.name) - 1);

Is there any need to be sure the rest of the name field is zero'd out? 
It looks like maybe not, not sure.

sln

>   	pf->ptp_caps.owner = THIS_MODULE;
>   	pf->ptp_caps.max_adj = 999999999;
>   	pf->ptp_caps.n_ext_ts = 0;
> 
