From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 26 Oct 2015 16:32:05 -0700
Subject: [Intel-wired-lan] [next-queue 4/6] fm10k: remove unnecessary else
	block from if statements with return
In-Reply-To: <1445902327-6717-1-git-send-email-jacob.e.keller@intel.com>
References: <1445902327-6717-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <1445902327-6717-4-git-send-email-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Improve code style by removing the unnecessary else block of an if
statement which immediately returns.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_pf.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pf.c b/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
index f45e0bad41a9..3f9aa2f4311d 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
@@ -1232,8 +1232,8 @@ s32 fm10k_iov_msg_mac_vlan_pf(struct fm10k_hw *hw, u32 **results,
 		err = fm10k_iov_select_vid(vf_info, (u16)vid);
 		if (err < 0)
 			return err;
-		else
-			vid = err;
+
+		vid = err;
 
 		/* update VSI info for VF in regards to VLAN table */
 		err = hw->mac.ops.update_vlan(hw, vid, vf_info->vsi, set);
@@ -1258,8 +1258,8 @@ s32 fm10k_iov_msg_mac_vlan_pf(struct fm10k_hw *hw, u32 **results,
 		err = fm10k_iov_select_vid(vf_info, vlan);
 		if (err < 0)
 			return err;
-		else
-			vlan = (u16)err;
+
+		vlan = (u16)err;
 
 		/* notify switch of request for new unicast address */
 		err = hw->mac.ops.update_uc_addr(hw, vf_info->glort,
@@ -1284,8 +1284,8 @@ s32 fm10k_iov_msg_mac_vlan_pf(struct fm10k_hw *hw, u32 **results,
 		err = fm10k_iov_select_vid(vf_info, vlan);
 		if (err < 0)
 			return err;
-		else
-			vlan = (u16)err;
+
+		vlan = (u16)err;
 
 		/* notify switch of request for new multicast address */
 		err = hw->mac.ops.update_mc_addr(hw, vf_info->glort,
-- 
2.6.1.264.gbab76a9

