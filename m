From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Tue, 26 Feb 2019 16:35:08 -0800
Subject: [Intel-wired-lan] [PATCH S13 v2 02/17] ice: Remove unused function
 prototype
In-Reply-To: <20190227003523.28733-1-anirudh.venkataramanan@intel.com>
References: <20190227003523.28733-1-anirudh.venkataramanan@intel.com>
Message-ID: <20190227003523.28733-3-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Commit 7c710869d64e ("ice: Add handlers for VF netdevice operations")
seems to have inadvertently introduced a function prototype for
ice_set_vf_bw that isn't implemented. Remove it.

Fixes: 7c710869d64e ("ice: Add handlers for VF netdevice operations")

Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h
index 01470a8ee03a..1790b2c457b7 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h
@@ -89,9 +89,6 @@ bool ice_reset_all_vfs(struct ice_pf *pf, bool is_vflr);
 int ice_set_vf_port_vlan(struct net_device *netdev, int vf_id,
 			 u16 vlan_id, u8 qos, __be16 vlan_proto);
 
-int ice_set_vf_bw(struct net_device *netdev, int vf_id, int min_tx_rate,
-		  int max_tx_rate);
-
 int ice_set_vf_trust(struct net_device *netdev, int vf_id, bool trusted);
 
 int ice_set_vf_link_state(struct net_device *netdev, int vf_id, int link_state);
@@ -162,12 +159,5 @@ ice_set_vf_link_state(struct net_device __always_unused *netdev,
 	return -EOPNOTSUPP;
 }
 
-static inline int
-ice_set_vf_bw(struct net_device __always_unused *netdev,
-	      int __always_unused vf_id, int __always_unused min_tx_rate,
-	      int __always_unused max_tx_rate)
-{
-	return -EOPNOTSUPP;
-}
 #endif /* CONFIG_PCI_IOV */
 #endif /* _ICE_VIRTCHNL_PF_H_ */
-- 
2.14.5

