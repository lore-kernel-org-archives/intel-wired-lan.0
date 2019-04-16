From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Tue, 16 Apr 2019 10:21:18 -0700
Subject: [Intel-wired-lan] [PATCH S18 05/15] ice: Do not unnecessarily
 initialize local variable
In-Reply-To: <20190416172128.27184-1-anirudh.venkataramanan@intel.com>
References: <20190416172128.27184-1-anirudh.venkataramanan@intel.com>
Message-ID: <20190416172128.27184-6-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bruce Allan <bruce.w.allan@intel.com>

The local variable speed does not need to be initialized and can cause some
static analysis tools to complain the initial assigned value is never used.

Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
[Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> cleaned up commit message]
---
 drivers/net/ethernet/intel/ice/ice_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 977e2a50dc93..28d7eacfb801 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -1880,10 +1880,10 @@ void
 ice_update_phy_type(u64 *phy_type_low, u64 *phy_type_high,
 		    u16 link_speeds_bitmap)
 {
-	u16 speed = ICE_AQ_LINK_SPEED_UNKNOWN;
 	u64 pt_high;
 	u64 pt_low;
 	int index;
+	u16 speed;
 
 	/* We first check with low part of phy_type */
 	for (index = 0; index <= ICE_PHY_TYPE_LOW_MAX_INDEX; index++) {
-- 
2.20.1

