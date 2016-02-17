From: Alexander Duyck <aduyck@mirantis.com>
Date: Wed, 17 Feb 2016 11:02:56 -0800
Subject: [Intel-wired-lan] [next PATCH 3/4] i40e/i40evf: Move Tx checksum
	closer to TSO
In-Reply-To: <20160217185838.10339.68543.stgit@localhost.localdomain>
References: <20160217185838.10339.68543.stgit@localhost.localdomain>
Message-ID: <20160217190256.10339.83791.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On all of the other Intel drivers we place checksum close to TSO as they
have a significant amount in common and it can help to reduce the decision
tree for how to handle the frame as the first check in TSO is to see if
checksumming is offloaded, and if it is not we can skip _BOTH_ TSO and Tx
checksum offload based on a single check.

Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   |   12 ++++++------
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c |   10 +++++-----
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 5123646a895f..cb52f39d514a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -2929,6 +2929,12 @@ static netdev_tx_t i40e_xmit_frame_ring(struct sk_buff *skb,
 	else if (tso)
 		tx_flags |= I40E_TX_FLAGS_TSO;
 
+	/* Always offload the checksum, since it's in the data descriptor */
+	tso = i40e_tx_enable_csum(skb, &tx_flags, &td_cmd, &td_offset,
+				  tx_ring, &cd_tunneling);
+	if (tso < 0)
+		goto out_drop;
+
 	tsyn = i40e_tsyn(tx_ring, skb, tx_flags, &cd_type_cmd_tso_mss);
 
 	if (tsyn)
@@ -2939,12 +2945,6 @@ static netdev_tx_t i40e_xmit_frame_ring(struct sk_buff *skb,
 	/* always enable CRC insertion offload */
 	td_cmd |= I40E_TX_DESC_CMD_ICRC;
 
-	/* Always offload the checksum, since it's in the data descriptor */
-	tso = i40e_tx_enable_csum(skb, &tx_flags, &td_cmd, &td_offset,
-				  tx_ring, &cd_tunneling);
-	if (tso < 0)
-		goto out_drop;
-
 	i40e_create_tx_ctx(tx_ring, cd_type_cmd_tso_mss,
 			   cd_tunneling, cd_l2tag2);
 
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
index 1dd1cc12304b..686a95fe48bd 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
@@ -2146,17 +2146,17 @@ static netdev_tx_t i40e_xmit_frame_ring(struct sk_buff *skb,
 	else if (tso)
 		tx_flags |= I40E_TX_FLAGS_TSO;
 
-	skb_tx_timestamp(skb);
-
-	/* always enable CRC insertion offload */
-	td_cmd |= I40E_TX_DESC_CMD_ICRC;
-
 	/* Always offload the checksum, since it's in the data descriptor */
 	tso = i40e_tx_enable_csum(skb, &tx_flags, &td_cmd, &td_offset,
 				  tx_ring, &cd_tunneling);
 	if (tso < 0)
 		goto out_drop;
 
+	skb_tx_timestamp(skb);
+
+	/* always enable CRC insertion offload */
+	td_cmd |= I40E_TX_DESC_CMD_ICRC;
+
 	i40e_create_tx_ctx(tx_ring, cd_type_cmd_tso_mss,
 			   cd_tunneling, cd_l2tag2);
 

