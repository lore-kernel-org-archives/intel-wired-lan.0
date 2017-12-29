From: Alice Michael <alice.michael@intel.com>
Date: Fri, 29 Dec 2017 08:50:05 -0500
Subject: [Intel-wired-lan] [next PATCH S85-V1 06/14] i40e: Add delay after
 EMP reset for firmware to recover
Message-ID: <20171229135005.14410-1-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Filip Sadowski <filip.sadowski@intel.com>

This patch adds necessary delay for 4.33 firmware to recover after
EMP reset. Without this patch driver occasionally reinitializes
structures too quickly to communicate with firmware after EMP reset
causing AdminQ to timeout.

Signed-off-by: Filip Sadowski <filip.sadowski@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index fdf0bfb..c810e9d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -9259,6 +9259,17 @@ static void i40e_rebuild(struct i40e_pf *pf, bool reinit, bool lock_acquired)
 	}
 	i40e_get_oem_version(&pf->hw);
 
+	if (test_bit(__I40E_EMP_RESET_INTR_RECEIVED, pf->state) &&
+	    ((hw->aq.fw_maj_ver == 4 && hw->aq.fw_min_ver <= 33) ||
+	     hw->aq.fw_maj_ver < 4) && hw->mac.type == I40E_MAC_XL710) {
+		/* The following delay is necessary for 4.33 firmware and older
+		 * to recover after EMP reset. 200 ms should suffice but we
+		 * put here 300 ms to be sure that FW is ready to operate
+		 * after reset.
+		 */
+		mdelay(300);
+	}
+
 	/* re-verify the eeprom if we just had an EMP reset */
 	if (test_and_clear_bit(__I40E_EMP_RESET_INTR_RECEIVED, pf->state))
 		i40e_verify_eeprom(pf);
-- 
2.9.5

