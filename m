From: Mark D Rustad <mark.d.rustad@intel.com>
Date: Sat, 08 Aug 2015 16:27:46 -0700
Subject: [Intel-wired-lan] [PATCH] ixgbe: Only clear adapter_stopped if
 ixgbe_setup_fc succeeded
Message-ID: <20150808232746.95142.70671.stgit@mdrustad-wks.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

A logic error here results in the adapter_stopped flag only being
cleared when ixgbe_setup_fc returns an error. Correct the logic.

Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_common.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
index aa5c6d06cf04..5085fa93675e 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
@@ -297,13 +297,13 @@ s32 ixgbe_start_hw_generic(struct ixgbe_hw *hw)
 
 	/* Setup flow control */
 	ret_val = ixgbe_setup_fc(hw);
-	if (!ret_val)
-		return 0;
+	if (ret_val)
+		return ret_val;
 
 	/* Clear adapter stopped flag */
 	hw->adapter_stopped = false;
 
-	return ret_val;
+	return 0;
 }
 
 /**

