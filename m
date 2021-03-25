From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Thu, 25 Mar 2021 15:35:17 -0700
Subject: [Intel-wired-lan] [PATCH S57 14/14] ice: Remove unnecessary checks
 in add/kill_vid ndo ops
In-Reply-To: <20210325223517.17722-1-anthony.l.nguyen@intel.com>
References: <20210325223517.17722-1-anthony.l.nguyen@intel.com>
Message-ID: <20210325223517.17722-14-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Brett Creeley <brett.creeley@intel.com>

Currently the driver is doing two unnecessary checks. First both ops are
checking if the VLAN ID passed in is less than VLAN_N_VID and second
both ops are checking to see if a port VLAN is configured on the VSI.

The first check is already handled by the 8021q driver so this is an
unnecessary check. The second check is unnecessary because the PF VSI is
never put into a port VLAN.

Remove these checks.

Signed-off-by: Brett Creeley <brett.creeley@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index b3229202a300..47a7531f517d 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3097,15 +3097,6 @@ ice_vlan_rx_add_vid(struct net_device *netdev, __always_unused __be16 proto,
 	struct ice_vsi *vsi = np->vsi;
 	int ret;
 
-	if (vid >= VLAN_N_VID) {
-		netdev_err(netdev, "VLAN id requested %d is out of range %d\n",
-			   vid, VLAN_N_VID);
-		return -EINVAL;
-	}
-
-	if (vsi->info.pvid)
-		return -EINVAL;
-
 	/* VLAN 0 is added by default during load/reset */
 	if (!vid)
 		return 0;
@@ -3143,9 +3134,6 @@ ice_vlan_rx_kill_vid(struct net_device *netdev, __always_unused __be16 proto,
 	struct ice_vsi *vsi = np->vsi;
 	int ret;
 
-	if (vsi->info.pvid)
-		return -EINVAL;
-
 	/* don't allow removal of VLAN 0 */
 	if (!vid)
 		return 0;
-- 
2.20.1

