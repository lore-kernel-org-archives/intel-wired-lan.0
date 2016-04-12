From: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
Date: Tue, 12 Apr 2016 08:30:48 -0700
Subject: [Intel-wired-lan] [next PATCH S33 09/13] i40e: Remove zero check
In-Reply-To: <1460475052-6348-1-git-send-email-harshitha.ramamurthy@intel.com>
References: <1460475052-6348-1-git-send-email-harshitha.ramamurthy@intel.com>
Message-ID: <1460475052-6348-10-git-send-email-harshitha.ramamurthy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Greg Rose <gregory.v.rose@intel.com>

A mirror rule ID may be zero so do not return invalid parameter when the
user passes in a zero value for a rule ID.

Signed-off-by: Greg Rose <gregory.v.rose@intel.com>
Change-ID: I261b8c24725ce2c6ed32f859da81093dfcbe2970
---
Testing Hints : Ensure code compiles correctly.

 drivers/net/ethernet/intel/i40e/i40e_common.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index 1db4790..25872f2 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -2668,10 +2668,7 @@ i40e_status i40e_aq_delete_mirrorrule(struct i40e_hw *hw, u16 sw_seid,
 			u16 *rules_used, u16 *rules_free)
 {
 	/* Rule ID has to be valid except rule_type: INGRESS VLAN mirroring */
-	if (rule_type != I40E_AQC_MIRROR_RULE_TYPE_VLAN) {
-		if (!rule_id)
-			return I40E_ERR_PARAM;
-	} else {
+	if (rule_type == I40E_AQC_MIRROR_RULE_TYPE_VLAN) {
 		/* count and mr_list shall be valid for rule_type INGRESS VLAN
 		 * mirroring. For other rule_type, count and rule_type should
 		 * not matter.
-- 
2.4.3

