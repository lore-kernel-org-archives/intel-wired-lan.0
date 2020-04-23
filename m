From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 23 Apr 2020 21:17:07 +0000
Subject: [Intel-wired-lan] [PATCH 2/4] igc: Remove mac_table from
 igc_adapter
In-Reply-To: <20200411002834.13916-3-andre.guedes@intel.com>
References: <20200411002834.13916-1-andre.guedes@intel.com>
 <20200411002834.13916-3-andre.guedes@intel.com>
Message-ID: <DM6PR11MB2890B7461B339060D83D50AEBCD30@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Andre Guedes
> Sent: Friday, April 10, 2020 5:29 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 2/4] igc: Remove mac_table from
> igc_adapter
> 
> In igc_adapter we keep a sort of shadow copy of RAL and RAH registers.
> There is not much benefit in keeping it, at the cost of maintainability,
> since adding/removing MAC address filters is not hot path, and we
> already keep filters information in adapter->nfc_filter_list for cleanup
> and restoration purposes.
> 
> So in order to simplify the MAC address filtering code and prepare it
> for source address support, this patch removes the mac_table from
> igc_adapter.
> 
> Signed-off-by: Andre Guedes <andre.guedes@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc.h         | 11 ----
>  drivers/net/ethernet/intel/igc/igc_defines.h |  1 +
>  drivers/net/ethernet/intel/igc/igc_main.c    | 57 +++++++-------------
>  3 files changed, 21 insertions(+), 48 deletions(-)
Tested-by: Aaron Brown <aaron .f.brown@intel.com>
