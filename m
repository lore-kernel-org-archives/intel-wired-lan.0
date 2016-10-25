From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Tue, 25 Oct 2016 15:18:01 -0700
Subject: [Intel-wired-lan] [next PATCH S51 7/9] i40e: fix compile error due
	to type conflict
In-Reply-To: <1477433883-3248-1-git-send-email-bimmy.pujari@intel.com>
References: <1477433883-3248-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1477433883-3248-8-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Matt Jared <matthew.a.jared@intel.com>

For the clause 22 and 45 phy register read funcions, cast u32 variables to
u8, resolving compiler error due to data being truncated when placing it
in u8 variable.

Signed-off-by: Matt Jared <matthew.a.jared@intel.com>
Change-ID: I8b144b1fc503401369b765b7c76965a6cfc7d28c
---
 drivers/net/ethernet/intel/i40e/i40e_common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index 5ba34be..fb72fb3 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -4442,7 +4442,7 @@ i40e_status i40e_read_phy_register_clause22(struct i40e_hw *hw,
 					u16 reg, u8 phy_addr, u16 *value)
 {
 	i40e_status status = I40E_ERR_TIMEOUT;
-	u8 port_num = hw->func_caps.mdio_port_num;
+	u8 port_num = (u8)hw->func_caps.mdio_port_num;
 	u32 command = 0;
 	u16 retry = 1000;
 
@@ -4494,9 +4494,9 @@ i40e_status i40e_write_phy_register_clause22(struct i40e_hw *hw,
 					u16 reg, u8 phy_addr, u16 value)
 {
 	i40e_status status = I40E_ERR_TIMEOUT;
+	u8 port_num = (u8)hw->func_caps.mdio_port_num;
 	u32 command  = 0;
 	u16 retry = 1000;
-	u8 port_num = hw->func_caps.mdio_port_num;
 
 	command = value << I40E_GLGEN_MSRWD_MDIWRDATA_SHIFT;
 	wr32(hw, I40E_GLGEN_MSRWD(port_num), command);
-- 
2.4.11

