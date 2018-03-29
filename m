From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Thu, 29 Mar 2018 14:07:49 -0700
Subject: [Intel-wired-lan] [next-queue PATCH v6 08/10] igb: Add MAC address
 support for ethtool nftuple filters
In-Reply-To: <20180329210751.11531-1-vinicius.gomes@intel.com>
References: <20180329210751.11531-1-vinicius.gomes@intel.com>
Message-ID: <20180329210751.11531-9-vinicius.gomes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This adds the capability of configuring the queue steering of arriving
packets based on their source and destination MAC addresses.

In practical terms this adds support for the following use cases,
characterized by these examples:

$ ethtool -N eth0 flow-type ether dst aa:aa:aa:aa:aa:aa action 0
(this will direct packets with destination address "aa:aa:aa:aa:aa:aa"
to the RX queue 0)

$ ethtool -N eth0 flow-type ether src 44:44:44:44:44:44 action 3
(this will direct packets with source address "44:44:44:44:44:44" to
the RX queue 3)

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 drivers/net/ethernet/intel/igb/igb_ethtool.c | 35 ++++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
index 31b2960a7869..491946e09f8e 100644
--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
@@ -2495,6 +2495,23 @@ static int igb_get_ethtool_nfc_entry(struct igb_adapter *adapter,
 			fsp->h_ext.vlan_tci = rule->filter.vlan_tci;
 			fsp->m_ext.vlan_tci = htons(VLAN_PRIO_MASK);
 		}
+		if (rule->filter.match_flags & IGB_FILTER_FLAG_DST_MAC_ADDR) {
+			ether_addr_copy(fsp->h_u.ether_spec.h_dest,
+					rule->filter.dst_addr);
+			/* As we only support matching by the full
+			 * mask, return the mask to userspace
+			 */
+			eth_broadcast_addr(fsp->m_u.ether_spec.h_dest);
+		}
+		if (rule->filter.match_flags & IGB_FILTER_FLAG_SRC_MAC_ADDR) {
+			ether_addr_copy(fsp->h_u.ether_spec.h_source,
+					rule->filter.src_addr);
+			/* As we only support matching by the full
+			 * mask, return the mask to userspace
+			 */
+			eth_broadcast_addr(fsp->m_u.ether_spec.h_source);
+		}
+
 		return 0;
 	}
 	return -EINVAL;
@@ -2933,10 +2950,6 @@ static int igb_add_ethtool_nfc_entry(struct igb_adapter *adapter,
 	if ((fsp->flow_type & ~FLOW_EXT) != ETHER_FLOW)
 		return -EINVAL;
 
-	if (fsp->m_u.ether_spec.h_proto != ETHER_TYPE_FULL_MASK &&
-	    fsp->m_ext.vlan_tci != htons(VLAN_PRIO_MASK))
-		return -EINVAL;
-
 	input = kzalloc(sizeof(*input), GFP_KERNEL);
 	if (!input)
 		return -ENOMEM;
@@ -2946,6 +2959,20 @@ static int igb_add_ethtool_nfc_entry(struct igb_adapter *adapter,
 		input->filter.match_flags = IGB_FILTER_FLAG_ETHER_TYPE;
 	}
 
+	/* Only support matching addresses by the full mask */
+	if (is_broadcast_ether_addr(fsp->m_u.ether_spec.h_source)) {
+		input->filter.match_flags |= IGB_FILTER_FLAG_SRC_MAC_ADDR;
+		ether_addr_copy(input->filter.src_addr,
+				fsp->h_u.ether_spec.h_source);
+	}
+
+	/* Only support matching addresses by the full mask */
+	if (is_broadcast_ether_addr(fsp->m_u.ether_spec.h_dest)) {
+		input->filter.match_flags |= IGB_FILTER_FLAG_DST_MAC_ADDR;
+		ether_addr_copy(input->filter.dst_addr,
+				fsp->h_u.ether_spec.h_dest);
+	}
+
 	if ((fsp->flow_type & FLOW_EXT) && fsp->m_ext.vlan_tci) {
 		if (fsp->m_ext.vlan_tci != htons(VLAN_PRIO_MASK)) {
 			err = -EINVAL;
-- 
2.16.3

