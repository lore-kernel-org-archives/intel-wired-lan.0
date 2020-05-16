From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri, 15 May 2020 17:51:17 -0700
Subject: [Intel-wired-lan] [PATCH S45 11/15] ice: allow host to clear
 administratively set VF MAC
In-Reply-To: <20200516005121.4963-1-anthony.l.nguyen@intel.com>
References: <20200516005121.4963-1-anthony.l.nguyen@intel.com>
Message-ID: <20200516005121.4963-11-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Brett Creeley <brett.creeley@intel.com>

Currently a user is not allowed to clear a VF's administratively set MAC
on the PF. Fix this by allowing an all zero MAC address via "ip link set
${pf_eth} vf ${vf_id} mac 00:00:00:00:00:00".

An example use case for this would be issuing a "virsh shutdown"
command on a VM. The call to iproute mentioned above is part of this flow.
Without this change the driver incorrectly rejects clearing the VF's
administratively set MAC and prints unhelpful log messages.

Also, improve the comments surrounding this change.

Signed-off-by: Brett Creeley <brett.creeley@intel.com>
---
 .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 22 ++++++++++++-------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
index f5596b45b996..abc4f2dba388 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
@@ -3912,7 +3912,7 @@ int ice_set_vf_mac(struct net_device *netdev, int vf_id, u8 *mac)
 	if (ice_validate_vf_id(pf, vf_id))
 		return -EINVAL;
 
-	if (is_zero_ether_addr(mac) || is_multicast_ether_addr(mac)) {
+	if (is_multicast_ether_addr(mac)) {
 		netdev_err(netdev, "%pM not a valid unicast address\n", mac);
 		return -EINVAL;
 	}
@@ -3932,15 +3932,21 @@ int ice_set_vf_mac(struct net_device *netdev, int vf_id, u8 *mac)
 		return -EINVAL;
 	}
 
-	/* copy MAC into dflt_lan_addr and trigger a VF reset. The reset
-	 * flow will use the updated dflt_lan_addr and add a MAC filter
-	 * using ice_add_mac. Also set pf_set_mac to indicate that the PF has
-	 * set the MAC address for this VF.
+	/* VF is notified of its new MAC via the PF's response to the
+	 * VIRTCHNL_OP_GET_VF_RESOURCES message after the VF has been reset
 	 */
 	ether_addr_copy(vf->dflt_lan_addr.addr, mac);
-	vf->pf_set_mac = true;
-	netdev_info(netdev, "MAC on VF %d set to %pM. VF driver will be reinitialized\n",
-		    vf_id, mac);
+	if (is_zero_ether_addr(mac)) {
+		/* VF will send VIRTCHNL_OP_ADD_ETH_ADDR message with its MAC */
+		vf->pf_set_mac = false;
+		netdev_info(netdev, "Removing MAC on VF %d. VF driver will be reinitialized\n",
+			    vf->vf_id);
+	} else {
+		/* PF will add MAC rule for the VF */
+		vf->pf_set_mac = true;
+		netdev_info(netdev, "Setting MAC %pM on VF %d. VF driver will be reinitialized\n",
+			    mac, vf_id);
+	}
 
 	ice_vc_reset_vf(vf);
 	return 0;
-- 
2.20.1

