From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Tue, 19 Feb 2019 15:04:07 -0800
Subject: [Intel-wired-lan] [PATCH S15 07/14] ice: Remove unused function
 prototype
In-Reply-To: <20190219230414.25627-1-anirudh.venkataramanan@intel.com>
References: <20190219230414.25627-1-anirudh.venkataramanan@intel.com>
Message-ID: <20190219230414.25627-8-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Commit 37bb83901286 ("ice: Move common functions out of ice_main.c part
7/7") seems to have inadvertently introduced a function prototype for
ice_vsi_cfg_tc without a corresponding function implementation. Remove it.

Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.h b/drivers/net/ethernet/intel/ice/ice_lib.h
index 5d5611ce0719..d88705828e4c 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_lib.h
@@ -70,8 +70,6 @@ void ice_vsi_free_rx_rings(struct ice_vsi *vsi);
 
 void ice_vsi_free_tx_rings(struct ice_vsi *vsi);
 
-int ice_vsi_cfg_tc(struct ice_vsi *vsi, u8 ena_tc);
-
 int ice_vsi_manage_rss_lut(struct ice_vsi *vsi, bool ena);
 
 #endif /* !_ICE_LIB_H_ */
-- 
2.14.5

