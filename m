From: Sasha Neftin <sasha.neftin@intel.com>
Date: Sun,  7 Mar 2021 10:44:27 +0200
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Fix prototype warning
Message-ID: <20210307084427.2882842-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Correct report warnings in igc_i225.c

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_i225.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_i225.c b/drivers/net/ethernet/intel/igc/igc_i225.c
index 7ec04e48860c..cc83bb5c15e8 100644
--- a/drivers/net/ethernet/intel/igc/igc_i225.c
+++ b/drivers/net/ethernet/intel/igc/igc_i225.c
@@ -6,7 +6,7 @@
 #include "igc_hw.h"
 
 /**
- * igc_get_hw_semaphore_i225 - Acquire hardware semaphore
+ * igc_acquire_nvm_i225 - Acquire exclusive access to EEPROM
  * @hw: pointer to the HW structure
  *
  * Acquire the necessary semaphores for exclusive access to the EEPROM.
-- 
2.25.1

