From: Alexander Duyck <aduyck@mirantis.com>
Date: Wed, 15 Jun 2016 15:07:54 -0700
Subject: [Intel-wired-lan] [net-next PATCH v2 06/17] bnxt: Move GENEVE
 support from hard-coded port to using port notifier
In-Reply-To: <20160615220449.15575.17031.stgit@localhost.localdomain>
References: <20160615220449.15575.17031.stgit@localhost.localdomain>
Message-ID: <20160615220754.15575.94576.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The port number for GENEVE is hard coded into the bnxt driver.  This is the
kind of thing we want to avoid going forward.  For now I will integrate
this back into the port notifier so that we can change the GENEVE port
number if we need to in the future.

Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c |   36 ++++++++++++++++++++++++-----
 drivers/net/ethernet/broadcom/bnxt/bnxt.h |    3 ++
 2 files changed, 33 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index bb66091b7dd6..8755c554a61b 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -5071,13 +5071,8 @@ static int __bnxt_open_nic(struct bnxt *bp, bool irq_re_init, bool link_re_init)
 			netdev_warn(bp->dev, "failed to update phy settings\n");
 	}
 
-	if (irq_re_init) {
+	if (irq_re_init)
 		udp_tunnel_get_rx_info(bp->dev);
-		if (!bnxt_hwrm_tunnel_dst_port_alloc(
-				bp, htons(0x17c1),
-				TUNNEL_DST_PORT_FREE_REQ_TUNNEL_TYPE_GENEVE))
-			bp->nge_port_cnt = 1;
-	}
 
 	set_bit(BNXT_STATE_OPEN, &bp->state);
 	bnxt_enable_int(bp);
@@ -5670,6 +5665,15 @@ static void bnxt_sp_task(struct work_struct *work)
 		bnxt_hwrm_tunnel_dst_port_free(
 			bp, TUNNEL_DST_PORT_FREE_REQ_TUNNEL_TYPE_VXLAN);
 	}
+	if (test_and_clear_bit(BNXT_GENEVE_ADD_PORT_SP_EVENT, &bp->sp_event)) {
+		bnxt_hwrm_tunnel_dst_port_alloc(
+			bp, bp->nge_port,
+			TUNNEL_DST_PORT_FREE_REQ_TUNNEL_TYPE_GENEVE);
+	}
+	if (test_and_clear_bit(BNXT_GENEVE_DEL_PORT_SP_EVENT, &bp->sp_event)) {
+		bnxt_hwrm_tunnel_dst_port_free(
+			bp, TUNNEL_DST_PORT_FREE_REQ_TUNNEL_TYPE_GENEVE);
+	}
 	if (test_and_clear_bit(BNXT_RESET_TASK_SP_EVENT, &bp->sp_event)) {
 		/* bnxt_reset_task() calls bnxt_close_nic() which waits
 		 * for BNXT_STATE_IN_SP_TASK to clear.
@@ -6067,6 +6071,16 @@ static void bnxt_udp_tunnel_add(struct net_device *dev,
 			schedule_work(&bp->sp_task);
 		}
 		break;
+	case UDP_TUNNEL_TYPE_GENEVE:
+		if (bp->nge_port_cnt && bp->nge_port != ti->port)
+			return;
+
+		bp->nge_port_cnt++;
+		if (bp->nge_port_cnt == 1) {
+			bp->nge_port = ti->port;
+			set_bit(BNXT_GENEVE_ADD_PORT_SP_EVENT, &bp->sp_event);
+		}
+		break;
 	default:
 		return;
 	}
@@ -6096,6 +6110,16 @@ static void bnxt_udp_tunnel_del(struct net_device *dev,
 
 		set_bit(BNXT_VXLAN_DEL_PORT_SP_EVENT, &bp->sp_event);
 		break;
+	case UDP_TUNNEL_TYPE_GENEVE:
+		if (!bp->nge_port_cnt || bp->nge_port != ti->port)
+			return;
+		bp->nge_port_cnt--;
+
+		if (bp->nge_port_cnt != 0)
+			return;
+
+		set_bit(BNXT_GENEVE_DEL_PORT_SP_EVENT, &bp->sp_event);
+		break;
 	default:
 		return;
 	}
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 2824d65b2e35..9878c1db4402 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -991,6 +991,7 @@ struct bnxt {
 	__be16			vxlan_port;
 	u8			vxlan_port_cnt;
 	__le16			vxlan_fw_dst_port_id;
+	__be16			nge_port;
 	u8			nge_port_cnt;
 	__le16			nge_fw_dst_port_id;
 
@@ -1018,6 +1019,8 @@ struct bnxt {
 #define BNXT_HWRM_PF_UNLOAD_SP_EVENT	8
 #define BNXT_PERIODIC_STATS_SP_EVENT	9
 #define BNXT_HWRM_PORT_MODULE_SP_EVENT	10
+#define BNXT_GENEVE_ADD_PORT_SP_EVENT	11
+#define BNXT_GENEVE_DEL_PORT_SP_EVENT	12
 
 	struct bnxt_pf_info	pf;
 #ifdef CONFIG_BNXT_SRIOV

