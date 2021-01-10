From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Sun, 10 Jan 2021 15:56:05 +0100
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Remove unused MII_CR_RESET
In-Reply-To: <20210110145114.3493608-1-sasha.neftin@intel.com>
References: <20210110145114.3493608-1-sasha.neftin@intel.com>
Message-ID: <99bb5e22-086c-365b-7d9c-263b18f4c9dd@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Sasha,


Am 10.01.21 um 15:51 schrieb Sasha Neftin:
> MII_CR_RESET mask not in use in i225 device and could be removed

Nit: ? and is removed.

> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_defines.h | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
> index 4fc9ef978ad3..58fc207dc995 100644
> --- a/drivers/net/ethernet/intel/igc/igc_defines.h
> +++ b/drivers/net/ethernet/intel/igc/igc_defines.h
> @@ -442,7 +442,6 @@
>   #define MII_CR_POWER_DOWN	0x0800  /* Power down */
>   #define MII_CR_AUTO_NEG_EN	0x1000  /* Auto Neg Enable */
>   #define MII_CR_LOOPBACK		0x4000  /* 0 = normal, 1 = loopback */
> -#define MII_CR_RESET		0x8000  /* 0 = normal, 1 = PHY reset */
>   #define MII_CR_SPEED_1000	0x0040
>   #define MII_CR_SPEED_100	0x2000
>   #define MII_CR_SPEED_10		0x0000

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
