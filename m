From: Andre Guedes <andre.guedes@intel.com>
Date: Fri, 10 Apr 2020 17:28:34 -0700
Subject: [Intel-wired-lan] [PATCH 4/4] igc: Enable NFC rules based source
 MAC address
In-Reply-To: <20200411002834.13916-1-andre.guedes@intel.com>
References: <20200411002834.13916-1-andre.guedes@intel.com>
Message-ID: <20200411002834.13916-5-andre.guedes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch adds support for Network Flow Classification (NFC) rules
based on source MAC address. Note that the controller doesn't support
rules with both source and destination addresses set, so this special
case is checked in igc_add_ethtool_nfc_entry().

Signed-off-by: Andre Guedes <andre.guedes@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 31 +++++++++++++-------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index 20d22df52f09..9cd629b7d5f4 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -1188,16 +1188,8 @@ static int igc_set_rss_hash_opt(struct igc_adapter *adapter,
 
 int igc_add_filter(struct igc_adapter *adapter, struct igc_nfc_filter *input)
 {
-	struct igc_hw *hw = &adapter->hw;
 	int err = -EINVAL;
 
-	if (hw->mac.type == igc_i225 &&
-	    !(input->filter.match_flags & ~IGC_FILTER_FLAG_SRC_MAC_ADDR)) {
-		netdev_err(adapter->netdev,
-			   "i225 doesn't support flow classification rules specifying only source addresses");
-		return -EOPNOTSUPP;
-	}
-
 	if (input->filter.match_flags & IGC_FILTER_FLAG_ETHER_TYPE) {
 		u16 etype = ntohs(input->filter.etype);
 
@@ -1206,6 +1198,14 @@ int igc_add_filter(struct igc_adapter *adapter, struct igc_nfc_filter *input)
 			return err;
 	}
 
+	if (input->filter.match_flags & IGC_FILTER_FLAG_SRC_MAC_ADDR) {
+		err = igc_add_mac_filter(adapter, IGC_MAC_FILTER_TYPE_SRC,
+					 input->filter.src_addr,
+					 input->action);
+		if (err)
+			return err;
+	}
+
 	if (input->filter.match_flags & IGC_FILTER_FLAG_DST_MAC_ADDR) {
 		err = igc_add_mac_filter(adapter, IGC_MAC_FILTER_TYPE_DST,
 					 input->filter.dst_addr,
@@ -1239,6 +1239,10 @@ int igc_erase_filter(struct igc_adapter *adapter, struct igc_nfc_filter *input)
 		igc_del_vlan_prio_filter(adapter, prio);
 	}
 
+	if (input->filter.match_flags & IGC_FILTER_FLAG_SRC_MAC_ADDR)
+		igc_del_mac_filter(adapter, IGC_MAC_FILTER_TYPE_SRC,
+				   input->filter.src_addr);
+
 	if (input->filter.match_flags & IGC_FILTER_FLAG_DST_MAC_ADDR)
 		igc_del_mac_filter(adapter, IGC_MAC_FILTER_TYPE_DST,
 				   input->filter.dst_addr);
@@ -1334,20 +1338,27 @@ static int igc_add_ethtool_nfc_entry(struct igc_adapter *adapter,
 		input->filter.match_flags = IGC_FILTER_FLAG_ETHER_TYPE;
 	}
 
-	/* Only support matching addresses by the full mask */
+	/* Both source and destination address filters only support the full
+	 * mask.
+	 */
 	if (is_broadcast_ether_addr(fsp->m_u.ether_spec.h_source)) {
 		input->filter.match_flags |= IGC_FILTER_FLAG_SRC_MAC_ADDR;
 		ether_addr_copy(input->filter.src_addr,
 				fsp->h_u.ether_spec.h_source);
 	}
 
-	/* Only support matching addresses by the full mask */
 	if (is_broadcast_ether_addr(fsp->m_u.ether_spec.h_dest)) {
 		input->filter.match_flags |= IGC_FILTER_FLAG_DST_MAC_ADDR;
 		ether_addr_copy(input->filter.dst_addr,
 				fsp->h_u.ether_spec.h_dest);
 	}
 
+	if (input->filter.match_flags & IGC_FILTER_FLAG_DST_MAC_ADDR &&
+	    input->filter.match_flags & IGC_FILTER_FLAG_SRC_MAC_ADDR) {
+		netdev_dbg(netdev, "Filters with both dst and src are not supported");
+		return -EOPNOTSUPP;
+	}
+
 	if ((fsp->flow_type & FLOW_EXT) && fsp->m_ext.vlan_tci) {
 		if (fsp->m_ext.vlan_tci != htons(VLAN_PRIO_MASK)) {
 			netdev_dbg(netdev, "VLAN mask not supported");
-- 
2.26.0

