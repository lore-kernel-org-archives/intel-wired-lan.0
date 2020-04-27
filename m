From: Wei Yongjun <weiyongjun1@huawei.com>
Date: Mon, 27 Apr 2020 12:12:28 +0000
Subject: [Intel-wired-lan] [PATCH net-next] ice: Fix error return code in
 ice_add_prof()
Message-ID: <20200427121228.12241-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Fix to return a error code from the error handling case
instead of 0, as done elsewhere in this function.

Fixes: 31ad4e4ee1e4 ("ice: Allocate flow profile")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/net/ethernet/intel/ice/ice_flex_pipe.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_flex_pipe.c b/drivers/net/ethernet/intel/ice/ice_flex_pipe.c
index 42bac3ec5526..e7a2671222d2 100644
--- a/drivers/net/ethernet/intel/ice/ice_flex_pipe.c
+++ b/drivers/net/ethernet/intel/ice/ice_flex_pipe.c
@@ -2962,8 +2962,10 @@ ice_add_prof(struct ice_hw *hw, enum ice_block blk, u64 id, u8 ptypes[],
 
 	/* add profile info */
 	prof = devm_kzalloc(ice_hw_to_dev(hw), sizeof(*prof), GFP_KERNEL);
-	if (!prof)
+	if (!prof) {
+		status = ICE_ERR_NO_MEMORY;
 		goto err_ice_add_prof;
+	}
 
 	prof->profile_cookie = id;
 	prof->prof_id = prof_id;



