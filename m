From: ajdayana <avinash.dayanand@intel.com>
Date: Thu, 10 Mar 2016 14:59:43 -0800
Subject: [Intel-wired-lan] [next PATCH S30 v3 05/13] i40e: Remove msix only
	if created
In-Reply-To: <1457650791-100229-1-git-send-email-avinash.dayanand@intel.com>
References: <1457650791-100229-1-git-send-email-avinash.dayanand@intel.com>
Message-ID: <1457650791-100229-6-git-send-email-avinash.dayanand@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Shannon Nelson <shannon.nelson@intel.com>

When cleaning up the interrupt handling, clean up the irqs only if
we actually got them set up.  There are a couple of error recovery
paths that were violating this and causing the kernel a bit of
indigestion.

Testing Hints:
Inject an error om the i40e_probe() that puts the driver into the
debug mode, then remove the driver.  Often this causes a NULL pointer
warning from the i40e_remove trace.

Reviewed-by: Williams, Mitch A <mitch.a.williams@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 59e911f..260abd8 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -4164,7 +4164,7 @@ static void i40e_clear_interrupt_scheme(struct i40e_pf *pf)
 	int i;
 
 	i40e_stop_misc_vector(pf);
-	if (pf->flags & I40E_FLAG_MSIX_ENABLED) {
+	if (pf->flags & I40E_FLAG_MSIX_ENABLED && pf->msix_entries) {
 		synchronize_irq(pf->msix_entries[0].vector);
 		free_irq(pf->msix_entries[0].vector, pf);
 	}
-- 
2.4.3

