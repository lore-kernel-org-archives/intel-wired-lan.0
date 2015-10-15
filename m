From: Nicholas Krause <xerofoify@gmail.com>
Date: Wed, 14 Oct 2015 21:35:13 -0400
Subject: [Intel-wired-lan] [PATCH RESEND] i40e:Return -ENODEV if hardware
	has no support for certain required features in the function
	i40e_init_pf_fcoe
Message-ID: <1444872913-32140-1-git-send-email-xerofoify@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This makes the function i40e_init_pf_fcoe correctly return -ENODEV
as a error return for when the underlying hardware does not have
support for FCOE or DCB rather then 0 to it's callers in order
to comply with checks run by these particular function's callers
to find out if the underlying hardware supports these features.

Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
---
 drivers/net/ethernet/intel/i40e/i40e_fcoe.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_fcoe.c b/drivers/net/ethernet/intel/i40e/i40e_fcoe.c
index c8b621e..24a44dd 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_fcoe.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_fcoe.c
@@ -273,7 +273,8 @@ out:
  * i40e_fcoe_sw_init - sets up the HW for FCoE
  * @pf: pointer to PF
  *
- * Returns 0 if FCoE is supported otherwise the error code
+ * Returns 0 if FCoE is supported otherwise  -ENODEV if
+ * the hardware does not support it
  **/
 int i40e_init_pf_fcoe(struct i40e_pf *pf)
 {
@@ -287,13 +288,13 @@ int i40e_init_pf_fcoe(struct i40e_pf *pf)
 
 	if (!pf->hw.func_caps.fcoe) {
 		dev_info(&pf->pdev->dev, "FCoE capability is disabled\n");
-		return 0;
+		return -ENODEV;
 	}
 
 	if (!pf->hw.func_caps.dcb) {
 		dev_warn(&pf->pdev->dev,
 			 "Hardware is not DCB capable not enabling FCoE.\n");
-		return 0;
+		return -ENODEV;
 	}
 
 	/* enable FCoE hash filter */
-- 
2.1.4

