From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 23 Apr 2020 21:12:38 +0000
Subject: [Intel-wired-lan] [PATCH 1/4] igc: Remove
 IGC_MAC_STATE_SRC_ADDR flag
In-Reply-To: <20200411002834.13916-2-andre.guedes@intel.com>
References: <20200411002834.13916-1-andre.guedes@intel.com>
 <20200411002834.13916-2-andre.guedes@intel.com>
Message-ID: <DM6PR11MB28909DC230F1BD9E96611024BCD30@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Andre Guedes
> Sent: Friday, April 10, 2020 5:29 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 1/4] igc: Remove
> IGC_MAC_STATE_SRC_ADDR flag
> 
> MAC address filters based on source address are not currently supported
> by the IGC driver. Despite of that, the driver have some dangling code
> to handle it, inherited from IGB driver. This patch removes that code to
> prepare for a follow up patch that adds proper source MAC address filter
> support.
> 
> Signed-off-by: Andre Guedes <andre.guedes@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc.h         |  6 ++---
>  drivers/net/ethernet/intel/igc/igc_ethtool.c | 16 ++----------
>  drivers/net/ethernet/intel/igc/igc_main.c    | 27 ++++++--------------
>  3 files changed, 12 insertions(+), 37 deletions(-)
> 
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
