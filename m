From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Tue, 16 Apr 2019 10:30:47 -0700
Subject: [Intel-wired-lan] [PATCH S20 10/15] ice: Remove redundant and
 premature event config
In-Reply-To: <20190416173052.28928-1-anirudh.venkataramanan@intel.com>
References: <20190416173052.28928-1-anirudh.venkataramanan@intel.com>
Message-ID: <20190416173052.28928-11-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Dave Ertman <david.m.ertman@intel.com>

In the path for re-enabling FW LLDP engine, there is
a call to register for LLDP MIB change events.  This
call is redundant, in that the call to ice_pf_dcb_cfg
will already register the driver for these events.  Also,
the call as it stands now is too early in the flow before
before DCB is configured.

Remove the redundant call.

Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 77c98b121e62..9dde6dd78643 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -1080,12 +1080,6 @@ static int ice_set_priv_flags(struct net_device *netdev, u32 flags)
 			 * registration/init failed but do not return error
 			 * state to ethtool
 			 */
-			status = ice_aq_cfg_lldp_mib_change(&pf->hw, false,
-							    NULL);
-			if (status)
-				dev_dbg(&pf->pdev->dev,
-					"Fail to reg for MIB change\n");
-
 			status = ice_init_pf_dcb(pf, true);
 			if (status)
 				dev_dbg(&pf->pdev->dev, "Fail to init DCB\n");
-- 
2.20.1

