From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 18 Jun 2020 17:19:31 +0000
Subject: [Intel-wired-lan] [PATCH 5/6] igc: Refactor
 igc_ptp_set_timestamp_mode()
In-Reply-To: <20200604000105.15059-6-andre.guedes@intel.com>
References: <20200604000105.15059-1-andre.guedes@intel.com>
 <20200604000105.15059-6-andre.guedes@intel.com>
Message-ID: <DM6PR11MB28906D74C4C6BCB4BC968A5ABC9B0@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Andre Guedes
> Sent: Wednesday, June 3, 2020 5:01 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 5/6] igc: Refactor
> igc_ptp_set_timestamp_mode()
> 
> Current igc_ptp_set_timestamp_mode() logic is a bit tangled since it
> handles many different hardware configurations in one single place,
> making it harder to follow. This patch untangles that code by breaking
> it into helper functions.
> 
> Quick note about the hw->mac.type check which was removed in this
> refactoring: this check it not really needed since igc_i225 is the only
> type supported by the IGC driver.
> 
> Signed-off-by: Andre Guedes <andre.guedes@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_ptp.c | 103 ++++++++++++-----------
>  1 file changed, 53 insertions(+), 50 deletions(-)
> 
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
