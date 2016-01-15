From: Alexander Duyck <aduyck@mirantis.com>
Date: Thu, 14 Jan 2016 20:42:09 -0800
Subject: [Intel-wired-lan] [next PATCH 3/3] i40e: Fix build warnings when
	geneve is not enabled
In-Reply-To: <20160115043921.24270.62791.stgit@localhost.localdomain>
References: <20160115043921.24270.62791.stgit@localhost.localdomain>
Message-ID: <20160115044209.24270.5939.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

My default config didn't have geneve enabled.  As a result I was getting
warnings about the port functions being defined but not used.

Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index a15ab5fd3bd7..d35e6d62f659 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -8664,6 +8664,7 @@ static void i40e_del_vxlan_port(struct net_device *netdev,
 #endif
 }
 
+#if IS_ENABLED(CONFIG_GENEVE)
 /**
  * i40e_add_geneve_port - Get notifications about GENEVE ports that come up
  * @netdev: This physical port's netdev
@@ -8673,7 +8674,6 @@ static void i40e_del_vxlan_port(struct net_device *netdev,
 static void i40e_add_geneve_port(struct net_device *netdev,
 				 sa_family_t sa_family, __be16 port)
 {
-#if IS_ENABLED(CONFIG_GENEVE)
 	struct i40e_netdev_priv *np = netdev_priv(netdev);
 	struct i40e_vsi *vsi = np->vsi;
 	struct i40e_pf *pf = vsi->back;
@@ -8708,7 +8708,6 @@ static void i40e_add_geneve_port(struct net_device *netdev,
 	pf->flags |= I40E_FLAG_UDP_FILTER_SYNC;
 
 	dev_info(&pf->pdev->dev, "adding geneve port %d\n", ntohs(port));
-#endif
 }
 
 /**
@@ -8720,7 +8719,6 @@ static void i40e_add_geneve_port(struct net_device *netdev,
 static void i40e_del_geneve_port(struct net_device *netdev,
 				 sa_family_t sa_family, __be16 port)
 {
-#if IS_ENABLED(CONFIG_GENEVE)
 	struct i40e_netdev_priv *np = netdev_priv(netdev);
 	struct i40e_vsi *vsi = np->vsi;
 	struct i40e_pf *pf = vsi->back;
@@ -8746,8 +8744,8 @@ static void i40e_del_geneve_port(struct net_device *netdev,
 		netdev_warn(netdev, "geneve port %d was not found, not deleting\n",
 			    ntohs(port));
 	}
-#endif
 }
+#endif
 
 static int i40e_get_phys_port_id(struct net_device *netdev,
 				 struct netdev_phys_item_id *ppid)

