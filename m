From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 20 Oct 2017 13:59:20 -0700
Subject: [Intel-wired-lan] [jkirsher/net-queue PATCH] i40e: Fix incorrect
 use of tx_itr_setting when checking for Rx ITR setup
Message-ID: <20171020205906.24055.27032.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alexander Duyck <alexander.h.duyck@intel.com>

It looks like there was either a copy/paste error or just a typo that
resulted in the Tx ITR setting being used to determine if we were using
adaptive Rx interrupt moderation or not.

This patch fixes the typo.

Fixes: 65e87c0398f5 ("i40evf: support queue-specific settings for interrupt moderation")
Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index edbc94c4353d..778633569663 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -2277,7 +2277,7 @@ static inline void i40e_update_enable_itr(struct i40e_vsi *vsi,
 		goto enable_int;
 	}
 
-	if (ITR_IS_DYNAMIC(tx_itr_setting)) {
+	if (ITR_IS_DYNAMIC(rx_itr_setting)) {
 		rx = i40e_set_new_dynamic_itr(&q_vector->rx);
 		rxval = i40e_buildreg_itr(I40E_RX_ITR, q_vector->rx.itr);
 	}

