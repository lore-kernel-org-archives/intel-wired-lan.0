From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon,  8 Jul 2019 16:12:23 -0700
Subject: [Intel-wired-lan] [PATCH 06/19] fm10k: reduce the scope of the
 tx_buffer variable
In-Reply-To: <20190708231236.20516-1-jacob.e.keller@intel.com>
References: <20190708231236.20516-1-jacob.e.keller@intel.com>
Message-ID: <20190708231236.20516-7-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The tx_buffer local variable in the function fm10k_clean_tx_ring is not
used except inside a smaller block scope. Reduce the scope to its point
of use.

This was detected by cppcheck and resolves the following style warning
produced by that tool:

[fm10k_netdev.c:179]: (style) The scope of the variable 'tx_buffer' can
be reduced.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_netdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c b/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
index 538a8467f434..c73fb38be678 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
@@ -169,7 +169,6 @@ void fm10k_unmap_and_free_tx_resource(struct fm10k_ring *ring,
  **/
 static void fm10k_clean_tx_ring(struct fm10k_ring *tx_ring)
 {
-	struct fm10k_tx_buffer *tx_buffer;
 	unsigned long size;
 	u16 i;
 
@@ -179,7 +178,8 @@ static void fm10k_clean_tx_ring(struct fm10k_ring *tx_ring)
 
 	/* Free all the Tx ring sk_buffs */
 	for (i = 0; i < tx_ring->count; i++) {
-		tx_buffer = &tx_ring->tx_buffer[i];
+		struct fm10k_tx_buffer *tx_buffer = &tx_ring->tx_buffer[i];
+
 		fm10k_unmap_and_free_tx_resource(tx_ring, tx_buffer);
 	}
 
-- 
2.22.0.214.g8dca754b1e87

