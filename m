From: Alice Michael <alice.michael@intel.com>
Date: Fri, 16 Mar 2018 01:26:31 -0700
Subject: [Intel-wired-lan] [next PATCH S89 2/8] i40e: move
 I40E_FLAG_UDP_FILTER_SYNC to the state field
In-Reply-To: <20180316082637.49915-1-alice.michael@intel.com>
References: <20180316082637.49915-1-alice.michael@intel.com>
Message-ID: <20180316082637.49915-2-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

This flag is modified during run time, possibly even when the RTNL lock
is not held. Additionally it has a few places which should be using
test_and_set or test_and_clear atomic bit operations.

Create a new state bit __I40E_UDP_SYNC_PENDING and use it instead of the
ole I40E_FLAG_UDP_FILTER_SYNC flag.

This is part of a larger effort to remove the need for using cmpxchg64
in i40e_set_priv_flags.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h      |  3 ++-
 drivers/net/ethernet/intel/i40e/i40e_main.c | 10 ++++------
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index e83fb37..ff309501 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -163,6 +163,7 @@ enum i40e_state_t {
 	__I40E_PORT_SUSPENDED,
 	__I40E_VF_DISABLE,
 	__I40E_MACVLAN_SYNC_PENDING,
+	__I40E_UDP_FILTER_SYNC_PENDING,
 	/* This must be last as it determines the size of the BITMAP */
 	__I40E_STATE_SIZE__,
 };
@@ -526,7 +527,7 @@ struct i40e_pf {
 #define I40E_FLAG_FD_SB_AUTO_DISABLED		BIT_ULL(11)
 #define I40E_FLAG_FD_ATR_AUTO_DISABLED		BIT_ULL(12)
 #define I40E_FLAG_MFP_ENABLED			BIT_ULL(13)
-#define I40E_FLAG_UDP_FILTER_SYNC		BIT_ULL(14)
+/* Gap for BIT_ULL(14) */
 #define I40E_FLAG_HW_ATR_EVICT_ENABLED		BIT_ULL(15)
 #define I40E_FLAG_VEB_MODE_ENABLED		BIT_ULL(16)
 #define I40E_FLAG_VEB_STATS_ENABLED		BIT_ULL(17)
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index e96c22a..a24f99a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -9721,7 +9721,7 @@ static void i40e_sync_udp_filters(struct i40e_pf *pf)
 			pf->pending_udp_bitmap |= BIT_ULL(i);
 	}
 
-	pf->flags |= I40E_FLAG_UDP_FILTER_SYNC;
+	set_bit(__I40E_UDP_FILTER_SYNC_PENDING, pf->state);
 }
 
 /**
@@ -9735,11 +9735,9 @@ static void i40e_sync_udp_filters_subtask(struct i40e_pf *pf)
 	u16 port;
 	int i;
 
-	if (!(pf->flags & I40E_FLAG_UDP_FILTER_SYNC))
+	if (!test_and_clear_bit(__I40E_UDP_FILTER_SYNC_PENDING, pf->state))
 		return;
 
-	pf->flags &= ~I40E_FLAG_UDP_FILTER_SYNC;
-
 	for (i = 0; i < I40E_MAX_PF_UDP_OFFLOAD_PORTS; i++) {
 		if (pf->pending_udp_bitmap & BIT_ULL(i)) {
 			pf->pending_udp_bitmap &= ~BIT_ULL(i);
@@ -11439,7 +11437,7 @@ static void i40e_udp_tunnel_add(struct net_device *netdev,
 	/* New port: add it and mark its index in the bitmap */
 	pf->udp_ports[next_idx].port = port;
 	pf->pending_udp_bitmap |= BIT_ULL(next_idx);
-	pf->flags |= I40E_FLAG_UDP_FILTER_SYNC;
+	set_bit(__I40E_UDP_FILTER_SYNC_PENDING, pf->state);
 }
 
 /**
@@ -11480,7 +11478,7 @@ static void i40e_udp_tunnel_del(struct net_device *netdev,
 	 */
 	pf->udp_ports[idx].port = 0;
 	pf->pending_udp_bitmap |= BIT_ULL(idx);
-	pf->flags |= I40E_FLAG_UDP_FILTER_SYNC;
+	set_bit(__I40E_UDP_FILTER_SYNC_PENDING, pf->state);
 
 	return;
 not_found:
-- 
2.9.5

