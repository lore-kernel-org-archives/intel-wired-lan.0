From: Alice Michael <alice.michael@intel.com>
Date: Thu,  4 Oct 2018 15:18:25 -0700
Subject: [Intel-wired-lan] [next PATCH S97 2/7] i40e: Add capability flag
 for stopping FW LLDP
In-Reply-To: <20181004221830.16212-1-alice.michael@intel.com>
References: <20181004221830.16212-1-alice.michael@intel.com>
Message-ID: <20181004221830.16212-2-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Krzysztof Galazka <krzysztof.galazka@intel.com>

Add HW capability flag to indicate that firmware supports stopping
LLDP agent. This feature has been added in FW API 1.7 for XL710
devices and 1.6 for X722. Also raise expected minor version number
for X722 FW API to 6.

Signed-off-by: Krzysztof Galazka <krzysztof.galazka@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_adminq.c     | 6 ++++++
 drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h | 4 +++-
 drivers/net/ethernet/intel/i40e/i40e_type.h       | 1 +
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq.c b/drivers/net/ethernet/intel/i40e/i40e_adminq.c
index 501ee71..7ab61f6 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_adminq.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_adminq.c
@@ -588,6 +588,12 @@ i40e_status i40e_init_adminq(struct i40e_hw *hw)
 	    hw->aq.api_maj_ver == I40E_FW_API_VERSION_MAJOR &&
 	    hw->aq.api_min_ver >= I40E_MINOR_VER_GET_LINK_INFO_XL710) {
 		hw->flags |= I40E_HW_FLAG_AQ_PHY_ACCESS_CAPABLE;
+		hw->flags |= I40E_HW_FLAG_FW_LLDP_STOPPABLE;
+	}
+	if (hw->mac.type == I40E_MAC_X722 &&
+	    hw->aq.api_maj_ver == I40E_FW_API_VERSION_MAJOR &&
+	    hw->aq.api_min_ver >= I40E_MINOR_VER_FW_LLDP_STOPPABLE_X722) {
+		hw->flags |= I40E_HW_FLAG_FW_LLDP_STOPPABLE;
 	}
 
 	/* Newer versions of firmware require lock when reading the NVM */
diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h b/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
index 80e3eec..1150610 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
@@ -11,7 +11,7 @@
  */
 
 #define I40E_FW_API_VERSION_MAJOR	0x0001
-#define I40E_FW_API_VERSION_MINOR_X722	0x0005
+#define I40E_FW_API_VERSION_MINOR_X722	0x0006
 #define I40E_FW_API_VERSION_MINOR_X710	0x0007
 
 #define I40E_FW_MINOR_VERSION(_h) ((_h)->mac.type == I40E_MAC_XL710 ? \
@@ -20,6 +20,8 @@
 
 /* API version 1.7 implements additional link and PHY-specific APIs  */
 #define I40E_MINOR_VER_GET_LINK_INFO_XL710 0x0007
+/* API version 1.6 for X722 devices adds ability to stop FW LLDP agent */
+#define I40E_MINOR_VER_FW_LLDP_STOPPABLE_X722 0x0006
 
 struct i40e_aq_desc {
 	__le16 flags;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_type.h b/drivers/net/ethernet/intel/i40e/i40e_type.h
index 7df969c..17d9d78 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_type.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_type.h
@@ -615,6 +615,7 @@ struct i40e_hw {
 #define I40E_HW_FLAG_802_1AD_CAPABLE        BIT_ULL(1)
 #define I40E_HW_FLAG_AQ_PHY_ACCESS_CAPABLE  BIT_ULL(2)
 #define I40E_HW_FLAG_NVM_READ_REQUIRES_LOCK BIT_ULL(3)
+#define I40E_HW_FLAG_FW_LLDP_STOPPABLE	    BIT_ULL(4)
 	u64 flags;
 
 	/* Used in set switch config AQ command */
-- 
2.9.5

