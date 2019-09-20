From: Alice Michael <alice.michael@intel.com>
Date: Fri, 20 Sep 2019 02:17:18 -0700
Subject: [Intel-wired-lan] [next PATCH S10 04/10] i40e: Extract detection of
 HW flags into a function
In-Reply-To: <20190920091724.51767-1-alice.michael@intel.com>
References: <20190920091724.51767-1-alice.michael@intel.com>
Message-ID: <20190920091724.51767-4-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Piotr Azarewicz <piotr.azarewicz@intel.com>

Move code detecting HW flags based on device type and FW API version
into a single function.

Signed-off-by: Piotr Azarewicz <piotr.azarewicz@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_adminq.c | 71 +++++++++++++++----
 drivers/net/ethernet/intel/i40e/i40e_common.c |  4 --
 2 files changed, 58 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq.c b/drivers/net/ethernet/intel/i40e/i40e_adminq.c
index 72c04881d290..9f0a4e92a231 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_adminq.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_adminq.c
@@ -507,6 +507,59 @@ static i40e_status i40e_shutdown_arq(struct i40e_hw *hw)
 	return ret_code;
 }
 
+/**
+ *  i40e_set_hw_flags - set HW flags
+ *  @hw: pointer to the hardware structure
+ **/
+static void i40e_set_hw_flags(struct i40e_hw *hw)
+{
+	struct i40e_adminq_info *aq = &hw->aq;
+
+	hw->flags = 0;
+
+	switch (hw->mac.type) {
+	case I40E_MAC_XL710:
+		if (aq->api_maj_ver > 1 ||
+		    (aq->api_maj_ver == 1 &&
+		     aq->api_min_ver >= I40E_MINOR_VER_GET_LINK_INFO_XL710)) {
+			hw->flags |= I40E_HW_FLAG_AQ_PHY_ACCESS_CAPABLE;
+			hw->flags |= I40E_HW_FLAG_FW_LLDP_STOPPABLE;
+			/* The ability to RX (not drop) 802.1ad frames */
+			hw->flags |= I40E_HW_FLAG_802_1AD_CAPABLE;
+		}
+		break;
+	case I40E_MAC_X722:
+		hw->flags |= I40E_HW_FLAG_AQ_SRCTL_ACCESS_ENABLE |
+			     I40E_HW_FLAG_NVM_READ_REQUIRES_LOCK;
+
+		if (aq->api_maj_ver > 1 ||
+		    (aq->api_maj_ver == 1 &&
+		     aq->api_min_ver >= I40E_MINOR_VER_FW_LLDP_STOPPABLE_X722))
+			hw->flags |= I40E_HW_FLAG_FW_LLDP_STOPPABLE;
+		/* fall through */
+	default:
+		break;
+	}
+
+	/* Newer versions of firmware require lock when reading the NVM */
+	if (aq->api_maj_ver > 1 ||
+	    (aq->api_maj_ver == 1 &&
+	     aq->api_min_ver >= 5))
+		hw->flags |= I40E_HW_FLAG_NVM_READ_REQUIRES_LOCK;
+
+	if (aq->api_maj_ver > 1 ||
+	    (aq->api_maj_ver == 1 &&
+	     aq->api_min_ver >= 8)) {
+		hw->flags |= I40E_HW_FLAG_FW_LLDP_PERSISTENT;
+		hw->flags |= I40E_HW_FLAG_DROP_MODE;
+	}
+
+	if (aq->api_maj_ver > 1 ||
+	    (aq->api_maj_ver == 1 &&
+	     aq->api_min_ver >= 9))
+		hw->flags |= I40E_HW_FLAG_AQ_PHY_ACCESS_EXTENDED;
+}
+
 /**
  *  i40e_init_adminq - main initialization routine for Admin Queue
  *  @hw: pointer to the hardware structure
@@ -571,6 +624,11 @@ i40e_status i40e_init_adminq(struct i40e_hw *hw)
 	if (ret_code != I40E_SUCCESS)
 		goto init_adminq_free_arq;
 
+	/* Some features were introduced in different FW API version
+	 * for different MAC type.
+	 */
+	i40e_set_hw_flags(hw);
+
 	/* get the NVM version info */
 	i40e_read_nvm_word(hw, I40E_SR_NVM_DEV_STARTER_VERSION,
 			   &hw->nvm.version);
@@ -596,25 +654,12 @@ i40e_status i40e_init_adminq(struct i40e_hw *hw)
 		hw->flags |= I40E_HW_FLAG_FW_LLDP_STOPPABLE;
 	}
 
-	/* Newer versions of firmware require lock when reading the NVM */
-	if (hw->aq.api_maj_ver > 1 ||
-	    (hw->aq.api_maj_ver == 1 &&
-	     hw->aq.api_min_ver >= 5))
-		hw->flags |= I40E_HW_FLAG_NVM_READ_REQUIRES_LOCK;
-
 	/* The ability to RX (not drop) 802.1ad frames was added in API 1.7 */
 	if (hw->aq.api_maj_ver > 1 ||
 	    (hw->aq.api_maj_ver == 1 &&
 	     hw->aq.api_min_ver >= 7))
 		hw->flags |= I40E_HW_FLAG_802_1AD_CAPABLE;
 
-	if (hw->aq.api_maj_ver > 1 ||
-	    (hw->aq.api_maj_ver == 1 &&
-	     hw->aq.api_min_ver >= 8)) {
-		hw->flags |= I40E_HW_FLAG_FW_LLDP_PERSISTENT;
-		hw->flags |= I40E_HW_FLAG_DROP_MODE;
-	}
-
 	if (hw->aq.api_maj_ver > I40E_FW_API_VERSION_MAJOR) {
 		ret_code = I40E_ERR_FIRMWARE_API_VERSION;
 		goto init_adminq_free_arq;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index f1d67267c983..fe553bb23d7a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -933,10 +933,6 @@ i40e_status i40e_init_shared_code(struct i40e_hw *hw)
 	else
 		hw->pf_id = (u8)(func_rid & 0x7);
 
-	if (hw->mac.type == I40E_MAC_X722)
-		hw->flags |= I40E_HW_FLAG_AQ_SRCTL_ACCESS_ENABLE |
-			     I40E_HW_FLAG_NVM_READ_REQUIRES_LOCK;
-
 	status = i40e_init_nvm(hw);
 	return status;
 }
-- 
2.21.0

