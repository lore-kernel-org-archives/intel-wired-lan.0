From: Yanir Lubetkin <yanirx.lubetkin@intel.com>
Date: Wed, 22 Apr 2015 04:15:01 +0300
Subject: [Intel-wired-lan] [PATCH] e1000e: i219 execute unit hang fix on
	every reset or power state transition
Message-ID: <1429665301-10596-1-git-send-email-yanirx.lubetkin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

after testing various cases, the conclusion is that the fix MUST be executed BEFORE
any event that the HW is reset or transition to D3. to fix that I moved the execution
to the relevant places but per Alexander Duyck's review, ensure now that the DMA is
valid and was not freed before manipulating the ring.

Signed-off-by: Yanir Lubetkin <yanirx.lubetkin@intel.com>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 76b1a90..3f561f3 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -4043,6 +4043,8 @@ void e1000e_reset(struct e1000_adapter *adapter)
 		}
 	}
 
+	if (hw->mac.type == e1000_pch_spt)
+		e1000_flush_desc_rings(adapter);
 	/* Allow time for pending master requests to run */
 	mac->ops.reset_hw(hw);
 
@@ -4215,10 +4217,6 @@ void e1000e_down(struct e1000_adapter *adapter, bool reset)
 	spin_unlock(&adapter->stats64_lock);
 
 	e1000e_flush_descriptors(adapter);
-	if (hw->mac.type == e1000_pch_spt)
-		e1000_flush_desc_rings(adapter);
-	e1000_clean_tx_ring(adapter->tx_ring);
-	e1000_clean_rx_ring(adapter->rx_ring);
 
 	adapter->link_speed = 0;
 	adapter->link_duplex = 0;
@@ -4229,8 +4227,14 @@ void e1000e_down(struct e1000_adapter *adapter, bool reset)
 	    e1000_lv_jumbo_workaround_ich8lan(hw, false))
 		e_dbg("failed to disable jumbo frame workaround mode\n");
 
-	if (reset && !pci_channel_offline(adapter->pdev))
-		e1000e_reset(adapter);
+        if (!pci_channel_offline(adapter->pdev)) {
+                if(reset)
+                        e1000e_reset(adapter);
+                else if (hw->mac.type == e1000_pch_spt)
+                        e1000_flush_desc_rings(adapter);
+        }
+	e1000_clean_tx_ring(adapter->tx_ring);
+	e1000_clean_rx_ring(adapter->rx_ring);
 }
 
 void e1000e_reinit_locked(struct e1000_adapter *adapter)
-- 
2.1.0

---------------------------------------------------------------------
Intel Israel (74) Limited

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

