From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon,  8 Jul 2019 16:12:27 -0700
Subject: [Intel-wired-lan] [PATCH 10/19] fm10k: reduce the scope of the
 result local variable
In-Reply-To: <20190708231236.20516-1-jacob.e.keller@intel.com>
References: <20190708231236.20516-1-jacob.e.keller@intel.com>
Message-ID: <20190708231236.20516-11-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Reduce the scope of the result local variable in the
fm10k_iov_msg_lport_state_pf function.

This was detected by cppcheck and resolves the following warning
produced by that tool:

[fm10k_pf.c:1435]: (style) The scope of the variable 'result' can be
reduced.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_pf.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pf.c b/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
index cb4d02629b86..e85b2f2eef05 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
@@ -1352,7 +1352,6 @@ s32 fm10k_iov_msg_lport_state_pf(struct fm10k_hw *hw, u32 **results,
 				 struct fm10k_mbx_info *mbx)
 {
 	struct fm10k_vf_info *vf_info = (struct fm10k_vf_info *)mbx;
-	u32 *result;
 	s32 err = 0;
 	u32 msg[2];
 	u8 mode = 0;
@@ -1362,7 +1361,7 @@ s32 fm10k_iov_msg_lport_state_pf(struct fm10k_hw *hw, u32 **results,
 		return FM10K_ERR_PARAM;
 
 	if (!!results[FM10K_LPORT_STATE_MSG_XCAST_MODE]) {
-		result = results[FM10K_LPORT_STATE_MSG_XCAST_MODE];
+		u32 *result = results[FM10K_LPORT_STATE_MSG_XCAST_MODE];
 
 		/* XCAST mode update requested */
 		err = fm10k_tlv_attr_get_u8(result, &mode);
-- 
2.22.0.214.g8dca754b1e87

