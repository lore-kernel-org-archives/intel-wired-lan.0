From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 23 Apr 2020 18:12:05 +0000
Subject: [Intel-wired-lan] [PATCH 1/5] igc: Remove duplicated IGC_RXPBS
 macro
In-Reply-To: <20200407210711.24371-2-andre.guedes@intel.com>
References: <20200407210711.24371-1-andre.guedes@intel.com>
 <20200407210711.24371-2-andre.guedes@intel.com>
Message-ID: <DM6PR11MB289041C9760BB6F1AFC9ADBBBCD30@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Andre Guedes
> Sent: Tuesday, April 7, 2020 2:07 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 1/5] igc: Remove duplicated IGC_RXPBS
> macro
> 
> This patch remove the IGC_RXPBS macro defined in line 233 since it is
> already defined in line 18 with the exactly same value.
> 
> Signed-off-by: Andre Guedes <andre.guedes@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_regs.h | 2 --
>  1 file changed, 2 deletions(-)
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
