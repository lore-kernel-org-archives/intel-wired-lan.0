From: Alexander Duyck <aduyck@mirantis.com>
Date: Thu, 21 Jan 2016 16:27:52 -0800
Subject: [Intel-wired-lan] [next PATCH v2 09/15] i40e/i40evf: Add exception
 handling for Tx checksum
In-Reply-To: <20160122002407.18278.95721.stgit@localhost.localdomain>
References: <20160122002407.18278.95721.stgit@localhost.localdomain>
Message-ID: <20160122002752.18278.51171.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Add exception handling to the Tx checksum path so that we can handle cases
of TSO where the frame is bad, or Tx checksum where we didn't recognize a
protocol

Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   |   31 ++++++++++++++++--------
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c |   32 +++++++++++++++++--------
 2 files changed, 43 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index a7f5df3c3c79..b13b637b97fe 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -2387,10 +2387,10 @@ static int i40e_tsyn(struct i40e_ring *tx_ring, struct sk_buff *skb,
  * @tx_ring: Tx descriptor ring
  * @cd_tunneling: ptr to context desc bits
  **/
-static void i40e_tx_enable_csum(struct sk_buff *skb, u32 *tx_flags,
-				u32 *td_cmd, u32 *td_offset,
-				struct i40e_ring *tx_ring,
-				u32 *cd_tunneling)
+static int i40e_tx_enable_csum(struct sk_buff *skb, u32 *tx_flags,
+			       u32 *td_cmd, u32 *td_offset,
+			       struct i40e_ring *tx_ring,
+			       u32 *cd_tunneling)
 {
 	union {
 		struct iphdr *v4;
@@ -2450,7 +2450,11 @@ static void i40e_tx_enable_csum(struct sk_buff *skb, u32 *tx_flags,
 			*tx_flags |= I40E_TX_FLAGS_TUNNEL;
 			break;
 		default:
-			return;
+			if (*tx_flags & I40E_TX_FLAGS_TSO)
+				return -1;
+
+			skb_checksum_help(skb);
+			return 0;
 		}
 
 		/* compute tunnel header size */
@@ -2514,11 +2518,16 @@ static void i40e_tx_enable_csum(struct sk_buff *skb, u32 *tx_flags,
 			  I40E_TX_DESC_LENGTH_L4_FC_LEN_SHIFT;
 		break;
 	default:
-		break;
+		if (*tx_flags & I40E_TX_FLAGS_TSO)
+			return -1;
+		skb_checksum_help(skb);
+		return 0;
 	}
 
 	*td_cmd |= cmd;
 	*td_offset |= offset;
+
+	return 1;
 }
 
 /**
@@ -2956,10 +2965,12 @@ static netdev_tx_t i40e_xmit_frame_ring(struct sk_buff *skb,
 
 	/* Always offload the checksum, since it's in the data descriptor */
 	if (skb->ip_summed == CHECKSUM_PARTIAL) {
-		tx_flags |= I40E_TX_FLAGS_CSUM;
-
-		i40e_tx_enable_csum(skb, &tx_flags, &td_cmd, &td_offset,
-				    tx_ring, &cd_tunneling);
+		tso = i40e_tx_enable_csum(skb, &tx_flags, &td_cmd, &td_offset,
+					  tx_ring, &cd_tunneling);
+		if (tso < 0)
+			goto out_drop;
+		else if (tso)
+			tx_flags |= I40E_TX_FLAGS_CSUM;
 	}
 
 	i40e_create_tx_ctx(tx_ring, cd_type_cmd_tso_mss,
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
index bd990dc5b7c6..b9272234959b 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
@@ -1602,12 +1602,13 @@ static int i40e_tso(struct i40e_ring *tx_ring, struct sk_buff *skb,
  * @tx_flags: pointer to Tx flags currently set
  * @td_cmd: Tx descriptor command bits to set
  * @td_offset: Tx descriptor header offsets to set
+ * @tx_ring: Tx descriptor ring
  * @cd_tunneling: ptr to context desc bits
  **/
-static void i40e_tx_enable_csum(struct sk_buff *skb, u32 *tx_flags,
-				u32 *td_cmd, u32 *td_offset,
-				struct i40e_ring *tx_ring,
-				u32 *cd_tunneling)
+static int i40e_tx_enable_csum(struct sk_buff *skb, u32 *tx_flags,
+			       u32 *td_cmd, u32 *td_offset,
+			       struct i40e_ring *tx_ring,
+			       u32 *cd_tunneling)
 {
 	union {
 		struct iphdr *v4;
@@ -1667,7 +1668,11 @@ static void i40e_tx_enable_csum(struct sk_buff *skb, u32 *tx_flags,
 			*tx_flags |= I40E_TX_FLAGS_TUNNEL;
 			break;
 		default:
-			return;
+			if (*tx_flags & I40E_TX_FLAGS_TSO)
+				return -1;
+
+			skb_checksum_help(skb);
+			return 0;
 		}
 
 		/* compute tunnel header size */
@@ -1731,11 +1736,16 @@ static void i40e_tx_enable_csum(struct sk_buff *skb, u32 *tx_flags,
 			  I40E_TX_DESC_LENGTH_L4_FC_LEN_SHIFT;
 		break;
 	default:
-		break;
+		if (*tx_flags & I40E_TX_FLAGS_TSO)
+			return -1;
+		skb_checksum_help(skb);
+		return 0;
 	}
 
 	*td_cmd |= cmd;
 	*td_offset |= offset;
+
+	return 1;
 }
 
 /**
@@ -2152,10 +2162,12 @@ static netdev_tx_t i40e_xmit_frame_ring(struct sk_buff *skb,
 
 	/* Always offload the checksum, since it's in the data descriptor */
 	if (skb->ip_summed == CHECKSUM_PARTIAL) {
-		tx_flags |= I40E_TX_FLAGS_CSUM;
-
-		i40e_tx_enable_csum(skb, &tx_flags, &td_cmd, &td_offset,
-				    tx_ring, &cd_tunneling);
+		tso = i40e_tx_enable_csum(skb, &tx_flags, &td_cmd, &td_offset,
+					  tx_ring, &cd_tunneling);
+		if (tso < 0)
+			goto out_drop;
+		else if (tso)
+			tx_flags |= I40E_TX_FLAGS_CSUM;
 	}
 
 	i40e_create_tx_ctx(tx_ring, cd_type_cmd_tso_mss,

