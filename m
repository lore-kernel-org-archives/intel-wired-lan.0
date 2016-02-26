From: Allan, Bruce W <bruce.w.allan@intel.com>
Date: Fri, 26 Feb 2016 00:57:04 +0000
Subject: [Intel-wired-lan] [PATCH v2] fm10k: remove duplication of
	the	driver summary
In-Reply-To: <1456444736-7832-1-git-send-email-jacob.e.keller@intel.com>
References: <1456444736-7832-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <804857E1F29AAC47BF68C404FC60A18490D7121B@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Jacob Keller
> Sent: Thursday, February 25, 2016 3:59 PM
> To: Intel Wired LAN
> Subject: [Intel-wired-lan] [PATCH v2] fm10k: remove duplication of the
> driver summary
> 
> Use DRV_SUMMARY, similar to DRV_VERSION so that we don't have
> duplicate
> copies of the summary left in the driver.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
> This is a direct replacement of what is already on the queue. This
> version drops the summary change and only removes the duplication.
> 
>  drivers/net/ethernet/intel/fm10k/fm10k_main.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_main.c
> b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
> index 3a81c1451624..7832f9cdf743 100644
> --- a/drivers/net/ethernet/intel/fm10k/fm10k_main.c
> +++ b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
> @@ -29,15 +29,15 @@
>  #include "fm10k.h"
> 
>  #define DRV_VERSION	"0.19.3-k"
> +#define DRV_SUMMARY	"Intel(R) Ethernet Switch Host Interface
> Driver"
>  const char fm10k_driver_version[] = DRV_VERSION;
>  char fm10k_driver_name[] = "fm10k";
> -static const char fm10k_driver_string[] =
> -	"Intel(R) Ethernet Switch Host Interface Driver";
> +static const char fm10k_driver_string[] = DRV_SUMMARY;
>  static const char fm10k_copyright[] =
>  	"Copyright (c) 2013 Intel Corporation.";
> 
>  MODULE_AUTHOR("Intel Corporation, <linux.nics@intel.com>");
> -MODULE_DESCRIPTION("Intel(R) Ethernet Switch Host Interface Driver");
> +MODULE_DESCRIPTION(DRV_SUMMARY);
>  MODULE_LICENSE("GPL");
>  MODULE_VERSION(DRV_VERSION);

Perhaps consider updating the copyright at the same time you are modifying this file?!?

I suggested a change to "Copyright(c) 2013 - 2016 Intel Corporation."

