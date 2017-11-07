From: Matt Turner <mattst88@gmail.com>
Date: Tue,  7 Nov 2017 14:13:32 -0800
Subject: [Intel-wired-lan] [PATCH 3/3] e1000e: Disable jumbo receive
 workaround on Lynx Point and newer
In-Reply-To: <20171107221332.28283-1-mattst88@gmail.com>
References: <20171107221332.28283-1-mattst88@gmail.com>
Message-ID: <20171107221332.28283-3-mattst88@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Matt Turner <matt.turner@intel.com>

Commit 3e35d9918cbb ("e1000e: adjust PM QoS request") expanded the
application of what is evidently a hardware workaround to apply to all
e1000e devices. Prior to the commit, it applied only to e1000_pch2lan
(Sandy Bridge era) and the commit message notes that other earlier parts
such as ICH9 and ICH10 suffer from the problem as well.

The workaround works by preventing the CPU from entering deep sleep
states, which increases energy consumption significantly. My Skylake
CPU reaches the C10 state the PC8 package state with the MTU for its
I219-LM set to 1500. At an MTU of 9000, it can only reach the C1E state
and no low power package state at all. With this patch, the CPU again
reaches the C10 state and (only) the PC2 package state. Not ideal, but an
improvement nonetheless.

Signed-off-by: Matt Turner <matt.turner@intel.com>
---
This patch is speculative -- I'm an Intel employee (not in the networking
division), but I have no idea where to find documentation about the hardware
bug in question. I'm hoping that someone more in the know can check if the
hardware was fixed in subsequent generations and this workaround can be
disabled. I have chosen the pch2 cut off only because nothing further is
mentioned about the bug in git history.

 drivers/net/ethernet/intel/e1000e/netdev.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 4dcff481c4b4..553f8bd45eea 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -3277,7 +3277,8 @@ static void e1000_configure_rx(struct e1000_adapter *adapter)
 	/* With jumbo frames, excessive C-state transition latencies result
 	 * in dropped transactions.
 	 */
-	if (adapter->netdev->mtu > ETH_DATA_LEN) {
+	if (adapter->hw.mac.type <= e1000_pch2lan &&
+	    adapter->netdev->mtu > ETH_DATA_LEN) {
 		u32 lat =
 		    ((er32(PBA) & E1000_PBA_RXA_MASK) * 1024 -
 		     adapter->max_frame_size) * 8 / 1000;
@@ -3292,9 +3293,6 @@ static void e1000_configure_rx(struct e1000_adapter *adapter)
 			 "Some CPU C-states have been disabled in order to "
 			 "enable jumbo frames\n");
 		pm_qos_update_request(&adapter->pm_qos_req, lat);
-	} else {
-		pm_qos_update_request(&adapter->pm_qos_req,
-				      PM_QOS_DEFAULT_VALUE);
 	}
 
 	/* Enable Receives */
@@ -4625,8 +4623,9 @@ int e1000e_open(struct net_device *netdev)
 		e1000_update_mng_vlan(adapter);
 
 	/* DMA latency requirement to workaround jumbo issue */
-	pm_qos_add_request(&adapter->pm_qos_req, PM_QOS_CPU_DMA_LATENCY,
-			   PM_QOS_DEFAULT_VALUE);
+	if (adapter->hw.mac.type <= e1000_pch2lan)
+		pm_qos_add_request(&adapter->pm_qos_req, PM_QOS_CPU_DMA_LATENCY,
+				   PM_QOS_DEFAULT_VALUE);
 
 	/* before we allocate an interrupt, we must be ready to handle it.
 	 * Setting DEBUG_SHIRQ in the kernel makes it fire an interrupt
@@ -4669,7 +4668,8 @@ int e1000e_open(struct net_device *netdev)
 	return 0;
 
 err_req_irq:
-	pm_qos_remove_request(&adapter->pm_qos_req);
+	if (adapter->hw.mac.type <= e1000_pch2lan)
+		pm_qos_remove_request(&adapter->pm_qos_req);
 	e1000e_release_hw_control(adapter);
 	e1000_power_down_phy(adapter);
 	e1000e_free_rx_resources(adapter->rx_ring);
@@ -4733,7 +4733,8 @@ int e1000e_close(struct net_device *netdev)
 	    !test_bit(__E1000_TESTING, &adapter->state))
 		e1000e_release_hw_control(adapter);
 
-	pm_qos_remove_request(&adapter->pm_qos_req);
+	if (adapter->hw.mac.type <= e1000_pch2lan)
+		pm_qos_remove_request(&adapter->pm_qos_req);
 
 	pm_runtime_put_sync(&pdev->dev);
 
-- 
2.13.6

