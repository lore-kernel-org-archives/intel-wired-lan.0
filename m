From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Mon, 20 Jun 2016 09:10:34 -0700
Subject: [Intel-wired-lan] [next PTACH S38-v2 2/7] i40e: enable VSI
	broadcast promiscuous mode instead of adding broadcast filter
In-Reply-To: <1466439039-16378-1-git-send-email-bimmy.pujari@intel.com>
References: <1466439039-16378-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1466439039-16378-3-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Kiran Patil <kiran.patil@intel.com>

This patch sets VSI brodcast promiscuous mode during VSI add sequence
and prevents adding MAC filter if specified MAC address is broadcast.

Signed-off-by: Kiran Patil <kiran.patil@intel.com>
Change-ID: Ia62251fca095bc449d0497fc44bec3a5a0136773
---
Testing Hints :
1. Bring up network interface, assign IP address.
2. Make sure it can ping to link partner.
This proves that ARP request are processed correctly due to VSI
broadcast promiscuous mode even though MAC filter for broadcast
address is not programmed.

Likewise tried the test case mentioned in HSD where source MAC is
broadcast and those packets are getting forwarded to one of the
rx-queue.

HSD-number: 7661069

 drivers/net/ethernet/intel/i40e/i40e_main.c | 32 ++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 6817275..3b8d079 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -1344,6 +1344,13 @@ struct i40e_mac_filter *i40e_add_filter(struct i40e_vsi *vsi,
 	if (!vsi || !macaddr)
 		return NULL;
 
+	/* Do not allow broadcast filter to be added since broadcast filter
+	 * is added as part of add vsi for any newly created VSI except
+	 * FDIR VSI
+	 */
+	if (is_broadcast_ether_addr(macaddr))
+		return NULL;
+
 	f = i40e_find_filter(vsi, macaddr, vlan, is_vf, is_netdev);
 	if (!f) {
 		f = kzalloc(sizeof(*f), GFP_ATOMIC);
@@ -2179,18 +2186,6 @@ int i40e_sync_vsi_filters(struct i40e_vsi *vsi)
 						     hw->aq.asq_last_status));
 			}
 		}
-		aq_ret = i40e_aq_set_vsi_broadcast(&vsi->back->hw,
-						   vsi->seid,
-						   cur_promisc, NULL);
-		if (aq_ret) {
-			retval = i40e_aq_rc_to_posix(aq_ret,
-						     pf->hw.aq.asq_last_status);
-			dev_info(&pf->pdev->dev,
-				 "set brdcast promisc failed, err %s, aq_err %s\n",
-					 i40e_stat_str(hw, aq_ret),
-					 i40e_aq_str(hw,
-						     hw->aq.asq_last_status));
-		}
 	}
 out:
 	/* if something went wrong then set the changed flag so we try again */
@@ -9254,6 +9249,7 @@ int i40e_is_vsi_uplink_mode_veb(struct i40e_vsi *vsi)
 static int i40e_add_vsi(struct i40e_vsi *vsi)
 {
 	int ret = -ENODEV;
+	i40e_status aq_ret = 0;
 	u8 laa_macaddr[ETH_ALEN];
 	bool found_laa_mac_filter = false;
 	struct i40e_pf *pf = vsi->back;
@@ -9443,6 +9439,18 @@ static int i40e_add_vsi(struct i40e_vsi *vsi)
 		vsi->seid = ctxt.seid;
 		vsi->id = ctxt.vsi_number;
 	}
+	/* Except FDIR VSI, for all othet VSI set the broadcast filter */
+	if (vsi->type != I40E_VSI_FDIR) {
+		aq_ret = i40e_aq_set_vsi_broadcast(hw, vsi->seid, true, NULL);
+		if (aq_ret) {
+			ret = i40e_aq_rc_to_posix(aq_ret,
+						  hw->aq.asq_last_status);
+			dev_info(&pf->pdev->dev,
+				 "set brdcast promisc failed, err %s, aq_err %s\n",
+				 i40e_stat_str(hw, aq_ret),
+				 i40e_aq_str(hw, hw->aq.asq_last_status));
+		}
+	}
 
 	spin_lock_bh(&vsi->mac_filter_list_lock);
 	/* If macvlan filters already exist, force them to get loaded */
-- 
2.4.11

