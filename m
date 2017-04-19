From: Alice Michael <alice.michael@intel.com>
Date: Wed, 19 Apr 2017 09:25:50 -0400
Subject: [Intel-wired-lan] [next PATCH S71 01/10] i40e: rename index to port
	to avoid confusion
Message-ID: <20170419132559.20459-1-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

The .index field of i40e_udp_port_config represents the udp port number.
Rename this variable to port so that it is more obvious.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h      |  2 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 70f9458..0f22c03 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -245,7 +245,7 @@ struct i40e_tc_configuration {
 
 struct i40e_udp_port_config {
 	/* AdminQ command interface expects port number in Host byte order */
-	u16 index;
+	u16 port;
 	u8 type;
 };
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 8f47a31..0630442 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -7349,7 +7349,7 @@ static void i40e_sync_udp_filters_subtask(struct i40e_pf *pf)
 	for (i = 0; i < I40E_MAX_PF_UDP_OFFLOAD_PORTS; i++) {
 		if (pf->pending_udp_bitmap & BIT_ULL(i)) {
 			pf->pending_udp_bitmap &= ~BIT_ULL(i);
-			port = pf->udp_ports[i].index;
+			port = pf->udp_ports[i].port;
 			if (port)
 				ret = i40e_aq_add_udp_tunnel(hw, port,
 							pf->udp_ports[i].type,
@@ -7366,7 +7366,7 @@ static void i40e_sync_udp_filters_subtask(struct i40e_pf *pf)
 					i40e_stat_str(&pf->hw, ret),
 					i40e_aq_str(&pf->hw,
 						    pf->hw.aq.asq_last_status));
-				pf->udp_ports[i].index = 0;
+				pf->udp_ports[i].port = 0;
 			}
 		}
 	}
@@ -8953,7 +8953,7 @@ static u8 i40e_get_udp_port_idx(struct i40e_pf *pf, u16 port)
 	u8 i;
 
 	for (i = 0; i < I40E_MAX_PF_UDP_OFFLOAD_PORTS; i++) {
-		if (pf->udp_ports[i].index == port)
+		if (pf->udp_ports[i].port == port)
 			return i;
 	}
 
@@ -9006,7 +9006,7 @@ static void i40e_udp_tunnel_add(struct net_device *netdev,
 	}
 
 	/* New port: add it and mark its index in the bitmap */
-	pf->udp_ports[next_idx].index = port;
+	pf->udp_ports[next_idx].port = port;
 	pf->pending_udp_bitmap |= BIT_ULL(next_idx);
 	pf->flags |= I40E_FLAG_UDP_FILTER_SYNC;
 }
@@ -9047,7 +9047,7 @@ static void i40e_udp_tunnel_del(struct net_device *netdev,
 	/* if port exists, set it to 0 (mark for deletion)
 	 * and make it pending
 	 */
-	pf->udp_ports[idx].index = 0;
+	pf->udp_ports[idx].port = 0;
 	pf->pending_udp_bitmap |= BIT_ULL(idx);
 	pf->flags |= I40E_FLAG_UDP_FILTER_SYNC;
 
-- 
2.9.3

