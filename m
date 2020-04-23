From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 23 Apr 2020 21:21:14 +0000
Subject: [Intel-wired-lan] [PATCH 3/4] igc: Add support for source
 address filters in core
In-Reply-To: <20200411002834.13916-4-andre.guedes@intel.com>
References: <20200411002834.13916-1-andre.guedes@intel.com>
 <20200411002834.13916-4-andre.guedes@intel.com>
Message-ID: <DM6PR11MB28909CB45C19E6C9688E4941BCD30@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Andre Guedes
> Sent: Friday, April 10, 2020 5:29 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 3/4] igc: Add support for source address
> filters in core
> 
> This patch extends MAC address filter internal APIs igc_add_mac_filter()
> and igc_del_mac_filter(), as well as local helpers, to support filters
> based on source address.
> 
> A new parameters 'type' is added to the APIs to indicate if the filter
> type is source or destination. In case it is source type, the RAH
> register is configured accordingly in igc_set_mac_filter_hw().
> 
> Signed-off-by: Andre Guedes <andre.guedes@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc.h         | 13 ++++--
>  drivers/net/ethernet/intel/igc/igc_defines.h |  2 +
>  drivers/net/ethernet/intel/igc/igc_ethtool.c |  6 ++-
>  drivers/net/ethernet/intel/igc/igc_main.c    | 49 +++++++++++++-------
>  4 files changed, 49 insertions(+), 21 deletions(-)
> 
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
