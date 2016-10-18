From: David Ahern <dsa@cumulusnetworks.com>
Date: Mon, 17 Oct 2016 19:15:49 -0700
Subject: [Intel-wired-lan] [PATCH net-next 07/11] mlxsw: Flip to the new dev
	walk API
In-Reply-To: <1476756953-30923-1-git-send-email-dsa@cumulusnetworks.com>
References: <1476756953-30923-1-git-send-email-dsa@cumulusnetworks.com>
Message-ID: <1476756953-30923-8-git-send-email-dsa@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Convert mlxsw users to new dev walk API. This is just a code conversion;
no functional change is intended.

Signed-off-by: David Ahern <dsa@cumulusnetworks.com>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c | 37 ++++++++++++++++----------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
index 43a5eddc2c11..99805fd3d110 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -3092,19 +3092,30 @@ static bool mlxsw_sp_port_dev_check(const struct net_device *dev)
 	return dev->netdev_ops == &mlxsw_sp_port_netdev_ops;
 }
 
+static int mlxsw_lower_dev_walk(struct net_device *lower_dev, void *data)
+{
+	struct mlxsw_sp_port **port = data;
+	int ret = 0;
+
+	if (mlxsw_sp_port_dev_check(lower_dev)) {
+		*port = netdev_priv(lower_dev);
+		ret = 1;
+	}
+
+	return ret;
+}
+
 static struct mlxsw_sp_port *mlxsw_sp_port_dev_lower_find(struct net_device *dev)
 {
-	struct net_device *lower_dev;
-	struct list_head *iter;
+	struct mlxsw_sp_port *port;
 
 	if (mlxsw_sp_port_dev_check(dev))
 		return netdev_priv(dev);
 
-	netdev_for_each_all_lower_dev(dev, lower_dev, iter) {
-		if (mlxsw_sp_port_dev_check(lower_dev))
-			return netdev_priv(lower_dev);
-	}
-	return NULL;
+	port = NULL;
+	netdev_walk_all_lower_dev(dev, mlxsw_lower_dev_walk, &port);
+
+	return port;
 }
 
 static struct mlxsw_sp *mlxsw_sp_lower_get(struct net_device *dev)
@@ -3117,17 +3128,15 @@ static struct mlxsw_sp *mlxsw_sp_lower_get(struct net_device *dev)
 
 static struct mlxsw_sp_port *mlxsw_sp_port_dev_lower_find_rcu(struct net_device *dev)
 {
-	struct net_device *lower_dev;
-	struct list_head *iter;
+	struct mlxsw_sp_port *port;
 
 	if (mlxsw_sp_port_dev_check(dev))
 		return netdev_priv(dev);
 
-	netdev_for_each_all_lower_dev_rcu(dev, lower_dev, iter) {
-		if (mlxsw_sp_port_dev_check(lower_dev))
-			return netdev_priv(lower_dev);
-	}
-	return NULL;
+	port = NULL;
+	netdev_walk_all_lower_dev_rcu(dev, mlxsw_lower_dev_walk, &port);
+
+	return port;
 }
 
 struct mlxsw_sp_port *mlxsw_sp_port_lower_dev_hold(struct net_device *dev)
-- 
2.1.4

