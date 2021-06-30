From: Radoslaw Tyl <radoslawx.tyl@intel.com>
Date: Wed, 30 Jun 2021 10:15:30 +0200
Subject: [Intel-wired-lan] [PATCH v2 3/5] ixgbevf: Add legacy suffix to old
 API mailbox functions
In-Reply-To: <20210630081532.3069914-1-radoslawx.tyl@intel.com>
References: <20210630081532.3069914-1-radoslawx.tyl@intel.com>
Message-ID: <20210630081532.3069914-4-radoslawx.tyl@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Add legacy suffix to mailbox functions which should be backwards compatible
with older PF drivers. Communication during API negotiation always has to
be done using the earlier implementation.

Signed-off-by: Radoslaw Tyl <radoslawx.tyl@intel.com>
---
 drivers/net/ethernet/intel/ixgbevf/ixgbevf.h      |  2 +-
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |  2 +-
 drivers/net/ethernet/intel/ixgbevf/mbx.c          | 14 +++++++-------
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h b/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
index a0e325774819..5d9284dd04dc 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
@@ -429,7 +429,7 @@ extern const struct ixgbevf_info ixgbevf_82599_vf_info;
 extern const struct ixgbevf_info ixgbevf_X540_vf_info;
 extern const struct ixgbevf_info ixgbevf_X550_vf_info;
 extern const struct ixgbevf_info ixgbevf_X550EM_x_vf_info;
-extern const struct ixgbe_mbx_operations ixgbevf_mbx_ops;
+extern const struct ixgbe_mbx_operations ixgbevf_mbx_ops_legacy;
 extern const struct ixgbevf_info ixgbevf_x550em_a_vf_info;
 
 extern const struct ixgbevf_info ixgbevf_82599_vf_hv_info;
diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index dc56931fc1dc..e9b99929588b 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -4567,7 +4567,7 @@ static int ixgbevf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	memcpy(&hw->mac.ops, ii->mac_ops, sizeof(hw->mac.ops));
 	hw->mac.type  = ii->mac;
 
-	memcpy(&hw->mbx.ops, &ixgbevf_mbx_ops,
+	memcpy(&hw->mbx.ops, &ixgbevf_mbx_ops_legacy,
 	       sizeof(struct ixgbe_mbx_operations));
 
 	/* setup the private structure */
diff --git a/drivers/net/ethernet/intel/ixgbevf/mbx.c b/drivers/net/ethernet/intel/ixgbevf/mbx.c
index 2c3762cb467d..0edcfcbf5296 100644
--- a/drivers/net/ethernet/intel/ixgbevf/mbx.c
+++ b/drivers/net/ethernet/intel/ixgbevf/mbx.c
@@ -224,14 +224,14 @@ static s32 ixgbevf_obtain_mbx_lock_vf(struct ixgbe_hw *hw)
 }
 
 /**
- *  ixgbevf_write_mbx_vf - Write a message to the mailbox
+ *  ixgbevf_write_mbx_vf_legacy - Write a message to the mailbox
  *  @hw: pointer to the HW structure
  *  @msg: The message buffer
  *  @size: Length of buffer
  *
  *  returns 0 if it successfully copied message into the buffer
  **/
-static s32 ixgbevf_write_mbx_vf(struct ixgbe_hw *hw, u32 *msg, u16 size)
+static s32 ixgbevf_write_mbx_vf_legacy(struct ixgbe_hw *hw, u32 *msg, u16 size)
 {
 	s32 ret_val;
 	u16 i;
@@ -260,14 +260,14 @@ static s32 ixgbevf_write_mbx_vf(struct ixgbe_hw *hw, u32 *msg, u16 size)
 }
 
 /**
- *  ixgbevf_read_mbx_vf - Reads a message from the inbox intended for VF
+ *  ixgbevf_read_mbx_vf_legacy - Reads a message from the inbox intended for VF
  *  @hw: pointer to the HW structure
  *  @msg: The message buffer
  *  @size: Length of buffer
  *
  *  returns 0 if it successfully read message from buffer
  **/
-static s32 ixgbevf_read_mbx_vf(struct ixgbe_hw *hw, u32 *msg, u16 size)
+static s32 ixgbevf_read_mbx_vf_legacy(struct ixgbe_hw *hw, u32 *msg, u16 size)
 {
 	s32 ret_val = 0;
 	u16 i;
@@ -318,10 +318,10 @@ static s32 ixgbevf_init_mbx_params_vf(struct ixgbe_hw *hw)
 	return 0;
 }
 
-const struct ixgbe_mbx_operations ixgbevf_mbx_ops = {
+const struct ixgbe_mbx_operations ixgbevf_mbx_ops_legacy = {
 	.init_params	= ixgbevf_init_mbx_params_vf,
-	.read		= ixgbevf_read_mbx_vf,
-	.write		= ixgbevf_write_mbx_vf,
+	.read		= ixgbevf_read_mbx_vf_legacy,
+	.write		= ixgbevf_write_mbx_vf_legacy,
 	.read_posted	= ixgbevf_read_posted_mbx,
 	.write_posted	= ixgbevf_write_posted_mbx,
 	.check_for_msg	= ixgbevf_check_for_msg_vf,
-- 
2.27.0

