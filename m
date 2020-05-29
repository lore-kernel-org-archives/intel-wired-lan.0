From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Fri, 29 May 2020 13:01:22 -0700
Subject: [Intel-wired-lan] [next-queue v2] i40e: Add support for 5Gbps cards
Message-ID: <20200529200122.1471018-1-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Make possible for the i40e driver to bind to the new v710 for 5GBASE-T
NICs.

Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_common.c | 3 +++
 drivers/net/ethernet/intel/i40e/i40e_devids.h | 4 +++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index 4ab081953e19..afad5e9f80e0 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -27,6 +27,7 @@ i40e_status i40e_set_mac_type(struct i40e_hw *hw)
 		case I40E_DEV_ID_QSFP_A:
 		case I40E_DEV_ID_QSFP_B:
 		case I40E_DEV_ID_QSFP_C:
+		case I40E_DEV_ID_5G_BASE_T_BC:
 		case I40E_DEV_ID_10G_BASE_T:
 		case I40E_DEV_ID_10G_BASE_T4:
 		case I40E_DEV_ID_10G_BASE_T_BC:
@@ -4906,6 +4907,7 @@ i40e_status i40e_write_phy_register(struct i40e_hw *hw,
 		status = i40e_write_phy_register_clause22(hw, reg, phy_addr,
 							  value);
 		break;
+	case I40E_DEV_ID_5G_BASE_T_BC:
 	case I40E_DEV_ID_10G_BASE_T:
 	case I40E_DEV_ID_10G_BASE_T4:
 	case I40E_DEV_ID_10G_BASE_T_BC:
@@ -4943,6 +4945,7 @@ i40e_status i40e_read_phy_register(struct i40e_hw *hw,
 		status = i40e_read_phy_register_clause22(hw, reg, phy_addr,
 							 value);
 		break;
+	case I40E_DEV_ID_5G_BASE_T_BC:
 	case I40E_DEV_ID_10G_BASE_T:
 	case I40E_DEV_ID_10G_BASE_T4:
 	case I40E_DEV_ID_10G_BASE_T_BC:
diff --git a/drivers/net/ethernet/intel/i40e/i40e_devids.h b/drivers/net/ethernet/intel/i40e/i40e_devids.h
index 33df3bf2f73b..1bcb0ec0f0c0 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_devids.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_devids.h
@@ -23,8 +23,10 @@
 #define I40E_DEV_ID_10G_BASE_T_BC	0x15FF
 #define I40E_DEV_ID_10G_B		0x104F
 #define I40E_DEV_ID_10G_SFP		0x104E
+#define I40E_DEV_ID_5G_BASE_T_BC	0x101F
 #define I40E_IS_X710TL_DEVICE(d) \
-	((d) == I40E_DEV_ID_10G_BASE_T_BC)
+	(((d) == I40E_DEV_ID_5G_BASE_T_BC) || \
+	 ((d) == I40E_DEV_ID_10G_BASE_T_BC))
 #define I40E_DEV_ID_KX_X722		0x37CE
 #define I40E_DEV_ID_QSFP_X722		0x37CF
 #define I40E_DEV_ID_SFP_X722		0x37D0
-- 
2.26.2

