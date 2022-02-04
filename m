From: Jonathan Toppins <jtoppins@redhat.com>
Date: Fri,  4 Feb 2022 11:58:46 -0500
Subject: [Intel-wired-lan] [RFC] ice: use msleep instead of mdelay
Message-ID: <c095aac80cac3fc103f13170a976def3aa4d0f78.1643993926.git.jtoppins@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Use msleep for long delays instead of spinning in the driver.

Suggested-by: Jocelyn Falempe <jfalempe@redhat.com>
Signed-off-by: Jonathan Toppins <jtoppins@redhat.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 408d15a5b0e3..50987d513faf 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -1107,7 +1107,7 @@ int ice_check_reset(struct ice_hw *hw)
 			GLGEN_RSTCTL_GRSTDEL_S) + 10;
 
 	for (cnt = 0; cnt < grst_timeout; cnt++) {
-		mdelay(100);
+		msleep(100);
 		reg = rd32(hw, GLGEN_RSTAT);
 		if (!(reg & GLGEN_RSTAT_DEVSTATE_M))
 			break;
@@ -3196,7 +3196,7 @@ ice_set_fc(struct ice_port_info *pi, u8 *aq_failures, bool ena_auto_link_update)
 			if (!status)
 				break;
 
-			mdelay(100);
+			msleep(100);
 		}
 
 		if (status)
-- 
2.27.0

