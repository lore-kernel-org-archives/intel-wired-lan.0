From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 1 Jan 2018 20:43:35 +0100
Subject: [Intel-wired-lan] [PATCH] i40e: Delete an error message for a
 failed memory allocation in i40e_init_interrupt_scheme()
Message-ID: <c9c151e5-bd26-5b72-d26b-c153249811ab@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 1 Jan 2018 20:38:14 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 4a964d6e4a9e..fd9ac22ee65a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -10445,10 +10445,9 @@ static int i40e_init_interrupt_scheme(struct i40e_pf *pf)
 	/* set up vector assignment tracking */
 	size = sizeof(struct i40e_lump_tracking) + (sizeof(u16) * vectors);
 	pf->irq_pile = kzalloc(size, GFP_KERNEL);
-	if (!pf->irq_pile) {
-		dev_err(&pf->pdev->dev, "error allocating irq_pile memory\n");
+	if (!pf->irq_pile)
 		return -ENOMEM;
-	}
+
 	pf->irq_pile->num_entries = vectors;
 	pf->irq_pile->search_hint = 0;
 
-- 
2.15.1

