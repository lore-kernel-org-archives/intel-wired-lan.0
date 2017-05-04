From: Sridhar Samudrala <sridhar.samudrala@intel.com>
Date: Thu,  4 May 2017 11:46:49 -0700
Subject: [Intel-wired-lan] [PATCH] i40e: Fix pf-flags overwrite bug
	introduced in hw_disabled_flags removal patch.
Message-ID: <1493923609-15708-1-git-send-email-sridhar.samudrala@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Commit 	47994c119a36 (i40e: remove hw_disabled_flags in favor of
using separate flag bits) causes pf->flags overwrite when setting 
I40E_FLAG_HW_ATR_EVICT_CAPABLE flag.

Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index e4eb978..c05221c 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -8822,9 +8822,9 @@ static int i40e_sw_init(struct i40e_pf *pf)
 		    (pf->hw.aq.api_min_ver > 4))) {
 		/* Supported in FW API version higher than 1.4 */
 		pf->flags |= I40E_FLAG_GENEVE_OFFLOAD_CAPABLE;
-		pf->flags = I40E_FLAG_HW_ATR_EVICT_CAPABLE;
+		pf->flags |= I40E_FLAG_HW_ATR_EVICT_CAPABLE;
 	} else {
-		pf->flags = I40E_FLAG_HW_ATR_EVICT_CAPABLE;
+		pf->flags |= I40E_FLAG_HW_ATR_EVICT_CAPABLE;
 	}
 
 	pf->eeprom_version = 0xDEAD;
-- 
1.8.3.1

