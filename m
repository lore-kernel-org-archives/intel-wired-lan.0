From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Wed, 8 Jul 2020 01:23:01 +0000
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Fix registers definition
In-Reply-To: <20200629145944.34867-1-sasha.neftin@intel.com>
References: <20200629145944.34867-1-sasha.neftin@intel.com>
Message-ID: <DM6PR11MB28904E416C274E61415ED35CBC670@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Sasha Neftin
> Sent: Monday, June 29, 2020 8:00 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Fix registers definition
> 
> Fix double definition and remove unneeded registers.
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_mac.c  | 4 ----
>  drivers/net/ethernet/intel/igc/igc_main.c | 4 ----
>  drivers/net/ethernet/intel/igc/igc_regs.h | 8 --------
>  3 files changed, 16 deletions(-)
> 
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
