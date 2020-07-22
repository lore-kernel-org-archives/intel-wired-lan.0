From: Jakub Kicinski <kuba@kernel.org>
Date: Tue, 21 Jul 2020 18:27:11 -0700
Subject: [Intel-wired-lan] [PATCH net-next v1 2/7] netdevsim: add warnings
 on unexpected UDP tunnel port errors
In-Reply-To: <20200722012716.2814777-1-kuba@kernel.org>
References: <20200722012716.2814777-1-kuba@kernel.org>
Message-ID: <20200722012716.2814777-3-kuba@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

We should never see a removal of a port which is not in the table
or adding a port to an occupied entry in the table. To make sure
such errors don't escape the checks in the test script add a
warning/kernel spat.

Error injection will not trigger those, nor should it ever put
us in a bad state.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/netdevsim/udp_tunnels.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/netdevsim/udp_tunnels.c b/drivers/net/netdevsim/udp_tunnels.c
index 22c06a76033c..ad65b860bd7b 100644
--- a/drivers/net/netdevsim/udp_tunnels.c
+++ b/drivers/net/netdevsim/udp_tunnels.c
@@ -22,11 +22,13 @@ nsim_udp_tunnel_set_port(struct net_device *dev, unsigned int table,
 		msleep(ns->udp_ports.sleep);
 
 	if (!ret) {
-		if (ns->udp_ports.ports[table][entry])
+		if (ns->udp_ports.ports[table][entry]) {
+			WARN(1, "entry already in use\n");
 			ret = -EBUSY;
-		else
+		} else {
 			ns->udp_ports.ports[table][entry] =
 				be16_to_cpu(ti->port) << 16 | ti->type;
+		}
 	}
 
 	netdev_info(dev, "set [%d, %d] type %d family %d port %d - %d\n",
@@ -50,10 +52,13 @@ nsim_udp_tunnel_unset_port(struct net_device *dev, unsigned int table,
 	if (!ret) {
 		u32 val = be16_to_cpu(ti->port) << 16 | ti->type;
 
-		if (val == ns->udp_ports.ports[table][entry])
+		if (val == ns->udp_ports.ports[table][entry]) {
 			ns->udp_ports.ports[table][entry] = 0;
-		else
+		} else {
+			WARN(1, "entry not installed %x vs %x\n",
+			     val, ns->udp_ports.ports[table][entry]);
 			ret = -ENOENT;
+		}
 	}
 
 	netdev_info(dev, "unset [%d, %d] type %d family %d port %d - %d\n",
-- 
2.26.2

