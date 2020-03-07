From: Andre Guedes <andre.guedes@intel.com>
Date: Fri,  6 Mar 2020 16:36:42 -0800
Subject: [Intel-wired-lan] [PATCH] igc: Remove dead code related to flower
 filter
Message-ID: <20200307003642.25590-1-andre.guedes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

IGC driver has no support for tc-flower filters so this patch removes
some leftover code, probably copied from IGB driver by mistake.

Signed-off-by: Andre Guedes <andre.guedes@intel.com>
---
 drivers/net/ethernet/intel/igc/igc.h      | 1 -
 drivers/net/ethernet/intel/igc/igc_main.c | 3 ---
 2 files changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index b6137648471d..4823b8ead547 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -185,7 +185,6 @@ struct igc_adapter {
 
 	/* RX network flow classification support */
 	struct hlist_head nfc_filter_list;
-	struct hlist_head cls_flower_list;
 	unsigned int nfc_filter_count;
 
 	/* lock for RX network flow classification filter */
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 025f2e439aef..21c8696918f9 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -3483,9 +3483,6 @@ static void igc_nfc_filter_exit(struct igc_adapter *adapter)
 	hlist_for_each_entry(rule, &adapter->nfc_filter_list, nfc_node)
 		igc_erase_filter(adapter, rule);
 
-	hlist_for_each_entry(rule, &adapter->cls_flower_list, nfc_node)
-		igc_erase_filter(adapter, rule);
-
 	spin_unlock(&adapter->nfc_lock);
 }
 
-- 
2.25.0

