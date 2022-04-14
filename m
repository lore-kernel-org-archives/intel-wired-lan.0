From: Jeff Daly <jeffd@silicom-usa.com>
Date: Thu, 14 Apr 2022 16:13:29 -0400
Subject: [Intel-wired-lan] [PATCH v2] ixgbe: Treat 1G Cu SFPs as 1G SX for
 X550EM
In-Reply-To: <20220414172020.22396-1-jeffd@silicom-usa.com>
References: <20220414172020.22396-1-jeffd@silicom-usa.com>
Message-ID: <20220414201329.27714-1-jeffd@silicom-usa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

X550EM NICs do not support 1G Cu SFPs by default from Intel, this patch
enables treating these SFPs as 1G SX SFPs via a module parameter similar to
the parameter that allows the driver to be able to recognize unsupported
(by Intel) SFPs.

Signed-off-by: Jeff Daly <jeffd@silicom-usa.com>

---

v2:
* Make module_param option a boolean, fix commit message.
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  8 ++++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |  1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c | 16 +++++++++++++++-
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index c4a4954aa317..b02345b82cae 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -156,6 +156,11 @@ module_param(allow_unsupported_sfp, uint, 0);
 MODULE_PARM_DESC(allow_unsupported_sfp,
 		 "Allow unsupported and untested SFP+ modules on 82599-based adapters");
 
+static bool cu_sfp_as_sx;
+module_param(cu_sfp_as_sx, bool, 0);
+MODULE_PARM_DESC(cu_sfp_as_sx,
+		 "Allow treating 1G Cu SFP modules as 1G SX modules on X550-based adapters");
+
 #define DEFAULT_MSG_ENABLE (NETIF_MSG_DRV|NETIF_MSG_PROBE|NETIF_MSG_LINK)
 static int debug = -1;
 module_param(debug, int, 0);
@@ -10814,6 +10819,9 @@ static int ixgbe_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (allow_unsupported_sfp)
 		hw->allow_unsupported_sfp = allow_unsupported_sfp;
 
+	if (cu_sfp_as_sx)
+		hw->cu_sfp_as_sx = cu_sfp_as_sx;
+
 	/* reset_hw fills in the perm_addr as well */
 	hw->phy.reset_if_overtemp = true;
 	err = hw->mac.ops.reset_hw(hw);
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
index 6da9880d766a..0ffe09c0d5a8 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
@@ -3645,6 +3645,7 @@ struct ixgbe_hw {
 	bool				allow_unsupported_sfp;
 	bool				wol_enabled;
 	bool				need_crosstalk_fix;
+	bool				cu_sfp_as_sx;
 };
 
 struct ixgbe_info {
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
index e4b50c7781ff..aa12d589c39b 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
@@ -1609,6 +1609,8 @@ static s32 ixgbe_setup_ixfi_x550em(struct ixgbe_hw *hw, ixgbe_link_speed *speed)
  */
 static s32 ixgbe_supported_sfp_modules_X550em(struct ixgbe_hw *hw, bool *linear)
 {
+	struct ixgbe_adapter *adapter = hw->back;
+
 	switch (hw->phy.sfp_type) {
 	case ixgbe_sfp_type_not_present:
 		return IXGBE_ERR_SFP_NOT_PRESENT;
@@ -1626,9 +1628,21 @@ static s32 ixgbe_supported_sfp_modules_X550em(struct ixgbe_hw *hw, bool *linear)
 	case ixgbe_sfp_type_1g_lx_core1:
 		*linear = false;
 		break;
-	case ixgbe_sfp_type_unknown:
 	case ixgbe_sfp_type_1g_cu_core0:
+		if (hw->cu_sfp_as_sx) {
+			e_warn(drv, "WARNING: Treating Cu SFP modules as SX modules is unsupported by Intel and may cause unstable operation or damage to the module or the adapter.  Intel Corporation is not responsible for any harm caused by using Cu modules in this way with this adapter.\n");
+			*linear = false;
+			hw->phy.sfp_type = ixgbe_sfp_type_1g_sx_core0;
+			break;
+		}
 	case ixgbe_sfp_type_1g_cu_core1:
+		if (hw->cu_sfp_as_sx) {
+			e_warn(drv, "WARNING: Treating Cu SFP modules as SX modules is unsupported by Intel and may cause unstable operation or damage to the module or the adapter.  Intel Corporation is not responsible for any harm caused by using Cu modules in this way with this adapter.\n");
+			*linear = false;
+			hw->phy.sfp_type = ixgbe_sfp_type_1g_sx_core1;
+			break;
+		}
+	case ixgbe_sfp_type_unknown:
 	default:
 		return IXGBE_ERR_SFP_NOT_SUPPORTED;
 	}
-- 
2.25.1

