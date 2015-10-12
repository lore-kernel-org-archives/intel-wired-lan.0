From: =?unknown-8bit?q?J=CE=B5an?= Sacren <sakiwit@gmail.com>
Date: Sun, 11 Oct 2015 23:59:44 -0600
Subject: [Intel-wired-lan] [next-queue 4/8] i40e: add missing kernel-doc
	argument
In-Reply-To: <1444629588-29933-1-git-send-email-sakiwit@gmail.com>
References: <1444629588-29933-1-git-send-email-sakiwit@gmail.com>
Message-ID: <1444629588-29933-4-git-send-email-sakiwit@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jean Sacren <sakiwit@gmail.com>

The following kernell-doc arguments for their respective functions are
missing:

1) @cd_type_cmd_tso_mss for i40e_tso();
2) @cd_type_cmd_tso_mss for i40e_tsyn();
3) @tx_ring for i40e_tx_enable_csum().

Add them all for the kernel-doc requirement.

Signed-off-by: Jean Sacren <sakiwit@gmail.com>
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index c9f7caf1d920..8db8b9b6cdcd 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -2187,6 +2187,7 @@ out:
  * @tx_ring:  ptr to the ring to send
  * @skb:      ptr to the skb we're sending
  * @hdr_len:  ptr to the size of the packet header
+ * @cd_type_cmd_tso_mss: ptr to u64 object
  * @cd_tunneling: ptr to context descriptor bits
  *
  * Returns 0 if no TSO can happen, 1 if tso is going, or error
@@ -2246,6 +2247,7 @@ static int i40e_tso(struct i40e_ring *tx_ring, struct sk_buff *skb,
  * @tx_ring:  ptr to the ring to send
  * @skb:      ptr to the skb we're sending
  * @tx_flags: the collected send information
+ * @cd_type_cmd_tso_mss: ptr to u64 object
  *
  * Returns 0 if no Tx timestamp can happen and 1 if the timestamp will happen
  **/
@@ -2288,6 +2290,7 @@ static int i40e_tsyn(struct i40e_ring *tx_ring, struct sk_buff *skb,
  * @tx_flags: pointer to Tx flags currently set
  * @td_cmd: Tx descriptor command bits to set
  * @td_offset: Tx descriptor header offsets to set
+ * @tx_ring: Tx descriptor ring
  * @cd_tunneling: ptr to context desc bits
  **/
 static void i40e_tx_enable_csum(struct sk_buff *skb, u32 *tx_flags,
