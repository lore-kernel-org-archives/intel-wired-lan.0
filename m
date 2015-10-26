From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Mon, 26 Oct 2015 19:44:30 -0400
Subject: [Intel-wired-lan] [next PATCH S20 04/15] i40e/i40evf: prefetch skb
	data on transmit
In-Reply-To: <1445903081-155893-1-git-send-email-catherine.sullivan@intel.com>
References: <1445903081-155893-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1445903081-155893-5-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

Issue a prefetch for data early in the transmit path.
This should not be generally needed for tx traffic, but
it helps immensely for pktgen workloads and should help
for forwarding workloads as well.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Change-ID: Iefee870c20599e0c4240e1d8637e4f16b625f83a

---
Testing-hints: Run transmit traffic UDP and TCP to make sure there is
not a performance (CPU utilization) increase. Run pktgen (Jesse has
helper script available) to see the performance increases with the patch
when sending 64 byte packets. For bonus points could test forwarding
workload for performance improvement.
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 3 +++
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 7e7d224..494e6ef 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -2807,6 +2807,9 @@ static netdev_tx_t i40e_xmit_frame_ring(struct sk_buff *skb,
 	int tsyn;
 	int tso;
 
+	/* prefetch the data, we'll need it later */
+	prefetch(skb->data);
+
 	if (0 == i40e_xmit_descriptor_count(skb, tx_ring))
 		return NETDEV_TX_BUSY;
 
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
index a7f9840..35fc721 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
@@ -1994,6 +1994,9 @@ static netdev_tx_t i40e_xmit_frame_ring(struct sk_buff *skb,
 	u8 hdr_len = 0;
 	int tso;
 
+	/* prefetch the data, we'll need it later */
+	prefetch(skb->data);
+
 	if (0 == i40evf_xmit_descriptor_count(skb, tx_ring))
 		return NETDEV_TX_BUSY;
 
-- 
1.9.3

