From: Brett Creeley <brett.creeley@intel.com>
Date: Thu,  9 Sep 2021 14:38:09 -0700
Subject: [Intel-wired-lan] [PATCH net v2] ice: Fix race conditions between
 virtchnl handling and VF ndo ops
In-Reply-To: <20210909213809.27461-1-brett.creeley@intel.com>
References: <20210909213809.27461-1-brett.creeley@intel.com>
Message-ID: <20210909213809.27461-2-brett.creeley@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The VF can be configured via the PF's ndo ops at the same time the PF is
receiving/handling virtchnl messages. This has many issues, with
one of them being the ndo op could be actively resetting a VF (i.e.
resetting it to the default state and deleting/re-adding the VF's VSI)
while a virtchnl message is being handled. The following error was seen
because a VF ndo op was used to change a VF's trust setting while the
VIRTCHNL_OP_CONFIG_VSI_QUEUES was ongoing:

[35274.192484] ice 0000:88:00.0: Failed to set LAN Tx queue context, error: ICE_ERR_PARAM
[35274.193074] ice 0000:88:00.0: VF 0 failed opcode 6, retval: -5
[35274.193640] iavf 0000:88:01.0: PF returned error -5 (IAVF_ERR_PARAM) to our request 6

Fix this by making sure the virtchnl handling and VF ndo ops that
trigger VF resets cannot run concurrently. This is done by adding a
struct mutex cfg_lock to each VF structure. For VF ndo ops, the mutex
will be locked around the critical operations and VFR. Since the ndo ops
will trigger a VFR, the virtchnl thread will use mutex_trylock(). This
is done because if any other thread (i.e. VF ndo op) has the mutex, then
that means the current VF message being handled is no longer valid, so
just ignore it.

This issue can be seen using the following commands:

for i in {0..50}; do
        rmmod ice
        modprobe ice

        sleep 1

        echo 1 > /sys/class/net/ens785f0/device/sriov_numvfs
        echo 1 > /sys/class/net/ens785f1/device/sriov_numvfs

        ip link set ens785f1 vf 0 trust on
        ip link set ens785f0 vf 0 trust on

        sleep 2

        echo 0 > /sys/class/net/ens785f0/device/sriov_numvfs
        echo 0 > /sys/class/net/ens785f1/device/sriov_numvfs
        sleep 1
        echo 1 > /sys/class/net/ens785f0/device/sriov_numvfs
        echo 1 > /sys/class/net/ens785f1/device/sriov_numvfs

        ip link set ens785f1 vf 0 trust on
        ip link set ens785f0 vf 0 trust on
done

Fixes: 7c710869d64e ("ice: Add handlers for VF netdevice operations")
Signed-off-by: Brett Creeley <brett.creeley@intel.com>
---
v2: Update Fixes tag

 .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 25 +++++++++++++++++++
 .../net/ethernet/intel/ice/ice_virtchnl_pf.h  |  5 ++++
 2 files changed, 30 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
index e93430ab37f1..bf6bffbc2173 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
@@ -647,6 +647,8 @@ void ice_free_vfs(struct ice_pf *pf)
 			set_bit(ICE_VF_STATE_DIS, pf->vf[i].vf_states);
 			ice_free_vf_res(&pf->vf[i]);
 		}
+
+		mutex_destroy(&pf->vf[i].cfg_lock);
 	}
 
 	if (ice_sriov_free_msix_res(pf))
@@ -1894,6 +1896,8 @@ static void ice_set_dflt_settings_vfs(struct ice_pf *pf)
 		 */
 		ice_vf_ctrl_invalidate_vsi(vf);
 		ice_vf_fdir_init(vf);
+
+		mutex_init(&vf->cfg_lock);
 	}
 }
 
@@ -4078,6 +4082,8 @@ ice_set_vf_port_vlan(struct net_device *netdev, int vf_id, u16 vlan_id, u8 qos,
 		return 0;
 	}
 
+	mutex_lock(&vf->cfg_lock);
+
 	vf->port_vlan_info = vlanprio;
 
 	if (vf->port_vlan_info)
@@ -4087,6 +4093,7 @@ ice_set_vf_port_vlan(struct net_device *netdev, int vf_id, u16 vlan_id, u8 qos,
 		dev_info(dev, "Clearing port VLAN on VF %d\n", vf_id);
 
 	ice_vc_reset_vf(vf);
+	mutex_unlock(&vf->cfg_lock);
 
 	return 0;
 }
@@ -4461,6 +4468,15 @@ void ice_vc_process_vf_msg(struct ice_pf *pf, struct ice_rq_event_info *event)
 		return;
 	}
 
+	/* VF is being configured in another context that triggers a VFR, so no
+	 * need to process this message
+	 */
+	if (!mutex_trylock(&vf->cfg_lock)) {
+		dev_info(dev, "VF %u is being configured in another context that will trigger a VFR, so there is no need to handle this message\n",
+			 vf->vf_id);
+		return;
+	}
+
 	switch (v_opcode) {
 	case VIRTCHNL_OP_VERSION:
 		err = ice_vc_get_ver_msg(vf, msg);
@@ -4549,6 +4565,8 @@ void ice_vc_process_vf_msg(struct ice_pf *pf, struct ice_rq_event_info *event)
 		dev_info(dev, "PF failed to honor VF %d, opcode %d, error %d\n",
 			 vf_id, v_opcode, err);
 	}
+
+	mutex_unlock(&vf->cfg_lock);
 }
 
 /**
@@ -4664,6 +4682,8 @@ int ice_set_vf_mac(struct net_device *netdev, int vf_id, u8 *mac)
 		return -EINVAL;
 	}
 
+	mutex_lock(&vf->cfg_lock);
+
 	/* VF is notified of its new MAC via the PF's response to the
 	 * VIRTCHNL_OP_GET_VF_RESOURCES message after the VF has been reset
 	 */
@@ -4682,6 +4702,7 @@ int ice_set_vf_mac(struct net_device *netdev, int vf_id, u8 *mac)
 	}
 
 	ice_vc_reset_vf(vf);
+	mutex_unlock(&vf->cfg_lock);
 	return 0;
 }
 
@@ -4711,11 +4732,15 @@ int ice_set_vf_trust(struct net_device *netdev, int vf_id, bool trusted)
 	if (trusted == vf->trusted)
 		return 0;
 
+	mutex_lock(&vf->cfg_lock);
+
 	vf->trusted = trusted;
 	ice_vc_reset_vf(vf);
 	dev_info(ice_pf_to_dev(pf), "VF %u is now %strusted\n",
 		 vf_id, trusted ? "" : "un");
 
+	mutex_unlock(&vf->cfg_lock);
+
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h
index 842cb077df86..b7e24b5fd4df 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h
@@ -74,6 +74,11 @@ struct ice_mdd_vf_events {
 struct ice_vf {
 	struct ice_pf *pf;
 
+	/* Used during virtchnl message handling and NDO ops against the VF
+	 * that will trigger a VFR
+	 */
+	struct mutex cfg_lock;
+
 	u16 vf_id;			/* VF ID in the PF space */
 	u16 lan_vsi_idx;		/* index into PF struct */
 	u16 ctrl_vsi_idx;
-- 
2.26.3

