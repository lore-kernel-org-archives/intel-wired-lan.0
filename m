From: Vitaly Lifshits <vitaly.lifshits@intel.com>
Date: Sun,  4 Aug 2019 10:40:26 +0300
Subject: [Intel-wired-lan] [PATCH v4] e1000e: PCIm function state support
Message-ID: <20190804074026.25198-1-vitaly.lifshits@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Due to commit: 5d8682588605 ("[misc] mei: me: allow runtime
pm for platform with D0i3")
when disconnecting the cable and reconnecting it the NIC
enters DMoff state. This caused wrong link indication
and duplex mismatch.

Checking PCIm function state and performing PHY reset after
exiting DMoff state in watchdog task, solves this issue.

Link: https://bugzilla.redhat.com/show_bug.cgi?id=1689436
Signed-off-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
---

V2: Fix typos in commit message
V3: Fix minor typo
V4: Address community comments 
---
 drivers/net/ethernet/intel/e1000e/defines.h |  4 ++++
 drivers/net/ethernet/intel/e1000e/netdev.c  | 20 +++++++++++++++++++-
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000e/defines.h b/drivers/net/ethernet/intel/e1000e/defines.h
index fd550dee4982..4cff73cbd032 100644
--- a/drivers/net/ethernet/intel/e1000e/defines.h
+++ b/drivers/net/ethernet/intel/e1000e/defines.h
@@ -222,6 +222,10 @@
 #define E1000_STATUS_PHYRA      0x00000400      /* PHY Reset Asserted */
 #define E1000_STATUS_GIO_MASTER_ENABLE	0x00080000	/* Master Req status */
 
+/* PCIm function state */
+#define E1000_STATUS_PCIM_STATE	0x40000000
+#define PCIM_DMOFF_EXIT_TIMEOUT 100
+
 #define HALF_DUPLEX 1
 #define FULL_DUPLEX 2
 
diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index b5fed6177ad6..2d29c0d0be1b 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -5162,7 +5162,7 @@ static void e1000_watchdog_task(struct work_struct *work)
 	struct e1000_phy_info *phy = &adapter->hw.phy;
 	struct e1000_ring *tx_ring = adapter->tx_ring;
 	struct e1000_hw *hw = &adapter->hw;
-	u32 link, tctl;
+	u32 link, tctl, pcim_state, tries = 0;
 
 	if (test_bit(__E1000_DOWN, &adapter->state))
 		return;
@@ -5187,6 +5187,24 @@ static void e1000_watchdog_task(struct work_struct *work)
 			/* Cancel scheduled suspend requests. */
 			pm_runtime_resume(netdev->dev.parent);
 
+			/* Checking if MAC is in DMoff state*/
+			pcim_state = er32(STATUS);
+			while (pcim_state & E1000_STATUS_PCIM_STATE) {
+				if (tries++ == PCIM_DMOFF_EXIT_TIMEOUT) {
+					e_dbg("Error in exiting dmoff\n");
+					e_err("PCIm DMoff timeout expired\n");
+					break;
+				}
+				usleep_range(10000, 20000);
+				pcim_state = er32(STATUS);
+
+				/* If MAC entered DMoff state, PHY reset is
+				 * needed after exiting it
+				 */
+				if (!(pcim_state & E1000_STATUS_PCIM_STATE))
+					e1000_phy_hw_reset(&adapter->hw);
+			}
+
 			/* update snapshot of PHY registers on LSC */
 			e1000_phy_read_status(adapter);
 			mac->ops.get_link_up_info(&adapter->hw,
-- 
2.11.0

