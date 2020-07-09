From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Thu,  9 Jul 2020 09:16:13 -0700
Subject: [Intel-wired-lan] [PATCH S49 14/15] ice: Report AOC PHY Types as
 Fiber
In-Reply-To: <20200709161614.61098-1-anthony.l.nguyen@intel.com>
References: <20200709161614.61098-1-anthony.l.nguyen@intel.com>
Message-ID: <20200709161614.61098-14-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Doug Dziggel <douglas.a.dziggel@intel.com>

Report AOC types as fiber instead of unknown.

Signed-off-by: Doug Dziggel <douglas.a.dziggel@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 2fdee4a34b39..8b45e64398f9 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -285,6 +285,14 @@ static enum ice_media_type ice_get_media_type(struct ice_port_info *pi)
 		case ICE_PHY_TYPE_LOW_100GBASE_LR4:
 		case ICE_PHY_TYPE_LOW_100GBASE_SR2:
 		case ICE_PHY_TYPE_LOW_100GBASE_DR:
+		case ICE_PHY_TYPE_LOW_10G_SFI_AOC_ACC:
+		case ICE_PHY_TYPE_LOW_25G_AUI_AOC_ACC:
+		case ICE_PHY_TYPE_LOW_40G_XLAUI_AOC_ACC:
+		case ICE_PHY_TYPE_LOW_50G_LAUI2_AOC_ACC:
+		case ICE_PHY_TYPE_LOW_50G_AUI2_AOC_ACC:
+		case ICE_PHY_TYPE_LOW_50G_AUI1_AOC_ACC:
+		case ICE_PHY_TYPE_LOW_100G_CAUI4_AOC_ACC:
+		case ICE_PHY_TYPE_LOW_100G_AUI4_AOC_ACC:
 			return ICE_MEDIA_FIBER;
 		case ICE_PHY_TYPE_LOW_100BASE_TX:
 		case ICE_PHY_TYPE_LOW_1000BASE_T:
@@ -338,6 +346,9 @@ static enum ice_media_type ice_get_media_type(struct ice_port_info *pi)
 			fallthrough;
 		case ICE_PHY_TYPE_HIGH_100GBASE_KR2_PAM4:
 			return ICE_MEDIA_BACKPLANE;
+		case ICE_PHY_TYPE_HIGH_100G_CAUI2_AOC_ACC:
+		case ICE_PHY_TYPE_HIGH_100G_AUI2_AOC_ACC:
+			return ICE_MEDIA_FIBER;
 		}
 	}
 	return ICE_MEDIA_UNKNOWN;
-- 
2.20.1

