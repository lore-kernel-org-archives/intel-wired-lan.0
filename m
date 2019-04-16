From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Tue, 16 Apr 2019 10:35:02 -0700
Subject: [Intel-wired-lan] [PATCH S21 13/14] ice: Recognize higher speeds
In-Reply-To: <20190416173503.29847-1-anirudh.venkataramanan@intel.com>
References: <20190416173503.29847-1-anirudh.venkataramanan@intel.com>
Message-ID: <20190416173503.29847-14-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

In ice_print_link_msg, add cases for 50GB and 100GB speeds. This
results in the right speed being reported on load, instead of
"Unknownbps".

When VF link if forced (in ice_set_pfe_link_forced), report
max speed 100GB.

Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c        | 6 ++++++
 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index c8cf2c35ecbb..d34e2d529165 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -645,6 +645,12 @@ void ice_print_link_msg(struct ice_vsi *vsi, bool isup)
 	}
 
 	switch (vsi->port_info->phy.link_info.link_speed) {
+	case ICE_AQ_LINK_SPEED_100GB:
+		speed = "100 G";
+		break;
+	case ICE_AQ_LINK_SPEED_50GB:
+		speed = "50 G";
+		break;
 	case ICE_AQ_LINK_SPEED_40GB:
 		speed = "40 G";
 		break;
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
index ecbf447e558a..fff59ebf07ca 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
@@ -103,7 +103,7 @@ ice_set_pfe_link_forced(struct ice_vf *vf, struct virtchnl_pf_event *pfe,
 	u16 link_speed;
 
 	if (link_up)
-		link_speed = ICE_AQ_LINK_SPEED_40GB;
+		link_speed = ICE_AQ_LINK_SPEED_100GB;
 	else
 		link_speed = ICE_AQ_LINK_SPEED_UNKNOWN;
 
-- 
2.20.1

