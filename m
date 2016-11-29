From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Mon, 28 Nov 2016 16:06:00 -0800
Subject: [Intel-wired-lan] [next PATCH S55 03/14] i40e: Remove FPK HyperV VF
	device ID
In-Reply-To: <1480377971-23412-1-git-send-email-bimmy.pujari@intel.com>
References: <1480377971-23412-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1480377971-23412-4-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jayaprakash Shanmugam <jayaprakash.shanmugam@intel.com>

Requirement for VFs to use the VMBus has been removed that's why
removing Hyper-V VF device ID.

Signed-off-by: Jayaprakash Shanmugam <jayaprakash.shanmugam@intel.com>
Change-ID: I84f0964f443ee0db3e5e444b5ace996eb71b8280
---
 drivers/net/ethernet/intel/i40evf/i40e_common.c | 1 -
 drivers/net/ethernet/intel/i40evf/i40e_devids.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40evf/i40e_common.c b/drivers/net/ethernet/intel/i40evf/i40e_common.c
index aa63b7f..b5a59dd 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_common.c
@@ -64,7 +64,6 @@ i40e_status i40e_set_mac_type(struct i40e_hw *hw)
 			hw->mac.type = I40E_MAC_X722;
 			break;
 		case I40E_DEV_ID_X722_VF:
-		case I40E_DEV_ID_X722_VF_HV:
 			hw->mac.type = I40E_MAC_X722_VF;
 			break;
 		case I40E_DEV_ID_VF:
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_devids.h b/drivers/net/ethernet/intel/i40evf/i40e_devids.h
index 21dcaee..d76393c 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_devids.h
+++ b/drivers/net/ethernet/intel/i40evf/i40e_devids.h
@@ -48,7 +48,6 @@
 #define I40E_DEV_ID_10G_BASE_T_X722	0x37D2
 #define I40E_DEV_ID_SFP_I_X722		0x37D3
 #define I40E_DEV_ID_X722_VF		0x37CD
-#define I40E_DEV_ID_X722_VF_HV		0x37D9
 
 #define i40e_is_40G_device(d)		((d) == I40E_DEV_ID_QSFP_A  || \
 					 (d) == I40E_DEV_ID_QSFP_B  || \
-- 
2.4.11

