From: Alice Michael <alice.michael@intel.com>
Date: Mon, 26 Feb 2018 03:33:10 -0500
Subject: [Intel-wired-lan] [next PATCH S87 V2 6/7] i40e: fix for wrong
 partition id calculation on OCP mezz cards
In-Reply-To: <20180226083311.52442-1-alice.michael@intel.com>
References: <20180226083311.52442-1-alice.michael@intel.com>
Message-ID: <20180226083311.52442-6-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mariusz Stachura <mariusz.stachura@intel.com>

This patch overwrites number of ports for X722 devices with support
for OCP PHY mezzanine.
The old method with checking if port is disabled in the PRTGEN_CNF
register cannot be used in this case. When the OCP is removed, ports
were seen as disabled, which resulted in wrong calculation of partition
id, that caused WoL to be disabled on certain ports.

Signed-off-by: Mariusz Stachura <mariusz.stachura@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_common.c | 23 ++++++++++++++++++++++-
 drivers/net/ethernet/intel/i40e/i40e_type.h   |  3 +++
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index 2861e17..f4de78f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -3201,9 +3201,10 @@ static void i40e_parse_discover_capabilities(struct i40e_hw *hw, void *buff,
 	u32 valid_functions, num_functions;
 	u32 number, logical_id, phys_id;
 	struct i40e_hw_capabilities *p;
+	u16 id, ocp_cfg_word0;
+	i40e_status status;
 	u8 major_rev;
 	u32 i = 0;
-	u16 id;
 
 	cap = (struct i40e_aqc_list_capabilities_element_resp *) buff;
 
@@ -3390,6 +3391,26 @@ static void i40e_parse_discover_capabilities(struct i40e_hw *hw, void *buff,
 			hw->num_ports++;
 	}
 
+	/* OCP cards case: if a mezz is removed the ethernet port is at
+	 * disabled state in PRTGEN_CNF register. Additional NVM read is
+	 * needed in order to check if we are dealing with OCP card.
+	 * Those cards have 4 PFs at minimum, so using PRTGEN_CNF for counting
+	 * physical ports results in wrong partition id calculation and thus
+	 * not supporting WoL.
+	 */
+	if (hw->mac.type == I40E_MAC_X722) {
+		if (!i40e_acquire_nvm(hw, I40E_RESOURCE_READ)) {
+			status = i40e_aq_read_nvm(hw, I40E_SR_EMP_MODULE_PTR,
+						  2 * I40E_SR_OCP_CFG_WORD0,
+						  sizeof(ocp_cfg_word0),
+						  &ocp_cfg_word0, true, NULL);
+			if (!status &&
+			    (ocp_cfg_word0 & I40E_SR_OCP_ENABLED))
+				hw->num_ports = 4;
+			i40e_release_nvm(hw);
+		}
+	}
+
 	valid_functions = p->valid_functions;
 	num_functions = 0;
 	while (valid_functions) {
diff --git a/drivers/net/ethernet/intel/i40e/i40e_type.h b/drivers/net/ethernet/intel/i40e/i40e_type.h
index 71b2049..bfb8009 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_type.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_type.h
@@ -1337,6 +1337,9 @@ struct i40e_hw_port_stats {
 #define I40E_SR_PCIE_ALT_MODULE_MAX_SIZE	1024
 #define I40E_SR_CONTROL_WORD_1_SHIFT		0x06
 #define I40E_SR_CONTROL_WORD_1_MASK	(0x03 << I40E_SR_CONTROL_WORD_1_SHIFT)
+#define I40E_PTR_TYPE				BIT(15)
+#define I40E_SR_OCP_CFG_WORD0			0x2B
+#define I40E_SR_OCP_ENABLED			BIT(15)
 
 /* Shadow RAM related */
 #define I40E_SR_SECTOR_SIZE_IN_WORDS	0x800
-- 
2.9.5

