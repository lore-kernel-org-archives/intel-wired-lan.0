From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Fri, 10 Mar 2017 12:22:02 -0800
Subject: [Intel-wired-lan] [next PATCH S62 3/6] i40e: use register for XL722
	control register read/write
In-Reply-To: <1489177325-13156-1-git-send-email-bimmy.pujari@intel.com>
References: <1489177325-13156-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1489177325-13156-4-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>

The XL722 doesn't support the AQ command to read/write the control
register so enable it to bypass the check and use the direct read/write
method.

Signed-off-by: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
Change-ID: Iefecc737b57207485c90845af5989d5af518bf16
---
 drivers/net/ethernet/intel/i40e/i40e_common.c   | 8 ++++++--
 drivers/net/ethernet/intel/i40evf/i40e_common.c | 8 ++++++--
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index 95946f4..f9db95a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -4963,7 +4963,9 @@ u32 i40e_read_rx_ctl(struct i40e_hw *hw, u32 reg_addr)
 	int retry = 5;
 	u32 val = 0;
 
-	use_register = (hw->aq.api_maj_ver == 1) && (hw->aq.api_min_ver < 5);
+	use_register = (((hw->aq.api_maj_ver == 1) &&
+			(hw->aq.api_min_ver < 5)) ||
+			(hw->mac.type == I40E_MAC_X722));
 	if (!use_register) {
 do_retry:
 		status = i40e_aq_rx_ctl_read_register(hw, reg_addr, &val, NULL);
@@ -5022,7 +5024,9 @@ void i40e_write_rx_ctl(struct i40e_hw *hw, u32 reg_addr, u32 reg_val)
 	bool use_register;
 	int retry = 5;
 
-	use_register = (hw->aq.api_maj_ver == 1) && (hw->aq.api_min_ver < 5);
+	use_register = (((hw->aq.api_maj_ver == 1) &&
+			(hw->aq.api_min_ver < 5)) ||
+			(hw->mac.type == I40E_MAC_X722));
 	if (!use_register) {
 do_retry:
 		status = i40e_aq_rx_ctl_write_register(hw, reg_addr,
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_common.c b/drivers/net/ethernet/intel/i40evf/i40e_common.c
index 89dfdbc..626fbf1 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_common.c
@@ -958,7 +958,9 @@ u32 i40evf_read_rx_ctl(struct i40e_hw *hw, u32 reg_addr)
 	int retry = 5;
 	u32 val = 0;
 
-	use_register = (hw->aq.api_maj_ver == 1) && (hw->aq.api_min_ver < 5);
+	use_register = (((hw->aq.api_maj_ver == 1) &&
+			(hw->aq.api_min_ver < 5)) ||
+			(hw->mac.type == I40E_MAC_X722));
 	if (!use_register) {
 do_retry:
 		status = i40evf_aq_rx_ctl_read_register(hw, reg_addr,
@@ -1019,7 +1021,9 @@ void i40evf_write_rx_ctl(struct i40e_hw *hw, u32 reg_addr, u32 reg_val)
 	bool use_register;
 	int retry = 5;
 
-	use_register = (hw->aq.api_maj_ver == 1) && (hw->aq.api_min_ver < 5);
+	use_register = (((hw->aq.api_maj_ver == 1) &&
+			(hw->aq.api_min_ver < 5)) ||
+			(hw->mac.type == I40E_MAC_X722));
 	if (!use_register) {
 do_retry:
 		status = i40evf_aq_rx_ctl_write_register(hw, reg_addr,
-- 
2.4.11

