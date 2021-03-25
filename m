From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Thu, 25 Mar 2021 15:35:08 -0700
Subject: [Intel-wired-lan] [PATCH S57 05/14] ice: Remove unnecessary checker
 loop
In-Reply-To: <20210325223517.17722-1-anthony.l.nguyen@intel.com>
References: <20210325223517.17722-1-anthony.l.nguyen@intel.com>
Message-ID: <20210325223517.17722-5-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>

The loop checking for PF VSI doesn't make any sense. The VSI type
backing the netdev passed to ice_set_link_ksettings will always be
of type ICE_PF_VSI. Remove it.

Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index af02bbbc3647..b942ff36f772 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -2198,8 +2198,8 @@ ice_set_link_ksettings(struct net_device *netdev,
 	struct ethtool_link_ksettings safe_ks, copy_ks;
 	struct ice_aqc_get_phy_caps_data *abilities;
 	u8 autoneg, timeout = TEST_SET_BITS_TIMEOUT;
-	u16 adv_link_speed, curr_link_speed, idx;
 	struct ice_aqc_set_phy_cfg_data config;
+	u16 adv_link_speed, curr_link_speed;
 	struct ice_pf *pf = np->vsi->back;
 	struct ice_port_info *p;
 	u8 autoneg_changed = 0;
@@ -2214,14 +2214,6 @@ ice_set_link_ksettings(struct net_device *netdev,
 	if (!p)
 		return -EOPNOTSUPP;
 
-	/* Check if this is LAN VSI */
-	ice_for_each_vsi(pf, idx)
-		if (pf->vsi[idx]->type == ICE_VSI_PF) {
-			if (np->vsi != pf->vsi[idx])
-				return -EOPNOTSUPP;
-			break;
-		}
-
 	if (p->phy.media_type != ICE_MEDIA_BASET &&
 	    p->phy.media_type != ICE_MEDIA_FIBER &&
 	    p->phy.media_type != ICE_MEDIA_BACKPLANE &&
-- 
2.20.1

