From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri, 15 May 2020 17:36:36 -0700
Subject: [Intel-wired-lan] [PATCH S43 07/15] ice: fix usage of incorrect
 variable
In-Reply-To: <20200516003644.4658-1-anthony.l.nguyen@intel.com>
References: <20200516003644.4658-1-anthony.l.nguyen@intel.com>
Message-ID: <20200516003644.4658-7-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

The driver was using rq_last_status where it should have been
using sq_last_status. Fix the string to be using the correct
error reporting variable.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 2 +-
 drivers/net/ethernet/intel/ice/ice_main.c    | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 477ad33e0403..f39d4eb7fd8b 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -3251,7 +3251,7 @@ static int ice_vsi_set_dflt_rss_lut(struct ice_vsi *vsi, int req_rss_size)
 	if (status) {
 		dev_err(dev, "Cannot set RSS lut, err %s aq_err %s\n",
 			ice_stat_str(status),
-			ice_aq_str(hw->adminq.rq_last_status));
+			ice_aq_str(hw->adminq.sq_last_status));
 		err = -EIO;
 	}
 
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 5675804ba899..4731c919a080 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5317,7 +5317,7 @@ int ice_set_rss(struct ice_vsi *vsi, u8 *seed, u8 *lut, u16 lut_size)
 		if (status) {
 			dev_err(dev, "Cannot set RSS key, err %s aq_err %s\n",
 				ice_stat_str(status),
-				ice_aq_str(hw->adminq.rq_last_status));
+				ice_aq_str(hw->adminq.sq_last_status));
 			return -EIO;
 		}
 	}
@@ -5328,7 +5328,7 @@ int ice_set_rss(struct ice_vsi *vsi, u8 *seed, u8 *lut, u16 lut_size)
 		if (status) {
 			dev_err(dev, "Cannot set RSS lut, err %s aq_err %s\n",
 				ice_stat_str(status),
-				ice_aq_str(hw->adminq.rq_last_status));
+				ice_aq_str(hw->adminq.sq_last_status));
 			return -EIO;
 		}
 	}
@@ -5361,7 +5361,7 @@ int ice_get_rss(struct ice_vsi *vsi, u8 *seed, u8 *lut, u16 lut_size)
 		if (status) {
 			dev_err(dev, "Cannot get RSS key, err %s aq_err %s\n",
 				ice_stat_str(status),
-				ice_aq_str(hw->adminq.rq_last_status));
+				ice_aq_str(hw->adminq.sq_last_status));
 			return -EIO;
 		}
 	}
@@ -5372,7 +5372,7 @@ int ice_get_rss(struct ice_vsi *vsi, u8 *seed, u8 *lut, u16 lut_size)
 		if (status) {
 			dev_err(dev, "Cannot get RSS lut, err %s aq_err %s\n",
 				ice_stat_str(status),
-				ice_aq_str(hw->adminq.rq_last_status));
+				ice_aq_str(hw->adminq.sq_last_status));
 			return -EIO;
 		}
 	}
-- 
2.20.1

