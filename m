From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Tue, 21 Apr 2020 18:29:59 +0000
Subject: [Intel-wired-lan] [PATCH 1/4] igc: Rename IGC_VLAPQF macro
In-Reply-To: <20200403181743.23447-2-andre.guedes@intel.com>
References: <20200403181743.23447-1-andre.guedes@intel.com>
 <20200403181743.23447-2-andre.guedes@intel.com>
Message-ID: <DM6PR11MB28906FE90989C6C092F5C032BCD50@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Andre Guedes
> Sent: Friday, April 3, 2020 11:18 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 1/4] igc: Rename IGC_VLAPQF macro
> 
> This patch renames the IGC_VLAPQF macro to IGC_VLANPQF as well as
> related macros so they match the register name and fields described in
> the datasheet.
> 
> Signed-off-by: Andre Guedes <andre.guedes@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_defines.h |  6 +++---
>  drivers/net/ethernet/intel/igc/igc_ethtool.c | 21 ++++++++++----------
>  drivers/net/ethernet/intel/igc/igc_regs.h    |  2 +-
>  3 files changed, 14 insertions(+), 15 deletions(-)
Tested-by: Aaron Brown <aaron.f.brown@intel.com>

