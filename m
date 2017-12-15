From: Alice Michael <alice.michael@intel.com>
Date: Fri, 15 Dec 2017 10:25:37 -0500
Subject: [Intel-wired-lan] [next PATCH S83-V5 7/9] i40e: check for invalid
 DCB config
In-Reply-To: <20171215152539.49695-1-alice.michael@intel.com>
References: <20171215152539.49695-1-alice.michael@intel.com>
Message-ID: <20171215152539.49695-7-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

The driver (and the entire netdev layer for that matter) assumes
that TC0 will always be present in our DCB configuration.
Unfortunately, this isn't always the case. Rather than fail to
configure the VSI, let's go ahead and try to make it work, even
though DCB will end up being disabled by the kernel.

If the driver fails to configure DCB, the driver queries what's
valid, then writes that back to the hardware, always forcing TC0.

This fixes a bug where the driver could fail to adhere to ETS BW
allocations if 8 TCs were configured on the switch.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 34 ++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index a53f76f..1ce24e2 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -5229,6 +5229,8 @@ static void i40e_vsi_update_queue_map(struct i40e_vsi *vsi,
 static int i40e_vsi_config_tc(struct i40e_vsi *vsi, u8 enabled_tc)
 {
 	u8 bw_share[I40E_MAX_TRAFFIC_CLASS] = {0};
+	struct i40e_pf *pf = vsi->back;
+	struct i40e_hw *hw = &pf->hw;
 	struct i40e_vsi_context ctxt;
 	int ret = 0;
 	int i;
@@ -5246,10 +5248,40 @@ static int i40e_vsi_config_tc(struct i40e_vsi *vsi, u8 enabled_tc)
 
 	ret = i40e_vsi_configure_bw_alloc(vsi, enabled_tc, bw_share);
 	if (ret) {
+		struct i40e_aqc_query_vsi_bw_config_resp bw_config = {0};
+
 		dev_info(&vsi->back->pdev->dev,
 			 "Failed configuring TC map %d for VSI %d\n",
 			 enabled_tc, vsi->seid);
-		goto out;
+		ret = i40e_aq_query_vsi_bw_config(hw, vsi->seid,
+						  &bw_config, NULL);
+		if (ret) {
+			dev_info(&pf->pdev->dev,
+				 "Failed querying vsi bw info, err %s aq_err %s\n",
+				 i40e_stat_str(hw, ret),
+				 i40e_aq_str(hw, hw->aq.asq_last_status));
+			goto out;
+		}
+		if ((bw_config.tc_valid_bits & enabled_tc) != enabled_tc) {
+			u8 valid_tc = bw_config.tc_valid_bits & enabled_tc;
+
+			if (!valid_tc)
+				valid_tc = bw_config.tc_valid_bits;
+			/* Always enable TC0, no matter what */
+			valid_tc |= 1;
+			dev_info(&pf->pdev->dev,
+				 "Requested tc 0x%x, but FW reports 0x%x as valid. Attempting to use 0x%x.\n",
+				 enabled_tc, bw_config.tc_valid_bits, valid_tc);
+			enabled_tc = valid_tc;
+		}
+
+		ret = i40e_vsi_configure_bw_alloc(vsi, enabled_tc, bw_share);
+		if (ret) {
+			dev_err(&pf->pdev->dev,
+				"Unable to  configure TC map %d for VSI %d\n",
+				enabled_tc, vsi->seid);
+			goto out;
+		}
 	}
 
 	/* Update Queue Pairs Mapping for currently enabled UPs */
-- 
2.9.5

