From: Anatolii Gerasymenko <anatolii.gerasymenko@intel.com>
Date: Fri,  1 Apr 2022 13:48:26 +0000
Subject: [Intel-wired-lan] [PATCH net v1] ice: Do not skip not enabled
 queues in ice_vc_dis_qs_msg
Message-ID: <20220401134826.627557-1-anatolii.gerasymenko@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Disable check for queue being enabled in ice_vc_dis_qs_msg, because
there could be a case when queues were created, but were not enabled.
We still need to delete those queues.

Normal workflow for VF looks like:
Enable path:
VIRTCHNL_OP_ADD_ETH_ADDR (opcode 10)
VIRTCHNL_OP_CONFIG_VSI_QUEUES (opcode 6)
VIRTCHNL_OP_ENABLE_QUEUES (opcode 8)

Disable path:
VIRTCHNL_OP_DISABLE_QUEUES (opcode 9)
VIRTCHNL_OP_DEL_ETH_ADDR (opcode 11)

The issue appears only in stress conditions when VF is enabled and
disabled very fast.
Eventually there will be a case, when queues are created by
VIRTCHNL_OP_CONFIG_VSI_QUEUES, but are not enabled by
VIRTCHNL_OP_ENABLE_QUEUES.
In turn, these queues are not deleted by VIRTCHNL_OP_DISABLE_QUEUES,
because there is a check whether queues are enabled in
ice_vc_dis_qs_msg.

When we bring up the VF again, we will see the "Failed to set LAN Tx queue
context" error during VIRTCHNL_OP_CONFIG_VSI_QUEUES step. This
happens because old 16 queues were not deleted and VF requests to create
16 more, but ice_sched_get_free_qparent in ice_ena_vsi_txq would fail to
find a parent node for first newly requested queue (because all nodes
are allocated to 16 old queues).

Testing Hints:

Just enable and disable VF fast enough, so it would be disabled before
reaching VIRTCHNL_OP_ENABLE_QUEUES.

while true; do
        ip link set dev ens785f0v0 up
        sleep 0.065 # adjust delay value for you machine
        ip link set dev ens785f0v0 down
done

Fixes: 77ca27c41705 ("ice: add support for virtchnl_queue_select.[tx|rx]_queues bitmap")

Signed-off-by: Anatolii Gerasymenko <anatolii.gerasymenko@intel.com>
Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>
---
This is an urgent fix for https://bugzilla.redhat.com/show_bug.cgi?id=1997012
Send it, please, directly to net. Thanks!
---
 drivers/net/ethernet/intel/ice/ice_virtchnl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl.c b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
index 3f1a63815bac..69ff4b929772 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
@@ -1358,9 +1358,9 @@ static int ice_vc_dis_qs_msg(struct ice_vf *vf, u8 *msg)
 				goto error_param;
 			}
 
-			/* Skip queue if not enabled */
 			if (!test_bit(vf_q_id, vf->txq_ena))
-				continue;
+				dev_dbg(ice_pf_to_dev(vsi->back), "Queue %u on VSI %u is not enabled, but stopping it anyway\n",
+					vf_q_id, vsi->vsi_num);
 
 			ice_fill_txq_meta(vsi, ring, &txq_meta);
 
-- 
2.25.1

