From: YueHaibing <yuehaibing@huawei.com>
Date: Thu, 26 Jul 2018 14:37:36 +0800
Subject: [Intel-wired-lan] [PATCH net-next] i40e/i40evf: remove redundant
 functions i40evf_aq_{set/get}_phy_register
Message-ID: <20180726063736.10404-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

There are no in-tree callers.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/intel/i40evf/i40e_common.c | 69 -------------------------
 1 file changed, 69 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40evf/i40e_common.c b/drivers/net/ethernet/intel/i40evf/i40e_common.c
index 9cef549..eea280ba 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_common.c
@@ -1021,75 +1021,6 @@ void i40evf_write_rx_ctl(struct i40e_hw *hw, u32 reg_addr, u32 reg_val)
 }
 
 /**
- * i40evf_aq_set_phy_register
- * @hw: pointer to the hw struct
- * @phy_select: select which phy should be accessed
- * @dev_addr: PHY device address
- * @reg_addr: PHY register address
- * @reg_val: new register value
- * @cmd_details: pointer to command details structure or NULL
- *
- * Reset the external PHY.
- **/
-i40e_status i40evf_aq_set_phy_register(struct i40e_hw *hw,
-				       u8 phy_select, u8 dev_addr,
-				       u32 reg_addr, u32 reg_val,
-				       struct i40e_asq_cmd_details *cmd_details)
-{
-	struct i40e_aq_desc desc;
-	struct i40e_aqc_phy_register_access *cmd =
-		(struct i40e_aqc_phy_register_access *)&desc.params.raw;
-	i40e_status status;
-
-	i40evf_fill_default_direct_cmd_desc(&desc,
-					    i40e_aqc_opc_set_phy_register);
-
-	cmd->phy_interface = phy_select;
-	cmd->dev_address = dev_addr;
-	cmd->reg_address = cpu_to_le32(reg_addr);
-	cmd->reg_value = cpu_to_le32(reg_val);
-
-	status = i40evf_asq_send_command(hw, &desc, NULL, 0, cmd_details);
-
-	return status;
-}
-
-/**
- * i40evf_aq_get_phy_register
- * @hw: pointer to the hw struct
- * @phy_select: select which phy should be accessed
- * @dev_addr: PHY device address
- * @reg_addr: PHY register address
- * @reg_val: read register value
- * @cmd_details: pointer to command details structure or NULL
- *
- * Reset the external PHY.
- **/
-i40e_status i40evf_aq_get_phy_register(struct i40e_hw *hw,
-				       u8 phy_select, u8 dev_addr,
-				       u32 reg_addr, u32 *reg_val,
-				       struct i40e_asq_cmd_details *cmd_details)
-{
-	struct i40e_aq_desc desc;
-	struct i40e_aqc_phy_register_access *cmd =
-		(struct i40e_aqc_phy_register_access *)&desc.params.raw;
-	i40e_status status;
-
-	i40evf_fill_default_direct_cmd_desc(&desc,
-					    i40e_aqc_opc_get_phy_register);
-
-	cmd->phy_interface = phy_select;
-	cmd->dev_address = dev_addr;
-	cmd->reg_address = cpu_to_le32(reg_addr);
-
-	status = i40evf_asq_send_command(hw, &desc, NULL, 0, cmd_details);
-	if (!status)
-		*reg_val = le32_to_cpu(cmd->reg_value);
-
-	return status;
-}
-
-/**
  * i40e_aq_send_msg_to_pf
  * @hw: pointer to the hardware structure
  * @v_opcode: opcodes for VF-PF communication
-- 
2.7.0


