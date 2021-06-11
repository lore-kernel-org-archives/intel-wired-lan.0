From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Thu, 10 Jun 2021 17:39:23 -0700
Subject: [Intel-wired-lan] [PATCH next-queue v1 4/5] igc: Make flex filter
 more flexible
In-Reply-To: <20210611003924.492853-1-vinicius.gomes@intel.com>
References: <20210611003924.492853-1-vinicius.gomes@intel.com>
Message-ID: <20210611003924.492853-5-vinicius.gomes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Kurt Kanzenbach <kurt@linutronix.de>

Currently flex filters are only used for filters containing user data.
However, it makes sense to utilize them also for filters having
multiple conditions, because that's not supported by the driver at the
moment. Add it.

Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 drivers/net/ethernet/intel/igc/igc.h         |  1 +
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 27 ++++++++++++--------
 drivers/net/ethernet/intel/igc/igc_main.c    | 14 ++++------
 3 files changed, 22 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index 54a1779fa53a..5710e5420b40 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -507,6 +507,7 @@ struct igc_nfc_rule {
 	struct igc_nfc_filter filter;
 	u32 location;
 	u16 action;
+	bool flex;
 };
 
 /* IGC supports a total of 32 NFC rules: 16 MAC address based, 8 VLAN priority
diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index 5a7b27b2a95c..d3e84416248e 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -1222,19 +1222,29 @@ static void igc_ethtool_init_nfc_rule(struct igc_nfc_rule *rule,
 				fsp->h_u.ether_spec.h_dest);
 	}
 
+	/* VLAN etype matching */
+	if ((fsp->flow_type & FLOW_EXT) && fsp->h_ext.vlan_etype) {
+		rule->filter.vlan_etype = fsp->h_ext.vlan_etype;
+		rule->filter.match_flags |= IGC_FILTER_FLAG_VLAN_ETYPE;
+	}
+
 	/* Check for user defined data */
 	if ((fsp->flow_type & FLOW_EXT) &&
 	    (fsp->h_ext.data[0] || fsp->h_ext.data[1])) {
 		rule->filter.match_flags |= IGC_FILTER_FLAG_USER_DATA;
 		memcpy(rule->filter.user_data, fsp->h_ext.data, sizeof(fsp->h_ext.data));
 		memcpy(rule->filter.user_mask, fsp->m_ext.data, sizeof(fsp->m_ext.data));
-
-		/* VLAN etype matching is only valid using flex filter */
-		if ((fsp->flow_type & FLOW_EXT) && fsp->h_ext.vlan_etype) {
-			rule->filter.vlan_etype = fsp->h_ext.vlan_etype;
-			rule->filter.match_flags |= IGC_FILTER_FLAG_VLAN_ETYPE;
-		}
 	}
+
+	/* When multiple filter options or user data or vlan etype is set, use a
+	 * flex filter.
+	 */
+	if ((rule->filter.match_flags & IGC_FILTER_FLAG_USER_DATA) ||
+	    (rule->filter.match_flags & IGC_FILTER_FLAG_VLAN_ETYPE) ||
+	    (rule->filter.match_flags & (rule->filter.match_flags - 1)))
+		rule->flex = true;
+	else
+		rule->flex = false;
 }
 
 /**
@@ -1264,11 +1274,6 @@ static int igc_ethtool_check_nfc_rule(struct igc_adapter *adapter,
 		return -EINVAL;
 	}
 
-	if (flags & (flags - 1)) {
-		netdev_dbg(dev, "Rule with multiple matches not supported\n");
-		return -EOPNOTSUPP;
-	}
-
 	list_for_each_entry(tmp, &adapter->nfc_rule_list, list) {
 		if (!memcmp(&rule->filter, &tmp->filter,
 			    sizeof(rule->filter)) &&
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 9abcecc57534..ac558a6defe7 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -3391,14 +3391,8 @@ static int igc_enable_nfc_rule(struct igc_adapter *adapter,
 {
 	int err;
 
-	/* Check for user data first: When user data is set, the only option is
-	 * to use a flex filter. When more options are set (ethertype, vlan tci,
-	 * ...) construct a flex filter matching all of that.
-	 */
-	if (rule->filter.match_flags & IGC_FILTER_FLAG_USER_DATA) {
-		err = igc_add_flex_filter(adapter, rule);
-		if (err)
-			return err;
+	if (rule->flex) {
+		return igc_add_flex_filter(adapter, rule);
 	}
 
 	if (rule->filter.match_flags & IGC_FILTER_FLAG_ETHER_TYPE) {
@@ -3437,8 +3431,10 @@ static int igc_enable_nfc_rule(struct igc_adapter *adapter,
 static void igc_disable_nfc_rule(struct igc_adapter *adapter,
 				 const struct igc_nfc_rule *rule)
 {
-	if (rule->filter.match_flags & IGC_FILTER_FLAG_USER_DATA)
+	if (rule->flex) {
 		igc_del_flex_filter(adapter, rule->filter.flex_index);
+		return;
+	}
 
 	if (rule->filter.match_flags & IGC_FILTER_FLAG_ETHER_TYPE)
 		igc_del_etype_filter(adapter, rule->filter.etype);
-- 
2.32.0

