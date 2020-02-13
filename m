From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Thu, 13 Feb 2020 13:31:21 -0800
Subject: [Intel-wired-lan] [PATCH S39 v2 07/15] ice: SW DCB,
 report correct max TC value
In-Reply-To: <20200213213129.34023-1-anthony.l.nguyen@intel.com>
References: <20200213213129.34023-1-anthony.l.nguyen@intel.com>
Message-ID: <20200213213129.34023-6-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Dave Ertman <david.m.ertman@intel.com>

lldpad is using the value reported in the DCB config for
max_tc as the max allowed number of TCs, not the current
max.  ICE driver was reporting it as current maximum TC.

Change DCB_NL function to report maximum TC allowed by
this device.

Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_dcb_nl.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dcb_nl.c b/drivers/net/ethernet/intel/ice/ice_dcb_nl.c
index 589b820a6b5b..c4c12414083a 100644
--- a/drivers/net/ethernet/intel/ice/ice_dcb_nl.c
+++ b/drivers/net/ethernet/intel/ice/ice_dcb_nl.c
@@ -100,14 +100,7 @@ static int ice_dcbnl_setets(struct net_device *netdev, struct ieee_ets *ets)
 		goto ets_out;
 	}
 
-	/* max_tc is a 1-8 value count of number of TC's, not a 0-7 value
-	 * for the TC's index number.  Add one to value if not zero, and
-	 * for zero set it to the FW's default value
-	 */
-	if (max_tc)
-		max_tc++;
-	else
-		max_tc = IEEE_8021QAZ_MAX_TCS;
+	max_tc = pf->hw.func_caps.common_cap.maxtc;
 
 	new_cfg->etscfg.maxtcs = max_tc;
 
-- 
2.20.1

