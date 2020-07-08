From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Wed, 8 Jul 2020 01:20:37 +0000
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Remove unneeded ICTXQMTC
 register
In-Reply-To: <20200622074334.30238-1-sasha.neftin@intel.com>
References: <20200622074334.30238-1-sasha.neftin@intel.com>
Message-ID: <DM6PR11MB2890058D758142BADE16B644BC670@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Sasha Neftin
> Sent: Monday, June 22, 2020 12:44 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Remove unneeded ICTXQMTC
> register
> 
> Tx Queue Min Threshold Count register no applicable for the i225 device.
> This patch comes to clean up it.
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_mac.c  | 1 -
>  drivers/net/ethernet/intel/igc/igc_main.c | 1 -
>  drivers/net/ethernet/intel/igc/igc_regs.h | 2 --
>  3 files changed, 4 deletions(-)
> 
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
