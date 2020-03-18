From: Andre Guedes <andre.guedes@intel.com>
Date: Wed, 18 Mar 2020 16:00:53 -0700
Subject: [Intel-wired-lan] [PATCH 03/12] igc: Change igc_add_mac_filter()
 returning value
In-Reply-To: <20200318230102.36952-1-andre.guedes@intel.com>
References: <20200318230102.36952-1-andre.guedes@intel.com>
Message-ID: <20200318230102.36952-4-andre.guedes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

In case of success, igc_add_mac_filter() returns the index in
adapter->mac_table where the requested filter was added. This
information, however, is not used by any caller of that function.
In fact, callers have extra code just to handle this returning
index as 0 (success).

So this patch changes the function to return 0 on success instead,
and cleans up the extra code.

Signed-off-by: Andre Guedes <andre.guedes@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 2 --
 drivers/net/ethernet/intel/igc/igc_main.c    | 7 ++-----
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index 925f0979506e..9ef133fe6e40 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -1270,7 +1270,6 @@ int igc_add_filter(struct igc_adapter *adapter, struct igc_nfc_filter *input)
 		err = igc_add_mac_steering_filter(adapter,
 						  input->filter.dst_addr,
 						  input->action, 0);
-		err = min_t(int, err, 0);
 		if (err)
 			return err;
 	}
@@ -1280,7 +1279,6 @@ int igc_add_filter(struct igc_adapter *adapter, struct igc_nfc_filter *input)
 						  input->filter.src_addr,
 						  input->action,
 						  IGC_MAC_STATE_SRC_ADDR);
-		err = min_t(int, err, 0);
 		if (err)
 			return err;
 	}
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 5360d73d9c63..ed2648e0fbd8 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -2218,7 +2218,7 @@ static int igc_add_mac_filter(struct igc_adapter *adapter, const u8 *addr,
 		adapter->mac_table[i].state |= IGC_MAC_STATE_IN_USE | flags;
 
 		igc_rar_set_index(adapter, i);
-		return i;
+		return 0;
 	}
 
 	return -ENOSPC;
@@ -2277,11 +2277,8 @@ static int igc_del_mac_filter(struct igc_adapter *adapter, const u8 *addr,
 static int igc_uc_sync(struct net_device *netdev, const unsigned char *addr)
 {
 	struct igc_adapter *adapter = netdev_priv(netdev);
-	int ret;
-
-	ret = igc_add_mac_filter(adapter, addr, adapter->num_rx_queues, 0);
 
-	return min_t(int, ret, 0);
+	return igc_add_mac_filter(adapter, addr, adapter->num_rx_queues, 0);
 }
 
 static int igc_uc_unsync(struct net_device *netdev, const unsigned char *addr)
-- 
2.25.0

