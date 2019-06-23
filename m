From: Sasha Neftin <sasha.neftin@intel.com>
Date: Sun, 23 Jun 2019 13:42:32 +0300
Subject: [Intel-wired-lan] [PATCH v1 2/2] igc: Remove the unused field from
 a device specification structure
In-Reply-To: <20190623104232.36661-1-sasha.neftin@intel.com>
References: <20190623104232.36661-1-sasha.neftin@intel.com>
Message-ID: <20190623104232.36661-2-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch comes to clean up the device specification structure.

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_hw.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_hw.h b/drivers/net/ethernet/intel/igc/igc_hw.h
index f689f0a02b5d..9a338fbf671c 100644
--- a/drivers/net/ethernet/intel/igc/igc_hw.h
+++ b/drivers/net/ethernet/intel/igc/igc_hw.h
@@ -184,12 +184,7 @@ struct igc_fc_info {
 };
 
 struct igc_dev_spec_base {
-	bool global_device_reset;
-	bool eee_disable;
 	bool clear_semaphore_once;
-	bool module_plugged;
-	u8 media_port;
-	bool mas_capable;
 };
 
 struct igc_hw {
-- 
2.11.0

