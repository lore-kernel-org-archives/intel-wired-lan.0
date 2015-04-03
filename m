From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Fri,  3 Apr 2015 13:27:15 -0700
Subject: [Intel-wired-lan] [net-next 25/25] fm10k: corrected VF multicast
	update
In-Reply-To: <1428092835-16834-1-git-send-email-jeffrey.t.kirsher@intel.com>
References: <1428092835-16834-1-git-send-email-jeffrey.t.kirsher@intel.com>
Message-ID: <1428092835-16834-25-git-send-email-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

VFs were being improperly added to the switch's multicast group. The
error stems from the fact that incorrect arguments were passed to the
"update_mc_addr" function. It would seem to be a copy paste error since
the parameters are similar to the "update_uc_addr" function.

Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Ngai-Mint Kwan <ngai-mint.kwan@intel.com>
Acked-by: Matthew Vick <matthew.vick@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_pf.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pf.c b/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
index be80024..30264d8 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
@@ -334,6 +334,9 @@ static s32 fm10k_update_xc_addr_pf(struct fm10k_hw *hw, u16 glort,
 	struct fm10k_mac_update mac_update;
 	u32 msg[5];
 
+	/* clear set bit from VLAN ID */
+	vid &= ~FM10K_VLAN_CLEAR;
+
 	/* if glort or vlan are not valid return error */
 	if (!fm10k_glort_valid_pf(hw, glort) || vid >= FM10K_VLAN_TABLE_VID_MAX)
 		return FM10K_ERR_PARAM;
@@ -1264,8 +1267,8 @@ s32 fm10k_iov_msg_mac_vlan_pf(struct fm10k_hw *hw, u32 **results,
 		}
 
 		/* notify switch of request for new multicast address */
-		err = hw->mac.ops.update_mc_addr(hw, vf_info->glort, mac,
-						 !(vlan & FM10K_VLAN_CLEAR), 0);
+		err = hw->mac.ops.update_mc_addr(hw, vf_info->glort, mac, vlan,
+						 !(vlan & FM10K_VLAN_CLEAR));
 	}
 
 	return err;
-- 
1.9.3

