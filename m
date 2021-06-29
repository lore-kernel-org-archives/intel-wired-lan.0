From: Radoslaw Tyl <radoslawx.tyl@intel.com>
Date: Tue, 29 Jun 2021 12:49:38 +0200
Subject: [Intel-wired-lan] [PATCH 2/5] ixgbevf: Improve error handling in
 mailbox
In-Reply-To: <20210629104941.2460721-1-radoslawx.tyl@intel.com>
References: <20210629104941.2460721-1-radoslawx.tyl@intel.com>
Message-ID: <20210629104941.2460721-3-radoslawx.tyl@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Add new handling for error codes:
 IXGBE_ERR_CONFIG - ixgbe_mbx_operations is not correctly set
 IXGBE_ERR_TIMEOUT - mailbox operation, e.g. poll for message, timeout

Signed-off-by: Radoslaw Tyl <radoslawx.tyl@intel.com>
---
 drivers/net/ethernet/intel/ixgbevf/defines.h |  3 +++
 drivers/net/ethernet/intel/ixgbevf/mbx.c     | 14 ++++++++++----
 drivers/net/ethernet/intel/ixgbevf/mbx.h     |  1 -
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/defines.h b/drivers/net/ethernet/intel/ixgbevf/defines.h
index 6bace746eaac..46fb1f9eab7f 100644
--- a/drivers/net/ethernet/intel/ixgbevf/defines.h
+++ b/drivers/net/ethernet/intel/ixgbevf/defines.h
@@ -281,6 +281,9 @@ struct ixgbe_adv_tx_context_desc {
 #define IXGBE_ERR_INVALID_MAC_ADDR	-1
 #define IXGBE_ERR_RESET_FAILED		-2
 #define IXGBE_ERR_INVALID_ARGUMENT	-3
+#define IXGBE_ERR_CONFIG		-4
+#define IXGBE_ERR_MBX			-5
+#define IXGBE_ERR_TIMEOUT		-6
 
 /* Transmit Config masks */
 #define IXGBE_TXDCTL_ENABLE		0x02000000 /* Ena specific Tx Queue */
diff --git a/drivers/net/ethernet/intel/ixgbevf/mbx.c b/drivers/net/ethernet/intel/ixgbevf/mbx.c
index 6bc1953263b9..2c3762cb467d 100644
--- a/drivers/net/ethernet/intel/ixgbevf/mbx.c
+++ b/drivers/net/ethernet/intel/ixgbevf/mbx.c
@@ -15,6 +15,9 @@ static s32 ixgbevf_poll_for_msg(struct ixgbe_hw *hw)
 	struct ixgbe_mbx_info *mbx = &hw->mbx;
 	int countdown = mbx->timeout;
 
+	if (!countdown || !mbx->ops.check_for_msg)
+		return IXGBE_ERR_CONFIG;
+
 	while (countdown && mbx->ops.check_for_msg(hw)) {
 		countdown--;
 		udelay(mbx->udelay);
@@ -24,7 +27,7 @@ static s32 ixgbevf_poll_for_msg(struct ixgbe_hw *hw)
 	if (!countdown)
 		mbx->timeout = 0;
 
-	return countdown ? 0 : IXGBE_ERR_MBX;
+	return countdown ? 0 : IXGBE_ERR_TIMEOUT;
 }
 
 /**
@@ -38,6 +41,9 @@ static s32 ixgbevf_poll_for_ack(struct ixgbe_hw *hw)
 	struct ixgbe_mbx_info *mbx = &hw->mbx;
 	int countdown = mbx->timeout;
 
+	if (!countdown || !mbx->ops.check_for_ack)
+		return IXGBE_ERR_CONFIG;
+
 	while (countdown && mbx->ops.check_for_ack(hw)) {
 		countdown--;
 		udelay(mbx->udelay);
@@ -47,7 +53,7 @@ static s32 ixgbevf_poll_for_ack(struct ixgbe_hw *hw)
 	if (!countdown)
 		mbx->timeout = 0;
 
-	return countdown ? 0 : IXGBE_ERR_MBX;
+	return countdown ? 0 : IXGBE_ERR_TIMEOUT;
 }
 
 /**
@@ -62,7 +68,7 @@ static s32 ixgbevf_poll_for_ack(struct ixgbe_hw *hw)
 static s32 ixgbevf_read_posted_mbx(struct ixgbe_hw *hw, u32 *msg, u16 size)
 {
 	struct ixgbe_mbx_info *mbx = &hw->mbx;
-	s32 ret_val = IXGBE_ERR_MBX;
+	s32 ret_val = IXGBE_ERR_CONFIG;
 
 	if (!mbx->ops.read)
 		goto out;
@@ -88,7 +94,7 @@ static s32 ixgbevf_read_posted_mbx(struct ixgbe_hw *hw, u32 *msg, u16 size)
 static s32 ixgbevf_write_posted_mbx(struct ixgbe_hw *hw, u32 *msg, u16 size)
 {
 	struct ixgbe_mbx_info *mbx = &hw->mbx;
-	s32 ret_val = IXGBE_ERR_MBX;
+	s32 ret_val = IXGBE_ERR_CONFIG;
 
 	/* exit if either we can't write or there isn't a defined timeout */
 	if (!mbx->ops.write || !mbx->timeout)
diff --git a/drivers/net/ethernet/intel/ixgbevf/mbx.h b/drivers/net/ethernet/intel/ixgbevf/mbx.h
index a461b7d16206..b3b83c95babf 100644
--- a/drivers/net/ethernet/intel/ixgbevf/mbx.h
+++ b/drivers/net/ethernet/intel/ixgbevf/mbx.h
@@ -7,7 +7,6 @@
 #include "vf.h"
 
 #define IXGBE_VFMAILBOX_SIZE	16 /* 16 32 bit words - 64 bytes */
-#define IXGBE_ERR_MBX		-100
 
 #define IXGBE_VFMAILBOX		0x002FC
 #define IXGBE_VFMBMEM		0x00200
-- 
2.27.0

