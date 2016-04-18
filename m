From: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
Date: Mon, 18 Apr 2016 01:31:53 -0700
Subject: [Intel-wired-lan] [v2 next PATCH S35 3/9] i40e/i40evf: Remove
	reference to ring->dtype
In-Reply-To: <1460968319-18950-1-git-send-email-harshitha.ramamurthy@intel.com>
References: <1460968319-18950-1-git-send-email-harshitha.ramamurthy@intel.com>
Message-ID: <1460968319-18950-4-git-send-email-harshitha.ramamurthy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

As part of the rx-refactor, the dtype variable in the i40e_ring
struct is no longer used, so remove it.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_debugfs.c | 8 ++------
 drivers/net/ethernet/intel/i40e/i40e_txrx.h    | 1 -
 drivers/net/ethernet/intel/i40evf/i40e_txrx.h  | 1 -
 3 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
index f119a74..c0a01e0 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
@@ -268,10 +268,9 @@ static void i40e_dbg_dump_vsi_seid(struct i40e_pf *pf, int seid)
 			 rx_ring->queue_index,
 			 rx_ring->reg_idx);
 		dev_info(&pf->pdev->dev,
-			 "    rx_rings[%i]: rx_hdr_len = %d, rx_buf_len = %d, dtype = %d\n",
+			 "    rx_rings[%i]: rx_hdr_len = %d, rx_buf_len = %d\n",
 			 i, rx_ring->rx_hdr_len,
-			 rx_ring->rx_buf_len,
-			 rx_ring->dtype);
+			 rx_ring->rx_buf_len);
 		dev_info(&pf->pdev->dev,
 			 "    rx_rings[%i]: next_to_use = %d, next_to_clean = %d, ring_active = %i\n",
 			 i,
@@ -326,9 +325,6 @@ static void i40e_dbg_dump_vsi_seid(struct i40e_pf *pf, int seid)
 			 tx_ring->queue_index,
 			 tx_ring->reg_idx);
 		dev_info(&pf->pdev->dev,
-			 "    tx_rings[%i]: dtype = %d\n",
-			 i, tx_ring->dtype);
-		dev_info(&pf->pdev->dev,
 			 "    tx_rings[%i]: next_to_use = %d, next_to_clean = %d, ring_active = %i\n",
 			 i,
 			 tx_ring->next_to_use,
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.h b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
index 5a2d0fe..03e21d9 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
@@ -282,7 +282,6 @@ struct i40e_ring {
 	u16 reg_idx;			/* HW register index of the ring */
 	u16 rx_hdr_len;
 	u16 rx_buf_len;
-	u8  dtype;
 #define I40E_RX_DTYPE_NO_SPLIT      0
 #define I40E_RX_DTYPE_HEADER_SPLIT  1
 #define I40E_RX_DTYPE_SPLIT_ALWAYS  2
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_txrx.h b/drivers/net/ethernet/intel/i40evf/i40e_txrx.h
index 54b52e8..3b3f976 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.h
+++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.h
@@ -280,7 +280,6 @@ struct i40e_ring {
 	u16 reg_idx;			/* HW register index of the ring */
 	u16 rx_hdr_len;
 	u16 rx_buf_len;
-	u8  dtype;
 #define I40E_RX_DTYPE_NO_SPLIT      0
 #define I40E_RX_DTYPE_HEADER_SPLIT  1
 #define I40E_RX_DTYPE_SPLIT_ALWAYS  2
-- 
2.4.3

