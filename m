From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 23 Jun 2016 13:54:02 -0700
Subject: [Intel-wired-lan] [PATCH 1/2] fm10k: rework vxlan_port offload
	before adding geneve support
In-Reply-To: <20160623205403.20327-1-jacob.e.keller@intel.com>
References: <20160623205403.20327-1-jacob.e.keller@intel.com>
Message-ID: <20160623205403.20327-2-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

In preparation for adding Geneve Rx offload support, refactor the
current VXLAN offload flow to be a bit more generic so that it will be
easier to add the new Geneve code. The fm10k hardware supports one VXLAN
and one Geneve tunnel, so we will eventually treat the VXLAN and Geneve
tunnels identically. To this end, factor out the code that handles the
current list so that we can use the generic flow for both tunnels in the
next patch.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k.h        |   6 +-
 drivers/net/ethernet/intel/fm10k/fm10k_main.c   |   4 +-
 drivers/net/ethernet/intel/fm10k/fm10k_netdev.c | 167 +++++++++++++-----------
 3 files changed, 94 insertions(+), 83 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k.h b/drivers/net/ethernet/intel/fm10k/fm10k.h
index e9850697be04..209268a14712 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k.h
+++ b/drivers/net/ethernet/intel/fm10k/fm10k.h
@@ -240,9 +240,7 @@ struct fm10k_iov_data {
 	struct fm10k_vf_info	vf_info[0];
 };
 
-#define fm10k_vxlan_port_for_each(vp, intfc) \
-	list_for_each_entry(vp, &(intfc)->vxlan_port, list)
-struct fm10k_vxlan_port {
+struct fm10k_udp_port {
 	struct list_head	list;
 	sa_family_t		sa_family;
 	__be16			port;
@@ -335,7 +333,7 @@ struct fm10k_intfc {
 	u32 reta[FM10K_RETA_SIZE];
 	u32 rssrk[FM10K_RSSRK_SIZE];
 
-	/* VXLAN port tracking information */
+	/* UDP encapsulation port tracking information */
 	struct list_head vxlan_port;
 
 #ifdef CONFIG_DEBUG_FS
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_main.c b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
index c2c7f2ef2152..199884305c7a 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_main.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
@@ -651,11 +651,11 @@ static int fm10k_clean_rx_irq(struct fm10k_q_vector *q_vector,
 static struct ethhdr *fm10k_port_is_vxlan(struct sk_buff *skb)
 {
 	struct fm10k_intfc *interface = netdev_priv(skb->dev);
-	struct fm10k_vxlan_port *vxlan_port;
+	struct fm10k_udp_port *vxlan_port;
 
 	/* we can only offload a vxlan if we recognize it as such */
 	vxlan_port = list_first_entry_or_null(&interface->vxlan_port,
-					      struct fm10k_vxlan_port, list);
+					      struct fm10k_udp_port, list);
 
 	if (!vxlan_port)
 		return NULL;
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c b/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
index 8ce918f87a05..411933b02712 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
@@ -384,133 +384,147 @@ static void fm10k_request_glort_range(struct fm10k_intfc *interface)
 }
 
 /**
- * fm10k_del_vxlan_port_all
+ * fm10k_free_udp_port_info
  * @interface: board private structure
  *
  * This function frees the entire vxlan_port list
  **/
-static void fm10k_del_vxlan_port_all(struct fm10k_intfc *interface)
+static void fm10k_free_udp_port_info(struct fm10k_intfc *interface)
 {
-	struct fm10k_vxlan_port *vxlan_port;
+	struct fm10k_udp_port *port;
 
-	/* flush all entries from list */
-	vxlan_port = list_first_entry_or_null(&interface->vxlan_port,
-					      struct fm10k_vxlan_port, list);
-	while (vxlan_port) {
-		list_del(&vxlan_port->list);
-		kfree(vxlan_port);
-		vxlan_port = list_first_entry_or_null(&interface->vxlan_port,
-						      struct fm10k_vxlan_port,
-						      list);
+	/* flush all entries from vxlan list */
+	port = list_first_entry_or_null(&interface->vxlan_port,
+					struct fm10k_udp_port, list);
+	while (port) {
+		list_del(&port->list);
+		kfree(port);
+		port = list_first_entry_or_null(&interface->vxlan_port,
+						struct fm10k_udp_port,
+						list);
 	}
 }
 
 /**
- * fm10k_restore_vxlan_port
+ * fm10k_restore_udp_port_info
  * @interface: board private structure
  *
- * This function restores the value in the tunnel_cfg register after reset
+ * This function restores the value in the tunnel_cfg register(s) after reset
  **/
-static void fm10k_restore_vxlan_port(struct fm10k_intfc *interface)
+static void fm10k_restore_udp_port_info(struct fm10k_intfc *interface)
 {
 	struct fm10k_hw *hw = &interface->hw;
-	struct fm10k_vxlan_port *vxlan_port;
+	struct fm10k_udp_port *port;
 
 	/* only the PF supports configuring tunnels */
 	if (hw->mac.type != fm10k_mac_pf)
 		return;
 
-	vxlan_port = list_first_entry_or_null(&interface->vxlan_port,
-					      struct fm10k_vxlan_port, list);
+	port = list_first_entry_or_null(&interface->vxlan_port,
+					struct fm10k_udp_port, list);
 
 	/* restore tunnel configuration register */
 	fm10k_write_reg(hw, FM10K_TUNNEL_CFG,
-			(vxlan_port ? ntohs(vxlan_port->port) : 0) |
+			(port ? ntohs(port->port) : 0) |
 			(ETH_P_TEB << FM10K_TUNNEL_CFG_NVGRE_SHIFT));
 }
 
+static struct fm10k_udp_port *
+fm10k_remove_tunnel_port(struct list_head *ports,
+			 struct udp_tunnel_info *ti)
+{
+	struct fm10k_udp_port *port;
+
+	list_for_each_entry(port, ports, list) {
+		if ((port->port == ti->port) &&
+		    (port->sa_family == ti->sa_family)) {
+			list_del(&port->list);
+			return port;
+		}
+	}
+
+	return NULL;
+}
+
+static void fm10k_insert_tunnel_port(struct list_head *ports,
+				     struct udp_tunnel_info *ti)
+{
+	struct fm10k_udp_port *port;
+
+	/* remove existing port entry from the list so that the newest items
+	 * are always at the tail of the list.
+	 */
+	port = fm10k_remove_tunnel_port(ports, ti);
+	if (!port) {
+		port = kmalloc(sizeof(*port), GFP_ATOMIC);
+		if  (!port)
+			return;
+		port->port = ti->port;
+		port->sa_family = ti->sa_family;
+	}
+
+	list_add_tail(&port->list, ports);
+}
+
 /**
- * fm10k_add_vxlan_port
+ * fm10k_udp_tunnel_add
  * @netdev: network interface device structure
- * @sa_family: Address family of new port
- * @port: port number used for VXLAN
- * @type: Enumerated value specifying udp encapsulation type
+ * @ti: Tunnel endpoint information
  *
- * This function is called when a new VXLAN interface has added a new port
- * number to the range that is currently in use for VXLAN.  The new port
- * number is always added to the tail so that the port number list should
- * match the order in which the ports were allocated.  The head of the list
- * is always used as the VXLAN port number for offloads.
+ * This function is called when a new UDP tunnel port has been added.
+ * Currently we only support VXLAN and only one port will actually be
+ * offloaded due to hardware restrictions.
  **/
-static void fm10k_add_vxlan_port(struct net_device *dev,
+static void fm10k_udp_tunnel_add(struct net_device *dev,
 				 struct udp_tunnel_info *ti)
 {
 	struct fm10k_intfc *interface = netdev_priv(dev);
-	struct fm10k_vxlan_port *vxlan_port;
 
-	if (ti->type != UDP_TUNNEL_TYPE_VXLAN)
-		return;
 	/* only the PF supports configuring tunnels */
 	if (interface->hw.mac.type != fm10k_mac_pf)
 		return;
 
-	/* existing ports are pulled out so our new entry is always last */
-	fm10k_vxlan_port_for_each(vxlan_port, interface) {
-		if ((vxlan_port->port == ti->port) &&
-		    (vxlan_port->sa_family == ti->sa_family)) {
-			list_del(&vxlan_port->list);
-			goto insert_tail;
-		}
+	switch (ti->type) {
+	case UDP_TUNNEL_TYPE_VXLAN:
+		fm10k_insert_tunnel_port(&interface->vxlan_port, ti);
+		break;
+	default:
+		return;
 	}
 
-	/* allocate memory to track ports */
-	vxlan_port = kmalloc(sizeof(*vxlan_port), GFP_ATOMIC);
-	if (!vxlan_port)
-		return;
-	vxlan_port->port = ti->port;
-	vxlan_port->sa_family = ti->sa_family;
-
-insert_tail:
-	/* add new port value to list */
-	list_add_tail(&vxlan_port->list, &interface->vxlan_port);
-
-	fm10k_restore_vxlan_port(interface);
+	fm10k_restore_udp_port_info(interface);
 }
 
 /**
- * fm10k_del_vxlan_port
+ * fm10k_udp_tunnel_del
  * @netdev: network interface device structure
- * @sa_family: Address family of freed port
- * @port: port number used for VXLAN
- * @type: Enumerated value specifying udp encapsulation type
+ * @ti: Tunnel end point information
  *
- * This function is called when a new VXLAN interface has freed a port
- * number from the range that is currently in use for VXLAN.  The freed
- * port is removed from the list and the new head is used to determine
- * the port number for offloads.
+ * This function is called when a new UDP tunnel port is deleted. The freed
+ * port will be removed from the list, then we reprogram the offloaded port
+ * based on the head of the list.
  **/
-static void fm10k_del_vxlan_port(struct net_device *dev,
+static void fm10k_udp_tunnel_del(struct net_device *dev,
 				 struct udp_tunnel_info *ti)
 {
 	struct fm10k_intfc *interface = netdev_priv(dev);
-	struct fm10k_vxlan_port *vxlan_port;
+	struct fm10k_udp_port *port = NULL;
 
-	if (ti->type != UDP_TUNNEL_TYPE_VXLAN)
-		return;
 	if (interface->hw.mac.type != fm10k_mac_pf)
 		return;
 
-	/* find the port in the list and free it */
-	fm10k_vxlan_port_for_each(vxlan_port, interface) {
-		if ((vxlan_port->port == ti->port) &&
-		    (vxlan_port->sa_family == ti->sa_family)) {
-			list_del(&vxlan_port->list);
-			kfree(vxlan_port);
-			break;
-		}
+	switch (ti->type) {
+	case UDP_TUNNEL_TYPE_VXLAN:
+		port = fm10k_remove_tunnel_port(&interface->vxlan_port, ti);
+		break;
+	default:
+		return;
 	}
 
-	fm10k_restore_vxlan_port(interface);
+	/* if we did remove a port we need to free its memory */
+	kfree(port);
+
+	fm10k_restore_udp_port_info(interface);
 }
 
 /**
@@ -559,7 +573,6 @@ int fm10k_open(struct net_device *netdev)
 	if (err)
 		goto err_set_queues;
 
-	/* update VXLAN port configuration */
 	udp_tunnel_get_rx_info(netdev);
 
 	fm10k_up(interface);
@@ -595,7 +608,7 @@ int fm10k_close(struct net_device *netdev)
 
 	fm10k_qv_free_irq(interface);
 
-	fm10k_del_vxlan_port_all(interface);
+	fm10k_free_udp_port_info(interface);
 
 	fm10k_free_all_tx_resources(interface);
 	fm10k_free_all_rx_resources(interface);
@@ -1059,7 +1072,7 @@ void fm10k_restore_rx_state(struct fm10k_intfc *interface)
 	interface->xcast_mode = xcast_mode;
 
 	/* Restore tunnel configuration */
-	fm10k_restore_vxlan_port(interface);
+	fm10k_restore_udp_port_info(interface);
 }
 
 void fm10k_reset_rx_state(struct fm10k_intfc *interface)
@@ -1379,8 +1392,8 @@ static const struct net_device_ops fm10k_netdev_ops = {
 	.ndo_set_vf_vlan	= fm10k_ndo_set_vf_vlan,
 	.ndo_set_vf_rate	= fm10k_ndo_set_vf_bw,
 	.ndo_get_vf_config	= fm10k_ndo_get_vf_config,
-	.ndo_udp_tunnel_add	= fm10k_add_vxlan_port,
-	.ndo_udp_tunnel_del	= fm10k_del_vxlan_port,
+	.ndo_udp_tunnel_add	= fm10k_udp_tunnel_add,
+	.ndo_udp_tunnel_del	= fm10k_udp_tunnel_del,
 	.ndo_dfwd_add_station	= fm10k_dfwd_add_station,
 	.ndo_dfwd_del_station	= fm10k_dfwd_del_station,
 #ifdef CONFIG_NET_POLL_CONTROLLER
-- 
2.9.0.rc1.405.g81f467e

