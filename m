From: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
Date: Wed, 13 Apr 2016 03:08:30 -0700
Subject: [Intel-wired-lan] [next PATCH S34 10/12] i40e: Drop extra copy of
	function
In-Reply-To: <1460542112-20166-1-git-send-email-harshitha.ramamurthy@intel.com>
References: <1460542112-20166-1-git-send-email-harshitha.ramamurthy@intel.com>
Message-ID: <1460542112-20166-11-git-send-email-harshitha.ramamurthy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

i40e_release_rx_desc was in two files, but was only used
and needed in txrx.c.  Get rid of the extra copy.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Change-Id: I86e18239aa03531fc198b6c052847475084a9200
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index a45748e..d6b1b98 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -397,24 +397,6 @@ static void i40e_tx_timeout(struct net_device *netdev)
 }
 
 /**
- * i40e_release_rx_desc - Store the new tail and head values
- * @rx_ring: ring to bump
- * @val: new head index
- **/
-static inline void i40e_release_rx_desc(struct i40e_ring *rx_ring, u32 val)
-{
-	rx_ring->next_to_use = val;
-
-	/* Force memory writes to complete before letting h/w
-	 * know there are new descriptors to fetch.  (Only
-	 * applicable for weak-ordered memory model archs,
-	 * such as IA-64).
-	 */
-	wmb();
-	writel(val, rx_ring->tail);
-}
-
-/**
  * i40e_get_vsi_stats_struct - Get System Network Statistics
  * @vsi: the VSI we care about
  *
-- 
2.4.3

