From: Alice Michael <alice.michael@intel.com>
Date: Tue, 29 Aug 2017 05:32:30 -0400
Subject: [Intel-wired-lan] [next PATCH S79-V2 01/13] i40e: add private flag
	to control source pruning
Message-ID: <20170829093242.41026-1-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

By default, our devices do source pruning, that is, they drop receive
packets that have the source MAC matching one of the receive filters.
Unfortunately, this breaks ARP monitoring in channel bonding, as the
bonding driver expects devices to receive ARPs containing their own
source address.

Add an ethtool private flag to control this feature.

Also, remove the netif_running() check when we process our private
flags. It's OK to reset when the device is closed and in most cases we
need the reset the apply these changes.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h         |  1 +
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c |  7 +++++--
 drivers/net/ethernet/intel/i40e/i40e_main.c    | 25 +++++++++++++++++++++++++
 3 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 890508f..1d1d51f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -453,6 +453,7 @@ struct i40e_pf {
 #define I40E_FLAG_CLIENT_L2_CHANGE		BIT_ULL(25)
 #define I40E_FLAG_CLIENT_RESET			BIT_ULL(26)
 #define I40E_FLAG_LINK_DOWN_ON_CLOSE_ENABLED	BIT_ULL(27)
+#define I40E_FLAG_SOURCE_PRUNING_DISABLED       BIT_ULL(29)
 
 	struct i40e_client_instance *cinst;
 	bool stat_offsets_loaded;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 9c6c63a..5fab6c5 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -227,6 +227,8 @@ static const struct i40e_priv_flags i40e_gstrings_priv_flags[] = {
 	I40E_PRIV_FLAG("veb-stats", I40E_FLAG_VEB_STATS_ENABLED, 0),
 	I40E_PRIV_FLAG("hw-atr-eviction", I40E_FLAG_HW_ATR_EVICT_ENABLED, 0),
 	I40E_PRIV_FLAG("legacy-rx", I40E_FLAG_LEGACY_RX, 0),
+	I40E_PRIV_FLAG("disable-source-pruning",
+		       I40E_FLAG_SOURCE_PRUNING_DISABLED, 0),
 };
 
 #define I40E_PRIV_FLAGS_STR_LEN ARRAY_SIZE(i40e_gstrings_priv_flags)
@@ -4189,8 +4191,9 @@ static int i40e_set_priv_flags(struct net_device *dev, u32 flags)
 	/* Issue reset to cause things to take effect, as additional bits
 	 * are added we will need to create a mask of bits requiring reset
 	 */
-	if ((changed_flags & I40E_FLAG_VEB_STATS_ENABLED) ||
-	    ((changed_flags & I40E_FLAG_LEGACY_RX) && netif_running(dev)))
+	if (changed_flags & (I40E_FLAG_VEB_STATS_ENABLED |
+			     I40E_FLAG_LEGACY_RX |
+			     I40E_FLAG_SOURCE_PRUNING_DISABLED))
 		i40e_do_reset(pf, BIT(__I40E_PF_RESET_REQUESTED), true);
 
 	return 0;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 32c1914..0083bf4 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -9904,6 +9904,31 @@ static int i40e_add_vsi(struct i40e_vsi *vsi)
 
 		enabled_tc = i40e_pf_get_tc_map(pf);
 
+		/* Source pruning is enabled by default, so the flag is
+		 * negative logic - if it's set, we need to fiddle with
+		 * the VSI to disable source pruning.
+		 */
+		if (pf->flags & I40E_FLAG_SOURCE_PRUNING_DISABLED) {
+			memset(&ctxt, 0, sizeof(ctxt));
+			ctxt.seid = pf->main_vsi_seid;
+			ctxt.pf_num = pf->hw.pf_id;
+			ctxt.vf_num = 0;
+			ctxt.info.valid_sections |=
+			     cpu_to_le16(I40E_AQ_VSI_PROP_SWITCH_VALID);
+			ctxt.info.switch_id =
+				   cpu_to_le16(I40E_AQ_VSI_SW_ID_FLAG_LOCAL_LB);
+			ret = i40e_aq_update_vsi_params(hw, &ctxt, NULL);
+			if (ret) {
+				dev_info(&pf->pdev->dev,
+					 "update vsi failed, err %s aq_err %s\n",
+					 i40e_stat_str(&pf->hw, ret),
+					 i40e_aq_str(&pf->hw,
+						    pf->hw.aq.asq_last_status));
+				ret = -ENOENT;
+				goto err;
+			}
+		}
+
 		/* MFP mode setup queue map and update VSI */
 		if ((pf->flags & I40E_FLAG_MFP_ENABLED) &&
 		    !(pf->hw.func_caps.iscsi)) { /* NIC type PF */
-- 
2.9.4

