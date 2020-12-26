From: Joe Perches <joe@perches.com>
Date: Sat, 26 Dec 2020 09:10:53 -0800
Subject: [Intel-wired-lan] [PATCH] ethernet: Remove invalid trailers after
 %pI4
Message-ID: <d1ea50ed47e2e9ca65a67ffc2ca0eee08e662132.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Alphanumeric characters after vsprintf pointer extension %pI4 are
not valid and are not emitted.

Remove the invalid characters from the %pI4 uses.

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c          | 6 +++---
 drivers/net/ethernet/intel/i40e/i40e_main.c           | 4 ++--
 drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c | 2 +-
 drivers/net/ethernet/qlogic/qed/qed_iwarp.c           | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c
index 5e4429b14b8c..213cbdea3888 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c
@@ -1232,7 +1232,7 @@ static int bnxt_tc_resolve_tunnel_hdrs(struct bnxt *bp,
 
 	rt = ip_route_output_key(dev_net(real_dst_dev), &flow);
 	if (IS_ERR(rt)) {
-		netdev_info(bp->dev, "no route to %pI4b\n", &flow.daddr);
+		netdev_info(bp->dev, "no route to %pI4\n", &flow.daddr);
 		return -EOPNOTSUPP;
 	}
 
@@ -1258,7 +1258,7 @@ static int bnxt_tc_resolve_tunnel_hdrs(struct bnxt *bp,
 #endif
 	} else if (dst_dev != real_dst_dev) {
 		netdev_info(bp->dev,
-			    "dst_dev(%s) for %pI4b is not PF-if(%s)\n",
+			    "dst_dev(%s) for %pI4 is not PF-if(%s)\n",
 			    netdev_name(dst_dev), &flow.daddr,
 			    netdev_name(real_dst_dev));
 		rc = -EOPNOTSUPP;
@@ -1267,7 +1267,7 @@ static int bnxt_tc_resolve_tunnel_hdrs(struct bnxt *bp,
 
 	nbr = dst_neigh_lookup(&rt->dst, &flow.daddr);
 	if (!nbr) {
-		netdev_info(bp->dev, "can't lookup neighbor for %pI4b\n",
+		netdev_info(bp->dev, "can't lookup neighbor for %pI4\n",
 			    &flow.daddr);
 		rc = -EOPNOTSUPP;
 		goto put_rt;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 1db482d310c2..eab6ce63b63d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -7924,7 +7924,7 @@ static int i40e_parse_cls_flower(struct i40e_vsi *vsi,
 			if (match.mask->dst == cpu_to_be32(0xffffffff)) {
 				field_flags |= I40E_CLOUD_FIELD_IIP;
 			} else {
-				dev_err(&pf->pdev->dev, "Bad ip dst mask %pI4b\n",
+				dev_err(&pf->pdev->dev, "Bad ip dst mask %pI4\n",
 					&match.mask->dst);
 				return I40E_ERR_CONFIG;
 			}
@@ -7934,7 +7934,7 @@ static int i40e_parse_cls_flower(struct i40e_vsi *vsi,
 			if (match.mask->src == cpu_to_be32(0xffffffff)) {
 				field_flags |= I40E_CLOUD_FIELD_IIP;
 			} else {
-				dev_err(&pf->pdev->dev, "Bad ip src mask %pI4b\n",
+				dev_err(&pf->pdev->dev, "Bad ip src mask %pI4\n",
 					&match.mask->src);
 				return I40E_ERR_CONFIG;
 			}
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
index 41424ee909a0..6c711385aae9 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
@@ -2297,7 +2297,7 @@ static void mlxsw_sp_router_neigh_ent_ipv4_process(struct mlxsw_sp *mlxsw_sp,
 	if (!n)
 		return;
 
-	netdev_dbg(dev, "Updating neighbour with IP=%pI4h\n", &dip);
+	netdev_dbg(dev, "Updating neighbour with IP=%pI4\n", &dip);
 	neigh_event_send(n, NULL);
 	neigh_release(n);
 }
diff --git a/drivers/net/ethernet/qlogic/qed/qed_iwarp.c b/drivers/net/ethernet/qlogic/qed/qed_iwarp.c
index a99861124630..6756f7919deb 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_iwarp.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_iwarp.c
@@ -584,7 +584,7 @@ qed_iwarp_print_tcp_ramrod(struct qed_hwfn *p_hwfn,
 
 	if (p_tcp_ramrod->tcp.ip_version == TCP_IPV4) {
 		DP_VERBOSE(p_hwfn, QED_MSG_RDMA,
-			   "local_ip=%pI4h:%x, remote_ip=%pI4h:%x, vlan=%x\n",
+			   "local_ip=%pI4:%x, remote_ip=%pI4:%x, vlan=%x\n",
 			   p_tcp_ramrod->tcp.local_ip,
 			   p_tcp_ramrod->tcp.local_port,
 			   p_tcp_ramrod->tcp.remote_ip,
@@ -1548,7 +1548,7 @@ qed_iwarp_print_cm_info(struct qed_hwfn *p_hwfn,
 
 	if (cm_info->ip_version == QED_TCP_IPV4)
 		DP_VERBOSE(p_hwfn, QED_MSG_RDMA,
-			   "remote_ip %pI4h:%x, local_ip %pI4h:%x vlan=%x\n",
+			   "remote_ip %pI4:%x, local_ip %pI4:%x vlan=%x\n",
 			   cm_info->remote_ip, cm_info->remote_port,
 			   cm_info->local_ip, cm_info->local_port,
 			   cm_info->vlan);


