From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Mon, 9 Nov 2020 19:29:04 +0000
Subject: [Intel-wired-lan] [PATCH net v2] i40e: Fix MAC address setting
 for a VF via Host/VM
In-Reply-To: <20201014085409.13389-1-mateusz.palczewski@intel.com>
References: <20201014085409.13389-1-mateusz.palczewski@intel.com>
Message-ID: <BN6PR11MB157239BE39BB533C75FED42BABEA0@BN6PR11MB1572.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



-----Original Message-----
From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Mateusz Palczewski
Sent: ?roda, 14 pa?dziernika 2020 10:54
To: intel-wired-lan@lists.osuosl.org
Cc: Laba, SlawomirX <slawomirx.laba@intel.com>
Subject: [Intel-wired-lan] [PATCH net v2] i40e: Fix MAC address setting for a VF via Host/VM

From: Slawomir Laba <slawomirx.laba@intel.com>

Fix MAC setting flow for the PF driver.

Update the unicast VF's MAC address in VF structure if it is a new setting in i40e_vc_add_mac_addr_msg.

When unicast MAC address gets deleted, record that and set the new unicast MAC address that is already waiting in the filter list. This logic is based on the order of messages arriving to the PF driver.

Without this change the MAC address setting was interpreted incorrectly in the following usecases:
1) Print incorrect VF MAC or zero MAC
ip link show dev $pf
2) Don't preserve MAC between driver reload rmmod iavf; modprobe iavf
3) Update VF MAC when macvlan was set
ip link add link $vf address $mac $vf.1 type macvlan
4) Failed to update mac address when VF was trusted ip link set dev $vf address $mac

This includes all other configurations including above commands.

Fixes: f657a6e1313b ("i40e: Fix VF driver MAC address configuration")
Signed-off-by: Slawomir Laba <slawomirx.laba@intel.com>
---
 .../ethernet/intel/i40e/i40e_virtchnl_pf.c    | 25 +++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 8e133d6..ef96f68 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -2702,6 +2702,10 @@ static int i40e_vc_add_mac_addr_msg(struct i40e_vf *vf, u8 *msg)
 				spin_unlock_bh(&vsi->mac_filter_hash_lock);
 				goto error_param;
 			}
+			if (is_valid_ether_addr(al->list[i].addr) &&
+			    is_zero_ether_addr(vf->default_lan_addr.addr))
+				ether_addr_copy(vf->default_lan_addr.addr,
+						al->list[i].addr);
 		}
 	}
 	spin_unlock_bh(&vsi->mac_filter_hash_lock);
@@ -2729,6 +2733,7 @@ static int i40e_vc_del_mac_addr_msg(struct i40e_vf *vf, u8 *msg)  {
 	struct virtchnl_ether_addr_list *al =
 	    (struct virtchnl_ether_addr_list *)msg;
+	bool was_unimac_deleted = false;
 	struct i40e_pf *pf = vf->pf;
 	struct i40e_vsi *vsi = NULL;
 	i40e_status ret = 0;
@@ -2748,6 +2753,8 @@ static int i40e_vc_del_mac_addr_msg(struct i40e_vf *vf, u8 *msg)
 			ret = I40E_ERR_INVALID_MAC_ADDR;
 			goto error_param;
 		}
+		if (ether_addr_equal(al->list[i].addr, vf->default_lan_addr.addr))
+			was_unimac_deleted = true;
 	}
 	vsi = pf->vsi[vf->lan_vsi_idx];
 
@@ -2768,10 +2775,24 @@ static int i40e_vc_del_mac_addr_msg(struct i40e_vf *vf, u8 *msg)
 		dev_err(&pf->pdev->dev, "Unable to program VF %d MAC filters, error %d\n",
 			vf->vf_id, ret);
 
+	if (vf->trusted && was_unimac_deleted) {
+		struct i40e_mac_filter *f;
+		struct hlist_node *h;
+		u8 *macaddr = NULL;
+		int bkt;
+		/* set last unicast mac address as default */
+		spin_lock_bh(&vsi->mac_filter_hash_lock);
+		hash_for_each_safe(vsi->mac_filter_hash, bkt, h, f, hlist) {
+			if (is_valid_ether_addr(f->macaddr))
+				macaddr = f->macaddr;
+		}
+		if (macaddr)
+			ether_addr_copy(vf->default_lan_addr.addr, macaddr);
+		spin_unlock_bh(&vsi->mac_filter_hash_lock);
+	}
 error_param:
 	/* send the response to the VF */
-	return i40e_vc_send_resp_to_vf(vf, VIRTCHNL_OP_DEL_ETH_ADDR,
-				       ret);
+	return i40e_vc_send_resp_to_vf(vf, VIRTCHNL_OP_DEL_ETH_ADDR, ret);
 }
 
 /**
--
2.17.1

Tested-by:Konrad Jankowski <konrad0.jankowski@intel.com>

Intel-wired-lan mailing list
Intel-wired-lan at osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
---------------------------------------------------------------------
Intel Technology Poland sp. z o.o.
ul. Sowackiego 173 | 80-298 Gdask | Sd Rejonowy Gdask Pnoc | VII Wydzia Gospodarczy Krajowego Rejestru Sdowego - KRS 101882 | NIP 957-07-52-316 | Kapita zakadowy 200.000 PLN.
Ta wiadomo wraz z zacznikami jest przeznaczona dla okrelonego adresata i moe zawiera informacje poufne. W razie przypadkowego otrzymania tej wiadomoci, prosimy o powiadomienie nadawcy oraz trwae jej usunicie; jakiekolwiek przegldanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by others is strictly prohibited.
 

