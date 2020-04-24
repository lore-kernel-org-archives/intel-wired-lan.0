From: Andre Guedes <andre.guedes@intel.com>
Date: Fri, 24 Apr 2020 13:16:14 -0700
Subject: [Intel-wired-lan] [PATCH 10/19] igc: Fix locking issue when
 retrieving NFC rules
In-Reply-To: <20200424201623.10971-1-andre.guedes@intel.com>
References: <20200424201623.10971-1-andre.guedes@intel.com>
Message-ID: <20200424201623.10971-11-andre.guedes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Access to NFC rules stored in adapter->nfc_rule_list is protect by
adapter->nfc_rule_lock. The functions igc_ethtool_get_nfc_rule()
and igc_ethtool_get_nfc_rules() are missing to hold the lock while
accessing rule objects.

Signed-off-by: Andre Guedes <andre.guedes@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index 93274e75e8c5..38ac61c04e5c 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -939,16 +939,18 @@ static int igc_ethtool_get_nfc_rule(struct igc_adapter *adapter,
 
 	cmd->data = IGC_MAX_RXNFC_RULES;
 
+	spin_lock(&adapter->nfc_rule_lock);
+
 	hlist_for_each_entry(rule, &adapter->nfc_rule_list, nfc_node) {
 		if (fsp->location <= rule->location)
 			break;
 	}
 
 	if (!rule || fsp->location != rule->location)
-		return -EINVAL;
+		goto out;
 
 	if (!rule->filter.match_flags)
-		return -EINVAL;
+		goto out;
 
 	fsp->flow_type = ETHER_FLOW;
 	fsp->ring_cookie = rule->action;
@@ -976,7 +978,12 @@ static int igc_ethtool_get_nfc_rule(struct igc_adapter *adapter,
 		eth_broadcast_addr(fsp->m_u.ether_spec.h_source);
 	}
 
+	spin_unlock(&adapter->nfc_rule_lock);
 	return 0;
+
+out:
+	spin_unlock(&adapter->nfc_rule_lock);
+	return -EINVAL;
 }
 
 static int igc_ethtool_get_nfc_rules(struct igc_adapter *adapter,
@@ -988,13 +995,19 @@ static int igc_ethtool_get_nfc_rules(struct igc_adapter *adapter,
 
 	cmd->data = IGC_MAX_RXNFC_RULES;
 
+	spin_lock(&adapter->nfc_rule_lock);
+
 	hlist_for_each_entry(rule, &adapter->nfc_rule_list, nfc_node) {
-		if (cnt == cmd->rule_cnt)
+		if (cnt == cmd->rule_cnt) {
+			spin_unlock(&adapter->nfc_rule_lock);
 			return -EMSGSIZE;
+		}
 		rule_locs[cnt] = rule->location;
 		cnt++;
 	}
 
+	spin_unlock(&adapter->nfc_rule_lock);
+
 	cmd->rule_cnt = cnt;
 
 	return 0;
-- 
2.26.0

