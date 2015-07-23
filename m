From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Thu, 23 Jul 2015 16:54:42 -0400
Subject: [Intel-wired-lan] [next PATCH S9 13/15] i40e: warn on double free
In-Reply-To: <1437684884-222825-1-git-send-email-catherine.sullivan@intel.com>
References: <1437684884-222825-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1437684884-222825-14-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

Down was requesting queue disables, but then exited immediately without
waiting for the queues to actually disable. This could allow any
function called after i40evf_down to run immediately, including
i40evf_up, and causes a memory leak.

This issue has been fixed in a recent refactor of the reset code, but
add a couple WARN_ONs in the slow path to help us recognize if we
reintroduce this issue or if we missed any cases.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Change-ID: I27b6b5c9a79c1892f0ba453129f116bc32647dd0
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index ce3f7cc..ca4d72b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -1000,6 +1000,8 @@ int i40e_setup_tx_descriptors(struct i40e_ring *tx_ring)
 	if (!dev)
 		return -ENOMEM;
 
+	/* warn if we are about to overwrite the pointer */
+	WARN_ON(tx_ring->tx_bi);
 	bi_size = sizeof(struct i40e_tx_buffer) * tx_ring->count;
 	tx_ring->tx_bi = kzalloc(bi_size, GFP_KERNEL);
 	if (!tx_ring->tx_bi)
@@ -1160,6 +1162,8 @@ int i40e_setup_rx_descriptors(struct i40e_ring *rx_ring)
 	struct device *dev = rx_ring->dev;
 	int bi_size;
 
+	/* warn if we are about to overwrite the pointer */
+	WARN_ON(rx_ring->rx_bi);
 	bi_size = sizeof(struct i40e_rx_buffer) * rx_ring->count;
 	rx_ring->rx_bi = kzalloc(bi_size, GFP_KERNEL);
 	if (!rx_ring->rx_bi)
-- 
1.9.3

