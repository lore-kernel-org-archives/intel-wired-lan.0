From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Tue, 18 Feb 2020 13:22:06 -0800
Subject: [Intel-wired-lan] [net-queue v2] ice: Wait for VF to be reset/ready
 before configuration
Message-ID: <20200218212206.1043785-1-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Brett Creeley <brett.creeley@intel.com>

The configuration/command below is failing when the VF in the xml
file is already bound to the host iavf driver.

pci_0000_af_0_0.xml:

<interface type='hostdev' managed='yes'>
<source>
<address type='pci' domain='0x0000' bus='0xaf' slot='0x0' function='0x0'/>
</source>
<mac address='00:de:ad:00:11:01'/>
</interface>

> virsh attach-device domain_name pci_0000_af_0_0.xml
error: Failed to attach device from pci_0000_af_0_0.xml
error: Cannot set interface MAC/vlanid to 00:de:ad:00:11:01/0 for
	ifname ens1f1 vf 0: Device or resource busy

This is failing because the VF has not been completely removed/reset
after being unbound (via the virsh command above) from the host iavf
driver and ice_set_vf_mac() checks if the VF is disabled before waiting
for the reset to finish.

Fix this by waiting for the VF remove/reset process to happen before
checking if the VF is disabled. Also, since many functions for VF
administration on the PF were more or less calling the same 3 functions
(ice_wait_on_vf_reset(), ice_is_vf_disabled(), and ice_check_vf_init())
move these into the helper function ice_check_vf_ready_for_cfg(). Then
call this function in any flow that attempts to configure/query a VF
from the PF.

Lastly, increase the maximum wait time in ice_wait_on_vf_reset() to
800ms, and modify/add the #define(s) that determine the wait time.
This was done for robustness because in rare/stress cases VF removal can
take a max of ~800ms and previously the wait was a max of ~300ms.

Signed-off-by: Brett Creeley <brett.creeley@intel.com>
---
v2: Original patch did not apply cleanly to my net-queue tree, so it had
    to be applied by hand, this version applies cleanly to net-queue

 .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 123 ++++++++++--------
 .../net/ethernet/intel/ice/ice_virtchnl_pf.h  |   3 +-
 2 files changed, 71 insertions(+), 55 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
index 262714d5f54a..af3e37b71111 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
@@ -1873,6 +1873,48 @@ static int ice_vc_config_rss_lut(struct ice_vf *vf, u8 *msg)
 				     NULL, 0);
 }
 
+/**
+ * ice_wait_on_vf_reset - poll to make sure a given VF is ready after reset
+ * @vf: The VF being resseting
+ *
+ * The max poll time is about ~800ms, which is about the maximum time it takes
+ * for a VF to be reset and/or a VF driver to be removed.
+ */
+static void ice_wait_on_vf_reset(struct ice_vf *vf)
+{
+	int i;
+
+	for (i = 0; i < ICE_MAX_VF_RESET_TRIES; i++) {
+		if (test_bit(ICE_VF_STATE_INIT, vf->vf_states))
+			break;
+		msleep(ICE_MAX_VF_RESET_SLEEP_MS);
+	}
+}
+
+/**
+ * ice_check_vf_ready_for_cfg - check if VF is ready to be configured/queried
+ * @vf: VF to check if it's ready to be configured/queried
+ *
+ * The purpose of this function is to make sure the VF is not in reset, not
+ * disabled, and initialized so it can be configured and/or queried by a host
+ * administrator.
+ */
+static int ice_check_vf_ready_for_cfg(struct ice_vf *vf)
+{
+	struct ice_pf *pf;
+
+	ice_wait_on_vf_reset(vf);
+
+	if (ice_is_vf_disabled(vf))
+		return -EINVAL;
+
+	pf = vf->pf;
+	if (ice_check_vf_init(pf, vf))
+		return -EBUSY;
+
+	return 0;
+}
+
 /**
  * ice_set_vf_spoofchk
  * @netdev: network interface device structure
@@ -1890,16 +1932,16 @@ int ice_set_vf_spoofchk(struct net_device *netdev, int vf_id, bool ena)
 	enum ice_status status;
 	struct device *dev;
 	struct ice_vf *vf;
-	int ret = 0;
+	int ret;
 
 	dev = ice_pf_to_dev(pf);
 	if (ice_validate_vf_id(pf, vf_id))
 		return -EINVAL;
 
 	vf = &pf->vf[vf_id];
-
-	if (ice_check_vf_init(pf, vf))
-		return -EBUSY;
+	ret = ice_check_vf_ready_for_cfg(vf);
+	if (ret)
+		return ret;
 
 	vf_vsi = pf->vsi[vf->lan_vsi_idx];
 	if (!vf_vsi) {
@@ -2696,7 +2738,7 @@ ice_set_vf_port_vlan(struct net_device *netdev, int vf_id, u16 vlan_id, u8 qos,
 	struct ice_vsi *vsi;
 	struct device *dev;
 	struct ice_vf *vf;
-	int ret = 0;
+	int ret;
 
 	dev = ice_pf_to_dev(pf);
 	if (ice_validate_vf_id(pf, vf_id))
@@ -2714,8 +2756,10 @@ ice_set_vf_port_vlan(struct net_device *netdev, int vf_id, u16 vlan_id, u8 qos,
 
 	vf = &pf->vf[vf_id];
 	vsi = pf->vsi[vf->lan_vsi_idx];
-	if (ice_check_vf_init(pf, vf))
-		return -EBUSY;
+
+	ret = ice_check_vf_ready_for_cfg(vf);
+	if (ret)
+		return ret;
 
 	if (le16_to_cpu(vsi->info.pvid) == vlanprio) {
 		/* duplicate request, so just return success */
@@ -3236,23 +3280,6 @@ ice_get_vf_cfg(struct net_device *netdev, int vf_id, struct ifla_vf_info *ivi)
 	return 0;
 }
 
-/**
- * ice_wait_on_vf_reset
- * @vf: The VF being resseting
- *
- * Poll to make sure a given VF is ready after reset
- */
-static void ice_wait_on_vf_reset(struct ice_vf *vf)
-{
-	int i;
-
-	for (i = 0; i < ICE_MAX_VF_RESET_WAIT; i++) {
-		if (test_bit(ICE_VF_STATE_INIT, vf->vf_states))
-			break;
-		msleep(20);
-	}
-}
-
 /**
  * ice_set_vf_mac
  * @netdev: network interface device structure
@@ -3265,29 +3292,21 @@ int ice_set_vf_mac(struct net_device *netdev, int vf_id, u8 *mac)
 {
 	struct ice_pf *pf = ice_netdev_to_pf(netdev);
 	struct ice_vf *vf;
-	int ret = 0;
+	int ret;
 
 	if (ice_validate_vf_id(pf, vf_id))
 		return -EINVAL;
 
-	vf = &pf->vf[vf_id];
-	/* Don't set MAC on disabled VF */
-	if (ice_is_vf_disabled(vf))
-		return -EINVAL;
-
-	/* In case VF is in reset mode, wait until it is completed. Depending
-	 * on factors like queue disabling routine, this could take ~250ms
-	 */
-	ice_wait_on_vf_reset(vf);
-
-	if (ice_check_vf_init(pf, vf))
-		return -EBUSY;
-
 	if (is_zero_ether_addr(mac) || is_multicast_ether_addr(mac)) {
 		netdev_err(netdev, "%pM not a valid unicast address\n", mac);
 		return -EINVAL;
 	}
 
+	vf = &pf->vf[vf_id];
+	ret = ice_check_vf_ready_for_cfg(vf);
+	if (ret)
+		return ret;
+
 	/* copy MAC into dflt_lan_addr and trigger a VF reset. The reset
 	 * flow will use the updated dflt_lan_addr and add a MAC filter
 	 * using ice_add_mac. Also set pf_set_mac to indicate that the PF has
@@ -3314,22 +3333,15 @@ int ice_set_vf_trust(struct net_device *netdev, int vf_id, bool trusted)
 {
 	struct ice_pf *pf = ice_netdev_to_pf(netdev);
 	struct ice_vf *vf;
+	int ret;
 
 	if (ice_validate_vf_id(pf, vf_id))
 		return -EINVAL;
 
 	vf = &pf->vf[vf_id];
-	/* Don't set Trusted Mode on disabled VF */
-	if (ice_is_vf_disabled(vf))
-		return -EINVAL;
-
-	/* In case VF is in reset mode, wait until it is completed. Depending
-	 * on factors like queue disabling routine, this could take ~250ms
-	 */
-	ice_wait_on_vf_reset(vf);
-
-	if (ice_check_vf_init(pf, vf))
-		return -EBUSY;
+	ret = ice_check_vf_ready_for_cfg(vf);
+	if (ret)
+		return ret;
 
 	/* Check if already trusted */
 	if (trusted == vf->trusted)
@@ -3355,13 +3367,15 @@ int ice_set_vf_link_state(struct net_device *netdev, int vf_id, int link_state)
 {
 	struct ice_pf *pf = ice_netdev_to_pf(netdev);
 	struct ice_vf *vf;
+	int ret;
 
 	if (ice_validate_vf_id(pf, vf_id))
 		return -EINVAL;
 
 	vf = &pf->vf[vf_id];
-	if (ice_check_vf_init(pf, vf))
-		return -EBUSY;
+	ret = ice_check_vf_ready_for_cfg(vf);
+	if (ret)
+		return ret;
 
 	switch (link_state) {
 	case IFLA_VF_LINK_STATE_AUTO:
@@ -3397,14 +3411,15 @@ int ice_get_vf_stats(struct net_device *netdev, int vf_id,
 	struct ice_eth_stats *stats;
 	struct ice_vsi *vsi;
 	struct ice_vf *vf;
+	int ret;
 
 	if (ice_validate_vf_id(pf, vf_id))
 		return -EINVAL;
 
 	vf = &pf->vf[vf_id];
-
-	if (ice_check_vf_init(pf, vf))
-		return -EBUSY;
+	ret = ice_check_vf_ready_for_cfg(vf);
+	if (ret)
+		return ret;
 
 	vsi = pf->vsi[vf->lan_vsi_idx];
 	if (!vsi)
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h
index 4647d636ed36..ac67982751df 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h
@@ -38,7 +38,8 @@
 #define ICE_MAX_POLICY_INTR_PER_VF	33
 #define ICE_MIN_INTR_PER_VF		(ICE_MIN_QS_PER_VF + 1)
 #define ICE_DFLT_INTR_PER_VF		(ICE_DFLT_QS_PER_VF + 1)
-#define ICE_MAX_VF_RESET_WAIT		15
+#define ICE_MAX_VF_RESET_TRIES		40
+#define ICE_MAX_VF_RESET_SLEEP_MS	20
 
 #define ice_for_each_vf(pf, i) \
 	for ((i) = 0; (i) < (pf)->num_alloc_vfs; (i)++)
-- 
2.24.1

