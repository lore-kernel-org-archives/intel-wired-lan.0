From: Leon Romanovsky <leon@kernel.org>
Date: Sat, 25 Sep 2021 14:22:44 +0300
Subject: [Intel-wired-lan] [PATCH net-next v1 04/21] dpaa2-eth: Register
 devlink instance at the end of probe
In-Reply-To: <cover.1632565508.git.leonro@nvidia.com>
References: <cover.1632565508.git.leonro@nvidia.com>
Message-ID: <c6abd202014523d6e685a97c0ec844d2756ffd34.1632565508.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Leon Romanovsky <leonro@nvidia.com>

Move devlink_register to be the last command in the initialization
sequence.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 .../ethernet/freescale/dpaa2/dpaa2-eth-devlink.c   | 14 +++++++++++---
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c   |  9 ++++++---
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.h   |  5 ++++-
 3 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth-devlink.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth-devlink.c
index 426926fb6fc6..7fefe1574b6a 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth-devlink.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth-devlink.c
@@ -189,7 +189,7 @@ static const struct devlink_ops dpaa2_eth_devlink_ops = {
 	.trap_group_action_set = dpaa2_eth_dl_trap_group_action_set,
 };
 
-int dpaa2_eth_dl_register(struct dpaa2_eth_priv *priv)
+int dpaa2_eth_dl_alloc(struct dpaa2_eth_priv *priv)
 {
 	struct net_device *net_dev = priv->net_dev;
 	struct device *dev = net_dev->dev.parent;
@@ -203,15 +203,23 @@ int dpaa2_eth_dl_register(struct dpaa2_eth_priv *priv)
 	}
 	dl_priv = devlink_priv(priv->devlink);
 	dl_priv->dpaa2_priv = priv;
+	return 0;
+}
+
+void dpaa2_eth_dl_free(struct dpaa2_eth_priv *priv)
+{
+	devlink_free(priv->devlink);
+}
+
 
+void dpaa2_eth_dl_register(struct dpaa2_eth_priv *priv)
+{
 	devlink_register(priv->devlink);
-	return 0;
 }
 
 void dpaa2_eth_dl_unregister(struct dpaa2_eth_priv *priv)
 {
 	devlink_unregister(priv->devlink);
-	devlink_free(priv->devlink);
 }
 
 int dpaa2_eth_dl_port_add(struct dpaa2_eth_priv *priv)
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
index 7065c71ed7b8..03c168b1712f 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
@@ -4431,7 +4431,7 @@ static int dpaa2_eth_probe(struct fsl_mc_device *dpni_dev)
 	if (err)
 		goto err_connect_mac;
 
-	err = dpaa2_eth_dl_register(priv);
+	err = dpaa2_eth_dl_alloc(priv);
 	if (err)
 		goto err_dl_register;
 
@@ -4453,6 +4453,7 @@ static int dpaa2_eth_probe(struct fsl_mc_device *dpni_dev)
 	dpaa2_dbg_add(priv);
 #endif
 
+	dpaa2_eth_dl_register(priv);
 	dev_info(dev, "Probed interface %s\n", net_dev->name);
 	return 0;
 
@@ -4461,7 +4462,7 @@ static int dpaa2_eth_probe(struct fsl_mc_device *dpni_dev)
 err_dl_port_add:
 	dpaa2_eth_dl_traps_unregister(priv);
 err_dl_trap_register:
-	dpaa2_eth_dl_unregister(priv);
+	dpaa2_eth_dl_free(priv);
 err_dl_register:
 	dpaa2_eth_disconnect_mac(priv);
 err_connect_mac:
@@ -4508,6 +4509,8 @@ static int dpaa2_eth_remove(struct fsl_mc_device *ls_dev)
 	net_dev = dev_get_drvdata(dev);
 	priv = netdev_priv(net_dev);
 
+	dpaa2_eth_dl_unregister(priv);
+
 #ifdef CONFIG_DEBUG_FS
 	dpaa2_dbg_remove(priv);
 #endif
@@ -4519,7 +4522,7 @@ static int dpaa2_eth_remove(struct fsl_mc_device *ls_dev)
 
 	dpaa2_eth_dl_port_del(priv);
 	dpaa2_eth_dl_traps_unregister(priv);
-	dpaa2_eth_dl_unregister(priv);
+	dpaa2_eth_dl_free(priv);
 
 	if (priv->do_link_poll)
 		kthread_stop(priv->poll_thread);
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.h b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.h
index cdb623d5f2c1..628d2d45f045 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.h
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.h
@@ -725,7 +725,10 @@ void dpaa2_eth_set_rx_taildrop(struct dpaa2_eth_priv *priv,
 
 extern const struct dcbnl_rtnl_ops dpaa2_eth_dcbnl_ops;
 
-int dpaa2_eth_dl_register(struct dpaa2_eth_priv *priv);
+int dpaa2_eth_dl_alloc(struct dpaa2_eth_priv *priv);
+void dpaa2_eth_dl_free(struct dpaa2_eth_priv *priv);
+
+void dpaa2_eth_dl_register(struct dpaa2_eth_priv *priv);
 void dpaa2_eth_dl_unregister(struct dpaa2_eth_priv *priv);
 
 int dpaa2_eth_dl_port_add(struct dpaa2_eth_priv *priv);
-- 
2.31.1

