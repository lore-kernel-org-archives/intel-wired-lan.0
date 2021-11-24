From: Shiraz Saleem <shiraz.saleem@intel.com>
Date: Wed, 24 Nov 2021 06:41:36 -0600
Subject: [Intel-wired-lan] [PATCH 2/2] net/ice: Remove unused enum
In-Reply-To: <20211124124136.1776-1-shiraz.saleem@intel.com>
References: <20211124124136.1776-1-shiraz.saleem@intel.com>
Message-ID: <20211124124136.1776-2-shiraz.saleem@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: "Shiraz Saleem" <shiraz.saleem@intel.com>

Remove ice_devlink_param_id enum as its not used.

Suggested-by: Parav Pandit <parav@nvidia.com>
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_devlink.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_devlink.h b/drivers/net/ethernet/intel/ice/ice_devlink.h
index faea757..fe006d9 100644
--- a/drivers/net/ethernet/intel/ice/ice_devlink.h
+++ b/drivers/net/ethernet/intel/ice/ice_devlink.h
@@ -4,10 +4,6 @@
 #ifndef _ICE_DEVLINK_H_
 #define _ICE_DEVLINK_H_
 
-enum ice_devlink_param_id {
-	ICE_DEVLINK_PARAM_ID_BASE = DEVLINK_PARAM_GENERIC_ID_MAX,
-};
-
 struct ice_pf *ice_allocate_pf(struct device *dev);
 
 void ice_devlink_register(struct ice_pf *pf);
-- 
1.8.3.1

