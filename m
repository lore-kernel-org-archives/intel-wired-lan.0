From: Alice Michael <alice.michael@intel.com>
Date: Fri, 20 Apr 2018 01:41:37 -0700
Subject: [Intel-wired-lan] [next PATCH S90 5/8] i40e: Fix multiple issues
 with UDP tunnel offload filter configuration
In-Reply-To: <20180420084140.8081-1-alice.michael@intel.com>
References: <20180420084140.8081-1-alice.michael@intel.com>
Message-ID: <20180420084140.8081-5-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alexander Duyck <alexander.h.duyck@intel.com>

This fixes at least 2 issues I have found with the UDP tunnel filter
configuration.

The first issue is the fact that the tunnels didn't have any sort of mutual
exlcusion in place to prevent an update from racing with a user request to
add/remove a port. As such you could request to add and remove a port
before the port update code had a chance to respond which would result in a
very confusing result. To address it I have added 2 changes. First I added
the RTNL mutex wrapper around our updating of the pending, port, and
filter_index bits. Second I added logic so that we cannot use a port that
has a pending deletion since we need to free the space in hardware before
we can allow software to reuse it.

The second issue addressed is the fact that we were not recording the
actual filter index provided to us by the admin queue. As a result we were
deleting filters that were not associated with the actual filter we wanted
to delete. To fix that I added a filter_index member to the UDP port
tracking structure.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h      |  2 +
 drivers/net/ethernet/intel/i40e/i40e_main.c | 66 +++++++++++++++++++++++------
 2 files changed, 56 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index f573108..70d369e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -310,10 +310,12 @@ struct i40e_tc_configuration {
 	struct i40e_tc_info tc_info[I40E_MAX_TRAFFIC_CLASS];
 };
 
+#define I40E_UDP_PORT_INDEX_UNUSED	255
 struct i40e_udp_port_config {
 	/* AdminQ command interface expects port number in Host byte order */
 	u16 port;
 	u8 type;
+	u8 filter_index;
 };
 
 /* macros related to FLX_PIT */
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index ad01bfc..0babde1 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -9672,9 +9672,9 @@ static void i40e_handle_mdd_event(struct i40e_pf *pf)
 	i40e_flush(hw);
 }
 
-static const char *i40e_tunnel_name(struct i40e_udp_port_config *port)
+static const char *i40e_tunnel_name(u8 type)
 {
-	switch (port->type) {
+	switch (type) {
 	case UDP_TUNNEL_TYPE_VXLAN:
 		return "vxlan";
 	case UDP_TUNNEL_TYPE_GENEVE:
@@ -9708,37 +9708,68 @@ static void i40e_sync_udp_filters(struct i40e_pf *pf)
 static void i40e_sync_udp_filters_subtask(struct i40e_pf *pf)
 {
 	struct i40e_hw *hw = &pf->hw;
-	i40e_status ret;
+	u8 filter_index, type;
 	u16 port;
 	int i;
 
 	if (!test_and_clear_bit(__I40E_UDP_FILTER_SYNC_PENDING, pf->state))
 		return;
 
+	/* acquire RTNL to maintain state of flags and port requests */
+	rtnl_lock();
+
 	for (i = 0; i < I40E_MAX_PF_UDP_OFFLOAD_PORTS; i++) {
 		if (pf->pending_udp_bitmap & BIT_ULL(i)) {
+			struct i40e_udp_port_config *udp_port;
+			i40e_status ret = 0;
+
+			udp_port = &pf->udp_ports[i];
 			pf->pending_udp_bitmap &= ~BIT_ULL(i);
-			port = pf->udp_ports[i].port;
+
+			port = READ_ONCE(udp_port->port);
+			type = READ_ONCE(udp_port->type);
+			filter_index = READ_ONCE(udp_port->filter_index);
+
+			/* release RTNL while we wait on AQ command */
+			rtnl_unlock();
+
 			if (port)
 				ret = i40e_aq_add_udp_tunnel(hw, port,
-							pf->udp_ports[i].type,
-							NULL, NULL);
-			else
-				ret = i40e_aq_del_udp_tunnel(hw, i, NULL);
+							     type,
+							     &filter_index,
+							     NULL);
+			else if (filter_index != I40E_UDP_PORT_INDEX_UNUSED)
+				ret = i40e_aq_del_udp_tunnel(hw, filter_index,
+							     NULL);
+
+			/* reacquire RTNL so we can update filter_index */
+			rtnl_lock();
 
 			if (ret) {
 				dev_info(&pf->pdev->dev,
 					 "%s %s port %d, index %d failed, err %s aq_err %s\n",
-					 i40e_tunnel_name(&pf->udp_ports[i]),
+					 i40e_tunnel_name(type),
 					 port ? "add" : "delete",
-					 port, i,
+					 port,
+					 filter_index,
 					 i40e_stat_str(&pf->hw, ret),
 					 i40e_aq_str(&pf->hw,
 						     pf->hw.aq.asq_last_status));
-				pf->udp_ports[i].port = 0;
+				if (port) {
+					/* failed to add, just reset port,
+					 * drop pending bit for any deletion
+					 */
+					udp_port->port = 0;
+					pf->pending_udp_bitmap &= ~BIT_ULL(i);
+				}
+			} else if (port) {
+				/* record filter index on success */
+				udp_port->filter_index = filter_index;
 			}
 		}
 	}
+
+	rtnl_unlock();
 }
 
 /**
@@ -11355,6 +11386,11 @@ static u8 i40e_get_udp_port_idx(struct i40e_pf *pf, u16 port)
 	u8 i;
 
 	for (i = 0; i < I40E_MAX_PF_UDP_OFFLOAD_PORTS; i++) {
+		/* Do not report ports with pending deletions as
+		 * being available.
+		 */
+		if (!port && (pf->pending_udp_bitmap & BIT_ULL(i)))
+			continue;
 		if (pf->udp_ports[i].port == port)
 			return i;
 	}
@@ -11409,6 +11445,7 @@ static void i40e_udp_tunnel_add(struct net_device *netdev,
 
 	/* New port: add it and mark its index in the bitmap */
 	pf->udp_ports[next_idx].port = port;
+	pf->udp_ports[next_idx].filter_index = I40E_UDP_PORT_INDEX_UNUSED;
 	pf->pending_udp_bitmap |= BIT_ULL(next_idx);
 	set_bit(__I40E_UDP_FILTER_SYNC_PENDING, pf->state);
 }
@@ -11450,7 +11487,12 @@ static void i40e_udp_tunnel_del(struct net_device *netdev,
 	 * and make it pending
 	 */
 	pf->udp_ports[idx].port = 0;
-	pf->pending_udp_bitmap |= BIT_ULL(idx);
+
+	/* Toggle pending bit instead of setting it. This way if we are
+	 * deleting a port that has yet to be added we just clear the pending
+	 * bit and don't have to worry about it.
+	 */
+	pf->pending_udp_bitmap ^= BIT_ULL(idx);
 	set_bit(__I40E_UDP_FILTER_SYNC_PENDING, pf->state);
 
 	return;
-- 
2.9.5

