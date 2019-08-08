From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Thu,  8 Aug 2019 07:39:25 -0700
Subject: [Intel-wired-lan] [PATCH S27 02/15] ice: Correctly handle return
 values for init DCB
In-Reply-To: <20190808143938.4968-1-anthony.l.nguyen@intel.com>
References: <20190808143938.4968-1-anthony.l.nguyen@intel.com>
Message-ID: <20190808143938.4968-2-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Dave Ertman <david.m.ertman@intel.com>

In the init path for DCB, the call to ice_init_dcb()
can return a non-zero value for either an actual
error, or due to the FW lldp engine being stopped.

We are currently treating all non-zero values only as
an indication that the FW LLDP engine is stopped.

Check for an actual error in the DCB init flow.

Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
index e65b87f26828..eb1077450e5b 100644
--- a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
@@ -457,14 +457,18 @@ int ice_init_pf_dcb(struct ice_pf *pf, bool locked)
 	port_info = hw->port_info;
 
 	err = ice_init_dcb(hw);
+	if (err && !port_info->is_sw_lldp) {
+		dev_err(&pf->pdev->dev, "Error initializing DCB %d\n", err);
+		goto dcb_init_err;
+	}
+
+	dev_info(&pf->pdev->dev,
+		 "DCB is enabled in the hardware, max number of TCs supported on this port are %d\n",
+		 pf->hw.func_caps.common_cap.maxtc);
 	if (err) {
 		/* FW LLDP is disabled, activate SW DCBX/LLDP mode */
-		dev_info(&pf->pdev->dev,
-			 "DCB is enabled in the hardware, max number of TCs supported on this port are %d\n",
-			 pf->hw.func_caps.common_cap.maxtc);
 		dev_info(&pf->pdev->dev,
 			 "FW LLDP is disabled, DCBx/LLDP in SW mode.\n");
-		port_info->is_sw_lldp = true;
 		clear_bit(ICE_FLAG_FW_LLDP_AGENT, pf->flags);
 		err = ice_dcb_sw_dflt_cfg(pf, locked);
 		if (err) {
@@ -480,7 +484,6 @@ int ice_init_pf_dcb(struct ice_pf *pf, bool locked)
 		return 0;
 	}
 
-	port_info->is_sw_lldp = false;
 	set_bit(ICE_FLAG_FW_LLDP_AGENT, pf->flags);
 
 	/* DCBX in FW and LLDP enabled in FW */
@@ -492,10 +495,6 @@ int ice_init_pf_dcb(struct ice_pf *pf, bool locked)
 	if (err)
 		goto dcb_init_err;
 
-	dev_info(&pf->pdev->dev,
-		 "DCB is enabled in the hardware, max number of TCs supported on this port are %d\n",
-		 pf->hw.func_caps.common_cap.maxtc);
-	dev_info(&pf->pdev->dev, "DCBX offload supported\n");
 	return err;
 
 dcb_init_err:
-- 
2.20.1

