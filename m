From: Sasha Neftin <sasha.neftin@intel.com>
Date: Tue, 18 Dec 2018 11:29:54 +0200
Subject: [Intel-wired-lan] [PATCH 1/1] igc: Fix code redundancy
Message-ID: <20181218092954.29914-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Remove redundant igc_check_for_link_base code and replace it with
an igc_check_for_copper_link method.
Fix duplication of IGC_ADVTXD_PAYLEN_SHIFT mask declaration.
Remove obsolete IGC_SCVPC register definition.

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_base.c | 20 ++------------------
 drivers/net/ethernet/intel/igc/igc_base.h |  3 ---
 drivers/net/ethernet/intel/igc/igc_regs.h |  1 -
 3 files changed, 2 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_base.c b/drivers/net/ethernet/intel/igc/igc_base.c
index df40af759542..19ff987922d2 100644
--- a/drivers/net/ethernet/intel/igc/igc_base.c
+++ b/drivers/net/ethernet/intel/igc/igc_base.c
@@ -54,22 +54,6 @@ static s32 igc_set_pcie_completion_timeout(struct igc_hw *hw)
 }
 
 /**
- * igc_check_for_link_base - Check for link
- * @hw: pointer to the HW structure
- *
- * If sgmii is enabled, then use the pcs register to determine link, otherwise
- * use the generic interface for determining link.
- */
-static s32 igc_check_for_link_base(struct igc_hw *hw)
-{
-	s32 ret_val = 0;
-
-	ret_val = igc_check_for_copper_link(hw);
-
-	return ret_val;
-}
-
-/**
  * igc_reset_hw_base - Reset hardware
  * @hw: pointer to the HW structure
  *
@@ -265,7 +249,7 @@ static s32 igc_init_phy_params_base(struct igc_hw *hw)
 	if (ret_val)
 		return ret_val;
 
-	igc_check_for_link_base(hw);
+	igc_check_for_copper_link(hw);
 
 	/* Verify phy id and set remaining function pointers */
 	switch (phy->id) {
@@ -512,7 +496,7 @@ void igc_rx_fifo_flush_base(struct igc_hw *hw)
 
 static struct igc_mac_operations igc_mac_ops_base = {
 	.init_hw		= igc_init_hw_base,
-	.check_for_link		= igc_check_for_link_base,
+	.check_for_link		= igc_check_for_copper_link,
 	.rar_set		= igc_rar_set,
 	.read_mac_addr		= igc_read_mac_addr_base,
 	.get_speed_and_duplex	= igc_get_link_up_info_base,
diff --git a/drivers/net/ethernet/intel/igc/igc_base.h b/drivers/net/ethernet/intel/igc/igc_base.h
index 35588fa7b8c5..a5d3f57274a8 100644
--- a/drivers/net/ethernet/intel/igc/igc_base.h
+++ b/drivers/net/ethernet/intel/igc/igc_base.h
@@ -90,9 +90,6 @@ union igc_adv_rx_desc {
 	} wb;  /* writeback */
 };
 
-/* Adv Transmit Descriptor Config Masks */
-#define IGC_ADVTXD_PAYLEN_SHIFT	14 /* Adv desc PAYLEN shift */
-
 /* Additional Transmit Descriptor Control definitions */
 #define IGC_TXDCTL_QUEUE_ENABLE	0x02000000 /* Ena specific Tx Queue */
 
diff --git a/drivers/net/ethernet/intel/igc/igc_regs.h b/drivers/net/ethernet/intel/igc/igc_regs.h
index a1bd3216c906..f8c835283377 100644
--- a/drivers/net/ethernet/intel/igc/igc_regs.h
+++ b/drivers/net/ethernet/intel/igc/igc_regs.h
@@ -188,7 +188,6 @@
 #define IGC_HGOTCL	0x04130  /* Host Good Octets Transmit Count Low */
 #define IGC_HGOTCH	0x04134  /* Host Good Octets Transmit Count High */
 #define IGC_LENERRS	0x04138  /* Length Errors Count */
-#define IGC_SCVPC	0x04228  /* SerDes/SGMII Code Violation Pkt Count */
 #define IGC_HRMPC	0x0A018  /* Header Redirection Missed Packet Count */
 
 /* Management registers */
-- 
2.11.0

