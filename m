From: Nicholas Krause <xerofoify@gmail.com>
Date: Mon, 29 Jun 2015 22:43:02 -0400
Subject: [Intel-wired-lan] [PATCH] i40e:Remove unneeded comments about the
	function i40e_vsi_free_arrays
Message-ID: <1435632182-23668-1-git-send-email-xerofoify@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This removes unneeded comments about this functio's return values
and what they mean when returned to this function's caller due to
this function being declared as void and therefore has no return
values.

Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 48a52b3..dfe29eb 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -6905,8 +6905,6 @@ unlock_pf:
  * @type: VSI pointer
  * @free_qvectors: a bool to specify if q_vectors need to be freed.
  *
- * On error: returns error code (negative)
- * On success: returns 0
  **/
 static void i40e_vsi_free_arrays(struct i40e_vsi *vsi, bool free_qvectors)
 {
-- 
2.1.4

