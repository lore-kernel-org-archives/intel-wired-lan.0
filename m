From: Alice Michael <alice.michael@intel.com>
Date: Tue, 29 Aug 2017 05:32:42 -0400
Subject: [Intel-wired-lan] [next PATCH S79-V2 13/13] i40e: ignore
	skb->xmit_more when deciding to set RS bit
In-Reply-To: <20170829093242.41026-1-alice.michael@intel.com>
References: <20170829093242.41026-1-alice.michael@intel.com>
Message-ID: <20170829093242.41026-13-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

Since commit 6a7fded776a7 ("i40e: Fix RS bit update in Tx path and
disable force WB workaround") we've tried to "optimize" setting the
RS bit based around skb->xmit_more. This same logic was refactored
in commit 1dc8b538795f ("i40e: Reorder logic for coalescing RS bits"),
but ultimately was not functionally changed.

Using skb->xmit_more in this way is incorrect, because in certain
circumstances we may see a large number of skbs in sequence with
xmit_more set. This leads to a performance loss as the hardware does not
writeback anything for those packets, which delays the time it takes for
us to respond to the stack transmit requests. This significantly impacts
UDP performance, especially when layered with multiple devices, such as
bonding, vlans, and vnet setups.

This was not noticed until now because it is difficult to create a setup
which reproduces the issue. It was discovered in a UDP_STREAM test in
a VM, connected using a vnet device to a bridge, which is connected to
a bonded pair of X710 ports in active-backup mode with a VLAN. These
layered devices seem to compound the number of skbs transmitted at once
by the qdisc. Additionally, the problem can be masked by reducing the
ITR value.

Since the original commit does not provide strong justification for this
RS bit "optimization", revert to the previous behavior of setting the RS
bit every 4th packet.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
Testing-hints:
  This may not be noticeable in many test setups. This was discovered by
  attaching 2 X710 ports to a bond, adding a vlan device on top of the
  bond, connecting this to a bridge, and using a vnet device in a VM
  running netperf UDP_STREAM test.

  See also RedHat BZ #1384558

 drivers/net/ethernet/intel/i40e/i40e_txrx.c | 34 ++++-------------------------
 1 file changed, 4 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 1b99167..53e1998 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -3166,38 +3166,12 @@ static inline int i40e_tx_map(struct i40e_ring *tx_ring, struct sk_buff *skb,
 	/* write last descriptor with EOP bit */
 	td_cmd |= I40E_TX_DESC_CMD_EOP;
 
-	/* We can OR these values together as they both are checked against
-	 * 4 below and at this point desc_count will be used as a boolean value
-	 * after this if/else block.
+	/* We OR these values together to check both against 4 (WB_STRIDE)
+	 * below. This is safe since we don't re-use desc_count afterwards.
 	 */
 	desc_count |= ++tx_ring->packet_stride;
 
-	/* Algorithm to optimize tail and RS bit setting:
-	 * if queue is stopped
-	 *	mark RS bit
-	 *	reset packet counter
-	 * else if xmit_more is supported and is true
-	 *	advance packet counter to 4
-	 *	reset desc_count to 0
-	 *
-	 * if desc_count >= 4
-	 *	mark RS bit
-	 *	reset packet counter
-	 * if desc_count > 0
-	 *	update tail
-	 *
-	 * Note: If there are less than 4 descriptors
-	 * pending and interrupts were disabled the service task will
-	 * trigger a force WB.
-	 */
-	if (netif_xmit_stopped(txring_txq(tx_ring))) {
-		goto do_rs;
-	} else if (skb->xmit_more) {
-		/* set stride to arm on next packet and reset desc_count */
-		tx_ring->packet_stride = WB_STRIDE;
-		desc_count = 0;
-	} else if (desc_count >= WB_STRIDE) {
-do_rs:
+	if (desc_count >= WB_STRIDE) {
 		/* write last descriptor with RS bit set */
 		td_cmd |= I40E_TX_DESC_CMD_RS;
 		tx_ring->packet_stride = 0;
@@ -3218,7 +3192,7 @@ static inline int i40e_tx_map(struct i40e_ring *tx_ring, struct sk_buff *skb,
 	first->next_to_watch = tx_desc;
 
 	/* notify HW of packet */
-	if (desc_count) {
+	if (netif_xmit_stopped(txring_txq(tx_ring)) || !skb->xmit_more) {
 		writel(i, tx_ring->tail);
 
 		/* we need this if more than one processor can write to our tail
-- 
2.9.4

