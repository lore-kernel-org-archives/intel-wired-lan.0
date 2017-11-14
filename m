From: Alice Michael <alice.michael@intel.com>
Date: Tue, 14 Nov 2017 07:00:48 -0500
Subject: [Intel-wired-lan] [next PATCH S82-V4 5/9] i40e: track id can be 0
In-Reply-To: <20171114120052.86665-1-alice.michael@intel.com>
References: <20171114120052.86665-1-alice.michael@intel.com>
Message-ID: <20171114120052.86665-5-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jingjing Wu <jingjing.wu@intel.com>

track_id == 0 is valid for ?read only? profiles when
profile does not have any ?write? commands.

Signed-off-by: Jingjing Wu <jingjing.wu@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_common.c   | 5 -----
 drivers/net/ethernet/intel/i40evf/i40e_common.c | 5 -----
 2 files changed, 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index 9ef7a0c..5abc83c 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -5357,11 +5357,6 @@ i40e_write_profile(struct i40e_hw *hw, struct i40e_profile_segment *profile,
 	u32 offset = 0, info = 0;
 	u32 i;
 
-	if (!track_id) {
-		i40e_debug(hw, I40E_DEBUG_PACKAGE, "Track_id can't be 0.");
-		return I40E_NOT_SUPPORTED;
-	}
-
 	dev_cnt = profile->device_table_count;
 
 	for (i = 0; i < dev_cnt; i++) {
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_common.c b/drivers/net/ethernet/intel/i40evf/i40e_common.c
index c1e4732..a946484 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_common.c
@@ -1330,11 +1330,6 @@ i40evf_write_profile(struct i40e_hw *hw, struct i40e_profile_segment *profile,
 	u32 offset = 0, info = 0;
 	u32 i;
 
-	if (!track_id) {
-		i40e_debug(hw, I40E_DEBUG_PACKAGE, "Track_id can't be 0.");
-		return I40E_NOT_SUPPORTED;
-	}
-
 	dev_cnt = profile->device_table_count;
 
 	for (i = 0; i < dev_cnt; i++) {
-- 
2.9.5

