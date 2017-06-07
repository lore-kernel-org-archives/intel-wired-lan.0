From: Alice Michael <alice.michael@intel.com>
Date: Wed,  7 Jun 2017 05:43:11 -0400
Subject: [Intel-wired-lan] [next PATCH S72-V3 11/13] i40e: clear only
	cause_ena bit
In-Reply-To: <20170607094313.32060-1-alice.michael@intel.com>
References: <20170607094313.32060-1-alice.michael@intel.com>
Message-ID: <20170607094313.32060-11-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Shannon Nelson <shannon.nelson@intel.com>

When disabling interrupts, we should only be clearing the CAUSE_ENA bit,
not clearing the whole register.  Clearing the whole register sets the
NEXTQ_IDX field to 0 instead of 0x7ff which can confuse the Firmware in
some reset sequences.

Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index b7b1f18..581a8ff 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -3588,14 +3588,24 @@ static void i40e_vsi_disable_irq(struct i40e_vsi *vsi)
 	int base = vsi->base_vector;
 	int i;
 
+	/* disable interrupt causation from each queue */
 	for (i = 0; i < vsi->num_queue_pairs; i++) {
-		wr32(hw, I40E_QINT_TQCTL(vsi->tx_rings[i]->reg_idx), 0);
-		wr32(hw, I40E_QINT_RQCTL(vsi->rx_rings[i]->reg_idx), 0);
+		u32 val;
+
+		val = rd32(hw, I40E_QINT_TQCTL(vsi->tx_rings[i]->reg_idx));
+		val &= ~I40E_QINT_TQCTL_CAUSE_ENA_MASK;
+		wr32(hw, I40E_QINT_TQCTL(vsi->tx_rings[i]->reg_idx), val);
+
+		val = rd32(hw, I40E_QINT_RQCTL(vsi->rx_rings[i]->reg_idx));
+		val &= ~I40E_QINT_RQCTL_CAUSE_ENA_MASK;
+		wr32(hw, I40E_QINT_RQCTL(vsi->rx_rings[i]->reg_idx), val);
+
 		if (!i40e_enabled_xdp_vsi(vsi))
 			continue;
 		wr32(hw, I40E_QINT_TQCTL(vsi->xdp_rings[i]->reg_idx), 0);
 	}
 
+	/* disable each interrupt */
 	if (pf->flags & I40E_FLAG_MSIX_ENABLED) {
 		for (i = vsi->base_vector;
 		     i < (vsi->num_q_vectors + vsi->base_vector); i++)
-- 
2.9.3

