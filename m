From: Andre Guedes <andre.guedes@intel.com>
Date: Fri, 24 Apr 2020 13:16:11 -0700
Subject: [Intel-wired-lan] [PATCH 07/19] igc: Change byte order in struct
 igc_nfc_filter
In-Reply-To: <20200424201623.10971-1-andre.guedes@intel.com>
References: <20200424201623.10971-1-andre.guedes@intel.com>
Message-ID: <20200424201623.10971-8-andre.guedes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Every time we access the 'etype' and 'vlan_tci' fields from struct
igc_nfc_filter to enable or disable filters in hardware we have to
convert them from big endian to host order so it makes more sense to
simply have these fields in host order.

The byte order conversion should take place in igc_ethtool_get_nfc_
rule() and igc_ethtool_add_nfc_rule(), which are called by .get_rxnfc
and .set_rxnfc ethtool ops, since ethtool subsystem is the one who deals
with them in big endian order.

Signed-off-by: Andre Guedes <andre.guedes@intel.com>
---
 drivers/net/ethernet/intel/igc/igc.h         | 10 ++------
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 25 +++++++++-----------
 2 files changed, 13 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index 7124ba254b89..fcc6261d7f67 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -452,16 +452,10 @@ enum igc_filter_match_flags {
 	IGC_FILTER_FLAG_DST_MAC_ADDR =	0x8,
 };
 
-/* RX network flow classification data structure */
 struct igc_nfc_filter {
-	/* Byte layout in order, all values with MSB first:
-	 * match_flags - 1 byte
-	 * etype - 2 bytes
-	 * vlan_tci - 2 bytes
-	 */
 	u8 match_flags;
-	__be16 etype;
-	__be16 vlan_tci;
+	u16 etype;
+	u16 vlan_tci;
 	u8 src_addr[ETH_ALEN];
 	u8 dst_addr[ETH_ALEN];
 };
diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index 46599ee7f0b9..f9518aa1375b 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -954,13 +954,13 @@ static int igc_ethtool_get_nfc_rule(struct igc_adapter *adapter,
 	fsp->ring_cookie = rule->action;
 
 	if (rule->filter.match_flags & IGC_FILTER_FLAG_ETHER_TYPE) {
-		fsp->h_u.ether_spec.h_proto = rule->filter.etype;
+		fsp->h_u.ether_spec.h_proto = htons(rule->filter.etype);
 		fsp->m_u.ether_spec.h_proto = ETHER_TYPE_FULL_MASK;
 	}
 
 	if (rule->filter.match_flags & IGC_FILTER_FLAG_VLAN_TCI) {
 		fsp->flow_type |= FLOW_EXT;
-		fsp->h_ext.vlan_tci = rule->filter.vlan_tci;
+		fsp->h_ext.vlan_tci = htons(rule->filter.vlan_tci);
 		fsp->m_ext.vlan_tci = htons(VLAN_PRIO_MASK);
 	}
 
@@ -1183,9 +1183,8 @@ int igc_enable_nfc_rule(struct igc_adapter *adapter,
 	int err = -EINVAL;
 
 	if (rule->filter.match_flags & IGC_FILTER_FLAG_ETHER_TYPE) {
-		u16 etype = ntohs(rule->filter.etype);
-
-		err = igc_add_etype_filter(adapter, etype, rule->action);
+		err = igc_add_etype_filter(adapter, rule->filter.etype,
+					   rule->action);
 		if (err)
 			return err;
 	}
@@ -1205,8 +1204,9 @@ int igc_enable_nfc_rule(struct igc_adapter *adapter,
 	}
 
 	if (rule->filter.match_flags & IGC_FILTER_FLAG_VLAN_TCI) {
-		int prio = (ntohs(rule->filter.vlan_tci) & VLAN_PRIO_MASK)
+		int prio = (rule->filter.vlan_tci & VLAN_PRIO_MASK)
 				>> VLAN_PRIO_SHIFT;
+
 		err = igc_add_vlan_prio_filter(adapter, prio, rule->action);
 		if (err)
 			return err;
@@ -1218,14 +1218,11 @@ int igc_enable_nfc_rule(struct igc_adapter *adapter,
 int igc_disable_nfc_rule(struct igc_adapter *adapter,
 			 const struct igc_nfc_rule *rule)
 {
-	if (rule->filter.match_flags & IGC_FILTER_FLAG_ETHER_TYPE) {
-		u16 etype = ntohs(rule->filter.etype);
-
-		igc_del_etype_filter(adapter, etype);
-	}
+	if (rule->filter.match_flags & IGC_FILTER_FLAG_ETHER_TYPE)
+		igc_del_etype_filter(adapter, rule->filter.etype);
 
 	if (rule->filter.match_flags & IGC_FILTER_FLAG_VLAN_TCI) {
-		int prio = (ntohs(rule->filter.vlan_tci) & VLAN_PRIO_MASK)
+		int prio = (rule->filter.vlan_tci & VLAN_PRIO_MASK)
 				>> VLAN_PRIO_SHIFT;
 		igc_del_vlan_prio_filter(adapter, prio);
 	}
@@ -1325,7 +1322,7 @@ static int igc_ethtool_add_nfc_rule(struct igc_adapter *adapter,
 		return -ENOMEM;
 
 	if (fsp->m_u.ether_spec.h_proto == ETHER_TYPE_FULL_MASK) {
-		rule->filter.etype = fsp->h_u.ether_spec.h_proto;
+		rule->filter.etype = ntohs(fsp->h_u.ether_spec.h_proto);
 		rule->filter.match_flags = IGC_FILTER_FLAG_ETHER_TYPE;
 	}
 
@@ -1357,7 +1354,7 @@ static int igc_ethtool_add_nfc_rule(struct igc_adapter *adapter,
 			err = -EOPNOTSUPP;
 			goto err_out;
 		}
-		rule->filter.vlan_tci = fsp->h_ext.vlan_tci;
+		rule->filter.vlan_tci = ntohs(fsp->h_ext.vlan_tci);
 		rule->filter.match_flags |= IGC_FILTER_FLAG_VLAN_TCI;
 	}
 
-- 
2.26.0

