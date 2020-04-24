From: Andre Guedes <andre.guedes@intel.com>
Date: Fri, 24 Apr 2020 13:16:23 -0700
Subject: [Intel-wired-lan] [PATCH 19/19] igc: Remove igc_nfc_rule_exit()
In-Reply-To: <20200424201623.10971-1-andre.guedes@intel.com>
References: <20200424201623.10971-1-andre.guedes@intel.com>
Message-ID: <20200424201623.10971-20-andre.guedes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

During igc_down(), we call igc_nfc_rule_exit() which traverse the NFC
rule list disabling filters one by one. Later on in igc_down() flow
we issue an hardware reset which also clear all filters.  Since we
already reset the hardware, we don't actually need to disable each
filter manually. In order to simplify the code, this patch removes
igc_nfc_rule() altogether.

Signed-off-by: Andre Guedes <andre.guedes@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 38327d9ec385..eaf797fcf581 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -2592,18 +2592,6 @@ static void igc_restore_nfc_rules(struct igc_adapter *adapter)
 	mutex_unlock(&adapter->nfc_rule_lock);
 }
 
-static void igc_nfc_rule_exit(struct igc_adapter *adapter)
-{
-	struct igc_nfc_rule *rule;
-
-	mutex_lock(&adapter->nfc_rule_lock);
-
-	list_for_each_entry(rule, &adapter->nfc_rule_list, list)
-		igc_disable_nfc_rule(adapter, rule);
-
-	mutex_unlock(&adapter->nfc_rule_lock);
-}
-
 static int igc_uc_sync(struct net_device *netdev, const unsigned char *addr)
 {
 	struct igc_adapter *adapter = netdev_priv(netdev);
@@ -3822,8 +3810,6 @@ void igc_down(struct igc_adapter *adapter)
 	wr32(IGC_RCTL, rctl & ~IGC_RCTL_EN);
 	/* flush and sleep below */
 
-	igc_nfc_rule_exit(adapter);
-
 	/* set trans_start so we don't get spurious watchdogs during reset */
 	netif_trans_update(netdev);
 
-- 
2.26.0

