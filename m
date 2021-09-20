From: Mateusz Palczewski <mateusz.palczewski@intel.com>
Date: Mon, 20 Sep 2021 09:48:14 +0200
Subject: [Intel-wired-lan] [PATCH net v1] i40e: Fix freeing of unitialized
 misc IRQ vector
Message-ID: <20210920074814.11741-1-mateusz.palczewski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Sylwester Dziedziuch <sylwesterx.dziedziuch@intel.com>

When VSI set up failed in i40e_probe() as part of PF switch set up
driver was trying to free misc IRQ vectors in
i40e_clear_interrupt_scheme. The problem is that at that point
misc IRQ vectors were not allocated yet and we get a call trace
that driver is trying to free already free IRQ vectors.

Add a check in i40e_free_misc_vector for __I40E_MISC_IRQ_REQUESTED
PF state which is only set if misc IRQ vectors were properly
initialized.

Fixes: c17401a1dd21 ("i40e: use separate state bit for miscellaneous IRQ setup")
Signed-off-by: Sylwester Dziedziuch <sylwesterx.dziedziuch@intel.com>
Singed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 000991a..b16ae48 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -3987,7 +3987,8 @@ static void i40e_free_misc_vector(struct i40e_pf *pf)
 	wr32(&pf->hw, I40E_PFINT_ICR0_ENA, 0);
 	i40e_flush(&pf->hw);
 
-	if (pf->flags & I40E_FLAG_MSIX_ENABLED && pf->msix_entries) {
+	if (pf->flags & I40E_FLAG_MSIX_ENABLED && pf->msix_entries &&
+	    test_bit(__I40E_MISC_IRQ_REQUESTED, pf->state)) {
 		synchronize_irq(pf->msix_entries[0].vector);
 		free_irq(pf->msix_entries[0].vector, pf);
 		clear_bit(__I40E_MISC_IRQ_REQUESTED, pf->state);
-- 
2.27.0

