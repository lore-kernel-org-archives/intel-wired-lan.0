From: Sasha Neftin <sasha.neftin@intel.com>
Date: Mon,  7 Jun 2021 09:19:12 +0300
Subject: [Intel-wired-lan] [PATCH v1 1/1] e1000e: Check the PCIm state
Message-ID: <20210607061912.2356057-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Complete to commit def4ec6dce393e ("e1000e: PCIm function state support")
Check the PCIm state only on CSME systems. There is no point to do this
check on none CSME systems.
This patch fixes a generation a false-positive warning:
"Error in exiting dmoff"

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 24 ++++++++++++----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 781b751f066f..6a20c7f82fc9 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -5225,18 +5225,20 @@ static void e1000_watchdog_task(struct work_struct *work)
 			pm_runtime_resume(netdev->dev.parent);
 
 			/* Checking if MAC is in DMoff state*/
-			pcim_state = er32(STATUS);
-			while (pcim_state & E1000_STATUS_PCIM_STATE) {
-				if (tries++ == dmoff_exit_timeout) {
-					e_dbg("Error in exiting dmoff\n");
-					break;
-				}
-				usleep_range(10000, 20000);
+			if (er32(FWSM) & E1000_ICH_FWSM_FW_VALID) {
 				pcim_state = er32(STATUS);
-
-				/* Checking if MAC exited DMoff state */
-				if (!(pcim_state & E1000_STATUS_PCIM_STATE))
-					e1000_phy_hw_reset(&adapter->hw);
+				while (pcim_state & E1000_STATUS_PCIM_STATE) {
+					if (tries++ == dmoff_exit_timeout) {
+						e_dbg("Error in exiting dmoff\n");
+						break;
+					}
+					usleep_range(10000, 20000);
+					pcim_state = er32(STATUS);
+
+					/* Checking if MAC exited DMoff state */
+					if (!(pcim_state & E1000_STATUS_PCIM_STATE))
+						e1000_phy_hw_reset(&adapter->hw);
+				}
 			}
 
 			/* update snapshot of PHY registers on LSC */
-- 
2.25.1

