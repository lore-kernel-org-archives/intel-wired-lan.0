From: Nicholas Krause <xerofoify@gmail.com>
Date: Mon, 29 Jun 2015 20:24:58 -0400
Subject: [Intel-wired-lan] [PATCH] i40e:Make the function
	i40e_vsi_enable_irq have a return type of void
Message-ID: <1435623898-21549-1-git-send-email-xerofoify@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This makes the function i40e_enable_irq have a return type of void
now due to this particular function always running successfully and
therefore can be declared as void due to never signalling its caller
with a error code due to the above reason.

Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 48a52b3..cbd5928 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -3110,7 +3110,7 @@ static void i40e_vsi_disable_irq(struct i40e_vsi *vsi)
  * i40e_vsi_enable_irq - Enable IRQ for the given VSI
  * @vsi: the VSI being configured
  **/
-static int i40e_vsi_enable_irq(struct i40e_vsi *vsi)
+static void i40e_vsi_enable_irq(struct i40e_vsi *vsi)
 {
 	struct i40e_pf *pf = vsi->back;
 	int i;
@@ -3124,7 +3124,6 @@ static int i40e_vsi_enable_irq(struct i40e_vsi *vsi)
 	}
 
 	i40e_flush(&pf->hw);
-	return 0;
 }
 
 /**
-- 
2.1.4

