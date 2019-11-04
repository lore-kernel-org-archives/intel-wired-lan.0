From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Mon,  4 Nov 2019 01:30:59 -0800
Subject: [Intel-wired-lan] [PATCH S32 v2 06/15] ice: configure software LLDP
 in ice_init_pf_dcb
In-Reply-To: <20191104093108.21542-1-anthony.l.nguyen@intel.com>
References: <20191104093108.21542-1-anthony.l.nguyen@intel.com>
Message-ID: <20191104093108.21542-6-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Paul Greenwalt <paul.greenwalt@intel.com>

Move software LLDP configuration when FW DCBX is disabled to
ice_init_pf_dcb, since that is where the FW DCBX state is determined.
Remove this software LLDP configuration from ice_vsi_setup and
ice_set_priv_flags. Software configuration includes redirecting Rx LLDP
packets up the stack, when FW DCBX is not running.

Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c | 15 +++++++++++++++
 drivers/net/ethernet/intel/ice/ice_ethtool.c |  5 -----
 drivers/net/ethernet/intel/ice/ice_lib.c     | 14 ++++----------
 3 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
index a218061ead8e..00cc2b566a0a 100644
--- a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
@@ -596,6 +596,8 @@ int ice_init_pf_dcb(struct ice_pf *pf, bool locked)
 		 "DCB is enabled in the hardware, max number of TCs supported on this port are %d\n",
 		 pf->hw.func_caps.common_cap.maxtc);
 	if (err) {
+		struct ice_vsi *pf_vsi;
+
 		/* FW LLDP is disabled, activate SW DCBX/LLDP mode */
 		dev_info(&pf->pdev->dev,
 			 "FW LLDP is disabled, DCBx/LLDP in SW mode.\n");
@@ -608,6 +610,19 @@ int ice_init_pf_dcb(struct ice_pf *pf, bool locked)
 			goto dcb_init_err;
 		}
 
+		/* If the FW DCBX engine is not running then Rx LLDP packets
+		 * need to be redirected up the stack.
+		 */
+		pf_vsi = ice_get_main_vsi(pf);
+		if (!pf_vsi) {
+			dev_err(&pf->pdev->dev,
+				"Failed to set local DCB config\n");
+			err = -EIO;
+			goto dcb_init_err;
+		}
+
+		ice_cfg_sw_lldp(pf_vsi, false, true);
+
 		pf->dcbx_cap = DCB_CAP_DCBX_HOST | DCB_CAP_DCBX_VER_IEEE;
 		return 0;
 	}
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 3b9d33ad23d8..9c2045056d59 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -1295,11 +1295,6 @@ static int ice_set_priv_flags(struct net_device *netdev, u32 flags)
 			status = ice_init_pf_dcb(pf, true);
 			if (status)
 				dev_warn(&pf->pdev->dev, "Fail to init DCB\n");
-
-			/* Forward LLDP packets to default VSI so that they
-			 * are passed up the stack
-			 */
-			ice_cfg_sw_lldp(vsi, false, true);
 		} else {
 			enum ice_status status;
 			bool dcbx_agent_status;
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index d4e3df6544f5..c9e0b533da47 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -1881,23 +1881,17 @@ ice_vsi_setup(struct ice_pf *pf, struct ice_port_info *pi,
 	 * out PAUSE or PFC frames. If enabled, FW can still send FC frames.
 	 * The rule is added once for PF VSI in order to create appropriate
 	 * recipe, since VSI/VSI list is ignored with drop action...
-	 * Also add rules to handle LLDP Tx and Rx packets.  Tx LLDP packets
-	 * need to be dropped so that VFs cannot send LLDP packets to reconfig
-	 * DCB settings in the HW.  Also, if the FW DCBX engine is not running
-	 * then Rx LLDP packets need to be redirected up the stack.
+	 * Also add rules to handle LLDP Tx packets.  Tx LLDP packets need to
+	 * be dropped so that VFs cannot send LLDP packets to reconfig DCB
+	 * settings in the HW.
 	 */
-	if (!ice_is_safe_mode(pf)) {
+	if (!ice_is_safe_mode(pf))
 		if (vsi->type == ICE_VSI_PF) {
 			ice_vsi_add_rem_eth_mac(vsi, true);
 
 			/* Tx LLDP packets */
 			ice_cfg_sw_lldp(vsi, true, true);
-
-			/* Rx LLDP packets */
-			if (!test_bit(ICE_FLAG_FW_LLDP_AGENT, pf->flags))
-				ice_cfg_sw_lldp(vsi, false, true);
 		}
-	}
 
 	return vsi;
 
-- 
2.20.1

