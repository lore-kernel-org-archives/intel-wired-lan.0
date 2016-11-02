From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed,  2 Nov 2016 16:44:44 -0700
Subject: [Intel-wired-lan] [PATCH 1/4] fm10k-shared: use mac-> instead of
	hw->mac.
Message-ID: <20161102234447.17181-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Ngai-Mint Kwan <ngai-mint.kwan@intel.com>

Since a pointer "mac" to fm10k_mac_info structure exists, use it to
access the contents of its members.

Signed-off-by: Ngai-Mint Kwan <ngai-mint.kwan@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_common.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_common.c b/drivers/net/ethernet/intel/fm10k/fm10k_common.c
index dd95ac4f4c64..62a6ad9b3eed 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_common.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_common.c
@@ -506,7 +506,7 @@ s32 fm10k_get_host_state_generic(struct fm10k_hw *hw, bool *host_ready)
 		goto out;
 
 	/* if we somehow dropped the Tx enable we should reset */
-	if (hw->mac.tx_ready && !(txdctl & FM10K_TXDCTL_ENABLE)) {
+	if (mac->tx_ready && !(txdctl & FM10K_TXDCTL_ENABLE)) {
 		ret_val = FM10K_ERR_RESET_REQUESTED;
 		goto out;
 	}
@@ -523,8 +523,8 @@ s32 fm10k_get_host_state_generic(struct fm10k_hw *hw, bool *host_ready)
 
 	/* interface cannot receive traffic without logical ports */
 	if (mac->dglort_map == FM10K_DGLORTMAP_NONE) {
-		if (hw->mac.ops.request_lport_map)
-			ret_val = hw->mac.ops.request_lport_map(hw);
+		if (mac->ops.request_lport_map)
+			ret_val = mac->ops.request_lport_map(hw);
 
 		goto out;
 	}
-- 
2.10.1.777.gd068e6b

