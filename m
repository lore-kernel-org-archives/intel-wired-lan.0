From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 07 Dec 2016 15:43:55 -0800
Subject: [Intel-wired-lan] [next-queue PATCH v2] i40e: Update driver to
 support napi_complete_done changes
Message-ID: <20161207234355.15561.26727.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alexander Duyck <alexander.h.duyck@intel.com>

Recently napi_complete_done was updated so that it will return zero if we
are using the queue vector for busy polling.  When this is the case we
don't need to re-enable interrupts as the busy polling will reschedule the
NAPI instance when it is finally done polling.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c |   32 ++++++++++++++-------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index e88e335c34ef..f9ef8c2676e2 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -2033,22 +2033,24 @@ int i40e_napi_poll(struct napi_struct *napi, int budget)
 		}
 	}
 
-	if (vsi->back->flags & I40E_TXR_FLAGS_WB_ON_ITR)
-		q_vector->arm_wb_state = false;
-
-	/* Work is done so exit the polling mode and re-enable the interrupt */
-	napi_complete_done(napi, work_done);
-
-	/* If we're prematurely stopping polling to fix the interrupt
-	 * affinity we want to make sure polling starts back up so we
-	 * issue a call to i40e_force_wb which triggers a SW interrupt.
+	/* Work is done so exit the polling mode,
+	 * if not busy polling re-enable interrupts.
 	 */
-	if (!clean_complete)
-		i40e_force_wb(vsi, q_vector);
-	else if (!(vsi->back->flags & I40E_FLAG_MSIX_ENABLED))
-		i40e_irq_dynamic_enable_icr0(vsi->back, false);
-	else
-		i40e_update_enable_itr(vsi, q_vector);
+	if (napi_complete_done(napi, work_done)) {
+		if (vsi->back->flags & I40E_TXR_FLAGS_WB_ON_ITR)
+			q_vector->arm_wb_state = false;
+
+		/* If we're prematurely stopping polling to fix the interrupt
+		 * affinity we want to make sure polling starts back up so we
+		 * issue a call to i40e_force_wb which triggers a SW interrupt.
+		 */
+		if (!clean_complete)
+			i40e_force_wb(vsi, q_vector);
+		else if (!(vsi->back->flags & I40E_FLAG_MSIX_ENABLED))
+			i40e_irq_dynamic_enable_icr0(vsi->back, false);
+		else
+			i40e_update_enable_itr(vsi, q_vector);
+	}
 
 	return min(work_done, budget - 1);
 }

