From: Andre Guedes <andre.guedes@intel.com>
Date: Fri, 24 Apr 2020 13:16:21 -0700
Subject: [Intel-wired-lan] [PATCH 17/19] igc: Change return type from
 igc_disable_nfc_rule()
In-Reply-To: <20200424201623.10971-1-andre.guedes@intel.com>
References: <20200424201623.10971-1-andre.guedes@intel.com>
Message-ID: <20200424201623.10971-18-andre.guedes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

None of igc_disable_nfc_rule() callers actually check its returning
value. A closer look at why this function would fail shows that the
only situation is when we try to delete an ethertype or mac filter that
doesn't exist.

That situation is very unlikely so we can change igc_del_etype_filter()
and igc_del_mac_filter() logic to "if the filter doesn't exist, we are
done", and keep the logic in igc_disable_nfc_rule() callers simple.

Signed-off-by: Andre Guedes <andre.guedes@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 26 ++++++++---------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 64e372f38c6b..134523064fe9 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -2260,18 +2260,16 @@ static int igc_add_mac_filter(struct igc_adapter *adapter,
  * @adapter: Pointer to adapter where the filter should be deleted from
  * @type: MAC address filter type (source or destination)
  * @addr: MAC address
- *
- * Return: 0 in case of success, negative errno code otherwise.
  */
-static int igc_del_mac_filter(struct igc_adapter *adapter,
-			      enum igc_mac_filter_type type, const u8 *addr)
+static void igc_del_mac_filter(struct igc_adapter *adapter,
+			       enum igc_mac_filter_type type, const u8 *addr)
 {
 	struct net_device *dev = adapter->netdev;
 	int index;
 
 	index = igc_find_mac_filter(adapter, type, addr);
 	if (index < 0)
-		return -ENOENT;
+		return;
 
 	if (index == 0) {
 		/* If this is the default filter, we don't actually delete it.
@@ -2289,8 +2287,6 @@ static int igc_del_mac_filter(struct igc_adapter *adapter,
 
 		igc_clear_mac_filter_hw(adapter, index);
 	}
-
-	return 0;
 }
 
 /**
@@ -2421,23 +2417,20 @@ static int igc_find_etype_filter(struct igc_adapter *adapter, u16 etype)
  * igc_del_etype_filter() - Delete ethertype filter.
  * @adapter: Pointer to adapter where the filter should be deleted from.
  * @etype: Ethertype value.
- *
- * Return: 0 in case of success, negative errno code otherwise.
  */
-static int igc_del_etype_filter(struct igc_adapter *adapter, u16 etype)
+static void igc_del_etype_filter(struct igc_adapter *adapter, u16 etype)
 {
 	struct igc_hw *hw = &adapter->hw;
 	int index;
 
 	index = igc_find_etype_filter(adapter, etype);
 	if (index < 0)
-		return -ENOENT;
+		return;
 
 	wr32(IGC_ETQF(index), 0);
 
 	netdev_dbg(adapter->netdev, "Delete ethertype filter: etype %04x",
 		   etype);
-	return 0;
 }
 
 static int igc_enable_nfc_rule(struct igc_adapter *adapter,
@@ -2478,8 +2471,8 @@ static int igc_enable_nfc_rule(struct igc_adapter *adapter,
 	return 0;
 }
 
-static int igc_disable_nfc_rule(struct igc_adapter *adapter,
-				const struct igc_nfc_rule *rule)
+static void igc_disable_nfc_rule(struct igc_adapter *adapter,
+				 const struct igc_nfc_rule *rule)
 {
 	if (rule->filter.match_flags & IGC_FILTER_FLAG_ETHER_TYPE)
 		igc_del_etype_filter(adapter, rule->filter.etype);
@@ -2498,8 +2491,6 @@ static int igc_disable_nfc_rule(struct igc_adapter *adapter,
 	if (rule->filter.match_flags & IGC_FILTER_FLAG_DST_MAC_ADDR)
 		igc_del_mac_filter(adapter, IGC_MAC_FILTER_TYPE_DST,
 				   rule->filter.dst_addr);
-
-	return 0;
 }
 
 /**
@@ -2624,7 +2615,8 @@ static int igc_uc_unsync(struct net_device *netdev, const unsigned char *addr)
 {
 	struct igc_adapter *adapter = netdev_priv(netdev);
 
-	return igc_del_mac_filter(adapter, IGC_MAC_FILTER_TYPE_DST, addr);
+	igc_del_mac_filter(adapter, IGC_MAC_FILTER_TYPE_DST, addr);
+	return 0;
 }
 
 /**
-- 
2.26.0

