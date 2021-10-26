From: Wang Hai <wanghai38@huawei.com>
Date: Tue, 26 Oct 2021 20:23:33 +0800
Subject: [Intel-wired-lan] [PATCH net-next] ice: fix error return code in
 ice_get_recp_frm_fw()
Message-ID: <20211026122333.3017952-1-wanghai38@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Return error code if devm_kmemdup() fails in ice_get_recp_frm_fw()

Fixes: fd2a6b71e300 ("ice: create advanced switch recipe")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wang Hai <wanghai38@huawei.com>
---
 drivers/net/ethernet/intel/ice/ice_switch.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
index 2742e1c1e33..373bcb5e4f4 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.c
+++ b/drivers/net/ethernet/intel/ice/ice_switch.c
@@ -1177,8 +1177,10 @@ ice_get_recp_frm_fw(struct ice_hw *hw, struct ice_sw_recipe *recps, u8 rid,
 	recps[rid].root_buf = devm_kmemdup(ice_hw_to_dev(hw), tmp,
 					   recps[rid].n_grp_count * sizeof(*recps[rid].root_buf),
 					   GFP_KERNEL);
-	if (!recps[rid].root_buf)
+	if (!recps[rid].root_buf) {
+		status = ICE_ERR_NO_MEMORY;
 		goto err_unroll;
+	}
 
 	/* Copy result indexes */
 	bitmap_copy(recps[rid].res_idxs, result_bm, ICE_MAX_FV_WORDS);
-- 
2.17.1

