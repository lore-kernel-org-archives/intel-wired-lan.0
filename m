From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Tue, 24 Mar 2015 21:30:24 -0700
Subject: [Intel-wired-lan] [next-queue S2 14/15] i40evf: Refactor VF RSS code
In-Reply-To: <1427257825-24519-1-git-send-email-jeffrey.t.kirsher@intel.com>
References: <1427257825-24519-1-git-send-email-jeffrey.t.kirsher@intel.com>
Message-ID: <1427257825-24519-14-git-send-email-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Anjali Singhai Jain <anjali.singhai@intel.com>

Refactor VF RSS code to allow RSS on a single queue and eliminate
the need for the next_queue function.

Change-ID: I9253bad96b7f542ee7036e15636db0e5d58d8ef2
Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
---
 drivers/net/ethernet/intel/i40evf/i40evf_main.c | 43 +++++++------------------
 1 file changed, 11 insertions(+), 32 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index 46aef2a..6d5f3b2 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -1435,41 +1435,22 @@ restart_watchdog:
 }
 
 /**
- * next_queue - increment to next available tx queue
- * @adapter: board private structure
- * @j: queue counter
- *
- * Helper function for RSS programming to increment through available
- * queus. Returns the next queue value.
- **/
-static int next_queue(struct i40evf_adapter *adapter, int j)
-{
-	j += 1;
-
-	return j >= adapter->num_active_queues ? 0 : j;
-}
-
-/**
- * i40evf_configure_rss - Prepare for RSS if used
+ * i40evf_configure_rss - Prepare for RSS
  * @adapter: board private structure
  **/
 static void i40evf_configure_rss(struct i40evf_adapter *adapter)
 {
 	u32 rss_key[I40E_VFQF_HKEY_MAX_INDEX + 1];
 	struct i40e_hw *hw = &adapter->hw;
+	u32 cqueue = 0;
 	u32 lut = 0;
 	int i, j;
 	u64 hena;
 
-	/* No RSS for single queue. */
-	if (adapter->num_active_queues == 1) {
-		wr32(hw, I40E_VFQF_HENA(0), 0);
-		wr32(hw, I40E_VFQF_HENA(1), 0);
-		return;
-	}
-
 	/* Hash type is configured by the PF - we just supply the key */
 	netdev_rss_key_fill(rss_key, sizeof(rss_key));
+
+	/* Fill out hash function seed */
 	for (i = 0; i <= I40E_VFQF_HKEY_MAX_INDEX; i++)
 		wr32(hw, I40E_VFQF_HKEY(i), rss_key[i]);
 
@@ -1479,16 +1460,14 @@ static void i40evf_configure_rss(struct i40evf_adapter *adapter)
 	wr32(hw, I40E_VFQF_HENA(1), (u32)(hena >> 32));
 
 	/* Populate the LUT with max no. of queues in round robin fashion */
-	j = adapter->num_active_queues;
 	for (i = 0; i <= I40E_VFQF_HLUT_MAX_INDEX; i++) {
-		j = next_queue(adapter, j);
-		lut = j;
-		j = next_queue(adapter, j);
-		lut |= j << 8;
-		j = next_queue(adapter, j);
-		lut |= j << 16;
-		j = next_queue(adapter, j);
-		lut |= j << 24;
+		lut = 0;
+		for (j = 0; j < 4; j++) {
+			if (cqueue == adapter->vsi_res->num_queue_pairs)
+				cqueue = 0;
+			lut |= ((cqueue) << (8 * j));
+			cqueue++;
+		}
 		wr32(hw, I40E_VFQF_HLUT(i), lut);
 	}
 	i40e_flush(hw);
-- 
1.9.3

