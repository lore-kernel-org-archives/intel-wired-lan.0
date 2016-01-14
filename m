From: Joshua Hay <joshua.a.hay@intel.com>
Date: Wed, 13 Jan 2016 16:51:51 -0800
Subject: [Intel-wired-lan] [v2 next PATCH S27 14/15] i40e: properly show
	packet split status in debugfs
In-Reply-To: <1452732712-12248-1-git-send-email-joshua.a.hay@intel.com>
References: <1452732712-12248-1-git-send-email-joshua.a.hay@intel.com>
Message-ID: <1452732712-12248-15-git-send-email-joshua.a.hay@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

Get rid of the unused hsplit field in the ring struct and use the
existing macro to detect packet split enablement. This allows debugfs
dumps of the VSI to properly show which rx routine is in use.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Change-ID: Ic4e9589e6a788ab196ed0850703f704e30c03781
---
Testing Hints: Enable/disable  packet split and
dump the VSI through debugfs. Note the output.

 drivers/net/ethernet/intel/i40e/i40e_debugfs.c | 6 +++---
 drivers/net/ethernet/intel/i40e/i40e_txrx.h    | 1 -
 drivers/net/ethernet/intel/i40evf/i40e_txrx.h  | 1 -
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
index bdac691..34da53b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
@@ -521,7 +521,7 @@ static void i40e_dbg_dump_vsi_seid(struct i40e_pf *pf, int seid)
 			 rx_ring->dtype);
 		dev_info(&pf->pdev->dev,
 			 "    rx_rings[%i]: hsplit = %d, next_to_use = %d, next_to_clean = %d, ring_active = %i\n",
-			 i, rx_ring->hsplit,
+			 i, ring_is_ps_enabled(rx_ring),
 			 rx_ring->next_to_use,
 			 rx_ring->next_to_clean,
 			 rx_ring->ring_active);
@@ -572,8 +572,8 @@ static void i40e_dbg_dump_vsi_seid(struct i40e_pf *pf, int seid)
 			 "    tx_rings[%i]: dtype = %d\n",
 			 i, tx_ring->dtype);
 		dev_info(&pf->pdev->dev,
-			 "    tx_rings[%i]: hsplit = %d, next_to_use = %d, next_to_clean = %d, ring_active = %i\n",
-			 i, tx_ring->hsplit,
+			 "    tx_rings[%i]: next_to_use = %d, next_to_clean = %d, ring_active = %i\n",
+			 i,
 			 tx_ring->next_to_use,
 			 tx_ring->next_to_clean,
 			 tx_ring->ring_active);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.h b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
index e538b40..fd72182 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
@@ -256,7 +256,6 @@ struct i40e_ring {
 #define I40E_RX_DTYPE_NO_SPLIT      0
 #define I40E_RX_DTYPE_HEADER_SPLIT  1
 #define I40E_RX_DTYPE_SPLIT_ALWAYS  2
-	u8  hsplit;
 #define I40E_RX_SPLIT_L2      0x1
 #define I40E_RX_SPLIT_IP      0x2
 #define I40E_RX_SPLIT_TCP_UDP 0x4
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_txrx.h b/drivers/net/ethernet/intel/i40evf/i40e_txrx.h
index 595cd8b..062bd0c 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.h
+++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.h
@@ -255,7 +255,6 @@ struct i40e_ring {
 #define I40E_RX_DTYPE_NO_SPLIT      0
 #define I40E_RX_DTYPE_HEADER_SPLIT  1
 #define I40E_RX_DTYPE_SPLIT_ALWAYS  2
-	u8  hsplit;
 #define I40E_RX_SPLIT_L2      0x1
 #define I40E_RX_SPLIT_IP      0x2
 #define I40E_RX_SPLIT_TCP_UDP 0x4
-- 
2.1.0

