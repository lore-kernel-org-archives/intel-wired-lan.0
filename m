From: Bednarz, Christopher N <christopher.n.bednarz@intel.com>
Date: Mon, 31 Jan 2022 20:50:09 +0000
Subject: [Intel-wired-lan] [PATCH for-next 3/3] RDMA/irdma: Add support
 for DSCP
In-Reply-To: <20220131165921.1392-4-shiraz.saleem@intel.com>
References: <20220131165921.1392-1-shiraz.saleem@intel.com>
 <20220131165921.1392-4-shiraz.saleem@intel.com>
Message-ID: <BN9PR11MB544912283EF19BB461F57796B2259@BN9PR11MB5449.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Patch is fine.

Promoting the TOS based on the inbound cm request doesn't seem right:
cm_node->tos = max(listener->tos, cm_info->tos);

This code was already there...So not blocking.  Mustafa and I chatted about experimenting with it removed (just take the listener->tos)...we believe there was some reason behind this but we've had numerous qos bugs that could have been getting in our way.

-Chris


-----Original Message-----
From: Saleem, Shiraz <shiraz.saleem@intel.com> 
Sent: Monday, January 31, 2022 10:59 AM
To: epg nat hpm dev <epg.nat.hpm.dev@intel.com>; intel-wired-lan at lists.osuosl.org
Cc: Ismail, Mustafa <mustafa.ismail@intel.com>; Saleem, Shiraz <shiraz.saleem@intel.com>
Subject: [PATCH for-next 3/3] RDMA/irdma: Add support for DSCP

From: Mustafa Ismail <mustafa.ismail@intel.com>

Add DSCP support for the Intel Ethernet 800 Series devices.
Setup VSI DSCP info when PCI driver indicates DSCP mode during
driver probe or as notification event.

Signed-off-by: Mustafa Ismail <mustafa.ismail@intel.com>
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
---
 drivers/infiniband/hw/irdma/cm.c    | 20 ++++++++++++++++----
 drivers/infiniband/hw/irdma/cm.h    |  7 +++++++
 drivers/infiniband/hw/irdma/ctrl.c  |  6 ++++++
 drivers/infiniband/hw/irdma/main.c  |  8 ++++++--
 drivers/infiniband/hw/irdma/osdep.h |  1 +
 drivers/infiniband/hw/irdma/type.h  |  4 ++++
 6 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/cm.c b/drivers/infiniband/hw/irdma/cm.c
index 6ff1800..abc101b 100644
--- a/drivers/infiniband/hw/irdma/cm.c
+++ b/drivers/infiniband/hw/irdma/cm.c
@@ -2209,8 +2209,12 @@ static void irdma_cm_free_ah(struct irdma_cm_node *cm_node)
 			ibdev_warn(&iwdev->ibdev,
 				   "application TOS[%d] and remote client TOS[%d] mismatch\n",
 				   listener->tos, cm_info->tos);
-		cm_node->tos = max(listener->tos, cm_info->tos);
-		cm_node->user_pri = rt_tos2priority(cm_node->tos);
+		if (iwdev->vsi.dscp_mode) {
+			cm_node->user_pri = listener->user_pri;
+		} else {
+			cm_node->tos = max(listener->tos, cm_info->tos);
+			cm_node->user_pri = rt_tos2priority(cm_node->tos);
+		}
 		ibdev_dbg(&iwdev->ibdev,
 			  "DCB: listener: TOS:[%d] UP:[%d]\n", cm_node->tos,
 			  cm_node->user_pri);
@@ -3835,7 +3839,11 @@ int irdma_connect(struct iw_cm_id *cm_id, struct iw_cm_conn_param *conn_param)
 	cm_info.cm_id = cm_id;
 	cm_info.qh_qpid = iwdev->vsi.ilq->qp_id;
 	cm_info.tos = cm_id->tos;
-	cm_info.user_pri = rt_tos2priority(cm_id->tos);
+	if (iwdev->vsi.dscp_mode)
+		cm_info.user_pri =
+			iwqp->sc_qp.vsi->dscp_map[irdma_tos2dscp(cm_info.tos)];
+	else
+		cm_info.user_pri = rt_tos2priority(cm_id->tos);
 
 	if (iwqp->sc_qp.dev->ws_add(iwqp->sc_qp.vsi, cm_info.user_pri))
 		return -ENOMEM;
@@ -3977,7 +3985,11 @@ int irdma_create_listen(struct iw_cm_id *cm_id, int backlog)
 	cm_id->provider_data = cm_listen_node;
 
 	cm_listen_node->tos = cm_id->tos;
-	cm_listen_node->user_pri = rt_tos2priority(cm_id->tos);
+	if (iwdev->vsi.dscp_mode)
+		cm_listen_node->user_pri =
+			iwdev->vsi.dscp_map[irdma_tos2dscp(cm_id->tos)];
+	else
+		cm_listen_node->user_pri = rt_tos2priority(cm_id->tos);
 	cm_info.user_pri = cm_listen_node->user_pri;
 	if (!cm_listen_node->reused_node) {
 		if (wildcard) {
diff --git a/drivers/infiniband/hw/irdma/cm.h b/drivers/infiniband/hw/irdma/cm.h
index 3bf4272..19c2849 100644
--- a/drivers/infiniband/hw/irdma/cm.h
+++ b/drivers/infiniband/hw/irdma/cm.h
@@ -384,6 +384,13 @@ int irdma_schedule_cm_timer(struct irdma_cm_node *cm_node,
 			    struct irdma_puda_buf *sqbuf,
 			    enum irdma_timer_type type, int send_retrans,
 			    int close_when_complete);
+
+static inline u8 irdma_tos2dscp(u8 tos)
+{
+#define IRDMA_DSCP_VAL GENMASK(7, 2)
+	return (u8)FIELD_GET(IRDMA_DSCP_VAL, tos);
+}
+
 int irdma_accept(struct iw_cm_id *cm_id, struct iw_cm_conn_param *conn_param);
 int irdma_reject(struct iw_cm_id *cm_id, const void *pdata, u8 pdata_len);
 int irdma_connect(struct iw_cm_id *cm_id, struct iw_cm_conn_param *conn_param);
diff --git a/drivers/infiniband/hw/irdma/ctrl.c b/drivers/infiniband/hw/irdma/ctrl.c
index ef1d6ad..94a9c26 100644
--- a/drivers/infiniband/hw/irdma/ctrl.c
+++ b/drivers/infiniband/hw/irdma/ctrl.c
@@ -77,6 +77,12 @@ static void irdma_set_qos_info(struct irdma_sc_vsi  *vsi,
 
 	vsi->qos_rel_bw = l2p->vsi_rel_bw;
 	vsi->qos_prio_type = l2p->vsi_prio_type;
+	vsi->dscp_mode = l2p->dscp_mode;
+	if (l2p->dscp_mode) {
+		memcpy(vsi->dscp_map, l2p->dscp_map, sizeof(vsi->dscp_map));
+		for (i = 0; i < IRDMA_MAX_USER_PRIORITY; i++)
+			l2p->up2tc[i] = i;
+	}
 	for (i = 0; i < IRDMA_MAX_USER_PRIORITY; i++) {
 		if (vsi->dev->hw_attrs.uk_attrs.hw_rev == IRDMA_GEN_1)
 			vsi->qos[i].qs_handle = l2p->qs_handle_list[i];
diff --git a/drivers/infiniband/hw/irdma/main.c b/drivers/infiniband/hw/irdma/main.c
index 179667b..9762526 100644
--- a/drivers/infiniband/hw/irdma/main.c
+++ b/drivers/infiniband/hw/irdma/main.c
@@ -79,6 +79,10 @@ static void irdma_fill_qos_info(struct irdma_l2params *l2params,
 	}
 	for (i = 0; i < IIDC_MAX_USER_PRIORITY; i++)
 		l2params->up2tc[i] = qos_info->up2tc[i];
+	if (qos_info->pfc_mode == IIDC_DSCP_PFC_MODE) {
+		l2params->dscp_mode = true;
+		memcpy(l2params->dscp_map, qos_info->dscp_map, sizeof(l2params->dscp_map));
+	}
 }
 
 static void irdma_iidc_event_handler(struct ice_pf *pf, struct iidc_event *event)
@@ -110,7 +114,7 @@ static void irdma_iidc_event_handler(struct ice_pf *pf, struct iidc_event *event
 		ice_get_qos_params(pf, &qos_info);
 		irdma_fill_qos_info(&l2params, &qos_info);
 		if (iwdev->rf->protocol_used != IRDMA_IWARP_PROTOCOL_ONLY)
-			iwdev->dcb_vlan_mode = qos_info.num_tc > 1;
+			iwdev->dcb_vlan_mode = qos_info.num_tc > 1 && !l2params.dscp_mode;
 		irdma_change_l2params(&iwdev->vsi, &l2params);
 	} else if (*event->type & BIT(IIDC_EVENT_CRIT_ERR)) {
 		ibdev_warn(&iwdev->ibdev, "ICE OICR event notification: oicr = 0x%08x\n",
@@ -285,7 +289,7 @@ static int irdma_probe(struct auxiliary_device *aux_dev, const struct auxiliary_
 	ice_get_qos_params(pf, &qos_info);
 	irdma_fill_qos_info(&l2params, &qos_info);
 	if (iwdev->rf->protocol_used != IRDMA_IWARP_PROTOCOL_ONLY)
-		iwdev->dcb_vlan_mode = l2params.num_tc > 1;
+		iwdev->dcb_vlan_mode = l2params.num_tc > 1 && !l2params.dscp_mode;
 
 	if (irdma_rt_init_hw(iwdev, &l2params)) {
 		err = -EIO;
diff --git a/drivers/infiniband/hw/irdma/osdep.h b/drivers/infiniband/hw/irdma/osdep.h
index 63d8bb3..6e28e43 100644
--- a/drivers/infiniband/hw/irdma/osdep.h
+++ b/drivers/infiniband/hw/irdma/osdep.h
@@ -5,6 +5,7 @@
 
 #include <linux/pci.h>
 #include <linux/bitfield.h>
+#include <linux/net/intel/iidc.h>
 #include <crypto/hash.h>
 #include <rdma/ib_verbs.h>
 
diff --git a/drivers/infiniband/hw/irdma/type.h b/drivers/infiniband/hw/irdma/type.h
index 9483bb3..4290a2c 100644
--- a/drivers/infiniband/hw/irdma/type.h
+++ b/drivers/infiniband/hw/irdma/type.h
@@ -611,6 +611,8 @@ struct irdma_sc_vsi {
 				struct irdma_ws_node *tc_node);
 	u8 qos_rel_bw;
 	u8 qos_prio_type;
+	u8 dscp_map[IIDC_MAX_DSCP_MAPPING];
+	bool dscp_mode:1;
 };
 
 struct irdma_sc_dev {
@@ -735,11 +737,13 @@ struct irdma_l2params {
 	u16 qs_handle_list[IRDMA_MAX_USER_PRIORITY];
 	u16 mtu;
 	u8 up2tc[IRDMA_MAX_USER_PRIORITY];
+	u8 dscp_map[IIDC_MAX_DSCP_MAPPING];
 	u8 num_tc;
 	u8 vsi_rel_bw;
 	u8 vsi_prio_type;
 	bool mtu_changed:1;
 	bool tc_changed:1;
+	bool dscp_mode:1;
 };
 
 struct irdma_vsi_init_info {
-- 
1.8.3.1

