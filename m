From: Serhey Popovych <serhe.popovych@gmail.com>
Date: Thu, 29 Mar 2018 17:51:36 +0300
Subject: [Intel-wired-lan] [PATCH next-queue] intel: correct return from set
 features callback
Message-ID: <1522335096-11689-1-git-send-email-serhe.popovych@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

According to comments in <linux/netdevice.h> we should return either >0
or -errno from ->ndo_set_features() if changing dev->features by itself.

Return 1 in such places to notify netdev_update_features() about applied
changes in dev->features.

Signed-off-by: Serhey Popovych <serhe.popovych@gmail.com>
---
 drivers/net/ethernet/intel/e100.c             | 2 +-
 drivers/net/ethernet/intel/e1000/e1000_main.c | 2 +-
 drivers/net/ethernet/intel/e1000e/netdev.c    | 2 +-
 drivers/net/ethernet/intel/igb/igb_main.c     | 2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/e100.c b/drivers/net/ethernet/intel/e100.c
index 41ad56e..27fa59b 100644
--- a/drivers/net/ethernet/intel/e100.c
+++ b/drivers/net/ethernet/intel/e100.c
@@ -2821,7 +2821,7 @@ static int e100_set_features(struct net_device *netdev,
 
 	netdev->features = features;
 	e100_exec_cb(nic, NULL, e100_configure);
-	return 0;
+	return 1;
 }
 
 static const struct net_device_ops e100_netdev_ops = {
diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/ethernet/intel/e1000/e1000_main.c
index d5eb19b..7068b82 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_main.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
@@ -846,7 +846,7 @@ static int e1000_set_features(struct net_device *netdev,
 	else
 		e1000_reset(adapter);
 
-	return 0;
+	return 1;
 }
 
 static const struct net_device_ops e1000_netdev_ops = {
diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index ec4a975..e4cd14d 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -7007,7 +7007,7 @@ static int e1000_set_features(struct net_device *netdev,
 	else
 		e1000e_reset(adapter);
 
-	return 0;
+	return 1;
 }
 
 static const struct net_device_ops e1000e_netdev_ops = {
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index c1c0bc3..dbf9294 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -2409,7 +2409,7 @@ static int igb_set_features(struct net_device *netdev,
 	else
 		igb_reset(adapter);
 
-	return 0;
+	return 1;
 }
 
 static int igb_ndo_fdb_add(struct ndmsg *ndm, struct nlattr *tb[],
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index afadba9..3b21eb6 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -9530,7 +9530,7 @@ static int ixgbe_set_features(struct net_device *netdev,
 			    NETIF_F_HW_VLAN_CTAG_FILTER))
 		ixgbe_set_rx_mode(netdev);
 
-	return 0;
+	return 1;
 }
 
 /**
-- 
1.8.3.1

