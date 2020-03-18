From: Andre Guedes <andre.guedes@intel.com>
Date: Wed, 18 Mar 2020 16:00:59 -0700
Subject: [Intel-wired-lan] [PATCH 09/12] igc: Remove
 igc_*_mac_steering_filter() wrappers
In-Reply-To: <20200318230102.36952-1-andre.guedes@intel.com>
References: <20200318230102.36952-1-andre.guedes@intel.com>
Message-ID: <20200318230102.36952-10-andre.guedes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

With the previous two patches, igc_add_mac_steering_filter() and
igc_del_mac_steering_filter() became a pointless wrapper of
igc_add_mac_filter() and igc_del_mac_filter().

This patch removes these wrappers and update callers to call
igc_add_mac_filter() and igc_del_mac_filter() directly.

Signed-off-by: Andre Guedes <andre.guedes@intel.com>
---
 drivers/net/ethernet/intel/igc/igc.h         |  8 ++++----
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 20 ++++++++------------
 drivers/net/ethernet/intel/igc/igc_main.c    | 20 ++++----------------
 3 files changed, 16 insertions(+), 32 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index 192cef07bdf7..6c18c74a68fb 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -231,10 +231,10 @@ void igc_write_rss_indir_tbl(struct igc_adapter *adapter);
 bool igc_has_link(struct igc_adapter *adapter);
 void igc_reset(struct igc_adapter *adapter);
 int igc_set_spd_dplx(struct igc_adapter *adapter, u32 spd, u8 dplx);
-int igc_add_mac_steering_filter(struct igc_adapter *adapter,
-				const u8 *addr, u8 queue, u8 flags);
-int igc_del_mac_steering_filter(struct igc_adapter *adapter,
-				const u8 *addr, u8 queue, u8 flags);
+int igc_add_mac_filter(struct igc_adapter *adapter, const u8 *addr,
+		       const s8 queue, const u8 flags);
+int igc_del_mac_filter(struct igc_adapter *adapter, const u8 *addr,
+		       const u8 flags);
 void igc_update_stats(struct igc_adapter *adapter);
 
 /* igc_dump declarations */
diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index 9ef133fe6e40..93608bd57c29 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -1267,18 +1267,16 @@ int igc_add_filter(struct igc_adapter *adapter, struct igc_nfc_filter *input)
 	}
 
 	if (input->filter.match_flags & IGC_FILTER_FLAG_DST_MAC_ADDR) {
-		err = igc_add_mac_steering_filter(adapter,
-						  input->filter.dst_addr,
-						  input->action, 0);
+		err = igc_add_mac_filter(adapter, input->filter.dst_addr,
+					 input->action, 0);
 		if (err)
 			return err;
 	}
 
 	if (input->filter.match_flags & IGC_FILTER_FLAG_SRC_MAC_ADDR) {
-		err = igc_add_mac_steering_filter(adapter,
-						  input->filter.src_addr,
-						  input->action,
-						  IGC_MAC_STATE_SRC_ADDR);
+		err = igc_add_mac_filter(adapter, input->filter.src_addr,
+					 input->action,
+					 IGC_MAC_STATE_SRC_ADDR);
 		if (err)
 			return err;
 	}
@@ -1332,13 +1330,11 @@ int igc_erase_filter(struct igc_adapter *adapter, struct igc_nfc_filter *input)
 					   ntohs(input->filter.vlan_tci));
 
 	if (input->filter.match_flags & IGC_FILTER_FLAG_SRC_MAC_ADDR)
-		igc_del_mac_steering_filter(adapter, input->filter.src_addr,
-					    input->action,
-					    IGC_MAC_STATE_SRC_ADDR);
+		igc_del_mac_filter(adapter, input->filter.src_addr,
+				   IGC_MAC_STATE_SRC_ADDR);
 
 	if (input->filter.match_flags & IGC_FILTER_FLAG_DST_MAC_ADDR)
-		igc_del_mac_steering_filter(adapter, input->filter.dst_addr,
-					    input->action, 0);
+		igc_del_mac_filter(adapter, input->filter.dst_addr, 0);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 273817252823..25d0431f4f4a 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -2210,8 +2210,8 @@ static bool igc_mac_entry_can_be_used(const struct igc_mac_addr *entry,
  *
  * In case of success, returns 0. Otherwise, it returns a negative errno code.
   */
-static int igc_add_mac_filter(struct igc_adapter *adapter, const u8 *addr,
-			      const s8 queue, const u8 flags)
+int igc_add_mac_filter(struct igc_adapter *adapter, const u8 *addr,
+		       const s8 queue, const u8 flags)
 {
 	struct igc_hw *hw = &adapter->hw;
 	int rar_entries = hw->mac.rar_entry_count;
@@ -2251,8 +2251,8 @@ static int igc_add_mac_filter(struct igc_adapter *adapter, const u8 *addr,
  *
  * In case of success, returns 0. Otherwise, it returns a negative errno code.
   */
-static int igc_del_mac_filter(struct igc_adapter *adapter, const u8 *addr,
-			      const u8 flags)
+int igc_del_mac_filter(struct igc_adapter *adapter, const u8 *addr,
+		       const u8 flags)
 {
 	struct igc_hw *hw = &adapter->hw;
 	int rar_entries = hw->mac.rar_entry_count;
@@ -3736,18 +3736,6 @@ igc_features_check(struct sk_buff *skb, struct net_device *dev,
 	return features;
 }
 
-int igc_add_mac_steering_filter(struct igc_adapter *adapter,
-				const u8 *addr, u8 queue, u8 flags)
-{
-	return igc_add_mac_filter(adapter, addr, queue, flags);
-}
-
-int igc_del_mac_steering_filter(struct igc_adapter *adapter,
-				const u8 *addr, u8 queue, u8 flags)
-{
-	return igc_del_mac_filter(adapter, addr, flags);
-}
-
 static void igc_tsync_interrupt(struct igc_adapter *adapter)
 {
 	struct igc_hw *hw = &adapter->hw;
-- 
2.25.0

