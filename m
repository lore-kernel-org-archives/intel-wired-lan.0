From: Mark D Rustad <mark.d.rustad@intel.com>
Date: Fri, 18 Mar 2016 11:33:00 -0700
Subject: [Intel-wired-lan] [PATCH V2 3/7] ixgbe: Add new semaphore method
	for a new MAC
In-Reply-To: <20160318183203.40415.3005.stgit@mdrustad-wks.jf.intel.com>
References: <20160318183203.40415.3005.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <20160318183300.40415.74097.stgit@mdrustad-wks.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Add a new method to support the firmware token used as a semaphore
for phy access on a new mac.

Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c |   53 +++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
index aaea94759d76..615aaea069b6 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
@@ -2428,6 +2428,59 @@ static void ixgbe_release_swfw_sync_X550em(struct ixgbe_hw *hw, u32 mask)
 	ixgbe_release_swfw_sync_X540(hw, mask);
 }
 
+/**
+ * ixgbe_acquire_swfw_sync_x550em_a - Acquire SWFW semaphore
+ * @hw: pointer to hardware structure
+ * @mask: Mask to specify which semaphore to acquire
+ *
+ * Acquires the SWFW semaphore and get the shared phy token as needed
+ */
+static s32 ixgbe_acquire_swfw_sync_x550em_a(struct ixgbe_hw *hw, u32 mask)
+{
+	u32 hmask = mask & ~IXGBE_GSSR_TOKEN_SM;
+	int retries = FW_PHY_TOKEN_RETRIES;
+	s32 status;
+
+	while (--retries) {
+		status = 0;
+		if (hmask)
+			status = ixgbe_acquire_swfw_sync_X540(hw, hmask);
+		if (status)
+			return status;
+		if (!(mask & IXGBE_GSSR_TOKEN_SM))
+			return 0;
+
+		status = ixgbe_get_phy_token(hw);
+		if (!status)
+			return 0;
+		if (hmask)
+			ixgbe_release_swfw_sync_X540(hw, hmask);
+		if (status != IXGBE_ERR_TOKEN_RETRY)
+			return status;
+		udelay(FW_PHY_TOKEN_DELAY * 1000);
+	}
+
+	return status;
+}
+
+/**
+ * ixgbe_release_swfw_sync_x550em_a - Release SWFW semaphore
+ * @hw: pointer to hardware structure
+ * @mask: Mask to specify which semaphore to release
+ *
+ * Release the SWFW semaphore and puts the shared phy token as needed
+ */
+static void ixgbe_release_swfw_sync_x550em_a(struct ixgbe_hw *hw, u32 mask)
+{
+	u32 hmask = mask & ~IXGBE_GSSR_TOKEN_SM;
+
+	if (mask & IXGBE_GSSR_TOKEN_SM)
+		ixgbe_put_phy_token(hw);
+
+	if (hmask)
+		ixgbe_release_swfw_sync_X540(hw, hmask);
+}
+
 #define X550_COMMON_MAC \
 	.init_hw			= &ixgbe_init_hw_generic, \
 	.start_hw			= &ixgbe_start_hw_X540, \

