From: Andre Guedes <andre.guedes@intel.com>
Date: Fri, 24 Apr 2020 13:16:19 -0700
Subject: [Intel-wired-lan] [PATCH 15/19] igc: Fix NFC rules leak when driver
 is unloaded
In-Reply-To: <20200424201623.10971-1-andre.guedes@intel.com>
References: <20200424201623.10971-1-andre.guedes@intel.com>
Message-ID: <20200424201623.10971-16-andre.guedes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

If we have RFC rules in adapter->nfc_rule_list when the IGC driver
is unloaded, all rules are leaked. This patch fixes the issue by
introducing the helper igc_flush_nfc_rules() and calling it in
igc_remove(). It also updates igc_set_features() so is reuses the
new helper instead of re-implementing it.

Signed-off-by: Andre Guedes <andre.guedes@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 29 +++++++++++++----------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index e09d74331257..64e372f38c6b 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -2545,6 +2545,18 @@ void igc_del_nfc_rule(struct igc_adapter *adapter, struct igc_nfc_rule *rule)
 	kfree(rule);
 }
 
+static void igc_flush_nfc_rules(struct igc_adapter *adapter)
+{
+	struct igc_nfc_rule *rule, *tmp;
+
+	spin_lock(&adapter->nfc_rule_lock);
+
+	list_for_each_entry_safe(rule, tmp, &adapter->nfc_rule_list, list)
+		igc_del_nfc_rule(adapter, rule);
+
+	spin_unlock(&adapter->nfc_rule_lock);
+}
+
 /**
  * igc_add_nfc_rule() - Add NFC rule.
  * @adapter: Pointer to adapter.
@@ -3968,19 +3980,8 @@ static int igc_set_features(struct net_device *netdev,
 	if (!(changed & (NETIF_F_RXALL | NETIF_F_NTUPLE)))
 		return 0;
 
-	if (!(features & NETIF_F_NTUPLE)) {
-		struct igc_nfc_rule *rule, *tmp;
-
-		spin_lock(&adapter->nfc_rule_lock);
-		list_for_each_entry_safe(rule, tmp,
-					 &adapter->nfc_rule_list, list) {
-			igc_disable_nfc_rule(adapter, rule);
-			list_del(&rule->list);
-			kfree(rule);
-		}
-		spin_unlock(&adapter->nfc_rule_lock);
-		adapter->nfc_rule_count = 0;
-	}
+	if (!(features & NETIF_F_NTUPLE))
+		igc_flush_nfc_rules(adapter);
 
 	netdev->features = features;
 
@@ -5250,6 +5251,8 @@ static void igc_remove(struct pci_dev *pdev)
 
 	pm_runtime_get_noresume(&pdev->dev);
 
+	igc_flush_nfc_rules(adapter);
+
 	igc_ptp_stop(adapter);
 
 	set_bit(__IGC_DOWN, &adapter->state);
-- 
2.26.0

