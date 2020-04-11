From: Andre Guedes <andre.guedes@intel.com>
Date: Fri, 10 Apr 2020 17:28:31 -0700
Subject: [Intel-wired-lan] [PATCH 1/4] igc: Remove IGC_MAC_STATE_SRC_ADDR
 flag
In-Reply-To: <20200411002834.13916-1-andre.guedes@intel.com>
References: <20200411002834.13916-1-andre.guedes@intel.com>
Message-ID: <20200411002834.13916-2-andre.guedes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

MAC address filters based on source address are not currently supported
by the IGC driver. Despite of that, the driver have some dangling code
to handle it, inherited from IGB driver. This patch removes that code to
prepare for a follow up patch that adds proper source MAC address filter
support.

Signed-off-by: Andre Guedes <andre.guedes@intel.com>
---
 drivers/net/ethernet/intel/igc/igc.h         |  6 ++---
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 16 ++----------
 drivers/net/ethernet/intel/igc/igc_main.c    | 27 ++++++--------------
 3 files changed, 12 insertions(+), 37 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index 22dde0590a23..c4c4498ab48f 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -231,9 +231,8 @@ bool igc_has_link(struct igc_adapter *adapter);
 void igc_reset(struct igc_adapter *adapter);
 int igc_set_spd_dplx(struct igc_adapter *adapter, u32 spd, u8 dplx);
 int igc_add_mac_filter(struct igc_adapter *adapter, const u8 *addr,
-		       const s8 queue, const u8 flags);
-int igc_del_mac_filter(struct igc_adapter *adapter, const u8 *addr,
-		       const u8 flags);
+		       const s8 queue);
+int igc_del_mac_filter(struct igc_adapter *adapter, const u8 *addr);
 int igc_add_vlan_prio_filter(struct igc_adapter *adapter, int prio,
 			     int queue);
 void igc_del_vlan_prio_filter(struct igc_adapter *adapter, int prio);
@@ -479,7 +478,6 @@ struct igc_mac_addr {
 
 #define IGC_MAC_STATE_DEFAULT		0x1
 #define IGC_MAC_STATE_IN_USE		0x2
-#define IGC_MAC_STATE_SRC_ADDR		0x4
 
 #define IGC_MAX_RXNFC_FILTERS		16
 
diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index 285310a99ddc..36e94142b248 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -1208,15 +1208,7 @@ int igc_add_filter(struct igc_adapter *adapter, struct igc_nfc_filter *input)
 
 	if (input->filter.match_flags & IGC_FILTER_FLAG_DST_MAC_ADDR) {
 		err = igc_add_mac_filter(adapter, input->filter.dst_addr,
-					 input->action, 0);
-		if (err)
-			return err;
-	}
-
-	if (input->filter.match_flags & IGC_FILTER_FLAG_SRC_MAC_ADDR) {
-		err = igc_add_mac_filter(adapter, input->filter.src_addr,
-					 input->action,
-					 IGC_MAC_STATE_SRC_ADDR);
+					 input->action);
 		if (err)
 			return err;
 	}
@@ -1246,12 +1238,8 @@ int igc_erase_filter(struct igc_adapter *adapter, struct igc_nfc_filter *input)
 		igc_del_vlan_prio_filter(adapter, prio);
 	}
 
-	if (input->filter.match_flags & IGC_FILTER_FLAG_SRC_MAC_ADDR)
-		igc_del_mac_filter(adapter, input->filter.src_addr,
-				   IGC_MAC_STATE_SRC_ADDR);
-
 	if (input->filter.match_flags & IGC_FILTER_FLAG_DST_MAC_ADDR)
-		igc_del_mac_filter(adapter, input->filter.dst_addr, 0);
+		igc_del_mac_filter(adapter, input->filter.dst_addr);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 9c2d487803b2..411af7eafe19 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -2185,8 +2185,7 @@ static void igc_nfc_filter_restore(struct igc_adapter *adapter)
 	spin_unlock(&adapter->nfc_lock);
 }
 
-static int igc_find_mac_filter(struct igc_adapter *adapter, const u8 *addr,
-			       u8 flags)
+static int igc_find_mac_filter(struct igc_adapter *adapter, const u8 *addr)
 {
 	int max_entries = adapter->hw.mac.rar_entry_count;
 	struct igc_mac_addr *entry;
@@ -2199,9 +2198,6 @@ static int igc_find_mac_filter(struct igc_adapter *adapter, const u8 *addr,
 			continue;
 		if (!ether_addr_equal(addr, entry->addr))
 			continue;
-		if ((entry->state & IGC_MAC_STATE_SRC_ADDR) !=
-		    (flags & IGC_MAC_STATE_SRC_ADDR))
-			continue;
 
 		return i;
 	}
@@ -2232,23 +2228,19 @@ static int igc_get_avail_mac_filter_slot(struct igc_adapter *adapter)
  * @queue: If non-negative, queue assignment feature is enabled and frames
  *         matching the filter are enqueued onto 'queue'. Otherwise, queue
  *         assignment is disabled.
- * @flags: Set IGC_MAC_STATE_SRC_ADDR bit to indicate @address is a source
- *         address.
  *
  * Return: 0 in case of success, negative errno code otherwise.
  */
 int igc_add_mac_filter(struct igc_adapter *adapter, const u8 *addr,
-		       const s8 queue, const u8 flags)
+		       const s8 queue)
 {
 	struct net_device *dev = adapter->netdev;
 	int index;
 
 	if (!is_valid_ether_addr(addr))
 		return -EINVAL;
-	if (flags & IGC_MAC_STATE_SRC_ADDR)
-		return -ENOTSUPP;
 
-	index = igc_find_mac_filter(adapter, addr, flags);
+	index = igc_find_mac_filter(adapter, addr);
 	if (index >= 0)
 		goto update_queue_assignment;
 
@@ -2260,7 +2252,7 @@ int igc_add_mac_filter(struct igc_adapter *adapter, const u8 *addr,
 		   index, addr, queue);
 
 	ether_addr_copy(adapter->mac_table[index].addr, addr);
-	adapter->mac_table[index].state |= IGC_MAC_STATE_IN_USE | flags;
+	adapter->mac_table[index].state |= IGC_MAC_STATE_IN_USE;
 update_queue_assignment:
 	adapter->mac_table[index].queue = queue;
 
@@ -2272,13 +2264,10 @@ int igc_add_mac_filter(struct igc_adapter *adapter, const u8 *addr,
  * igc_del_mac_filter() - Delete MAC address filter.
  * @adapter: Pointer to adapter where the filter should be deleted from.
  * @addr: MAC address.
- * @flags: Set IGC_MAC_STATE_SRC_ADDR bit to indicate @address is a source
- *         address.
  *
  * Return: 0 in case of success, negative errno code otherwise.
  */
-int igc_del_mac_filter(struct igc_adapter *adapter, const u8 *addr,
-		       const u8 flags)
+int igc_del_mac_filter(struct igc_adapter *adapter, const u8 *addr)
 {
 	struct net_device *dev = adapter->netdev;
 	struct igc_mac_addr *entry;
@@ -2287,7 +2276,7 @@ int igc_del_mac_filter(struct igc_adapter *adapter, const u8 *addr,
 	if (!is_valid_ether_addr(addr))
 		return -EINVAL;
 
-	index = igc_find_mac_filter(adapter, addr, flags);
+	index = igc_find_mac_filter(adapter, addr);
 	if (index < 0)
 		return -ENOENT;
 
@@ -2464,14 +2453,14 @@ static int igc_uc_sync(struct net_device *netdev, const unsigned char *addr)
 {
 	struct igc_adapter *adapter = netdev_priv(netdev);
 
-	return igc_add_mac_filter(adapter, addr, -1, 0);
+	return igc_add_mac_filter(adapter, addr, -1);
 }
 
 static int igc_uc_unsync(struct net_device *netdev, const unsigned char *addr)
 {
 	struct igc_adapter *adapter = netdev_priv(netdev);
 
-	return igc_del_mac_filter(adapter, addr, 0);
+	return igc_del_mac_filter(adapter, addr);
 }
 
 /**
-- 
2.26.0

