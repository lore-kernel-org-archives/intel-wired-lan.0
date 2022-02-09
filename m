From: Chen Yu <yu.c.chen@intel.com>
Date: Thu, 10 Feb 2022 07:43:02 +0800
Subject: [Intel-wired-lan] [PATCH] e1000e: Print PHY register address when
 MDI read/write fails
Message-ID: <20220209234302.50833-1-yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

There is occasional suspend error from e1000e which blocks the
system from further suspending:
[   20.078957] PM: pci_pm_suspend(): e1000e_pm_suspend+0x0/0x780 [e1000e] returns -2
[   20.078970] PM: dpm_run_callback(): pci_pm_suspend+0x0/0x170 returns -2
[   20.078974] e1000e 0000:00:1f.6: PM: pci_pm_suspend+0x0/0x170 returned -2 after 371012 usecs
[   20.078978] e1000e 0000:00:1f.6: PM: failed to suspend async: error -2
According to the code flow, this might be caused by broken MDI read/write to PHY registers.
However currently the code does not tell us which register is broken. Thus enhance the debug
information to print the offender PHY register for easier debugging.

Reported-by: Todd Brandt <todd.e.brandt@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 drivers/net/ethernet/intel/e1000e/phy.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/phy.c b/drivers/net/ethernet/intel/e1000e/phy.c
index 0f0efee5fc8e..fd07c3679bb1 100644
--- a/drivers/net/ethernet/intel/e1000e/phy.c
+++ b/drivers/net/ethernet/intel/e1000e/phy.c
@@ -146,11 +146,11 @@ s32 e1000e_read_phy_reg_mdic(struct e1000_hw *hw, u32 offset, u16 *data)
 			break;
 	}
 	if (!(mdic & E1000_MDIC_READY)) {
-		e_dbg("MDI Read did not complete\n");
+		e_dbg("MDI Read PHY Reg Address %d did not complete\n", offset);
 		return -E1000_ERR_PHY;
 	}
 	if (mdic & E1000_MDIC_ERROR) {
-		e_dbg("MDI Error\n");
+		e_dbg("MDI Read PHY Reg Address %d Error\n", offset);
 		return -E1000_ERR_PHY;
 	}
 	if (((mdic & E1000_MDIC_REG_MASK) >> E1000_MDIC_REG_SHIFT) != offset) {
@@ -210,11 +210,11 @@ s32 e1000e_write_phy_reg_mdic(struct e1000_hw *hw, u32 offset, u16 data)
 			break;
 	}
 	if (!(mdic & E1000_MDIC_READY)) {
-		e_dbg("MDI Write did not complete\n");
+		e_dbg("MDI Write PHY Reg Address %d did not complete\n", offset);
 		return -E1000_ERR_PHY;
 	}
 	if (mdic & E1000_MDIC_ERROR) {
-		e_dbg("MDI Error\n");
+		e_dbg("MDI Write PHY Red Address %d Error\n", offset);
 		return -E1000_ERR_PHY;
 	}
 	if (((mdic & E1000_MDIC_REG_MASK) >> E1000_MDIC_REG_SHIFT) != offset) {
-- 
2.25.1

