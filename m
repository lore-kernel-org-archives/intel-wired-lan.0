From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Date: Sun, 26 Dec 2021 15:38:57 +0100
Subject: [Intel-wired-lan] [PATCH] ice: Use bitmap_free() to free bitmap
Message-ID: <d139eb69eb12c9793a2a3b65e94f74d4cee2a39c.1640529439.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

kfree() and bitmap_free() are the same. But using the latter is more
consistent when freeing memory allocated with bitmap_zalloc().

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index d3f65e061a62..ae291d442539 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -2229,7 +2229,7 @@ ice_ptp_release_tx_tracker(struct ice_pf *pf, struct ice_ptp_tx *tx)
 	kfree(tx->tstamps);
 	tx->tstamps = NULL;
 
-	kfree(tx->in_use);
+	bitmap_free(tx->in_use);
 	tx->in_use = NULL;
 
 	tx->len = 0;
-- 
2.32.0

