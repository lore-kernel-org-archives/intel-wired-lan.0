From: Alice Michael <alice.michael@intel.com>
Date: Wed,  6 Feb 2019 11:36:17 -0800
Subject: [Intel-wired-lan] [next PATCH S2 08/13] i40e: Changed maximum
 supported FW API version to 1.8
In-Reply-To: <20190206193622.69370-1-alice.michael@intel.com>
References: <20190206193622.69370-1-alice.michael@intel.com>
Message-ID: <20190206193622.69370-8-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Adam Ludkiewicz <adam.ludkiewicz@intel.com>

A new FW has been released, which uses API version 1.8.

Signed-off-by: Adam Ludkiewicz <adam.ludkiewicz@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h | 4 ++--
 drivers/net/ethernet/intel/iavf/i40e_adminq_cmd.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h b/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
index 11506102471c..522058a7d4be 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
@@ -11,8 +11,8 @@
  */
 
 #define I40E_FW_API_VERSION_MAJOR	0x0001
-#define I40E_FW_API_VERSION_MINOR_X722	0x0006
-#define I40E_FW_API_VERSION_MINOR_X710	0x0007
+#define I40E_FW_API_VERSION_MINOR_X722	0x0008
+#define I40E_FW_API_VERSION_MINOR_X710	0x0008
 
 #define I40E_FW_MINOR_VERSION(_h) ((_h)->mac.type == I40E_MAC_XL710 ? \
 					I40E_FW_API_VERSION_MINOR_X710 : \
diff --git a/drivers/net/ethernet/intel/iavf/i40e_adminq_cmd.h b/drivers/net/ethernet/intel/iavf/i40e_adminq_cmd.h
index af4f94a6541e..e5ae4a1c0cff 100644
--- a/drivers/net/ethernet/intel/iavf/i40e_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/iavf/i40e_adminq_cmd.h
@@ -14,7 +14,7 @@
 
 #define I40E_FW_API_VERSION_MAJOR	0x0001
 #define I40E_FW_API_VERSION_MINOR_X722	0x0005
-#define I40E_FW_API_VERSION_MINOR_X710	0x0007
+#define I40E_FW_API_VERSION_MINOR_X710	0x0008
 
 #define I40E_FW_MINOR_VERSION(_h) ((_h)->mac.type == I40E_MAC_XL710 ? \
 					I40E_FW_API_VERSION_MINOR_X710 : \
-- 
2.19.2

