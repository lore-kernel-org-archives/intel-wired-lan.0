From: Mark D Rustad <mark.d.rustad@intel.com>
Date: Wed, 26 Aug 2015 14:10:22 -0700
Subject: [Intel-wired-lan] [PATCH] ixgbe: Fix CS4227-related semaphore error
	on reset failure
Message-ID: <20150826211022.8036.69298.stgit@mdrustad-wks.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

If the reset never completes, it is necessary to retake the
semaphore before returning, because the caller will release
the semaphore.

Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
index 6a31bc4ca5e4..028e35a5022b 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
@@ -193,6 +193,7 @@ static s32 ixgbe_write_pe(struct ixgbe_hw *hw, u8 reg, u8 value)
 /** ixgbe_reset_cs4227 - Reset CS4227 using port expander
  * @hw: pointer to hardware structure
  *
+ * This function assumes that the caller has acquired the proper semaphore.
  * Returns error code
  */
 static s32 ixgbe_reset_cs4227(struct ixgbe_hw *hw)
@@ -290,6 +291,14 @@ static void ixgbe_check_cs4227(struct ixgbe_hw *hw)
 		hw->mac.ops.release_swfw_sync(hw, swfw_mask);
 		msleep(IXGBE_CS4227_CHECK_DELAY);
 	}
+	/* If still pending, assume other instance failed. */
+	if (retry == IXGBE_CS4227_RETRIES) {
+		status = hw->mac.ops.acquire_swfw_sync(hw, swfw_mask);
+		if (status) {
+			hw_err(hw, "semaphore failed with %d\n", status);
+			return;
+		}
+	}
 
 	/* Reset the CS4227. */
 	status = ixgbe_reset_cs4227(hw);

