From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Sat, 25 Jan 2020 02:45:14 +0000
Subject: [Intel-wired-lan] [PATCH v1] e1000e: Add support to 0x15F5
 Device Id of Tiger Lake
In-Reply-To: <20200119100809.38869-1-vitaly.lifshits@intel.com>
References: <20200119100809.38869-1-vitaly.lifshits@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B971CC4E7@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Vitaly Lifshits
> Sent: Sunday, January 19, 2020 2:08 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v1] e1000e: Add support to 0x15F5 Device
> Id of Tiger Lake
> 
> Added support to 0x15F5 Device ID which is part of Intel Tiger Lake
> Platforms. This patch follows commit:
> 776f5d57ee ("e1000e: Add support for Tiger Lake").
> 
> Signed-off-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
> ---
>  drivers/net/ethernet/intel/e1000e/hw.h     | 1 +
>  drivers/net/ethernet/intel/e1000e/netdev.c | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/e1000e/hw.h
> b/drivers/net/ethernet/intel/e1000e/hw.h
> index f556163481cb..b85210ef31d9 100644
> --- a/drivers/net/ethernet/intel/e1000e/hw.h
> +++ b/drivers/net/ethernet/intel/e1000e/hw.h
> @@ -97,6 +97,7 @@ struct e1000_hw;
>  #define E1000_DEV_ID_PCH_TGP_I219_LM14		0x15F9
>  #define E1000_DEV_ID_PCH_TGP_I219_V14		0x15FA
>  #define E1000_DEV_ID_PCH_TGP_I219_LM15		0x15F4
> +#define E1000_DEV_ID_PCH_TGP_I219_V15		0x15F5
<snip>

Something seems to be missing.  After building and booting to the kernel with this patch included I do not see the 15f5 device from modinfo:
u1519:[1]/usr/src/kernels/next-queue> modinfo igc|grep -i 15f5                                                          
u1519:[1]/usr/src/kernels/next-queue>
