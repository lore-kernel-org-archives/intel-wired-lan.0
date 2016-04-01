From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri,  1 Apr 2016 16:17:37 -0700
Subject: [Intel-wired-lan] [PATCH v1 7/9] fm10k: use different name than
	FM10K_VLAN_CLEAR for override bit
In-Reply-To: <1459552659-22959-1-git-send-email-jacob.e.keller@intel.com>
References: <1459552659-22959-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <1459552659-22959-8-git-send-email-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Use a new #define FM10K_VLAN_OVERRIDE even though we're using the exact
same bit. The reason for this is clarity in the code, otherwise you can
read FM10K_VLAN_CLEAR and think it should be removed. Also add a comment
explaining why the FM10K_VLAN_OVERRIDE bit is set.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_pf.c   | 8 ++++++--
 drivers/net/ethernet/intel/fm10k/fm10k_type.h | 1 +
 drivers/net/ethernet/intel/fm10k/fm10k_vf.c   | 2 +-
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pf.c b/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
index ffe98056755b..88d5acf484d0 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
@@ -864,9 +864,13 @@ static s32 fm10k_iov_assign_default_mac_vlan_pf(struct fm10k_hw *hw,
 	fm10k_write_reg(hw, FM10K_TQMAP(qmap_idx), 0);
 	fm10k_write_reg(hw, FM10K_TXDCTL(vf_q_idx), 0);
 
-	/* determine correct default VLAN ID */
+	/* Determine correct default VLAN ID. The FM10K_VLAN_OVERRIDE bit is
+	 * used here to indicate to the VF that it will not have privilege to
+	 * write VLAN_TABLE. All policy is enforced on the PF but this allows
+	 * the VF to correctly report errors to userspace rqeuests.
+	 */
 	if (vf_info->pf_vid)
-		vf_vid = vf_info->pf_vid | FM10K_VLAN_CLEAR;
+		vf_vid = vf_info->pf_vid | FM10K_VLAN_OVERRIDE;
 	else
 		vf_vid = vf_info->sw_vid;
 
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_type.h b/drivers/net/ethernet/intel/fm10k/fm10k_type.h
index 995dceefec25..f3f37a49806e 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_type.h
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_type.h
@@ -350,6 +350,7 @@ struct fm10k_hw;
 #define FM10K_VLAN_TABLE_VSI_MAX		64
 #define FM10K_VLAN_LENGTH_SHIFT			16
 #define FM10K_VLAN_CLEAR			BIT(15)
+#define FM10K_VLAN_OVERRIDE			FM10K_VLAN_CLEAR
 #define FM10K_VLAN_ALL \
 	((FM10K_VLAN_TABLE_VID_MAX - 1) << FM10K_VLAN_LENGTH_SHIFT)
 
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_vf.c b/drivers/net/ethernet/intel/fm10k/fm10k_vf.c
index 86c358c37d3f..801238dec624 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_vf.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_vf.c
@@ -228,7 +228,7 @@ s32 fm10k_msg_mac_vlan_vf(struct fm10k_hw *hw, u32 **results,
 
 	ether_addr_copy(hw->mac.perm_addr, perm_addr);
 	hw->mac.default_vid = vid & (FM10K_VLAN_TABLE_VID_MAX - 1);
-	hw->mac.vlan_override = !!(vid & FM10K_VLAN_CLEAR);
+	hw->mac.vlan_override = !!(vid & FM10K_VLAN_OVERRIDE);
 
 	return 0;
 }
-- 
2.8.0.rc1.177.g5628860

