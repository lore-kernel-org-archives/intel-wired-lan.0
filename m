From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri, 15 May 2020 17:36:38 -0700
Subject: [Intel-wired-lan] [PATCH S43 09/15] ice: fix signed vs unsigned
 comparisons
In-Reply-To: <20200516003644.4658-1-anthony.l.nguyen@intel.com>
References: <20200516003644.4658-1-anthony.l.nguyen@intel.com>
Message-ID: <20200516003644.4658-9-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

Fix the remaining signed vs unsigned issues, which appear
when compiling with -Werror=sign-compare.

Many of these are because there is an external interface that is passing
an int to us (which we can't change) but that we (rightfully) store
and compare against as an unsigned in our data structures.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_base.c | 4 ++--
 drivers/net/ethernet/intel/ice/ice_main.c | 8 ++++----
 drivers/net/ethernet/intel/ice/ice_txrx.h | 7 ++++---
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
index 00c072f61a32..ff6a5cf8e06f 100644
--- a/drivers/net/ethernet/intel/ice/ice_base.c
+++ b/drivers/net/ethernet/intel/ice/ice_base.c
@@ -12,7 +12,7 @@
  */
 static int __ice_vsi_get_qs_contig(struct ice_qs_cfg *qs_cfg)
 {
-	int offset, i;
+	unsigned int offset, i;
 
 	mutex_lock(qs_cfg->qs_mutex);
 	offset = bitmap_find_next_zero_area(qs_cfg->pf_map, qs_cfg->pf_map_size,
@@ -38,7 +38,7 @@ static int __ice_vsi_get_qs_contig(struct ice_qs_cfg *qs_cfg)
  */
 static int __ice_vsi_get_qs_sc(struct ice_qs_cfg *qs_cfg)
 {
-	int i, index = 0;
+	unsigned int i, index = 0;
 
 	mutex_lock(qs_cfg->qs_mutex);
 	for (i = 0; i < qs_cfg->q_count; i++) {
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index e12413ec2504..e451120d6632 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5107,7 +5107,7 @@ static int ice_change_mtu(struct net_device *netdev, int new_mtu)
 	u8 count = 0;
 	int err = 0;
 
-	if (new_mtu == netdev->mtu) {
+	if (new_mtu == (int)netdev->mtu) {
 		netdev_warn(netdev, "MTU is already %u\n", netdev->mtu);
 		return 0;
 	}
@@ -5122,11 +5122,11 @@ static int ice_change_mtu(struct net_device *netdev, int new_mtu)
 		}
 	}
 
-	if (new_mtu < netdev->min_mtu) {
+	if (new_mtu < (int)netdev->min_mtu) {
 		netdev_err(netdev, "new MTU invalid. min_mtu is %d\n",
 			   netdev->min_mtu);
 		return -EINVAL;
-	} else if (new_mtu > netdev->max_mtu) {
+	} else if (new_mtu > (int)netdev->max_mtu) {
 		netdev_err(netdev, "new MTU invalid. max_mtu is %d\n",
 			   netdev->min_mtu);
 		return -EINVAL;
@@ -5151,7 +5151,7 @@ static int ice_change_mtu(struct net_device *netdev, int new_mtu)
 	if (!event)
 		return -ENOMEM;
 
-	netdev->mtu = new_mtu;
+	netdev->mtu = (unsigned int)new_mtu;
 
 	/* if VSI is up, bring it down and then back up */
 	if (!test_and_set_bit(__ICE_DOWN, vsi->state)) {
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.h b/drivers/net/ethernet/intel/ice/ice_txrx.h
index 7c4030caeea4..4a8006e80f65 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.h
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.h
@@ -38,7 +38,8 @@
  */
 #if (PAGE_SIZE < 8192)
 #define ICE_2K_TOO_SMALL_WITH_PADDING \
-((NET_SKB_PAD + ICE_RXBUF_1536) > SKB_WITH_OVERHEAD(ICE_RXBUF_2048))
+	((unsigned int)(NET_SKB_PAD + ICE_RXBUF_1536) > \
+			SKB_WITH_OVERHEAD(ICE_RXBUF_2048))
 
 /**
  * ice_compute_pad - compute the padding
@@ -107,8 +108,8 @@ static inline int ice_skb_pad(void)
 #define DESC_NEEDED (MAX_SKB_FRAGS + ICE_DESCS_FOR_CTX_DESC + \
 		     ICE_DESCS_PER_CACHE_LINE + ICE_DESCS_FOR_SKB_DATA_PTR)
 #define ICE_DESC_UNUSED(R)	\
-	((((R)->next_to_clean > (R)->next_to_use) ? 0 : (R)->count) + \
-	(R)->next_to_clean - (R)->next_to_use - 1)
+	(u16)((((R)->next_to_clean > (R)->next_to_use) ? 0 : (R)->count) + \
+	      (R)->next_to_clean - (R)->next_to_use - 1)
 
 #define ICE_TX_FLAGS_TSO	BIT(0)
 #define ICE_TX_FLAGS_HW_VLAN	BIT(1)
-- 
2.20.1

