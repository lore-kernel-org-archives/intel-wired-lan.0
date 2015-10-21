From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Wed, 21 Oct 2015 19:47:02 -0400
Subject: [Intel-wired-lan] [next PATCH S19 01/15] i40e/i40evf: remove unused
	tunnel parameter
In-Reply-To: <1445471236-35918-1-git-send-email-catherine.sullivan@intel.com>
References: <1445471236-35918-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1445471236-35918-2-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Shannon Nelson <shannon.nelson@intel.com>

Code was moved into a separate function some time ago.

Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
Change-ID: Icabbe71ce05cf5d716d3e1152cdd9cd41d11bcb5

---
Testing-hints: Internal code change, check that the patch was applied
and compiled correctly.
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 11 ++++-------
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c |  8 +++-----
 2 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 6cd0918..626c567 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -2187,14 +2187,12 @@ out:
  * @tx_ring:  ptr to the ring to send
  * @skb:      ptr to the skb we're sending
  * @hdr_len:  ptr to the size of the packet header
- * @cd_type_cmd_tso_mss: ptr to u64 object
- * @cd_tunneling: ptr to context descriptor bits
+ * @cd_type_cmd_tso_mss: Quad Word 1
  *
  * Returns 0 if no TSO can happen, 1 if tso is going, or error
  **/
 static int i40e_tso(struct i40e_ring *tx_ring, struct sk_buff *skb,
-		    u8 *hdr_len, u64 *cd_type_cmd_tso_mss,
-		    u32 *cd_tunneling)
+		    u8 *hdr_len, u64 *cd_type_cmd_tso_mss)
 {
 	u32 cd_cmd, cd_tso_len, cd_mss;
 	struct ipv6hdr *ipv6h;
@@ -2247,7 +2245,7 @@ static int i40e_tso(struct i40e_ring *tx_ring, struct sk_buff *skb,
  * @tx_ring:  ptr to the ring to send
  * @skb:      ptr to the skb we're sending
  * @tx_flags: the collected send information
- * @cd_type_cmd_tso_mss: ptr to u64 object
+ * @cd_type_cmd_tso_mss: Quad Word 1
  *
  * Returns 0 if no Tx timestamp can happen and 1 if the timestamp will happen
  **/
@@ -2826,8 +2824,7 @@ static netdev_tx_t i40e_xmit_frame_ring(struct sk_buff *skb,
 	else if (protocol == htons(ETH_P_IPV6))
 		tx_flags |= I40E_TX_FLAGS_IPV6;
 
-	tso = i40e_tso(tx_ring, skb, &hdr_len,
-		       &cd_type_cmd_tso_mss, &cd_tunneling);
+	tso = i40e_tso(tx_ring, skb, &hdr_len, &cd_type_cmd_tso_mss);
 
 	if (tso < 0)
 		goto out_drop;
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
index 0fe2625..521803e 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
@@ -1437,13 +1437,12 @@ out:
  * @tx_ring:  ptr to the ring to send
  * @skb:      ptr to the skb we're sending
  * @hdr_len:  ptr to the size of the packet header
- * @cd_tunneling: ptr to context descriptor bits
+ * @cd_type_cmd_tso_mss: Quad Word 1
  *
  * Returns 0 if no TSO can happen, 1 if tso is going, or error
  **/
 static int i40e_tso(struct i40e_ring *tx_ring, struct sk_buff *skb,
-		    u8 *hdr_len, u64 *cd_type_cmd_tso_mss,
-		    u32 *cd_tunneling)
+		    u8 *hdr_len, u64 *cd_type_cmd_tso_mss)
 {
 	u32 cd_cmd, cd_tso_len, cd_mss;
 	struct ipv6hdr *ipv6h;
@@ -1980,8 +1979,7 @@ static netdev_tx_t i40e_xmit_frame_ring(struct sk_buff *skb,
 	else if (protocol == htons(ETH_P_IPV6))
 		tx_flags |= I40E_TX_FLAGS_IPV6;
 
-	tso = i40e_tso(tx_ring, skb, &hdr_len,
-		       &cd_type_cmd_tso_mss, &cd_tunneling);
+	tso = i40e_tso(tx_ring, skb, &hdr_len, &cd_type_cmd_tso_mss);
 
 	if (tso < 0)
 		goto out_drop;
-- 
1.9.3

