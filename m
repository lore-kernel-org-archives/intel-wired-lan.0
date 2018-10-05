From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri,  5 Oct 2018 09:33:56 -0700
Subject: [Intel-wired-lan] [net-next 2/2] intel-ethernet: software timestamp
 skbs as late as possible
In-Reply-To: <20181005163356.23996-1-jacob.e.keller@intel.com>
References: <20181005163356.23996-1-jacob.e.keller@intel.com>
Message-ID: <20181005163356.23996-2-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Many of the Intel Ethernet drivers call skb_tx_timestamp() earlier than
necessary. Move the calls to this function to the latest point possible,
just prior to notifying hardware of the new Tx packet when we bump the
tail register.

This affects i40e, iavf, igb, igc, and ixgbe.

The e100, e1000, e1000e, fm10k, and ice drivers already call the
skb_tx_timestamp() function just prior to indicating the Tx packet to
hardware, so they do not need to be changed.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 4 ++--
 drivers/net/ethernet/intel/iavf/iavf_txrx.c   | 4 ++--
 drivers/net/ethernet/intel/igb/igb_main.c     | 4 ++--
 drivers/net/ethernet/intel/igc/igc_main.c     | 4 ++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 4 ++--
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 740ea58ba938..159a79e45196 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -3474,6 +3474,8 @@ static inline int i40e_tx_map(struct i40e_ring *tx_ring, struct sk_buff *skb,
 	tx_desc->cmd_type_offset_bsz =
 			build_ctob(td_cmd, td_offset, size, td_tag);
 
+	skb_tx_timestamp(skb);
+
 	/* Force memory writes to complete before letting h/w know there
 	 * are new descriptors to fetch.
 	 *
@@ -3653,8 +3655,6 @@ static netdev_tx_t i40e_xmit_frame_ring(struct sk_buff *skb,
 	if (tsyn)
 		tx_flags |= I40E_TX_FLAGS_TSYN;
 
-	skb_tx_timestamp(skb);
-
 	/* always enable CRC insertion offload */
 	td_cmd |= I40E_TX_DESC_CMD_ICRC;
 
diff --git a/drivers/net/ethernet/intel/iavf/iavf_txrx.c b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
index edc349f49748..7ec0c6fcfa89 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_txrx.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
@@ -2344,6 +2344,8 @@ static inline void iavf_tx_map(struct iavf_ring *tx_ring, struct sk_buff *skb,
 	tx_desc->cmd_type_offset_bsz =
 			build_ctob(td_cmd, td_offset, size, td_tag);
 
+	skb_tx_timestamp(skb);
+
 	/* Force memory writes to complete before letting h/w know there
 	 * are new descriptors to fetch.
 	 *
@@ -2462,8 +2464,6 @@ static netdev_tx_t iavf_xmit_frame_ring(struct sk_buff *skb,
 	if (tso < 0)
 		goto out_drop;
 
-	skb_tx_timestamp(skb);
-
 	/* always enable CRC insertion offload */
 	td_cmd |= IAVF_TX_DESC_CMD_ICRC;
 
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 5aa73199420a..151444d472f3 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -6019,6 +6019,8 @@ static int igb_tx_map(struct igb_ring *tx_ring,
 	/* set the timestamp */
 	first->time_stamp = jiffies;
 
+	skb_tx_timestamp(skb);
+
 	/* Force memory writes to complete before letting h/w know there
 	 * are new descriptors to fetch.  (Only applicable for weak-ordered
 	 * memory model archs, such as IA-64).
@@ -6147,8 +6149,6 @@ netdev_tx_t igb_xmit_frame_ring(struct sk_buff *skb,
 	else if (!tso)
 		igb_tx_csum(tx_ring, first);
 
-	skb_tx_timestamp(skb);
-
 	if (igb_tx_map(tx_ring, first, hdr_len))
 		goto cleanup_tx_tstamp;
 
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 37c4bd91c4ca..376fa7d0622c 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -895,6 +895,8 @@ static int igc_tx_map(struct igc_ring *tx_ring,
 	/* set the timestamp */
 	first->time_stamp = jiffies;
 
+	skb_tx_timestamp(skb);
+
 	/* Force memory writes to complete before letting h/w know there
 	 * are new descriptors to fetch.  (Only applicable for weak-ordered
 	 * memory model archs, such as IA-64).
@@ -989,8 +991,6 @@ static netdev_tx_t igc_xmit_frame_ring(struct sk_buff *skb,
 	first->bytecount = skb->len;
 	first->gso_segs = 1;
 
-	skb_tx_timestamp(skb);
-
 	/* record initial flags and protocol */
 	first->tx_flags = tx_flags;
 	first->protocol = protocol;
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 0f2b0264eb27..65558316ab48 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -8268,6 +8268,8 @@ static int ixgbe_tx_map(struct ixgbe_ring *tx_ring,
 	/* set the timestamp */
 	first->time_stamp = jiffies;
 
+	skb_tx_timestamp(skb);
+
 	/*
 	 * Force memory writes to complete before letting h/w know there
 	 * are new descriptors to fetch.  (Only applicable for weak-ordered
@@ -8645,8 +8647,6 @@ netdev_tx_t ixgbe_xmit_frame_ring(struct sk_buff *skb,
 		}
 	}
 
-	skb_tx_timestamp(skb);
-
 #ifdef CONFIG_PCI_IOV
 	/*
 	 * Use the l2switch_enable flag - would be false if the DMA
-- 
2.18.0.219.gaf81d287a9da

