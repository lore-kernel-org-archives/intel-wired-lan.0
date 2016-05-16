From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Mon, 16 May 2016 10:26:43 -0700
Subject: [Intel-wired-lan] [next PATCH S37 13/15] i40e: set default VSI
	without a reset
In-Reply-To: <1463419605-30746-1-git-send-email-bimmy.pujari@intel.com>
References: <1463419605-30746-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1463419605-30746-14-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

Remove the need for a reset when the device enters limited promiscuous
mode. This was causing heartburn for people who were using VFs and
bridging, since this would require all of the VFs to undergo a reset
each time the PF changed its promiscuity.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Change-ID: I0a83495c5e4d68112bbc7a7a076d20fa8dd3b61c
---
Testing Hints : Make sure default (limited) promiscuous mode works correctly 
with bridging, and that no resets happen when entering and leaving promiscuous 
mode.

 drivers/net/ethernet/intel/i40e/i40e_main.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index b749b46..16197f9 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -2115,7 +2115,25 @@ int i40e_sync_vsi_filters(struct i40e_vsi *vsi)
 			 */
 			if (pf->cur_promisc != cur_promisc) {
 				pf->cur_promisc = cur_promisc;
-				set_bit(__I40E_PF_RESET_REQUESTED, &pf->state);
+				if (cur_promisc)
+					aq_ret =
+					      i40e_aq_set_default_vsi(hw,
+								      vsi->seid,
+								      NULL);
+				else
+					aq_ret =
+					    i40e_aq_clear_default_vsi(hw,
+								      vsi->seid,
+								      NULL);
+				if (aq_ret) {
+					retval = i40e_aq_rc_to_posix(aq_ret,
+							hw->aq.asq_last_status);
+					dev_info(&pf->pdev->dev,
+						 "Set default VSI failed, err %s, aq_err %s\n",
+						 i40e_stat_str(hw, aq_ret),
+						 i40e_aq_str(hw,
+						     hw->aq.asq_last_status));
+				}
 			}
 		} else {
 			aq_ret = i40e_aq_set_vsi_unicast_promiscuous(
@@ -10127,14 +10145,14 @@ void i40e_veb_release(struct i40e_veb *veb)
 static int i40e_add_veb(struct i40e_veb *veb, struct i40e_vsi *vsi)
 {
 	struct i40e_pf *pf = veb->pf;
-	bool is_default = veb->pf->cur_promisc;
 	bool enable_stats = !!(pf->flags & I40E_FLAG_VEB_STATS_ENABLED);
 	int ret;
 
-	/* get a VEB from the hardware */
 	ret = i40e_aq_add_veb(&pf->hw, veb->uplink_seid, vsi->seid,
-			      veb->enabled_tc, is_default,
+			      veb->enabled_tc, false,
 			      &veb->seid, enable_stats, NULL);
+
+	/* get a VEB from the hardware */
 	if (ret) {
 		dev_info(&pf->pdev->dev,
 			 "couldn't add VEB, err %s aq_err %s\n",
-- 
2.4.11

