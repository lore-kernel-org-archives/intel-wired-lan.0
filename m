From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 23 Apr 2020 18:20:20 +0000
Subject: [Intel-wired-lan] [PATCH 2/5] igc: Remove ethertype filter in
 ptp code
In-Reply-To: <20200407210711.24371-3-andre.guedes@intel.com>
References: <20200407210711.24371-1-andre.guedes@intel.com>
 <20200407210711.24371-3-andre.guedes@intel.com>
Message-ID: <DM6PR11MB28906FE0967C7E2E09049631BCD30@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Andre Guedes
> Sent: Tuesday, April 7, 2020 2:07 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 2/5] igc: Remove ethertype filter in ptp
> code
> 
> The driver only supports hardware timestamping for all incoming
> traffic (HWTSTAMP_FILTER_ALL) which is enabled via Rx Time Sync
> Control (TSYNCRXCTL) register already. Therefore, the ethertype
> filter set in in igc_ptp_set_timestamp_mode() is useless so this
> patch removes it.
> 
> Signed-off-by: Andre Guedes <andre.guedes@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc.h         |  2 +-
>  drivers/net/ethernet/intel/igc/igc_defines.h |  3 ---
>  drivers/net/ethernet/intel/igc/igc_ptp.c     | 12 ------------
>  3 files changed, 1 insertion(+), 16 deletions(-)
> 
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
