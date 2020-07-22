From: Jakub Kicinski <kuba@kernel.org>
Date: Tue, 21 Jul 2020 18:27:12 -0700
Subject: [Intel-wired-lan] [PATCH net-next v1 3/7] netdevsim: shared UDP
 tunnel port table support
In-Reply-To: <20200722012716.2814777-1-kuba@kernel.org>
References: <20200722012716.2814777-1-kuba@kernel.org>
Message-ID: <20200722012716.2814777-4-kuba@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Add the ability to simulate a device with a shared UDP tunnel port
table.

Try to reject the configurations and actions which are not supported
by the core, so we don't get syzcaller etc. warning reports.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/netdevsim/netdevsim.h   |  7 ++++++-
 drivers/net/netdevsim/udp_tunnels.c | 17 ++++++++++++++++-
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
index d164052e0393..4335ab4e5ce0 100644
--- a/drivers/net/netdevsim/netdevsim.h
+++ b/drivers/net/netdevsim/netdevsim.h
@@ -20,6 +20,7 @@
 #include <linux/netdevice.h>
 #include <linux/u64_stats_sync.h>
 #include <net/devlink.h>
+#include <net/udp_tunnel.h>
 #include <net/xdp.h>
 
 #define DRV_NAME	"netdevsim"
@@ -77,7 +78,8 @@ struct netdevsim {
 	struct {
 		u32 inject_error;
 		u32 sleep;
-		u32 ports[2][NSIM_UDP_TUNNEL_N_PORTS];
+		u32 __ports[2][NSIM_UDP_TUNNEL_N_PORTS];
+		u32 (*ports)[NSIM_UDP_TUNNEL_N_PORTS];
 		struct debugfs_u32_array dfs_ports[2];
 	} udp_ports;
 };
@@ -197,9 +199,12 @@ struct nsim_dev {
 	bool fail_trap_policer_set;
 	bool fail_trap_policer_counter_get;
 	struct {
+		struct udp_tunnel_nic_shared utn_shared;
+		u32 __ports[2][NSIM_UDP_TUNNEL_N_PORTS];
 		bool sync_all;
 		bool open_only;
 		bool ipv4_only;
+		bool shared;
 		u32 sleep;
 	} udp_ports;
 };
diff --git a/drivers/net/netdevsim/udp_tunnels.c b/drivers/net/netdevsim/udp_tunnels.c
index ad65b860bd7b..6b98e6d1188f 100644
--- a/drivers/net/netdevsim/udp_tunnels.c
+++ b/drivers/net/netdevsim/udp_tunnels.c
@@ -112,7 +112,7 @@ nsim_udp_tunnels_info_reset_write(struct file *file, const char __user *data,
 	struct net_device *dev = file->private_data;
 	struct netdevsim *ns = netdev_priv(dev);
 
-	memset(&ns->udp_ports.ports, 0, sizeof(ns->udp_ports.ports));
+	memset(ns->udp_ports.ports, 0, sizeof(ns->udp_ports.__ports));
 	rtnl_lock();
 	udp_tunnel_nic_reset_ntf(dev);
 	rtnl_unlock();
@@ -132,6 +132,17 @@ int nsim_udp_tunnels_info_create(struct nsim_dev *nsim_dev,
 	struct netdevsim *ns = netdev_priv(dev);
 	struct udp_tunnel_nic_info *info;
 
+	if (nsim_dev->udp_ports.shared && nsim_dev->udp_ports.open_only) {
+		dev_err(&nsim_dev->nsim_bus_dev->dev,
+			"shared can't be used in conjunction with open_only\n");
+		return -EINVAL;
+	}
+
+	if (!nsim_dev->udp_ports.shared)
+		ns->udp_ports.ports = ns->udp_ports.__ports;
+	else
+		ns->udp_ports.ports = nsim_dev->udp_ports.__ports;
+
 	debugfs_create_u32("udp_ports_inject_error", 0600,
 			   ns->nsim_dev_port->ddir,
 			   &ns->udp_ports.inject_error);
@@ -173,6 +184,8 @@ int nsim_udp_tunnels_info_create(struct nsim_dev *nsim_dev,
 		info->flags |= UDP_TUNNEL_NIC_INFO_OPEN_ONLY;
 	if (nsim_dev->udp_ports.ipv4_only)
 		info->flags |= UDP_TUNNEL_NIC_INFO_IPV4_ONLY;
+	if (nsim_dev->udp_ports.shared)
+		info->shared = &nsim_dev->udp_ports.utn_shared;
 
 	dev->udp_tunnel_nic_info = info;
 	return 0;
@@ -192,6 +205,8 @@ void nsim_udp_tunnels_debugfs_create(struct nsim_dev *nsim_dev)
 			    &nsim_dev->udp_ports.open_only);
 	debugfs_create_bool("udp_ports_ipv4_only", 0600, nsim_dev->ddir,
 			    &nsim_dev->udp_ports.ipv4_only);
+	debugfs_create_bool("udp_ports_shared", 0600, nsim_dev->ddir,
+			    &nsim_dev->udp_ports.shared);
 	debugfs_create_u32("udp_ports_sleep", 0600, nsim_dev->ddir,
 			   &nsim_dev->udp_ports.sleep);
 }
-- 
2.26.2

