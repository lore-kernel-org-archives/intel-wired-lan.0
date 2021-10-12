From: Michal Maloszewski <michal.maloszewski@intel.com>
Date: Tue, 12 Oct 2021 13:52:45 +0000
Subject: [Intel-wired-lan] [PATCH net v1] iavf: Fix reporting when setting
 descriptor count
Message-ID: <20211012135245.6979-1-michal.maloszewski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

iavf_set_ringparams doesn't communicate to the user that

1. The user requested descriptor count is out of range. Instead it
   just quietly sets descriptors to the "clamped" value and calls it
   done. This makes it look an invalid value was successfully set as
   the descriptor count when this isn't actually true.

2. The user provided descriptor count needs to be inflated for alignment
   reasons.

This behavior is confusing. The ice driver has already addressed this
by rejecting invalid values for descriptor count and messaging for alignment adjustments.
Do the same thing here by adding the error and info messages.

Fixes: fcea6f3da546 ("ice: Add stats and ethtool support")
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Signed-off-by: Michal Maloszewski <michal.maloszewski@intel.com>
---
v3: Commit with fixes tag changed.
---
 .../net/ethernet/intel/iavf/iavf_ethtool.c    | 43 ++++++++++++++-----
 1 file changed, 32 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
index 7cbe59beee..cbfc8d07a0 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
@@ -612,23 +612,44 @@ static int iavf_set_ringparam(struct net_device *netdev,
 	if ((ring->rx_mini_pending) || (ring->rx_jumbo_pending))
 		return -EINVAL;
 
-	new_tx_count = clamp_t(u32, ring->tx_pending,
-			       IAVF_MIN_TXD,
-			       IAVF_MAX_TXD);
-	new_tx_count = ALIGN(new_tx_count, IAVF_REQ_DESCRIPTOR_MULTIPLE);
+	if (ring->tx_pending > IAVF_MAX_TXD ||
+	    ring->tx_pending < IAVF_MIN_TXD ||
+	    ring->rx_pending > IAVF_MAX_RXD ||
+	    ring->rx_pending < IAVF_MIN_RXD) {
+		  netdev_err(netdev, "Descriptors requested (Tx: %d / Rx: %d) out of range [%d-%d] (increment %d)\n",
+			     ring->tx_pending, ring->rx_pending, IAVF_MIN_TXD,
+			     IAVF_MAX_RXD, IAVF_REQ_DESCRIPTOR_MULTIPLE);
+		  return -EINVAL;
+	}
+
+	new_tx_count = ALIGN(ring->tx_pending, IAVF_REQ_DESCRIPTOR_MULTIPLE);
+	if (new_tx_count != ring->tx_pending)
+		netdev_info(netdev, "Requested Tx descriptor count rounded up to %d\n",
+			    new_tx_count);
 
-	new_rx_count = clamp_t(u32, ring->rx_pending,
-			       IAVF_MIN_RXD,
-			       IAVF_MAX_RXD);
-	new_rx_count = ALIGN(new_rx_count, IAVF_REQ_DESCRIPTOR_MULTIPLE);
+	new_rx_count = ALIGN(ring->rx_pending, IAVF_REQ_DESCRIPTOR_MULTIPLE);
+	if (new_rx_count != ring->rx_pending)
+		netdev_info(netdev, "Requested Rx descriptor count rounded up to %d\n",
+			    new_rx_count);
 
 	/* if nothing to do return success */
 	if ((new_tx_count == adapter->tx_desc_count) &&
-	    (new_rx_count == adapter->rx_desc_count))
+	    (new_rx_count == adapter->rx_desc_count)) {
+		netdev_dbg(netdev, "Nothing to change, descriptor count is same as requested\n");
 		return 0;
+	}
 
-	adapter->tx_desc_count = new_tx_count;
-	adapter->rx_desc_count = new_rx_count;
+	if (new_tx_count != adapter->tx_desc_count) {
+		netdev_info(netdev, "Changing Tx descriptor count from %d to %d\n",
+			    adapter->tx_desc_count, new_tx_count);
+		adapter->tx_desc_count = new_tx_count;
+	}
+
+	if (new_rx_count != adapter->rx_desc_count) {
+		netdev_info(netdev, "Changing Rx descriptor count from %d to %d\n",
+			    adapter->rx_desc_count, new_rx_count);
+		adapter->rx_desc_count = new_rx_count;
+	}
 
 	if (netif_running(netdev)) {
 		adapter->flags |= IAVF_FLAG_RESET_NEEDED;
-- 
2.27.0

