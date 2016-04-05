From: Sridhar Samudrala <sridhar.samudrala@intel.com>
Date: Tue,  5 Apr 2016 10:39:07 -0700
Subject: [Intel-wired-lan] [PATCH net-next 2/2] ixgbe: Add support for
	redirect action to cls_u32 offloads.
In-Reply-To: <1459877947-8241-1-git-send-email-sridhar.samudrala@intel.com>
References: <1459877947-8241-1-git-send-email-sridhar.samudrala@intel.com>
Message-ID: <1459877947-8241-2-git-send-email-sridhar.samudrala@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Sridhar Samudrala <sridhar.samudrala@intel.com>

This patch enables 'redirect' to a SRIOV VF or a offloaded macvlan
device queue via tc 'mirred' action.

Verified with the following script that creates SRIOV VFs,  offloaded
macvlan and adds tc u32 filters with redirect action to the associated
netdevs.

 # add ingress qdisc.
 tc qdisc add dev p4p1 ingress

 # enable hw tc offload.
 ethtool -K p4p1 hw-tc-offload on

 # create 4 sriov VFs and bring up the first one.
 echo 4 > /sys/class/net/p4p1/device/sriov_numvfs
 sleep 1
 ip link set p4p1 up
 ip link set p4p1_0 up

 # create a offloaded macvlan device and bring it up.
 ethtool -K p4p1 l2-fwd-offload on
 ip link add link p4p1 name mvlan_1 type macvlan
 ip link set mvlan_1 up

 # add u32 filter with action to redirect to VF netdev
 tc filter add dev p4p1 parent ffff: protocol ip prio 99 \
    handle 800:0:1 u32 ht 800: \
    match ip src 192.168.1.3/32 \
    action mirred egress redirect dev p4p1_0

 # add u32 filter with action to redirect to macvlan netdev
 tc filter add dev p4p1 parent ffff: protocol ip prio 99 \
    handle 800:0:2 u32 ht 800: \
    match ip src 192.168.2.3/32 \
    action mirred egress redirect dev mvlan_1

Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 96 +++++++++++++++++++++++----
 1 file changed, 83 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 19bf386..df7b10a 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -53,6 +53,7 @@
 #include <net/vxlan.h>
 #include <net/pkt_cls.h>
 #include <net/tc_act/tc_gact.h>
+#include <net/tc_act/tc_mirred.h>
 
 #include "ixgbe.h"
 #include "ixgbe_common.h"
@@ -8222,6 +8223,85 @@ static int ixgbe_configure_clsu32_del_hnode(struct ixgbe_adapter *adapter,
 	return 0;
 }
 
+#ifdef CONFIG_NET_CLS_ACT
+static int handle_redirect_action(struct ixgbe_adapter *adapter, int ifindex,
+				  u8 *queue, u64 *action)
+{
+	unsigned int num_vfs = adapter->num_vfs, vf;
+	struct net_device *upper;
+	struct list_head *iter;
+
+	/* redirect to a SRIOV VF */
+	for (vf = 0; vf < num_vfs; ++vf) {
+		upper = pci_get_drvdata(adapter->vfinfo[vf].vfdev);
+		if (upper->ifindex == ifindex) {
+			if (adapter->num_rx_pools > 1)
+				*queue = vf * 2;
+			else
+				*queue = vf * adapter->num_rx_queues_per_pool;
+
+			*action = vf+1;
+			*action <<= ETHTOOL_RX_FLOW_SPEC_RING_VF_OFF;
+			return 0;
+		}
+	}
+
+	/* redirect to a offloaded macvlan netdev */
+	netdev_for_each_all_upper_dev_rcu(adapter->netdev, upper, iter) {
+		if (netif_is_macvlan(upper)) {
+			struct macvlan_dev *dfwd = netdev_priv(upper);
+			struct ixgbe_fwd_adapter *vadapter = dfwd->fwd_priv;
+
+			if (vadapter && vadapter->netdev->ifindex == ifindex) {
+				*queue = adapter->rx_ring[vadapter->rx_base_queue]->reg_idx;
+				*action = *queue;
+				return 0;
+			}
+		}
+	}
+
+	return -EINVAL;
+}
+
+static int parse_tc_actions(struct ixgbe_adapter *adapter,
+			    struct tcf_exts *exts, u64 *action, u8 *queue)
+{
+	const struct tc_action *a;
+	int err;
+
+	if (tc_no_actions(exts))
+		return -EINVAL;
+
+	tc_for_each_action(a, exts) {
+
+		/* Drop action */
+		if (is_tcf_gact_shot(a)) {
+			*action = IXGBE_FDIR_DROP_QUEUE;
+			*queue = IXGBE_FDIR_DROP_QUEUE;
+			return 0;
+		}
+
+		/* Redirect to a VF or a offloaded macvlan */
+		if (is_tcf_mirred_redirect(a)) {
+			int ifindex = tcf_mirred_ifindex(a);
+
+			err = handle_redirect_action(adapter, ifindex, queue,
+						     action);
+			if (err == 0)
+				return err;
+		}
+	}
+
+	return -EINVAL;
+}
+#else
+static int parse_tc_actions(struct ixgbe_adapter *adapter,
+			    struct tcf_exts *exts, u64 *action, u8 *queue)
+{
+	return -EINVAL;
+}
+#endif /* CONFIG_NET_CLS_ACT */
+
 static int ixgbe_configure_clsu32(struct ixgbe_adapter *adapter,
 				  __be16 protocol,
 				  struct tc_cls_u32_offload *cls)
@@ -8231,9 +8311,6 @@ static int ixgbe_configure_clsu32(struct ixgbe_adapter *adapter,
 	struct ixgbe_mat_field *field_ptr;
 	struct ixgbe_fdir_filter *input;
 	union ixgbe_atr_input mask;
-#ifdef CONFIG_NET_CLS_ACT
-	const struct tc_action *a;
-#endif
 	int i, err = 0;
 	u8 queue;
 	u32 uhtid, link_uhtid;
@@ -8335,18 +8412,11 @@ static int ixgbe_configure_clsu32(struct ixgbe_adapter *adapter,
 	if (input->filter.formatted.flow_type == IXGBE_ATR_FLOW_TYPE_IPV4)
 		mask.formatted.flow_type &= IXGBE_ATR_L4TYPE_IPV6_MASK;
 
-#ifdef CONFIG_NET_CLS_ACT
-	if (list_empty(&cls->knode.exts->actions))
+	err = parse_tc_actions(adapter, cls->knode.exts, &input->action,
+			       &queue);
+	if (err < 0)
 		goto err_out;
 
-	list_for_each_entry(a, &cls->knode.exts->actions, list) {
-		if (!is_tcf_gact_shot(a))
-			goto err_out;
-	}
-#endif
-
-	input->action = IXGBE_FDIR_DROP_QUEUE;
-	queue = IXGBE_FDIR_DROP_QUEUE;
 	input->sw_idx = loc;
 
 	spin_lock(&adapter->fdir_perfect_lock);
-- 
2.1.0

