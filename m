From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Fri,  8 Feb 2019 12:51:04 -0800
Subject: [Intel-wired-lan] [PATCH S13 08/16] ice: Enable LAN_EN for the
 right recipes
In-Reply-To: <20190208205112.12180-1-anirudh.venkataramanan@intel.com>
References: <20190208205112.12180-1-anirudh.venkataramanan@intel.com>
Message-ID: <20190208205112.12180-9-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Yashaswini Raghuram Prathivadi Bhayankaram <yashaswini.raghuram.prathivadi.bhayankaram@intel.com>

In VEB mode, enable LAN_EN bit in the action fields for filter rules
corresponding to the right recipes.

Signed-off-by: Yashaswini Raghuram Prathivadi Bhayankaram <yashaswini.raghuram.prathivadi.bhayankaram@intel.com>
Reviewed-by: Bruce Allan <bruce.w.allan@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_switch.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
index f84f3bf0132a..8e73eb11235d 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.c
+++ b/drivers/net/ethernet/intel/ice/ice_switch.c
@@ -644,20 +644,31 @@ static void ice_fill_sw_info(struct ice_hw *hw, struct ice_fltr_info *fi)
 	     fi->fltr_act == ICE_FWD_TO_Q ||
 	     fi->fltr_act == ICE_FWD_TO_QGRP)) {
 		fi->lb_en = true;
-		/* Do not set lan_en to TRUE if
+		/* Set lan_en to TRUE if
 		 * 1. The switch is a VEB AND
 		 * 2
-		 * 2.1 The lookup is MAC with unicast addr for MAC, OR
-		 * 2.2 The lookup is MAC_VLAN with unicast addr for MAC
+		 * 2.1 The lookup is VLAN, OR
+		 * 2.2 The lookup is default port mode, OR
+		 * 2.3 The lookup is MAC with mcast or bcast addr for MAC, OR
+		 * 2.4 The lookup is MAC_VLAN with mcast or bcast addr for MAC.
 		 *
-		 * In all other cases, the LAN enable has to be set to true.
+		 * OR
+		 *
+		 * The switch is a VEPA.
+		 *
+		 * In all other cases, the LAN enable has to be set to false.
 		 */
-		if (!(hw->evb_veb &&
-		      ((fi->lkup_type == ICE_SW_LKUP_MAC &&
-			is_unicast_ether_addr(fi->l_data.mac.mac_addr)) ||
-		       (fi->lkup_type == ICE_SW_LKUP_MAC_VLAN &&
-			is_unicast_ether_addr(fi->l_data.mac_vlan.mac_addr)))))
+		if (hw->evb_veb) {
+			if (fi->lkup_type == ICE_SW_LKUP_VLAN ||
+			    fi->lkup_type == ICE_SW_LKUP_DFLT ||
+			    (fi->lkup_type == ICE_SW_LKUP_MAC &&
+			     !is_unicast_ether_addr(fi->l_data.mac.mac_addr)) ||
+			    (fi->lkup_type == ICE_SW_LKUP_MAC_VLAN &&
+			     !is_unicast_ether_addr(fi->l_data.mac.mac_addr)))
+				fi->lan_en = true;
+		} else {
 			fi->lan_en = true;
+		}
 	}
 }
 
-- 
2.14.5

