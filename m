From: Vitaly Lifshits <vitaly.lifshits@intel.com>
Date: Tue, 25 Jun 2019 17:39:11 +0300
Subject: [Intel-wired-lan] [PATCH v3] e1000e: PCIm function state support
Message-ID: <20190625143911.37284-1-vitaly.lifshits@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Due to commit: 5d8682588605 ("[misc] mei: me: allow runtime
			pm for platform with D0i3")
When disconnecting the cable and reconnecting it the NIC
enters DMoff state. This caused wrong link indication
and duplex mismatch. This bug is described in:
https://bugzilla.redhat.com/show_bug.cgi?id=1689436

Checking PCIm function state and performing PHY reset after a
timeout in watchdog task solves this issue.

Signed-off-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
---

V2: Fixed typos in commit massage
V3: Fixed minor typo
---
 drivers/net/ethernet/intel/e1000e/defines.h |  3 +++
 drivers/net/ethernet/intel/e1000e/netdev.c  | 18 +++++++++++++++++-
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000e/defines.h b/drivers/net/ethernet/intel/e1000e/defines.h
index fd550dee4982..13877fe300f1 100644
--- a/drivers/net/ethernet/intel/e1000e/defines.h
+++ b/drivers/net/ethernet/intel/e1000e/defines.h
@@ -222,6 +222,9 @@
 #define E1000_STATUS_PHYRA      0x00000400      /* PHY Reset Asserted */
 #define E1000_STATUS_GIO_MASTER_ENABLE	0x00080000	/* Master Req status */
 
+/* PCIm function state */
+#define E1000_STATUS_PCIM_STATE         0x40000000
+
 #define HALF_DUPLEX 1
 #define FULL_DUPLEX 2
 
diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index b081a1ef6859..c6a10fd30e4e 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -5173,8 +5173,9 @@ static void e1000_watchdog_task(struct work_struct *work)
 	struct e1000_mac_info *mac = &adapter->hw.mac;
 	struct e1000_phy_info *phy = &adapter->hw.phy;
 	struct e1000_ring *tx_ring = adapter->tx_ring;
+	u32 dmoff_exit_timeout = 100, tries = 0;
 	struct e1000_hw *hw = &adapter->hw;
-	u32 link, tctl;
+	u32 link, tctl, pcim_state;
 
 	if (test_bit(__E1000_DOWN, &adapter->state))
 		return;
@@ -5199,6 +5200,21 @@ static void e1000_watchdog_task(struct work_struct *work)
 			/* Cancel scheduled suspend requests. */
 			pm_runtime_resume(netdev->dev.parent);
 
+			/* Checking if MAC is in DMoff state*/
+			pcim_state = er32(STATUS);
+			while (pcim_state & E1000_STATUS_PCIM_STATE) {
+				if (tries++ == dmoff_exit_timeout) {
+					e_dbg("Error in exiting dmoff\n");
+					break;
+				}
+				usleep_range(10000, 20000);
+				pcim_state = er32(STATUS);
+
+				/* Checking if MAC exited DMoff state */
+				if (!(pcim_state & E1000_STATUS_PCIM_STATE))
+					e1000_phy_hw_reset(&adapter->hw);
+			}
+
 			/* update snapshot of PHY registers on LSC */
 			e1000_phy_read_status(adapter);
 			mac->ops.get_link_up_info(&adapter->hw,
-- 
2.11.0

