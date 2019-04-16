From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Tue, 16 Apr 2019 10:30:39 -0700
Subject: [Intel-wired-lan] [PATCH S20 02/15] ice: Implement toggling ethtool
 rx-vlan-filter
In-Reply-To: <20190416173052.28928-1-anirudh.venkataramanan@intel.com>
References: <20190416173052.28928-1-anirudh.venkataramanan@intel.com>
Message-ID: <20190416173052.28928-3-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Tony Nguyen <anthony.l.nguyen@intel.com>

Implement the toggling of rx-vlan-filter; enable|disable VLAN
pruning based on on|off, respectively.

Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 0a4abc21890c..eaa1b25dd1b0 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -2876,6 +2876,13 @@ ice_set_features(struct net_device *netdev, netdev_features_t features)
 		 (netdev->features & NETIF_F_HW_VLAN_CTAG_TX))
 		ret = ice_vsi_manage_vlan_insertion(vsi);
 
+	if ((features & NETIF_F_HW_VLAN_CTAG_FILTER) &&
+	    !(netdev->features & NETIF_F_HW_VLAN_CTAG_FILTER))
+		ret = ice_cfg_vlan_pruning(vsi, true, false);
+	else if (!(features & NETIF_F_HW_VLAN_CTAG_FILTER) &&
+		 (netdev->features & NETIF_F_HW_VLAN_CTAG_FILTER))
+		ret = ice_cfg_vlan_pruning(vsi, false, false);
+
 	return ret;
 }
 
-- 
2.20.1

