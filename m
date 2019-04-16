From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Tue, 16 Apr 2019 10:30:38 -0700
Subject: [Intel-wired-lan] [PATCH S20 01/15] ice: Remove direct write for
 GLLAN_RCTL_0
In-Reply-To: <20190416173052.28928-1-anirudh.venkataramanan@intel.com>
References: <20190416173052.28928-1-anirudh.venkataramanan@intel.com>
Message-ID: <20190416173052.28928-2-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Clear PXE mode AQ call (opcode 0x0110) is now supported in FW. So
remove the direct register write to GLLAN_RCTL_0.

Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 87b75d42460b..a14c6ec219b3 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -51,9 +51,6 @@ static enum ice_status ice_set_mac_type(struct ice_hw *hw)
  */
 void ice_dev_onetime_setup(struct ice_hw *hw)
 {
-	/* configure Rx - set non pxe mode */
-	wr32(hw, GLLAN_RCTL_0, 0x1);
-
 #define MBX_PF_VT_PFALLOC	0x00231E80
 	/* set VFs per PF */
 	wr32(hw, MBX_PF_VT_PFALLOC, rd32(hw, PF_VT_PFALLOC_HIF));
-- 
2.20.1

