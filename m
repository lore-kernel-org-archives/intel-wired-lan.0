From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 18 Jun 2020 17:19:11 +0000
Subject: [Intel-wired-lan] [PATCH 4/6] igc: Remove UDP filter setup in
 PTP code
In-Reply-To: <20200604000105.15059-5-andre.guedes@intel.com>
References: <20200604000105.15059-1-andre.guedes@intel.com>
 <20200604000105.15059-5-andre.guedes@intel.com>
Message-ID: <DM6PR11MB289069C73BC25525C4410B18BC9B0@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Andre Guedes
> Sent: Wednesday, June 3, 2020 5:01 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 4/6] igc: Remove UDP filter setup in PTP
> code
> 
> As implemented in igc_ethtool_get_ts_info(), igc only supports
> HWTSTAMP_
> FILTER_ALL so any HWTSTAMP_FILTER_* option the user may set falls back
> to
> HWTSTAMP_FILTER_ALL.
> 
> HWTSTAMP_FILTER_ALL is implemented via Rx Time Sync Control
> (TSYNCRXCTL)
> configuration which timestamps all incoming packets. Configuring an
> UDP filter, in addition to TSYNCRXCTL, doesn't add much so this patch
> removes that code. It also takes this opportunity to remove some
> non-applicable comments.
> 
> Signed-off-by: Andre Guedes <andre.guedes@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_ptp.c | 51 +-----------------------
>  1 file changed, 1 insertion(+), 50 deletions(-)
> 
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
