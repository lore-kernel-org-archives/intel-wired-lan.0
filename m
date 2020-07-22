From: Jakub Kicinski <kuba@kernel.org>
Date: Tue, 21 Jul 2020 18:27:13 -0700
Subject: [Intel-wired-lan] [PATCH net-next v1 4/7] selftests: net: add a
 test for shared UDP tunnel info tables
In-Reply-To: <20200722012716.2814777-1-kuba@kernel.org>
References: <20200722012716.2814777-1-kuba@kernel.org>
Message-ID: <20200722012716.2814777-5-kuba@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Add a test run of checks validating the shared UDP tunnel port
tables function as we expect.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../drivers/net/netdevsim/udp_tunnel_nic.sh   | 109 ++++++++++++++++++
 1 file changed, 109 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/netdevsim/udp_tunnel_nic.sh b/tools/testing/selftests/drivers/net/netdevsim/udp_tunnel_nic.sh
index ba1d53b9f815..9225133784af 100644
--- a/tools/testing/selftests/drivers/net/netdevsim/udp_tunnel_nic.sh
+++ b/tools/testing/selftests/drivers/net/netdevsim/udp_tunnel_nic.sh
@@ -775,6 +775,115 @@ for port in 0 1; do
     exp1=( 0 0 0 0 )
 done
 
+cleanup_nsim
+
+# shared port tables
+pfx="table sharing"
+
+echo $NSIM_ID > /sys/bus/netdevsim/new_device
+echo 0 > $NSIM_DEV_SYS/del_port
+
+echo 0 > $NSIM_DEV_DFS/udp_ports_open_only
+echo 1 > $NSIM_DEV_DFS/udp_ports_sleep
+echo 1 > $NSIM_DEV_DFS/udp_ports_shared
+
+old_netdevs=$(ls /sys/class/net)
+echo 1 > $NSIM_DEV_SYS/new_port
+NSIM_NETDEV=`get_netdev_name old_netdevs`
+old_netdevs=$(ls /sys/class/net)
+echo 2 > $NSIM_DEV_SYS/new_port
+NSIM_NETDEV2=`get_netdev_name old_netdevs`
+
+msg="VxLAN v4 devices"
+exp0=( `mke 4789 1` 0 0 0 )
+exp1=( 0 0 0 0 )
+new_vxlan vxlan0 4789 $NSIM_NETDEV
+new_vxlan vxlan1 4789 $NSIM_NETDEV2
+
+msg="VxLAN v4 devices go down"
+exp0=( 0 0 0 0 )
+ifconfig vxlan1 down
+ifconfig vxlan0 down
+check_tables
+
+for ifc in vxlan0 vxlan1; do
+    ifconfig $ifc up
+done
+
+msg="VxLAN v6 device"
+exp0=( `mke 4789 1` `mke 4790 1` 0 0 )
+new_vxlan vxlanC 4790 $NSIM_NETDEV 6
+
+msg="Geneve device"
+exp1=( `mke 6081 2` 0 0 0 )
+new_geneve gnv0 6081
+
+msg="NIC device goes down"
+ifconfig $NSIM_NETDEV down
+check_tables
+
+msg="NIC device goes up again"
+ifconfig $NSIM_NETDEV up
+check_tables
+
+for i in `seq 2`; do
+    msg="turn feature off - 1, rep $i"
+    ethtool -K $NSIM_NETDEV rx-udp_tunnel-port-offload off
+    check_tables
+
+    msg="turn feature off - 2, rep $i"
+    exp0=( 0 0 0 0 )
+    exp1=( 0 0 0 0 )
+    ethtool -K $NSIM_NETDEV2 rx-udp_tunnel-port-offload off
+    check_tables
+
+    msg="turn feature on - 1, rep $i"
+    exp0=( `mke 4789 1` `mke 4790 1` 0 0 )
+    exp1=( `mke 6081 2` 0 0 0 )
+    ethtool -K $NSIM_NETDEV rx-udp_tunnel-port-offload on
+    check_tables
+
+    msg="turn feature on - 2, rep $i"
+    ethtool -K $NSIM_NETDEV2 rx-udp_tunnel-port-offload on
+    check_tables
+done
+
+msg="tunnels destroyed 1"
+cleanup_tuns
+exp0=( 0 0 0 0 )
+exp1=( 0 0 0 0 )
+check_tables
+
+overflow_table0 "overflow NIC table"
+
+msg="re-add a port"
+
+echo 2 > $NSIM_DEV_SYS/del_port
+echo 2 > $NSIM_DEV_SYS/new_port
+check_tables
+
+msg="replace VxLAN in overflow table"
+exp0=( `mke 10000 1` `mke 10004 1` `mke 10002 1` `mke 10003 1` )
+del_dev vxlan1
+
+msg="vacate VxLAN in overflow table"
+exp0=( `mke 10000 1` `mke 10004 1` 0 `mke 10003 1` )
+del_dev vxlan2
+
+echo 1 > $NSIM_DEV_DFS/ports/$port/udp_ports_reset
+check_tables
+
+msg="tunnels destroyed 2"
+cleanup_tuns
+exp0=( 0 0 0 0 )
+exp1=( 0 0 0 0 )
+check_tables
+
+echo 1 > $NSIM_DEV_SYS/del_port
+echo 2 > $NSIM_DEV_SYS/del_port
+
+cleanup_nsim
+
 modprobe -r netdevsim
 
 if [ $num_errors -eq 0 ]; then
-- 
2.26.2

