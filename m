From: Karol Kolacinski <karol.kolacinski@intel.com>
Date: Thu,  4 Nov 2021 14:52:11 +0100
Subject: [Intel-wired-lan] [PATCH intel-next] ice: Use div64_u64 instead of
 div_u64 in adjfine
Message-ID: <20211104135211.21315-1-karol.kolacinski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Change the division in ice_ptp_adjfine from div_u64 to div64_u64.
div_u64 is used when the divisor is 32 bit but in this case incval is
64 bit and it caused incorrect calculations and incval adjustments.

Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 2b3b2060b504..2149595cc632 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -1104,7 +1104,7 @@ static int ice_ptp_adjfine(struct ptp_clock_info *info, long scaled_ppm)
 		scaled_ppm = -scaled_ppm;
 	}
 
-	while ((u64)scaled_ppm > div_u64(U64_MAX, incval)) {
+	while ((u64)scaled_ppm > div64_u64(U64_MAX, incval)) {
 		/* handle overflow by scaling down the scaled_ppm and
 		 * the divisor, losing some precision
 		 */
-- 
2.32.0

