From: Alice Michael <alice.michael@intel.com>
Date: Wed, 23 Oct 2019 03:19:57 -0700
Subject: [Intel-wired-lan] [PATCH] i40e: enable X710 support
Message-ID: <20191023101957.19272-1-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The I40E_DEV_ID_10G_BASE_T_BC device id was added previously,
but was not enabled in all the appropriate places.  Adding it
to enable it's use.

Signed-off-by: Alice Michael <alice.michael@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_common.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index 8b25a6d9c81d..a0791447849a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -29,6 +29,7 @@ i40e_status i40e_set_mac_type(struct i40e_hw *hw)
 		case I40E_DEV_ID_QSFP_C:
 		case I40E_DEV_ID_10G_BASE_T:
 		case I40E_DEV_ID_10G_BASE_T4:
+		case I40E_DEV_ID_10G_BASE_T_BC:
 		case I40E_DEV_ID_10G_B:
 		case I40E_DEV_ID_10G_SFP:
 		case I40E_DEV_ID_20G_KR2:
@@ -4910,6 +4911,7 @@ i40e_status i40e_write_phy_register(struct i40e_hw *hw,
 		break;
 	case I40E_DEV_ID_10G_BASE_T:
 	case I40E_DEV_ID_10G_BASE_T4:
+	case I40E_DEV_ID_10G_BASE_T_BC:
 	case I40E_DEV_ID_10G_BASE_T_X722:
 	case I40E_DEV_ID_25G_B:
 	case I40E_DEV_ID_25G_SFP28:
-- 
2.21.0

