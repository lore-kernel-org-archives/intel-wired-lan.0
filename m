From: Alice Michael <alice.michael@intel.com>
Date: Tue, 23 Jul 2019 06:03:37 -0400
Subject: [Intel-wired-lan] [next PATCH S8 04/12] i40e: Update FVL FW API
 version to 1.9
In-Reply-To: <20190723100345.57522-1-alice.michael@intel.com>
References: <20190723100345.57522-1-alice.michael@intel.com>
Message-ID: <20190723100345.57522-4-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Piotr Azarewicz <piotr.azarewicz@intel.com>

Upcoming FVL FW increment API version to 1.9 due to Extend PHY access AQ
command support. SW is ready for that support as well.

Signed-off-by: Piotr Azarewicz <piotr.azarewicz@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h b/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
index 4d966d80305f..360f0cb83b2d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
@@ -12,7 +12,7 @@
 
 #define I40E_FW_API_VERSION_MAJOR	0x0001
 #define I40E_FW_API_VERSION_MINOR_X722	0x0008
-#define I40E_FW_API_VERSION_MINOR_X710	0x0008
+#define I40E_FW_API_VERSION_MINOR_X710	0x0009
 
 #define I40E_FW_MINOR_VERSION(_h) ((_h)->mac.type == I40E_MAC_XL710 ? \
 					I40E_FW_API_VERSION_MINOR_X710 : \
-- 
2.21.0

