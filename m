From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Tue,  8 Nov 2016 13:05:12 -0800
Subject: [Intel-wired-lan] [next PATCH S52-V2 08/15] i40e: change message to
	only appear when extra debug info is wanted
In-Reply-To: <1478639119-14656-1-git-send-email-bimmy.pujari@intel.com>
References: <1478639119-14656-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1478639119-14656-9-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Carolyn Wyborny <carolyn.wyborny@intel.com>

This patch changes an X722 informational message so that it only
appears when extra messages are desired.  Without this patch,
on X722 devices, this message appears at load, potentially causing
unnecessary alarm.

Signed-off-by: Carolyn Wyborny <carolyn.wyborny@intel.com>
Change-ID: I94f7aae15dc5b2723cc9728c630c72538a3e670e
---
Testing Hints :  "cleared PE_CRITERR message
should no longer appear.

 drivers/net/ethernet/intel/i40e/i40e_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 8187d32..548cbe0 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -3567,7 +3567,7 @@ static irqreturn_t i40e_intr(int irq, void *data)
 	    (ena_mask & I40E_PFINT_ICR0_ENA_PE_CRITERR_MASK)) {
 		ena_mask &= ~I40E_PFINT_ICR0_ENA_PE_CRITERR_MASK;
 		icr0 &= ~I40E_PFINT_ICR0_ENA_PE_CRITERR_MASK;
-		dev_info(&pf->pdev->dev, "cleared PE_CRITERR\n");
+		dev_dbg(&pf->pdev->dev, "cleared PE_CRITERR\n");
 	}
 
 	/* only q0 is used in MSI/Legacy mode, and none are used in MSIX */
-- 
2.4.11

