From: Sasha Neftin <sasha.neftin@intel.com>
Date: Sun, 29 Dec 2019 16:09:09 +0200
Subject: [Intel-wired-lan] [PATCH v1] igc: Fix typo in a comment
Message-ID: <20191229140909.31851-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Fix typo in a context descriptor comment

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 7761f30f0152..c76aaf49ff4c 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -880,7 +880,7 @@ static void igc_tx_ctxtdesc(struct igc_ring *tx_ring,
 	/* set bits to identify this as an advanced context descriptor */
 	type_tucmd |= IGC_TXD_CMD_DEXT | IGC_ADVTXD_DTYP_CTXT;
 
-	/* For 82575, context index must be unique per ring. */
+	/* For i225, context index must be unique per ring. */
 	if (test_bit(IGC_RING_FLAG_TX_CTX_IDX, &tx_ring->flags))
 		mss_l4len_idx |= tx_ring->reg_idx << 4;
 
-- 
2.11.0

