From: Sasha Neftin <sasha.neftin@intel.com>
Date: Thu,  9 Sep 2021 20:49:04 +0300
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Update the device ID
Message-ID: <20210909174904.3765604-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Update device ID for the I226_K part.

Fixes: bfa5e98c9de4 ("igc: Add new device ID")
Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_hw.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_hw.h b/drivers/net/ethernet/intel/igc/igc_hw.h
index 772fd06e93ac..587db7483f25 100644
--- a/drivers/net/ethernet/intel/igc/igc_hw.h
+++ b/drivers/net/ethernet/intel/igc/igc_hw.h
@@ -22,9 +22,9 @@
 #define IGC_DEV_ID_I220_V			0x15F7
 #define IGC_DEV_ID_I225_K			0x3100
 #define IGC_DEV_ID_I225_K2			0x3101
+#define IGC_DEV_ID_I226_K			0x3102
 #define IGC_DEV_ID_I225_LMVP			0x5502
 #define IGC_DEV_ID_I226_LMVP			0x5503
-#define IGC_DEV_ID_I226_K			0x5504
 #define IGC_DEV_ID_I225_IT			0x0D9F
 #define IGC_DEV_ID_I226_LM			0x125B
 #define IGC_DEV_ID_I226_V			0x125C
-- 
2.25.1

