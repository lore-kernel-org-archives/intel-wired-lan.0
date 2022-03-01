From: Sasha Neftin <sasha.neftin@intel.com>
Date: Tue,  1 Mar 2022 15:32:10 +0200
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Fix infinite loop in
 release_swfw_sync
Message-ID: <20220301133210.1433609-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

An infinite loop may occur if we fail to acquire the HW semaphore,
which is needed for resource release.
This will typically happen if the hardware is surprise-removed.
At this stage there is nothing to do, except log an error and quit.

Suggested-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_i225.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_i225.c b/drivers/net/ethernet/intel/igc/igc_i225.c
index 66ea566488d1..59d5c467ea6e 100644
--- a/drivers/net/ethernet/intel/igc/igc_i225.c
+++ b/drivers/net/ethernet/intel/igc/igc_i225.c
@@ -156,8 +156,15 @@ void igc_release_swfw_sync_i225(struct igc_hw *hw, u16 mask)
 {
 	u32 swfw_sync;
 
-	while (igc_get_hw_semaphore_i225(hw))
-		; /* Empty */
+	/* Releasing the resource requires first getting the HW semaphore.
+	 * If we fail to get the semaphore, there is nothing we can do,
+	 * except log an error and quit. We are not allowed to hang here
+	 * indefinitely, as it may cause denial of service or system crash.
+	 */
+	if (igc_get_hw_semaphore_i225(hw)) {
+		hw_dbg("Failed to release SW_FW_SYNC.\n");
+		return;
+	}
 
 	swfw_sync = rd32(IGC_SW_FW_SYNC);
 	swfw_sync &= ~mask;
-- 
2.30.2

