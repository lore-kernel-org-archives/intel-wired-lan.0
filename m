From: Sasha Neftin <sasha.neftin@intel.com>
Date: Wed,  1 Apr 2020 14:38:44 +0300
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Clean up obsolete NVM defines
Message-ID: <20200401113844.17969-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Packet buffer allocation, reserved word and pointer guard
not applicable for i225 parts.
This patch comes to clean up these obsolete defines

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_defines.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
index dd0c86ce09ed..eda4510dd90e 100644
--- a/drivers/net/ethernet/intel/igc/igc_defines.h
+++ b/drivers/net/ethernet/intel/igc/igc_defines.h
@@ -163,11 +163,6 @@
 
 /* For checksumming, the sum of all words in the NVM should equal 0xBABA. */
 #define NVM_SUM				0xBABA
-
-#define NVM_PBA_OFFSET_0		8
-#define NVM_PBA_OFFSET_1		9
-#define NVM_RESERVED_WORD		0xFFFF
-#define NVM_PBA_PTR_GUARD		0xFAFA
 #define NVM_WORD_SIZE_BASE_SHIFT	6
 
 /* Collision related configuration parameters */
-- 
2.11.0

