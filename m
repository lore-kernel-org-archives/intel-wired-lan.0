From: Mauro S. M. Rodrigues <maurosr@linux.vnet.ibm.com>
Date: Thu, 18 Jul 2019 14:52:02 -0300
Subject: [Intel-wired-lan] [PATCH] i40e: Check if transceiver implements DDM
 before access
Message-ID: <20190718175202.14909-1-maurosr@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Similar to the ixgbe issue fixed in:
655c91414579 ("ixgbe: Check DDM existence in transceiver before access)

i40e has the same issue when reading eeprom from SFP's module that comply
with SFF-8472 but not implement the Digital Diagnostic Monitoring (DDM)
interface described in it. The existence of such area is specified by bit
6 of byte 92, set to 1 if implemented.

Without this patch, due to not checking this bit i40e fails to read SFP
module's eeprom with the follow message:

ethtool -m enP51p1s0f0
Cannot get Module EEPROM data: Input/output error

Because it fails to read the additional 256 bytes in which it was assumed
to exist the DDM data.

Signed-off-by: "Mauro S. M. Rodrigues" <maurosr@linux.vnet.ibm.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 6 ++++++
 drivers/net/ethernet/intel/i40e/i40e_type.h    | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 527eb52c5401..e456e2122fea 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -5123,6 +5123,12 @@ static int i40e_get_module_info(struct net_device *netdev,
 			/* Module is not SFF-8472 compliant */
 			modinfo->type = ETH_MODULE_SFF_8079;
 			modinfo->eeprom_len = ETH_MODULE_SFF_8079_LEN;
+		} else if (!(sff8472_swap & I40E_MODULE_SFF_DDM_IMPLEMENTED)) {
+			/* Module is SFF-8472 compliant but doesn't implemend Digital Diagnostic
+			 * Monitoring (DDM).
+			 */
+			modinfo->type = ETH_MODULE_SFF_8079;
+			modinfo->eeprom_len = ETH_MODULE_SFF_8079_LEN;
 		} else {
 			modinfo->type = ETH_MODULE_SFF_8472;
 			modinfo->eeprom_len = ETH_MODULE_SFF_8472_LEN;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_type.h b/drivers/net/ethernet/intel/i40e/i40e_type.h
index 8f43aa47c263..2a6219d66771 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_type.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_type.h
@@ -443,6 +443,7 @@ struct i40e_nvm_access {
 #define I40E_MODULE_SFF_8472_COMP	0x5E
 #define I40E_MODULE_SFF_8472_SWAP	0x5C
 #define I40E_MODULE_SFF_ADDR_MODE	0x04
+#define I40E_MODULE_SFF_DDM_IMPLEMENTED 0x40
 #define I40E_MODULE_TYPE_QSFP_PLUS	0x0D
 #define I40E_MODULE_TYPE_QSFP28		0x11
 #define I40E_MODULE_QSFP_MAX_LEN	640
-- 
2.21.0

