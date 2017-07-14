From: Alice Michael <alice.michael@intel.com>
Date: Fri, 14 Jul 2017 09:10:09 -0400
Subject: [Intel-wired-lan] [next PATCH S76-V2 03/13] i40e: move enabling
	icr0 into i40e_update_enable_itr
In-Reply-To: <20170714131019.52530-1-alice.michael@intel.com>
References: <20170714131019.52530-1-alice.michael@intel.com>
Message-ID: <20170714131019.52530-3-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

If we don't have MSI-X enabled, we handle interrupts on all icr0. This
is a special case, so let's move the conditional into
i40e_update_enable_itr() in order to make i40e_napi_poll easier to
read about.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index eda8da1..d96970f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -2241,6 +2241,12 @@ static inline void i40e_update_enable_itr(struct i40e_vsi *vsi,
 	int idx = q_vector->v_idx;
 	int rx_itr_setting, tx_itr_setting;
 
+	/* If we don't have MSIX, then we only need to re-enable icr0 */
+	if (!(vsi->back->flags & I40E_FLAG_MSIX_ENABLED)) {
+		i40e_irq_dynamic_enable_icr0(vsi->back, false);
+		return;
+	}
+
 	vector = (q_vector->v_idx + vsi->base_vector);
 
 	/* avoid dynamic calculation if in countdown mode OR if
@@ -2394,8 +2400,6 @@ int i40e_napi_poll(struct napi_struct *napi, int budget)
 	 */
 	if (!clean_complete)
 		i40e_force_wb(vsi, q_vector);
-	else if (!(vsi->back->flags & I40E_FLAG_MSIX_ENABLED))
-		i40e_irq_dynamic_enable_icr0(vsi->back, false);
 	else
 		i40e_update_enable_itr(vsi, q_vector);
 
-- 
2.9.3

