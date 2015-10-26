From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 26 Oct 2015 16:32:06 -0700
Subject: [Intel-wired-lan] [next-queue 5/6] fm10k: remove namespace
	pollution of fm10k_iov_msg_data_pf
In-Reply-To: <1445902327-6717-1-git-send-email-jacob.e.keller@intel.com>
References: <1445902327-6717-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <1445902327-6717-5-git-send-email-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_pf.c | 8 --------
 drivers/net/ethernet/intel/fm10k/fm10k_pf.h | 1 -
 2 files changed, 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pf.c b/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
index 3f9aa2f4311d..c7e09592c1f6 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
@@ -1413,14 +1413,6 @@ s32 fm10k_iov_msg_lport_state_pf(struct fm10k_hw *hw, u32 **results,
 	return err;
 }
 
-const struct fm10k_msg_data fm10k_iov_msg_data_pf[] = {
-	FM10K_TLV_MSG_TEST_HANDLER(fm10k_tlv_msg_test),
-	FM10K_VF_MSG_MSIX_HANDLER(fm10k_iov_msg_msix_pf),
-	FM10K_VF_MSG_MAC_VLAN_HANDLER(fm10k_iov_msg_mac_vlan_pf),
-	FM10K_VF_MSG_LPORT_STATE_HANDLER(fm10k_iov_msg_lport_state_pf),
-	FM10K_TLV_MSG_ERROR_HANDLER(fm10k_tlv_msg_error),
-};
-
 /**
  *  fm10k_update_stats_hw_pf - Updates hardware related statistics of PF
  *  @hw: pointer to hardware structure
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pf.h b/drivers/net/ethernet/intel/fm10k/fm10k_pf.h
index 40a0dbc62a04..9d77daa777bb 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pf.h
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pf.h
@@ -129,7 +129,6 @@ s32 fm10k_iov_msg_mac_vlan_pf(struct fm10k_hw *, u32 **,
 			      struct fm10k_mbx_info *);
 s32 fm10k_iov_msg_lport_state_pf(struct fm10k_hw *, u32 **,
 				 struct fm10k_mbx_info *);
-extern const struct fm10k_msg_data fm10k_iov_msg_data_pf[];
 
 extern struct fm10k_info fm10k_pf_info;
 #endif /* _FM10K_PF_H */
-- 
2.6.1.264.gbab76a9

