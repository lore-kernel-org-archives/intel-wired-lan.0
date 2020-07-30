From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 30 Jul 2020 14:20:46 -0700
Subject: [Intel-wired-lan] [PATCH v1] ice: devlink: use %*phD to print
 small buffer
In-Reply-To: <20200730160451.40810-1-andriy.shevchenko@linux.intel.com>
References: <20200730160451.40810-1-andriy.shevchenko@linux.intel.com>
Message-ID: <77247fbc-152a-517f-2500-ce761b7afa6a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 7/30/2020 9:04 AM, Andy Shevchenko wrote:
> Use %*phD format to print small buffer as hex string.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Ah nice. I swear I looked for a printk format to do this and didn't find
one. But it's been there since 2012.. so I guess I just missed it.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

I also tested this on my system to make sure it gives the same output
for the serial value, so I guess also:

Tested-by: Jacob Keller <jacob.e.keller@intel.com>

Thanks!

> ---
>  drivers/net/ethernet/intel/ice/ice_devlink.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_devlink.c b/drivers/net/ethernet/intel/ice/ice_devlink.c
> index dbbd8b6f9d1a..a9105ad5b983 100644
> --- a/drivers/net/ethernet/intel/ice/ice_devlink.c
> +++ b/drivers/net/ethernet/intel/ice/ice_devlink.c
> @@ -13,9 +13,7 @@ static int ice_info_get_dsn(struct ice_pf *pf, char *buf, size_t len)
>  	/* Copy the DSN into an array in Big Endian format */
>  	put_unaligned_be64(pci_get_dsn(pf->pdev), dsn);
>  
> -	snprintf(buf, len, "%02x-%02x-%02x-%02x-%02x-%02x-%02x-%02x",
> -		 dsn[0], dsn[1], dsn[2], dsn[3],
> -		 dsn[4], dsn[5], dsn[6], dsn[7]);
> +	snprintf(buf, len, "%8phD", dsn);
>  
>  	return 0;
>  }
> 
