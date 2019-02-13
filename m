From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Wed, 13 Feb 2019 10:51:10 -0800
Subject: [Intel-wired-lan] [PATCH S14 10/15] ice: add and use new
 ice_for_each_traffic_class() macro
In-Reply-To: <20190213185115.25877-1-anirudh.venkataramanan@intel.com>
References: <20190213185115.25877-1-anirudh.venkataramanan@intel.com>
Message-ID: <20190213185115.25877-11-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bruce Allan <bruce.w.allan@intel.com>

There are numerous for() loops iterating over each of the max traffic
classes.  Use a simple iterator macro instead to make the code cleaner.

Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c | 2 +-
 drivers/net/ethernet/intel/ice/ice_lib.c    | 4 ++--
 drivers/net/ethernet/intel/ice/ice_sched.c  | 2 +-
 drivers/net/ethernet/intel/ice/ice_type.h   | 3 +++
 4 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index be67d07b75cb..ca9a8c52a8d6 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -2949,7 +2949,7 @@ ice_cfg_vsi_qs(struct ice_port_info *pi, u16 vsi_handle, u8 tc_bitmap,
 
 	mutex_lock(&pi->sched_lock);
 
-	for (i = 0; i < ICE_MAX_TRAFFIC_CLASS; i++) {
+	ice_for_each_traffic_class(i) {
 		/* configuration is possible only if TC node is present */
 		if (!ice_sched_get_tc_node(pi, i))
 			continue;
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 914e59272a91..f0c87c40fd9d 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -868,7 +868,7 @@ static void ice_vsi_setup_q_map(struct ice_vsi *vsi, struct ice_vsi_ctx *ctxt)
 	/* find the (rounded up) power-of-2 of qcount */
 	pow = order_base_2(qcount_rx);
 
-	for (i = 0; i < ICE_MAX_TRAFFIC_CLASS; i++) {
+	ice_for_each_traffic_class(i) {
 		if (!(vsi->tc_cfg.ena_tc & BIT(i))) {
 			/* TC is not enabled */
 			vsi->tc_cfg.tc_info[i].qoffset = 0;
@@ -1715,7 +1715,7 @@ ice_vsi_cfg_txqs(struct ice_vsi *vsi, struct ice_ring **rings, int offset)
 	num_q_grps = 1;
 
 	/* set up and configure the Tx queues for each enabled TC */
-	for (tc = 0; tc < ICE_MAX_TRAFFIC_CLASS; tc++) {
+	ice_for_each_traffic_class(tc) {
 		if (!(vsi->tc_cfg.ena_tc & BIT(tc)))
 			break;
 
diff --git a/drivers/net/ethernet/intel/ice/ice_sched.c b/drivers/net/ethernet/intel/ice/ice_sched.c
index efbebf7a050f..e0218f4c8f0b 100644
--- a/drivers/net/ethernet/intel/ice/ice_sched.c
+++ b/drivers/net/ethernet/intel/ice/ice_sched.c
@@ -1606,7 +1606,7 @@ ice_sched_rm_vsi_cfg(struct ice_port_info *pi, u16 vsi_handle, u8 owner)
 	if (!vsi_ctx)
 		goto exit_sched_rm_vsi_cfg;
 
-	for (i = 0; i < ICE_MAX_TRAFFIC_CLASS; i++) {
+	ice_for_each_traffic_class(i) {
 		struct ice_sched_node *vsi_node, *tc_node;
 		u8 j = 0;
 
diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
index 584f260f2e4f..3a4e67484487 100644
--- a/drivers/net/ethernet/intel/ice/ice_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_type.h
@@ -210,6 +210,9 @@ struct ice_nvm_info {
 #define ICE_MAX_TRAFFIC_CLASS 8
 #define ICE_TXSCHED_MAX_BRANCHES ICE_MAX_TRAFFIC_CLASS
 
+#define ice_for_each_traffic_class(_i)	\
+	for ((_i) = 0; (_i) < ICE_MAX_TRAFFIC_CLASS; (_i)++)
+
 struct ice_sched_node {
 	struct ice_sched_node *parent;
 	struct ice_sched_node *sibling; /* next sibling in the same layer */
-- 
2.14.5

