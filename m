From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 15 Oct 2015 14:24:47 -0700
Subject: [Intel-wired-lan] [next-queue v3 07/17] fm10k: explicitly typecast
	vlan values to u16
In-Reply-To: <1444944297-9733-1-git-send-email-jacob.e.keller@intel.com>
References: <1444944297-9733-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <1444944297-9733-7-git-send-email-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_pf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pf.c b/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
index b1e09756a6ef..00f7a29e734f 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
@@ -1212,7 +1212,7 @@ s32 fm10k_iov_msg_mac_vlan_pf(struct fm10k_hw *hw, u32 **results,
 		set = !(vid & FM10K_VLAN_CLEAR);
 		vid &= ~FM10K_VLAN_CLEAR;
 
-		err = fm10k_iov_select_vid(vf_info, vid);
+		err = fm10k_iov_select_vid(vf_info, (u16)vid);
 		if (err < 0)
 			return err;
 		else
@@ -1242,7 +1242,7 @@ s32 fm10k_iov_msg_mac_vlan_pf(struct fm10k_hw *hw, u32 **results,
 		if (err < 0)
 			return err;
 		else
-			vlan = err;
+			vlan = (u16)err;
 
 		/* notify switch of request for new unicast address */
 		err = hw->mac.ops.update_uc_addr(hw, vf_info->glort,
@@ -1268,7 +1268,7 @@ s32 fm10k_iov_msg_mac_vlan_pf(struct fm10k_hw *hw, u32 **results,
 		if (err < 0)
 			return err;
 		else
-			vlan = err;
+			vlan = (u16)err;
 
 		/* notify switch of request for new multicast address */
 		err = hw->mac.ops.update_mc_addr(hw, vf_info->glort,
-- 
2.6.1.264.gbab76a9

