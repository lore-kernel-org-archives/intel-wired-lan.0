From: Paolo Abeni <pabeni@redhat.com>
Date: Thu, 15 Mar 2018 16:08:12 +0100
Subject: [Intel-wired-lan] [RFC PATCH 2/2] ixgbe: setup XPS via
 netif_set_xps()
In-Reply-To: <cover.1521124830.git.pabeni@redhat.com>
References: <cover.1521124830.git.pabeni@redhat.com>
Message-ID: <384ee099d617f3d3786a618b11cc10616923ec45.1521124830.git.pabeni@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Before this commit, ixgbe with the default setting lacks XPS mapping
for CPUs id greater than the number of tx queues.

As a consequence the xmit path for such CPUs experience a relevant cost
in __netdev_pick_tx, mainly due to skb_tx_hash(), as reported by the perf
tool:

7.55%--netdev_pick_tx
        |
        --6.92%--__netdev_pick_tx
                  |
                  --6.35%--__skb_tx_hash
                            |
                            --5.94%--__skb_get_hash
                                      |
                                      --3.22%--__skb_flow_dissect

in the following  scenario:

ethtool -L em1 combined 1
taskset 2 netperf -H 192.168.1.1 -t UDP_STREAM -- -m 1
MIGRATED UDP STREAM TEST from 0.0.0.0 (0.0.0.0) port 0 AF_INET to 192.168.101.1 () port 0 AF_INET
Socket  Message  Elapsed      Messages
Size    Size     Time         Okay Errors   Throughput
bytes   bytes    secs            #      #   10^6bits/sec

212992       1   10.00     11497225      0       9.20

After this commit the perf tool reports:

0.85%--__netdev_pick_tx

and netperf reports:

MIGRATED UDP STREAM TEST from 0.0.0.0 (0.0.0.0) port 0 AF_INET to 192.168.101.1 () port 0 AF_INET
Socket  Message  Elapsed      Messages
Size    Size     Time         Okay Errors   Throughput
bytes   bytes    secs            #      #   10^6bits/sec

212992       1   10.00     12736058      0      10.19

roughly +10% in xmit tput.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe.h         |  2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c |  1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c    | 13 +++----------
 3 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
index c1e3a0039ea5..04aaecce81d2 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
@@ -293,7 +293,6 @@ enum ixgbe_ring_state_t {
 	__IXGBE_RX_CSUM_UDP_ZERO_ERR,
 	__IXGBE_RX_FCOE,
 	__IXGBE_TX_FDIR_INIT_DONE,
-	__IXGBE_TX_XPS_INIT_DONE,
 	__IXGBE_TX_DETECT_HANG,
 	__IXGBE_HANG_CHECK_ARMED,
 	__IXGBE_TX_XDP_RING,
@@ -827,6 +826,7 @@ enum ixgbe_state_t {
 	__IXGBE_PTP_RUNNING,
 	__IXGBE_PTP_TX_IN_PROGRESS,
 	__IXGBE_RESET_REQUESTED,
+	__IXGBE_TX_XPS_INIT_DONE,
 };
 
 struct ixgbe_cb {
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index c0e6ab42e0e1..da4e6416e8eb 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -3224,6 +3224,7 @@ static int ixgbe_set_channels(struct net_device *dev,
 
 #endif
 	/* use setup TC to update any traffic class queue mapping */
+	clear_bit(__IXGBE_TX_XPS_INIT_DONE, &adapter->state);
 	return ixgbe_setup_tc(dev, adapter->hw_tcs);
 }
 
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 85369423452d..5bd45fc737fa 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -3566,16 +3566,6 @@ void ixgbe_configure_tx_ring(struct ixgbe_adapter *adapter,
 		ring->atr_sample_rate = 0;
 	}
 
-	/* initialize XPS */
-	if (!test_and_set_bit(__IXGBE_TX_XPS_INIT_DONE, &ring->state)) {
-		struct ixgbe_q_vector *q_vector = ring->q_vector;
-
-		if (q_vector)
-			netif_set_xps_queue(ring->netdev,
-					    &q_vector->affinity_mask,
-					    ring->queue_index);
-	}
-
 	clear_bit(__IXGBE_HANG_CHECK_ARMED, &ring->state);
 
 	/* reinitialize tx_buffer_info */
@@ -5626,6 +5616,9 @@ static void ixgbe_up_complete(struct ixgbe_adapter *adapter)
 	int err;
 	u32 ctrl_ext;
 
+	if (!test_and_set_bit(__IXGBE_TX_XPS_INIT_DONE, &adapter->state))
+		netif_set_xps(adapter->netdev);
+
 	ixgbe_get_hw_control(adapter);
 	ixgbe_setup_gpie(adapter);
 
-- 
2.14.3

