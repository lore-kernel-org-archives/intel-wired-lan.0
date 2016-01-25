From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Mon, 25 Jan 2016 11:40:51 +0530
Subject: [Intel-wired-lan] [PATCH 1/3] i40e: fix build warning
Message-ID: <1453702251-464-1-git-send-email-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

While building we are getting warning about:
i40e_main.c:8604:13: warning: 'i40e_add_geneve_port' defined but not used
and
i40e_main.c:8651:13: warning: 'i40e_del_geneve_port' defined but not used

The contents of these functions are defined under CONFIG_GENEVE, so if
CONFIG_GENEVE is not defined then we are having unused empty functions.
Lets have these functions under CONFIG_GENEVE as the callback is already
defined under CONFIG_GENEVE there is no chance of any failure.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index bb4612c..c258697 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -8595,6 +8595,7 @@ static void i40e_del_vxlan_port(struct net_device *netdev,
 #endif
 }
 
+#if IS_ENABLED(CONFIG_GENEVE)
 /**
  * i40e_add_geneve_port - Get notifications about GENEVE ports that come up
  * @netdev: This physical port's netdev
@@ -8604,7 +8605,6 @@ static void i40e_del_vxlan_port(struct net_device *netdev,
 static void i40e_add_geneve_port(struct net_device *netdev,
 				 sa_family_t sa_family, __be16 port)
 {
-#if IS_ENABLED(CONFIG_GENEVE)
 	struct i40e_netdev_priv *np = netdev_priv(netdev);
 	struct i40e_vsi *vsi = np->vsi;
 	struct i40e_pf *pf = vsi->back;
@@ -8639,7 +8639,6 @@ static void i40e_add_geneve_port(struct net_device *netdev,
 	pf->flags |= I40E_FLAG_UDP_FILTER_SYNC;
 
 	dev_info(&pf->pdev->dev, "adding geneve port %d\n", ntohs(port));
-#endif
 }
 
 /**
@@ -8651,7 +8650,6 @@ static void i40e_add_geneve_port(struct net_device *netdev,
 static void i40e_del_geneve_port(struct net_device *netdev,
 				 sa_family_t sa_family, __be16 port)
 {
-#if IS_ENABLED(CONFIG_GENEVE)
 	struct i40e_netdev_priv *np = netdev_priv(netdev);
 	struct i40e_vsi *vsi = np->vsi;
 	struct i40e_pf *pf = vsi->back;
@@ -8677,8 +8675,8 @@ static void i40e_del_geneve_port(struct net_device *netdev,
 		netdev_warn(netdev, "geneve port %d was not found, not deleting\n",
 			    ntohs(port));
 	}
-#endif
 }
+#endif
 
 static int i40e_get_phys_port_id(struct net_device *netdev,
 				 struct netdev_phys_item_id *ppid)
-- 
1.9.1

