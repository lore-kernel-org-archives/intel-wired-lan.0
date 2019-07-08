From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon,  8 Jul 2019 16:12:25 -0700
Subject: [Intel-wired-lan] [PATCH 08/19] fm10k: reduce the scope of the
 local i variable
In-Reply-To: <20190708231236.20516-1-jacob.e.keller@intel.com>
References: <20190708231236.20516-1-jacob.e.keller@intel.com>
Message-ID: <20190708231236.20516-9-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Reduce the scope of the local loop variable in the
fm10k_check_hang_subtask function.

This was detected by cppcheck and resolves the following warning
produced by that tool:

[driver/fm10k_pci.c:852]: (style) The scope of the variable 'i' can be
reduced.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
index 8cdfb24125bf..10a3b2576a3c 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
@@ -698,8 +698,6 @@ static void fm10k_watchdog_subtask(struct fm10k_intfc *interface)
  */
 static void fm10k_check_hang_subtask(struct fm10k_intfc *interface)
 {
-	int i;
-
 	/* If we're down or resetting, just bail */
 	if (test_bit(__FM10K_DOWN, interface->state) ||
 	    test_bit(__FM10K_RESETTING, interface->state))
@@ -711,6 +709,8 @@ static void fm10k_check_hang_subtask(struct fm10k_intfc *interface)
 	interface->next_tx_hang_check = jiffies + (2 * HZ);
 
 	if (netif_carrier_ok(interface->netdev)) {
+		int i;
+
 		/* Force detection of hung controller */
 		for (i = 0; i < interface->num_tx_queues; i++)
 			set_check_for_tx_hang(interface->tx_ring[i]);
-- 
2.22.0.214.g8dca754b1e87

