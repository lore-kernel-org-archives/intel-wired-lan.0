From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Mon, 29 Jul 2019 02:04:52 -0700
Subject: [Intel-wired-lan] [PATCH S24 v2 10/12] ice: Fix flag used for
 module query
In-Reply-To: <20190729090454.5501-1-anthony.l.nguyen@intel.com>
References: <20190729090454.5501-1-anthony.l.nguyen@intel.com>
Message-ID: <20190729090454.5501-10-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Chinh T Cao <chinh.t.cao@intel.com>

When checking the PHY for status, by specification, the driver
should be using "toplogy" mode when querying the module type.

Signed-off-by: Chinh T Cao <chinh.t.cao@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 5f9dc76699d2..15648d4a8bab 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -2031,7 +2031,7 @@ enum ice_status ice_update_link_info(struct ice_port_info *pi)
 		if (!pcaps)
 			return ICE_ERR_NO_MEMORY;
 
-		status = ice_aq_get_phy_caps(pi, false, ICE_AQC_REPORT_SW_CFG,
+		status = ice_aq_get_phy_caps(pi, false, ICE_AQC_REPORT_TOPO_CAP,
 					     pcaps, NULL);
 		if (!status)
 			memcpy(li->module_type, &pcaps->module_type,
-- 
2.20.1

