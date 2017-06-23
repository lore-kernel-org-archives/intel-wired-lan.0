From: Alice Michael <alice.michael@intel.com>
Date: Fri, 23 Jun 2017 04:24:51 -0400
Subject: [Intel-wired-lan] [next PATCH S74-V2 10/10] i40e: move check for
	avoiding VID=0 filters into i40e_vsi_add_vlan
In-Reply-To: <20170623082451.32671-1-alice.michael@intel.com>
References: <20170623082451.32671-1-alice.michael@intel.com>
Message-ID: <20170623082451.32671-10-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

In i40e_vsi_add_vlan we treat attempting to add VID=0 as an error,
because it does not do what the caller might expect. We already special
case VID=0 in i40e_vlan_rx_add_vid so that we avoid this error when
adding the VLAN.

This special casing is necessary so that we do not add the VLAN=0 filter
since we don't want to stop receiving untagged traffic. Unfortunately,
not all callers of i40e_vsi_add_vlan are aware of this, including when
we add VLANs from a VF device.

Rather than special casing every single caller of i40e_vsi_add_vlan,
lets just move this check internally. This makes the code simpler
because the caller does not need to be aware of how VLAN=0 is special,
and we don't forget to add this check in new places.

This fixes a harmless error message displaying when adding a VLAN from
within a VF. The message was meaningless but there is no reason to
confuse end users and system administrators, and this is now avoided.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index ffd4891..bd22a90 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -2596,9 +2596,20 @@ int i40e_vsi_add_vlan(struct i40e_vsi *vsi, u16 vid)
 {
 	int err;
 
-	if (!vid || vsi->info.pvid)
+	if (vsi->info.pvid)
 		return -EINVAL;
 
+	/* The network stack will attempt to add VID=0, with the intention to
+	 * receive priority tagged packets with a VLAN of 0. Our HW receives
+	 * these packets by default when configured to receive untagged
+	 * packets, so we don't need to add a filter for this case.
+	 * Additionally, HW interprets adding a VID=0 filter as meaning to
+	 * receive *only* tagged traffic and stops receiving untagged traffic.
+	 * Thus, we do not want to actually add a filter for VID=0
+	 */
+	if (!vid)
+		return 0;
+
 	/* Locked once because all functions invoked below iterates list*/
 	spin_lock_bh(&vsi->mac_filter_hash_lock);
 	err = i40e_add_vlan_all_mac(vsi, vid);
@@ -2675,15 +2686,7 @@ static int i40e_vlan_rx_add_vid(struct net_device *netdev,
 	if (vid >= VLAN_N_VID)
 		return -EINVAL;
 
-	/* If the network stack called us with vid = 0 then
-	 * it is asking to receive priority tagged packets with
-	 * vlan id 0.  Our HW receives them by default when configured
-	 * to receive untagged packets so there is no need to add an
-	 * extra filter for vlan 0 tagged packets.
-	 */
-	if (vid)
-		ret = i40e_vsi_add_vlan(vsi, vid);
-
+	ret = i40e_vsi_add_vlan(vsi, vid);
 	if (!ret)
 		set_bit(vid, vsi->active_vlans);
 
-- 
2.9.3

