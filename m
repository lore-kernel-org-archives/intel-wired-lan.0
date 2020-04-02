From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 2 Apr 2020 03:39:16 +0000
Subject: [Intel-wired-lan] [PATCH 04/10] igc: Use netdev log helpers in
 igc_dump.c
In-Reply-To: <20200325003824.5487-5-andre.guedes@intel.com>
References: <20200325003824.5487-1-andre.guedes@intel.com>
 <20200325003824.5487-5-andre.guedes@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B9722EC20@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Andre Guedes
> Sent: Tuesday, March 24, 2020 5:38 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 04/10] igc: Use netdev log helpers in
> igc_dump.c
> 
> In igc_dump.c we print log messages using dev_* and pr_* helpers,
> generating inconsistent output with the rest of the driver. Since this
> is a network device driver, we should preferably use netdev_* helpers
> because they append the interface name to the message, helping making
> sense out of the logs.
> 
> This patch converts all dev_* and pr_* calls to netdev_*. It also takes
> this opportunity to remove the '\n' character at the end of messages
> since is it automatically added by netdev_* log helpers.
> 
> Quick note about igc_rings_dump(): This function is always called with
> valid adapter->netdev so there is not need to check it.
> 
> Signed-off-by: Andre Guedes <andre.guedes@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_dump.c | 109 +++++++++++-----------
>  1 file changed, 54 insertions(+), 55 deletions(-)
> 
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
