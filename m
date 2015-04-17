From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Thu, 16 Apr 2015 20:06:05 -0400
Subject: [Intel-wired-lan] [net-next S4 08/15] i40e: fix unrecognized FCOE
	EOF case
In-Reply-To: <1429229172-143692-1-git-send-email-catherine.sullivan@intel.com>
References: <1429229172-143692-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1429229172-143692-9-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Vasu Dev <vasu.dev@intel.com>

Because i40e_fcoe_ctxt_eof should never be called without i40e_fcoe_eof_is_supported
being called first, the EOF in fcoe_ctxt_eof should always be valid and therefore
we do not need to print an error if it is not valid.

However, a WARN ON to easily catch any calls to i40e_fcoe_ctxt_eof that aren't
preceded with a call to i40e_fcoe_eof_is_supported is helpful.

Signed-off-by: Vasu Dev <vasu.dev@intel.com>
Change-ID: I3b536b1981ec0bce80576a74440b7dea3908bdb9
---
 drivers/net/ethernet/intel/i40e/i40e_fcoe.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_fcoe.c b/drivers/net/ethernet/intel/i40e/i40e_fcoe.c
index 1803afe..c8b621e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_fcoe.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_fcoe.c
@@ -118,7 +118,7 @@ static inline int i40e_fcoe_fc_eof(struct sk_buff *skb, u8 *eof)
  *
  * The FC EOF is converted to the value understood by HW for descriptor
  * programming. Never call this w/o calling i40e_fcoe_eof_is_supported()
- * first.
+ * first and that already checks for all supported valid eof values.
  **/
 static inline u32 i40e_fcoe_ctxt_eof(u8 eof)
 {
@@ -132,9 +132,12 @@ static inline u32 i40e_fcoe_ctxt_eof(u8 eof)
 	case FC_EOF_A:
 		return I40E_TX_DESC_CMD_L4T_EOFT_EOF_A;
 	default:
-		/* FIXME: still returns 0 */
-		pr_err("Unrecognized EOF %x\n", eof);
-		return 0;
+		/* Supported valid eof shall be already checked by
+		 * calling i40e_fcoe_eof_is_supported() first,
+		 * therefore this default case shall never hit.
+		 */
+		WARN_ON(1);
+		return -EINVAL;
 	}
 }
 
-- 
1.9.3

