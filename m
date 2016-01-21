From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Wed, 20 Jan 2016 19:53:02 -0800
Subject: [Intel-wired-lan] [PATCH] i40e: fix build warnings
Message-ID: <1453348382-79870-1-git-send-email-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Eric Dumazet <edumazet@google.com>

Fixes following build warnings :

drivers/net/ethernet/intel/i40e/i40e_main.c:7057:13: warning:
'i40e_sync_udp_filters_subtask' defined but not used [-Wunused-function]
drivers/net/ethernet/intel/i40e/i40e_main.c:8524:13: warning:
'i40e_add_vxlan_port' defined but not used [-Wunused-function]
drivers/net/ethernet/intel/i40e/i40e_main.c:8569:13: warning:
'i40e_del_vxlan_port' defined but not used [-Wunused-function]
drivers/net/ethernet/intel/i40e/i40e_main.c:8604:13: warning:
'i40e_add_geneve_port' defined but not used [-Wunused-function]
drivers/net/ethernet/intel/i40e/i40e_main.c:8651:13: warning:
'i40e_del_geneve_port' defined but not used [-Wunused-function]

Fixes: 6a899024058d ("i40e: geneve tunnel offload support")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 530572f..06b2204 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -7124,9 +7124,7 @@ static void i40e_service_task(struct work_struct *work)
 	i40e_watchdog_subtask(pf);
 	i40e_fdir_reinit_subtask(pf);
 	i40e_sync_filters_subtask(pf);
-#if IS_ENABLED(CONFIG_VXLAN) || IS_ENABLED(CONFIG_GENEVE)
 	i40e_sync_udp_filters_subtask(pf);
-#endif
 	i40e_clean_adminq_subtask(pf);
 
 	i40e_service_event_complete(pf);
@@ -8604,6 +8602,8 @@ static u8 i40e_get_udp_port_idx(struct i40e_pf *pf, __be16 port)
 }
 
 #endif
+
+#if IS_ENABLED(CONFIG_VXLAN)
 /**
  * i40e_add_vxlan_port - Get notifications about VXLAN ports that come up
  * @netdev: This physical port's netdev
@@ -8613,7 +8613,6 @@ static u8 i40e_get_udp_port_idx(struct i40e_pf *pf, __be16 port)
 static void i40e_add_vxlan_port(struct net_device *netdev,
 				sa_family_t sa_family, __be16 port)
 {
-#if IS_ENABLED(CONFIG_VXLAN)
 	struct i40e_netdev_priv *np = netdev_priv(netdev);
 	struct i40e_vsi *vsi = np->vsi;
 	struct i40e_pf *pf = vsi->back;
@@ -8646,7 +8645,6 @@ static void i40e_add_vxlan_port(struct net_device *netdev,
 	pf->udp_ports[next_idx].type = I40E_AQC_TUNNEL_TYPE_VXLAN;
 	pf->pending_udp_bitmap |= BIT_ULL(next_idx);
 	pf->flags |= I40E_FLAG_UDP_FILTER_SYNC;
-#endif
 }
 
 /**
@@ -8658,7 +8656,6 @@ static void i40e_add_vxlan_port(struct net_device *netdev,
 static void i40e_del_vxlan_port(struct net_device *netdev,
 				sa_family_t sa_family, __be16 port)
 {
-#if IS_ENABLED(CONFIG_VXLAN)
 	struct i40e_netdev_priv *np = netdev_priv(netdev);
 	struct i40e_vsi *vsi = np->vsi;
 	struct i40e_pf *pf = vsi->back;
@@ -8681,9 +8678,10 @@ static void i40e_del_vxlan_port(struct net_device *netdev,
 		netdev_warn(netdev, "vxlan port %d was not found, not deleting\n",
 			    ntohs(port));
 	}
-#endif
 }
+#endif
 
+#if IS_ENABLED(CONFIG_GENEVE)
 /**
  * i40e_add_geneve_port - Get notifications about GENEVE ports that come up
  * @netdev: This physical port's netdev
@@ -8693,7 +8691,6 @@ static void i40e_del_vxlan_port(struct net_device *netdev,
 static void i40e_add_geneve_port(struct net_device *netdev,
 				 sa_family_t sa_family, __be16 port)
 {
-#if IS_ENABLED(CONFIG_GENEVE)
 	struct i40e_netdev_priv *np = netdev_priv(netdev);
 	struct i40e_vsi *vsi = np->vsi;
 	struct i40e_pf *pf = vsi->back;
@@ -8731,7 +8728,6 @@ static void i40e_add_geneve_port(struct net_device *netdev,
 	pf->flags |= I40E_FLAG_UDP_FILTER_SYNC;
 
 	dev_info(&pf->pdev->dev, "adding geneve port %d\n", ntohs(port));
-#endif
 }
 
 /**
@@ -8743,7 +8739,6 @@ static void i40e_add_geneve_port(struct net_device *netdev,
 static void i40e_del_geneve_port(struct net_device *netdev,
 				 sa_family_t sa_family, __be16 port)
 {
-#if IS_ENABLED(CONFIG_GENEVE)
 	struct i40e_netdev_priv *np = netdev_priv(netdev);
 	struct i40e_vsi *vsi = np->vsi;
 	struct i40e_pf *pf = vsi->back;
@@ -8772,8 +8767,8 @@ static void i40e_del_geneve_port(struct net_device *netdev,
 		netdev_warn(netdev, "geneve port %d was not found, not deleting\n",
 			    ntohs(port));
 	}
-#endif
 }
+#endif
 
 static int i40e_get_phys_port_id(struct net_device *netdev,
 				 struct netdev_phys_item_id *ppid)
-- 
2.5.0

