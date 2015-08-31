From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Mon, 31 Aug 2015 19:54:43 -0400
Subject: [Intel-wired-lan] [next PATCH S14 03/15] i40e: Use BIT() macro for
	priority map parsing
In-Reply-To: <1441065295-234333-1-git-send-email-catherine.sullivan@intel.com>
References: <1441065295-234333-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1441065295-234333-4-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Neerav Parikh <neerav.parikh@intel.com>

Replace one left over (1 << up) in the i40e_dcb.c file with the BIT()
macro.

Signed-off-by: Neerav Parikh <neerav.parikh@intel.com>
Change-ID: I39492a400a2cee5ac566143a5b436cc478bea0db
---
 drivers/net/ethernet/intel/i40e/i40e_dcb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_dcb.c b/drivers/net/ethernet/intel/i40e/i40e_dcb.c
index 6fa07ef..251a841 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_dcb.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_dcb.c
@@ -393,7 +393,7 @@ static void i40e_parse_cee_app_tlv(struct i40e_cee_feat_tlv *tlv,
 	for (i = 0; i < dcbcfg->numapps; i++) {
 		app = (struct i40e_cee_app_prio *)(tlv->tlvinfo + offset);
 		for (up = 0; up < I40E_MAX_USER_PRIORITY; up++) {
-			if (app->prio_map & (1 << up))
+			if (app->prio_map & BIT(up))
 				break;
 		}
 		dcbcfg->app[i].priority = up;
-- 
1.9.3

