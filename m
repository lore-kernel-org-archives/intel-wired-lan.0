From: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
Date: Wed, 30 Mar 2016 03:49:40 -0700
Subject: [Intel-wired-lan] [v2 next PATCH S32 05/13] i40e/i40evf: Drop
	unused tx_ring argument
In-Reply-To: <1459334988-19951-1-git-send-email-harshitha.ramamurthy@intel.com>
References: <1459334988-19951-1-git-send-email-harshitha.ramamurthy@intel.com>
Message-ID: <1459334988-19951-6-git-send-email-harshitha.ramamurthy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

Some of the tx_ring arguments can be deleted since they are not used.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Change-ID: I99275b0f191d7f63ec2f05061919904940c36f31
---
Testing Hints: Compile test, no functional change.

 drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 6 ++----
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 6 ++----
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 76a48e9..f4e4d3d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -2252,15 +2252,13 @@ out:
 
 /**
  * i40e_tso - set up the tso context descriptor
- * @tx_ring:  ptr to the ring to send
  * @skb:      ptr to the skb we're sending
  * @hdr_len:  ptr to the size of the packet header
  * @cd_type_cmd_tso_mss: Quad Word 1
  *
  * Returns 0 if no TSO can happen, 1 if tso is going, or error
  **/
-static int i40e_tso(struct i40e_ring *tx_ring, struct sk_buff *skb,
-		    u8 *hdr_len, u64 *cd_type_cmd_tso_mss)
+static int i40e_tso(struct sk_buff *skb, u8 *hdr_len, u64 *cd_type_cmd_tso_mss)
 {
 	u64 cd_cmd, cd_tso_len, cd_mss;
 	union {
@@ -2932,7 +2930,7 @@ static netdev_tx_t i40e_xmit_frame_ring(struct sk_buff *skb,
 	else if (protocol == htons(ETH_P_IPV6))
 		tx_flags |= I40E_TX_FLAGS_IPV6;
 
-	tso = i40e_tso(tx_ring, skb, &hdr_len, &cd_type_cmd_tso_mss);
+	tso = i40e_tso(skb, &hdr_len, &cd_type_cmd_tso_mss);
 
 	if (tso < 0)
 		goto out_drop;
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
index d633dcf..ec1f447 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
@@ -1519,15 +1519,13 @@ out:
 
 /**
  * i40e_tso - set up the tso context descriptor
- * @tx_ring:  ptr to the ring to send
  * @skb:      ptr to the skb we're sending
  * @hdr_len:  ptr to the size of the packet header
  * @cd_type_cmd_tso_mss: Quad Word 1
  *
  * Returns 0 if no TSO can happen, 1 if tso is going, or error
  **/
-static int i40e_tso(struct i40e_ring *tx_ring, struct sk_buff *skb,
-		    u8 *hdr_len, u64 *cd_type_cmd_tso_mss)
+static int i40e_tso(struct sk_buff *skb, u8 *hdr_len, u64 *cd_type_cmd_tso_mss)
 {
 	u64 cd_cmd, cd_tso_len, cd_mss;
 	union {
@@ -2150,7 +2148,7 @@ static netdev_tx_t i40e_xmit_frame_ring(struct sk_buff *skb,
 	else if (protocol == htons(ETH_P_IPV6))
 		tx_flags |= I40E_TX_FLAGS_IPV6;
 
-	tso = i40e_tso(tx_ring, skb, &hdr_len, &cd_type_cmd_tso_mss);
+	tso = i40e_tso(skb, &hdr_len, &cd_type_cmd_tso_mss);
 
 	if (tso < 0)
 		goto out_drop;
-- 
2.4.3

