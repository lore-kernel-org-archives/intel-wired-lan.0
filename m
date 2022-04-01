From: Anatolii Gerasymenko <anatolii.gerasymenko@intel.com>
Date: Fri,  1 Apr 2022 13:48:52 +0000
Subject: [Intel-wired-lan] [PATCH net v1] ice: Set txq_teid to
 ICE_INVAL_TEID on ring creation
Message-ID: <20220401134852.627643-1-anatolii.gerasymenko@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

When VF is freshly created, but not brought up, ring->txq_teid
value is by default set to 0.
But 0 is a valid TEID. On some platforms the Root Node of
Tx scheduler has a TEID = 0. This can cause issues as shown below.

The proper way is to set ring->txq_teid to ICE_INVAL_TEID (0xFFFFFFFF).

Testing Hints:
echo 1 > /sys/class/net/ens785f0/device/sriov_numvfs
ip link set dev ens785f0v0 up
ip link set dev ens785f0v0 down

If we have freshly created VF and quickly turn it on and off, so there
would be no time to reach VIRTCHNL_OP_CONFIG_VSI_QUEUES stage, then
VIRTCHNL_OP_DISABLE_QUEUES stage will fail with error:
[  639.531454] disable queue 89 failed 14
[  639.532233] Failed to disable LAN Tx queues, error: ICE_ERR_AQ_ERROR
[  639.533107] ice 0000:02:00.0: Failed to stop Tx ring 0 on VSI 5

The reason for the fail is that we are trying to send AQ command to
delete queue 89, which has never been created and receive an "invalid
argument" error from firmware.

As this queue has never been created, it's teid and ring->txq_teid
have default value 0.
ice_dis_vsi_txq has a check against non-existent queues:

node = ice_sched_find_node_by_teid(pi->root, q_teids[i]);
if (!node)
	continue;

But on some platforms the Root Node of Tx scheduler has a teid = 0.
Hence, ice_sched_find_node_by_teid finds a node with teid = 0 (it is
pi->root), and we go further to submit an erroneous request to firmware.

Fixes: 37bb83901286 ("ice: Move common functions out of ice_main.c part 7/7")

Signed-off-by: Anatolii Gerasymenko <anatolii.gerasymenko@intel.com>
Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>
---
This is an urgent fix for
https://bugzilla.redhat.com/show_bug.cgi?id=1997012
Send it, please, directly to net. Thanks!
---
 drivers/net/ethernet/intel/ice/ice_lib.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 6d6233204388..2774cbd5b12a 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -1480,6 +1480,7 @@ static int ice_vsi_alloc_rings(struct ice_vsi *vsi)
 		ring->tx_tstamps = &pf->ptp.port.tx;
 		ring->dev = dev;
 		ring->count = vsi->num_tx_desc;
+		ring->txq_teid = ICE_INVAL_TEID;
 		if (dvm_ena)
 			ring->flags |= ICE_TX_FLAGS_RING_VLAN_L2TAG2;
 		else
-- 
2.25.1

