From: Alice Michael <alice.michael@intel.com>
Date: Wed,  7 Jun 2017 05:43:12 -0400
Subject: [Intel-wired-lan] [next PATCH S72-V3 12/13] i40e: Handle PE_CRITERR
	properly with IWARP enabled
In-Reply-To: <20170607094313.32060-1-alice.michael@intel.com>
References: <20170607094313.32060-1-alice.michael@intel.com>
Message-ID: <20170607094313.32060-12-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Catherine Sullivan <catherine.sullivan@intel.com>

When IWARP is enabled, we weren't clearing the PE_CRITERR, just logging
it and removing it from the mask. We need to do a corer to reset the
PE_CRITERR register, so set the bit for that as we handle the
interrupt.

We should also be checking for the error against the PFINT_ICR0 register,
and only need to clear it in the value getting written to
PFINT_ICR0_ENA.

Signed-off-by: Catherine Sullivan <catherine.sullivan@intel.com>
Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 581a8ff..6db448e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -3684,10 +3684,10 @@ static irqreturn_t i40e_intr(int irq, void *data)
 		pf->sw_int_count++;
 
 	if ((pf->flags & I40E_FLAG_IWARP_ENABLED) &&
-	    (ena_mask & I40E_PFINT_ICR0_ENA_PE_CRITERR_MASK)) {
+	    (icr0 & I40E_PFINT_ICR0_ENA_PE_CRITERR_MASK)) {
 		ena_mask &= ~I40E_PFINT_ICR0_ENA_PE_CRITERR_MASK;
-		icr0 &= ~I40E_PFINT_ICR0_ENA_PE_CRITERR_MASK;
 		dev_dbg(&pf->pdev->dev, "cleared PE_CRITERR\n");
+		set_bit(__I40E_CORE_RESET_REQUESTED, pf->state);
 	}
 
 	/* only q0 is used in MSI/Legacy mode, and none are used in MSIX */
-- 
2.9.3

