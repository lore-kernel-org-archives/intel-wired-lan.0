From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Mon,  5 Nov 2018 12:18:35 -0800
Subject: [Intel-wired-lan] [PATCH] ice: Change req_speeds to be u16
Message-ID: <20181105201835.2166-1-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Chinh T Cao <chinh.t.cao@intel.com>

Since the req_speeds field in struct ice_link_status is a u8,
req_speeds & ICE_AQ_LINK_SPEED_40GB always returns 0. This was caught
by a coverity scan.

Fix this by changing req_speeds to be u16.

Reported-by: Bruce Allan <bruce.w.allan@intel.com>
Signed-off-by: Chinh T Cao <chinh.t.cao@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
[Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> rewrote commit message]
---
 drivers/net/ethernet/intel/ice/ice_type.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
index e5657be86c74..0ea428104215 100644
--- a/drivers/net/ethernet/intel/ice/ice_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_type.h
@@ -92,12 +92,12 @@ struct ice_link_status {
 	u64 phy_type_low;
 	u16 max_frame_size;
 	u16 link_speed;
+	u16 req_speeds;
 	u8 lse_ena;	/* Link Status Event notification */
 	u8 link_info;
 	u8 an_info;
 	u8 ext_info;
 	u8 pacing;
-	u8 req_speeds;
 	/* Refer to #define from module_type[ICE_MODULE_TYPE_TOTAL_BYTE] of
 	 * ice_aqc_get_phy_caps structure
 	 */
-- 
2.14.3

