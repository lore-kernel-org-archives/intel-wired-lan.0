From: Deepthi Kavalur <deepthi.kavalur@intel.com>
Date: Wed, 23 Dec 2015 12:05:50 -0800
Subject: [Intel-wired-lan] [next PATCH S25 10/16] i40e: refactor dcb function
In-Reply-To: <1450901156-30904-1-git-send-email-deepthi.kavalur@intel.com>
References: <1450901156-30904-1-git-send-email-deepthi.kavalur@intel.com>
Message-ID: <1450901156-30904-11-git-send-email-deepthi.kavalur@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

This is a simple refactor suggested by the community
to change a multi-level if statement into a switch.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Acked-by: Shannon Nelson <shannon.nelson@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Change-ID: I831cf3c40426022220aa9b43990022d22dfd50db
---
Testing-Hints:
Verify if function still works.

 drivers/net/ethernet/intel/i40e/i40e_dcb.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_dcb.c b/drivers/net/ethernet/intel/i40e/i40e_dcb.c
index 582daa7..0fab3a9 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_dcb.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_dcb.c
@@ -380,17 +380,20 @@ static void i40e_parse_cee_app_tlv(struct i40e_cee_feat_tlv *tlv,
 {
 	u16 length, typelength, offset = 0;
 	struct i40e_cee_app_prio *app;
-	u8 i, up, selector;
+	u8 i;
 
 	typelength = ntohs(tlv->hdr.typelen);
 	length = (u16)((typelength & I40E_LLDP_TLV_LEN_MASK) >>
 		       I40E_LLDP_TLV_LEN_SHIFT);
 
 	dcbcfg->numapps = length / sizeof(*app);
+
 	if (!dcbcfg->numapps)
 		return;
 
 	for (i = 0; i < dcbcfg->numapps; i++) {
+		u8 up, selector;
+
 		app = (struct i40e_cee_app_prio *)(tlv->tlvinfo + offset);
 		for (up = 0; up < I40E_MAX_USER_PRIORITY; up++) {
 			if (app->prio_map & BIT(up))
@@ -400,13 +403,17 @@ static void i40e_parse_cee_app_tlv(struct i40e_cee_feat_tlv *tlv,
 
 		/* Get Selector from lower 2 bits, and convert to IEEE */
 		selector = (app->upper_oui_sel & I40E_CEE_APP_SELECTOR_MASK);
-		if (selector == I40E_CEE_APP_SEL_ETHTYPE)
+		switch (selector) {
+		case I40E_CEE_APP_SEL_ETHTYPE:
 			dcbcfg->app[i].selector = I40E_APP_SEL_ETHTYPE;
-		else if (selector == I40E_CEE_APP_SEL_TCPIP)
+			break;
+		case I40E_CEE_APP_SEL_TCPIP:
 			dcbcfg->app[i].selector = I40E_APP_SEL_TCPIP;
-		else
+			break;
+		default:
 			/* Keep selector as it is for unknown types */
 			dcbcfg->app[i].selector = selector;
+		}
 
 		dcbcfg->app[i].protocolid = ntohs(app->protocol);
 		/* Move to next app */
-- 
2.1.0

