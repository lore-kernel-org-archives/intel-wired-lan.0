From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon,  6 Feb 2017 14:38:38 -0800
Subject: [Intel-wired-lan] [PART1 PATCH 01/11] i40e: send correct port
	number to AdminQ when enabling UDP tunnels
In-Reply-To: <20170206223846.31052-1-jacob.e.keller@intel.com>
References: <20170206223846.31052-1-jacob.e.keller@intel.com>
Message-ID: <20170206223846.31052-2-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The firmware expects the port numbers for offloaded UDP tunnels in
Little Endian format. We accidentally sent the value in Big Endian
format which obviously will cause the wrong port number to be put into
the UDP tunnels list. This results in VxLAN and Geneve tunnel Rx
offloads being essentially disabled, unless the port number happens to
be identical after byte swapping. Note that i40e_aq_add_udp_tunnel()
will byteswap the parameter from host order into Little Endian so we
don't need worry about passing strictly a __le16 value to the command.

This patch essentially reverts b3f5c7bc88ba ("i40e: Fix for extra byte
swap in tunnel setup", 2016-08-24), but in a way that makes the result
much more clear to the reader.

Fixes: b3f5c7bc88ba ("i40e: Fix for extra byte swap in tunnel setup", 2016-08-24)
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Williams, Mitch A <mitch.a.williams@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h      |  3 ++-
 drivers/net/ethernet/intel/i40e/i40e_main.c | 17 ++++++++---------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 43c041d82fe4..8bb6c5c88fce 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -248,7 +248,8 @@ struct i40e_tc_configuration {
 };
 
 struct i40e_udp_port_config {
-	__be16 index;
+	/* AdminQ command interface expects port number in Host byte order */
+	u16 index;
 	u8 type;
 };
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index d8a10a10da86..8414973cebef 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -7494,7 +7494,7 @@ static void i40e_sync_udp_filters_subtask(struct i40e_pf *pf)
 {
 	struct i40e_hw *hw = &pf->hw;
 	i40e_status ret;
-	__be16 port;
+	u16 port;
 	int i;
 
 	if (!(pf->flags & I40E_FLAG_UDP_FILTER_SYNC))
@@ -7518,7 +7518,7 @@ static void i40e_sync_udp_filters_subtask(struct i40e_pf *pf)
 					"%s %s port %d, index %d failed, err %s aq_err %s\n",
 					pf->udp_ports[i].type ? "vxlan" : "geneve",
 					port ? "add" : "delete",
-					ntohs(port), i,
+					port, i,
 					i40e_stat_str(&pf->hw, ret),
 					i40e_aq_str(&pf->hw,
 						    pf->hw.aq.asq_last_status));
@@ -9201,7 +9201,7 @@ static int i40e_set_features(struct net_device *netdev,
  *
  * Returns the index number or I40E_MAX_PF_UDP_OFFLOAD_PORTS if port not found
  **/
-static u8 i40e_get_udp_port_idx(struct i40e_pf *pf, __be16 port)
+static u8 i40e_get_udp_port_idx(struct i40e_pf *pf, u16 port)
 {
 	u8 i;
 
@@ -9224,7 +9224,7 @@ static void i40e_udp_tunnel_add(struct net_device *netdev,
 	struct i40e_netdev_priv *np = netdev_priv(netdev);
 	struct i40e_vsi *vsi = np->vsi;
 	struct i40e_pf *pf = vsi->back;
-	__be16 port = ti->port;
+	u16 port = ntohs(ti->port);
 	u8 next_idx;
 	u8 idx;
 
@@ -9232,8 +9232,7 @@ static void i40e_udp_tunnel_add(struct net_device *netdev,
 
 	/* Check if port already exists */
 	if (idx < I40E_MAX_PF_UDP_OFFLOAD_PORTS) {
-		netdev_info(netdev, "port %d already offloaded\n",
-			    ntohs(port));
+		netdev_info(netdev, "port %d already offloaded\n", port);
 		return;
 	}
 
@@ -9242,7 +9241,7 @@ static void i40e_udp_tunnel_add(struct net_device *netdev,
 
 	if (next_idx == I40E_MAX_PF_UDP_OFFLOAD_PORTS) {
 		netdev_info(netdev, "maximum number of offloaded UDP ports reached, not adding port %d\n",
-			    ntohs(port));
+			    port);
 		return;
 	}
 
@@ -9276,7 +9275,7 @@ static void i40e_udp_tunnel_del(struct net_device *netdev,
 	struct i40e_netdev_priv *np = netdev_priv(netdev);
 	struct i40e_vsi *vsi = np->vsi;
 	struct i40e_pf *pf = vsi->back;
-	__be16 port = ti->port;
+	u16 port = ntohs(ti->port);
 	u8 idx;
 
 	idx = i40e_get_udp_port_idx(pf, port);
@@ -9308,7 +9307,7 @@ static void i40e_udp_tunnel_del(struct net_device *netdev,
 	return;
 not_found:
 	netdev_warn(netdev, "UDP port %d was not found, not deleting\n",
-		    ntohs(port));
+		    port);
 }
 
 static int i40e_get_phys_port_id(struct net_device *netdev,
-- 
2.12.0.rc0.151.g8a5726c42288

