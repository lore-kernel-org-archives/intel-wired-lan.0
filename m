From: Nicholas Krause <xerofoify@gmail.com>
Date: Mon, 29 Jun 2015 20:46:37 -0400
Subject: [Intel-wired-lan] [PATCH] i40e:Make the function i40e_vsi_clear
	have a return type of void
Message-ID: <1435625197-27831-1-git-send-email-xerofoify@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This makes the function i40e_vsi_clear have a return type of void
now due to all freeing functions like this one being guaranteed
to not every return a error code to their caller for a non
recoverable error in this function and therefore this particular

Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 48a52b3..c4d44e6 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -5121,8 +5121,6 @@ void i40e_do_reset(struct i40e_pf *pf, u32 reset_flags)
 			}
 		}
 
-		/* no further action needed, so return now */
-		return;
 	} else if (reset_flags & (1 << __I40E_DOWN_REQUESTED)) {
 		int v;
 
@@ -5138,12 +5136,9 @@ void i40e_do_reset(struct i40e_pf *pf, u32 reset_flags)
 			}
 		}
 
-		/* no further action needed, so return now */
-		return;
 	} else {
 		dev_info(&pf->pdev->dev,
 			 "bad reset request 0x%08x\n", reset_flags);
-		return;
 	}
 }
 
@@ -6211,7 +6206,7 @@ static int i40e_get_capabilities(struct i40e_pf *pf)
 	return 0;
 }
 
-static int i40e_vsi_clear(struct i40e_vsi *vsi);
+static void i40e_vsi_clear(struct i40e_vsi *vsi);
 
 /**
  * i40e_fdir_sb_setup - initialize the Flow Director resources for Sideband
@@ -6924,12 +6919,12 @@ static void i40e_vsi_free_arrays(struct i40e_vsi *vsi, bool free_qvectors)
  * i40e_vsi_clear - Deallocate the VSI provided
  * @vsi: the VSI being un-configured
  **/
-static int i40e_vsi_clear(struct i40e_vsi *vsi)
+static void i40e_vsi_clear(struct i40e_vsi *vsi)
 {
 	struct i40e_pf *pf;
 
 	if (!vsi)
-		return 0;
+		return;
 
 	if (!vsi->back)
 		goto free_vsi;
@@ -6966,8 +6961,6 @@ unlock_vsi:
 	mutex_unlock(&pf->switch_mutex);
 free_vsi:
 	kfree(vsi);
-
-	return 0;
 }
 
 /**
-- 
2.1.4

