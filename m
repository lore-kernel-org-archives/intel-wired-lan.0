From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Wed, 21 Mar 2018 17:33:50 -0700
Subject: [Intel-wired-lan] [next-queue PATCH v5 6/9] igb: Enable nfc filters
 to specify MAC addresses
In-Reply-To: <20180322003353.29970-1-vinicius.gomes@intel.com>
References: <20180322003353.29970-1-vinicius.gomes@intel.com>
Message-ID: <20180322003353.29970-7-vinicius.gomes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This allows igb_add_filter()/igb_erase_filter() to work on filters
that include MAC addresses (both source and destination).

For now, this only exposes the functionality, the next commit glues
ethtool into this. Later in this series, these APIs are used to allow
offloading of cls_flower filters.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 drivers/net/ethernet/intel/igb/igb.h         |  4 ++++
 drivers/net/ethernet/intel/igb/igb_ethtool.c | 28 ++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
index dfef1702ba21..66165879f12b 100644
--- a/drivers/net/ethernet/intel/igb/igb.h
+++ b/drivers/net/ethernet/intel/igb/igb.h
@@ -441,6 +441,8 @@ struct hwmon_buff {
 enum igb_filter_match_flags {
 	IGB_FILTER_FLAG_ETHER_TYPE = 0x1,
 	IGB_FILTER_FLAG_VLAN_TCI   = 0x2,
+	IGB_FILTER_FLAG_SRC_MAC_ADDR   = 0x4,
+	IGB_FILTER_FLAG_DST_MAC_ADDR   = 0x8,
 };
 
 #define IGB_MAX_RXNFC_FILTERS 16
@@ -455,6 +457,8 @@ struct igb_nfc_input {
 	u8 match_flags;
 	__be16 etype;
 	__be16 vlan_tci;
+	u8 src_addr[ETH_ALEN];
+	u8 dst_addr[ETH_ALEN];
 };
 
 struct igb_nfc_filter {
diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
index 143f0bb34e4d..4c6a1b78c413 100644
--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
@@ -2775,6 +2775,25 @@ int igb_add_filter(struct igb_adapter *adapter, struct igb_nfc_filter *input)
 			return err;
 	}
 
+	if (input->filter.match_flags & IGB_FILTER_FLAG_DST_MAC_ADDR) {
+		err = igb_add_mac_steering_filter(adapter,
+						  input->filter.dst_addr,
+						  input->action, 0);
+		err = min_t(int, err, 0);
+		if (err)
+			return err;
+	}
+
+	if (input->filter.match_flags & IGB_FILTER_FLAG_SRC_MAC_ADDR) {
+		err = igb_add_mac_steering_filter(adapter,
+						  input->filter.src_addr,
+						  input->action,
+						  IGB_MAC_STATE_SRC_ADDR);
+		err = min_t(int, err, 0);
+		if (err)
+			return err;
+	}
+
 	if (input->filter.match_flags & IGB_FILTER_FLAG_VLAN_TCI)
 		err = igb_rxnfc_write_vlan_prio_filter(adapter, input);
 
@@ -2823,6 +2842,15 @@ int igb_erase_filter(struct igb_adapter *adapter, struct igb_nfc_filter *input)
 		igb_clear_vlan_prio_filter(adapter,
 					   ntohs(input->filter.vlan_tci));
 
+	if (input->filter.match_flags & IGB_FILTER_FLAG_SRC_MAC_ADDR)
+		igb_del_mac_steering_filter(adapter, input->filter.src_addr,
+					    input->action,
+					    IGB_MAC_STATE_SRC_ADDR);
+
+	if (input->filter.match_flags & IGB_FILTER_FLAG_DST_MAC_ADDR)
+		igb_del_mac_steering_filter(adapter, input->filter.dst_addr,
+					    input->action, 0);
+
 	return 0;
 }
 
-- 
2.16.2

