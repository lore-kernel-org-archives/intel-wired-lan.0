From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Wed, 18 May 2022 14:31:11 -0700
Subject: [Intel-wired-lan] [PATCH RESEND] i40e: Remove unnecessary
 synchronize_irq() before free_irq()
Message-ID: <20220518213111.2444630-1-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Minghao Chi <chi.minghao@zte.com.cn>

Calling synchronize_irq() right before free_irq() is quite useless. On one
hand the IRQ can easily fire again before free_irq() is entered, on the
other hand free_irq() itself calls synchronize_irq() internally (in a race
condition free way), before any state associated with the IRQ is freed.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
Resending due to mail issues with Intel Wired LAN

 drivers/net/ethernet/intel/i40e/i40e_main.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 83e0cf475ebd..797f61b2cd96 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -4162,7 +4162,6 @@ static void i40e_free_misc_vector(struct i40e_pf *pf)
 	i40e_flush(&pf->hw);
 
 	if (pf->flags & I40E_FLAG_MSIX_ENABLED && pf->msix_entries) {
-		synchronize_irq(pf->msix_entries[0].vector);
 		free_irq(pf->msix_entries[0].vector, pf);
 		clear_bit(__I40E_MISC_IRQ_REQUESTED, pf->state);
 	}
@@ -4901,7 +4900,6 @@ static void i40e_vsi_free_irq(struct i40e_vsi *vsi)
 			irq_set_affinity_notifier(irq_num, NULL);
 			/* remove our suggested affinity mask for this IRQ */
 			irq_update_affinity_hint(irq_num, NULL);
-			synchronize_irq(irq_num);
 			free_irq(irq_num, vsi->q_vectors[i]);
 
 			/* Tear down the interrupt queue link list
-- 
2.35.1

