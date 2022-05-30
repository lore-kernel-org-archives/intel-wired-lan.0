From: Marcin Szycik <marcin.szycik@linux.intel.com>
Date: Mon, 30 May 2022 18:51:22 +0200
Subject: [Intel-wired-lan] [PATCH net-next v2] ice: disable stripping in
 default VSI ctx
Message-ID: <20220530165122.8804-1-marcin.szycik@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

In case when driver is in eswitch mode, having VLAN stripping enabled
causes failure in communication. All VLAN configuration commands are
blocked. Because of that VF driver can't disable VLAN stripping at
initialization. It leads to the situation when VLAN stripping on VF VSI
is on, but in kernel it is off.

To prevent this, disable VLAN stripping in VSI initialization. It doesn't
break other usecases, because it is set according to kernel settings.

To reproduce:
modprobe ice
devlink dev eswitch set $PF_PCI mode switchdev
ip link add br0 type bridge
ip link set br0 up
ip link set $PF_DEV master br0
ip link set $PF_DEV up
echo 1 > /sys/class/net/$PF_DEV/device/sriov_numvfs
ip link set $VF1 up
ip link set $VF1_PR master br0
ip link set $VF1_PR up
ip link add link $VF1 name vlan100 type vlan id 100
ip addr add $VLAN_IP/$MASK dev vlan100
ip link set vlan100 up

On link partner:
ip link add link $PF name vlan100 type vlan id 100
ip addr add $PEER_VLAN_IP/$MASK dev vlan100
ip link set vlan100 up
ping $VLAN_IP

Ping fails.

Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
---
v2:
   * Small corrections in commit msg
   * Added reproduction steps
   * Removed Fixes tag, added squash note

This patch should be squashed with "ice: remove VLAN representor specific
logs"
 drivers/net/ethernet/intel/ice/ice_lib.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 70961c0343e7..b28fb8eacffb 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -887,6 +887,9 @@ static void ice_set_dflt_vsi_ctx(struct ice_hw *hw, struct ice_vsi_ctx *ctxt)
 			(ICE_AQ_VSI_OUTER_TAG_VLAN_8100 <<
 			 ICE_AQ_VSI_OUTER_TAG_TYPE_S) &
 			ICE_AQ_VSI_OUTER_TAG_TYPE_M;
+		ctxt->info.outer_vlan_flags |=
+			FIELD_PREP(ICE_AQ_VSI_OUTER_VLAN_EMODE_M,
+				   ICE_AQ_VSI_OUTER_VLAN_EMODE_NOTHING);
 	}
 	/* Have 1:1 UP mapping for both ingress/egress tables */
 	table |= ICE_UP_TABLE_TRANSLATE(0, 0);
-- 
2.35.1

