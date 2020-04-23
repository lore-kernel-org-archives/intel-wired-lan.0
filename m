From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 23 Apr 2020 19:44:18 +0000
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Remove obsolete circuit
 breaker registers
In-Reply-To: <20200420113853.35732-1-sasha.neftin@intel.com>
References: <20200420113853.35732-1-sasha.neftin@intel.com>
Message-ID: <DM6PR11MB2890295402EDBD5FE06C98DBBCD30@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Sasha Neftin
> Sent: Monday, April 20, 2020 4:39 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Remove obsolete circuit
> breaker registers
> 
> Part of circuit breaker registers is obsolete
> and not applicable for i225 device.
> This patch comes to clean up these registers.
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_mac.c  | 4 ----
>  drivers/net/ethernet/intel/igc/igc_regs.h | 7 -------
>  2 files changed, 11 deletions(-)
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
