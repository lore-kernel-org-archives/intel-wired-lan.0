From: =?unknown-8bit?q?J=CE=B5an?= Sacren <sakiwit@gmail.com>
Date: Tue, 13 Oct 2015 01:06:29 -0600
Subject: [Intel-wired-lan] [next-queue v2 3/6] i40e: clean up the entire
	function exit path
In-Reply-To: <1444719992-301-1-git-send-email-sakiwit@gmail.com>
References: <1444719992-301-1-git-send-email-sakiwit@gmail.com>
Message-ID: <1444719992-301-3-git-send-email-sakiwit@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jean Sacren <sakiwit@gmail.com>

In i40e_tsyn(), by using a label of 'no_timestamp', we will be able to
clearly denote a slew of circumstances that return with 0, which is much
better as a default exit than the one that returns with 1.

With the above change, in the last check, we will be able to spare the
'else' branch. Further, the whole branch for returning 1 shall be put
together for clarity.

Add a comment next to returning 1 in comparison to no_timestamp label.

Signed-off-by: Jean Sacren <sakiwit@gmail.com>
---
v2: No changes except for the serial number.

 drivers/net/ethernet/intel/i40e/i40e_txrx.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 8db8b9b6cdcd..6cd091877731 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -2257,31 +2257,31 @@ static int i40e_tsyn(struct i40e_ring *tx_ring, struct sk_buff *skb,
 	struct i40e_pf *pf;
 
 	if (likely(!(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP)))
-		return 0;
+		goto no_timestamp;
 
 	/* Tx timestamps cannot be sampled when doing TSO */
 	if (tx_flags & I40E_TX_FLAGS_TSO)
-		return 0;
+		goto no_timestamp;
 
 	/* only timestamp the outbound packet if the user has requested it and
 	 * we are not already transmitting a packet to be timestamped
 	 */
 	pf = i40e_netdev_to_pf(tx_ring->netdev);
 	if (!(pf->flags & I40E_FLAG_PTP))
-		return 0;
+		goto no_timestamp;
 
 	if (pf->ptp_tx &&
 	    !test_and_set_bit_lock(__I40E_PTP_TX_IN_PROGRESS, &pf->state)) {
 		skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
 		pf->ptp_tx_skb = skb_get(skb);
-	} else {
-		return 0;
-	}
+		*cd_type_cmd_tso_mss |= (u64)I40E_TX_CTX_DESC_TSYN <<
+					I40E_TXD_CTX_QW1_CMD_SHIFT;
 
-	*cd_type_cmd_tso_mss |= (u64)I40E_TX_CTX_DESC_TSYN <<
-				I40E_TXD_CTX_QW1_CMD_SHIFT;
+		return 1; /* Tx timestamp will happen */
+	}
 
-	return 1;
+no_timestamp:
+	return 0;
 }
 
 /**
