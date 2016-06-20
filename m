From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Mon, 20 Jun 2016 09:10:35 -0700
Subject: [Intel-wired-lan] [next PTACH S38-v2 3/7] i40e/i40evf: remove
	useless initializer
In-Reply-To: <1466439039-16378-1-git-send-email-bimmy.pujari@intel.com>
References: <1466439039-16378-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1466439039-16378-4-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

This initializer isn't needed because the variable is assigned right
away.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Change-ID: I6ce3edb3f4e0364db248a7a0bcc62ca95c01d941
---
Testing Hints : No functionality changes.

 drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 4 +---
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 3 +--
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 55f151f..2def562 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -740,14 +740,12 @@ static bool i40e_clean_tx_irq(struct i40e_vsi *vsi,
 	tx_ring->q_vector->tx.total_packets += total_packets;
 
 	if (tx_ring->flags & I40E_TXR_FLAGS_WB_ON_ITR) {
-		unsigned int j = 0;
-
 		/* check to see if there are < 4 descriptors
 		 * waiting to be written back, then kick the hardware to force
 		 * them to be written back in case we stay in NAPI.
 		 * In this mode on X722 we do not enable Interrupt.
 		 */
-		j = i40e_get_tx_pending(tx_ring, false);
+		unsigned int j = i40e_get_tx_pending(tx_ring, false);
 
 		if (budget &&
 		    ((j / (WB_STRIDE + 1)) == 0) && (j != 0) &&
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
index be99189..40f224f 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
@@ -259,13 +259,12 @@ static bool i40e_clean_tx_irq(struct i40e_vsi *vsi,
 	tx_ring->q_vector->tx.total_packets += total_packets;
 
 	if (tx_ring->flags & I40E_TXR_FLAGS_WB_ON_ITR) {
-		unsigned int j = 0;
 		/* check to see if there are < 4 descriptors
 		 * waiting to be written back, then kick the hardware to force
 		 * them to be written back in case we stay in NAPI.
 		 * In this mode on X722 we do not enable Interrupt.
 		 */
-		j = i40evf_get_tx_pending(tx_ring, false);
+		unsigned int j = i40evf_get_tx_pending(tx_ring, false);
 
 		if (budget &&
 		    ((j / (WB_STRIDE + 1)) == 0) && (j > 0) &&
-- 
2.4.11

