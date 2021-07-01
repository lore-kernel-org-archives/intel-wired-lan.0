From: Machnikowski, Maciej <maciej.machnikowski@intel.com>
Date: Thu, 1 Jul 2021 17:25:01 +0000
Subject: [Intel-wired-lan] [PATCH] ice: Fix perout start time rounding
Message-ID: <PH0PR11MB495113B3795624D79EF8F1A1EA009@PH0PR11MB4951.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Internal tests found out that the latest code doesn't bring up 1PPS out
as expected. As a result of incorrect define used to round the time up
the time was round down to the past second boundary.

Fix define used for rounding to properly round up to the next Top of
second in ice_ptp_cfg_clkout to fix it.

Fixes: 172db5f91d5f ("ice: add support for auxiliary input/output pins")
Signed-off-by: Maciej Machnikowski <maciej.machnikowski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 5d5207b56ca9..9e3ddb9b8b51 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -656,7 +656,7 @@ static int ice_ptp_cfg_clkout(struct ice_pf *pf, unsigned int chan,
 	 * maintaining phase
 	 */
 	if (start_time < current_time)
-		start_time = div64_u64(current_time + NSEC_PER_MSEC - 1,
+		start_time = div64_u64(current_time + NSEC_PER_SEC - 1,
 				       NSEC_PER_SEC) * NSEC_PER_SEC + phase;
 
 	start_time -= E810_OUT_PROP_DELAY_NS;
-- 
2.31.1
