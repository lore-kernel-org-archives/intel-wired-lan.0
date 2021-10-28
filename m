From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Date: Thu, 28 Oct 2021 13:51:14 +0000
Subject: [Intel-wired-lan] [PATCH net v2] i40e: Increase delay to 1 s after
 global EMP reset
Message-ID: <20211028135114.202530-1-jedrzej.jagielski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Recently simplified i40e_rebuild causes that FW sometimes
is not ready after NVM update, the ping does not return.

Increase the delay in case of EMP reset.
Old delay of 300 ms was introduced for specific cards for 710 series.
Now it works for all the cards and delay was increased.

Fixes: 1fa51a650e1d ("i40e: Add delay after EMP reset for firmware to recover")
Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)
---
V2: Fix commit msg
---
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 85b076123663..1cec920bff28 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -10492,15 +10492,9 @@ static void i40e_rebuild(struct i40e_pf *pf, bool reinit, bool lock_acquired)
 	}
 	i40e_get_oem_version(&pf->hw);
 
-	if (test_bit(__I40E_EMP_RESET_INTR_RECEIVED, pf->state) &&
-	    ((hw->aq.fw_maj_ver == 4 && hw->aq.fw_min_ver <= 33) ||
-	     hw->aq.fw_maj_ver < 4) && hw->mac.type == I40E_MAC_XL710) {
-		/* The following delay is necessary for 4.33 firmware and older
-		 * to recover after EMP reset. 200 ms should suffice but we
-		 * put here 300 ms to be sure that FW is ready to operate
-		 * after reset.
-		 */
-		mdelay(300);
+	if (test_and_clear_bit(__I40E_EMP_RESET_INTR_RECEIVED, pf->state)) {
+		/* The following delay is necessary for firmware update. */
+		mdelay(1000);
 	}
 
 	/* re-verify the eeprom if we just had an EMP reset */
-- 
2.27.0

