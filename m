From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Wed, 15 Aug 2018 09:20:46 -0700
Subject: [Intel-wired-lan] [PATCH v5 05/11] igc: Add support for Tx/Rx
 rings
In-Reply-To: <1534345347-5578-1-git-send-email-sasha.neftin@intel.com>
References: <1534345347-5578-1-git-send-email-sasha.neftin@intel.com>
Message-ID: <e34da823689c32156285b98375445b45d353f068.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2018-08-15 at 18:02 +0300, Sasha Neftin wrote:
> diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h
> b/drivers/net/ethernet/intel/igc/igc_defines.h
> index 1ce997a..f9d1842 100644
> --- a/drivers/net/ethernet/intel/igc/igc_defines.h
> +++ b/drivers/net/ethernet/intel/igc/igc_defines.h
> @@ -28,13 +28,13 @@
>  #define IGC_RAH_POOL_1         0x00040000
>  
>  /* Error Codes */
> -#define IGC_SUCCESS                            0
> -#define IGC_ERR_NVM                            1
> -#define IGC_ERR_PHY                            2
> -#define IGC_ERR_CONFIG                         3
> -#define IGC_ERR_PARAM                          4
> -#define IGC_ERR_MAC_INIT                       5
> -#define IGC_ERR_RESET                          9
> +#define IGC_SUCCESS                    0
> +#define IGC_ERR_NVM                    1
> +#define IGC_ERR_PHY                    2
> +#define IGC_ERR_CONFIG                 3
> +#define IGC_ERR_PARAM                  4
> +#define IGC_ERR_MAC_INIT               5
> +#define IGC_ERR_RESET                  9

This change in indentation should be in patch 2, when the code was
first introduced.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20180815/3b99de62/attachment.asc>
