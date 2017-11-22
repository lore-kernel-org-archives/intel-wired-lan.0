From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 22 Nov 2017 10:56:28 -0800
Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH 03/16] ixgbe: Add
 support for macvlan offload RSS on X550 and clean-up pool handling
In-Reply-To: <20171122185256.29785.93548.stgit@localhost.localdomain>
References: <20171122185256.29785.93548.stgit@localhost.localdomain>
Message-ID: <20171122185628.29785.72704.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alexander Duyck <alexander.h.duyck@intel.com>

In order for RSS to work on the macvlan pools of the X550 we need to
populate the MRQC, RETA, and RSS key values for each pool. This patch makes
it so that we now take care of that.

In addition I have dropped the macvlan specific configuration of psrtype
since it is redundant with the code that already exists for configuring
this value.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   62 ++++++++++---------------
 1 file changed, 25 insertions(+), 37 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 9c6d4926a136..060474747ecc 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -3844,16 +3844,20 @@ static void ixgbe_store_vfreta(struct ixgbe_adapter *adapter)
 	u32 i, reta_entries = ixgbe_rss_indir_tbl_entries(adapter);
 	struct ixgbe_hw *hw = &adapter->hw;
 	u32 vfreta = 0;
-	unsigned int pf_pool = adapter->num_vfs;
 
 	/* Write redirection table to HW */
 	for (i = 0; i < reta_entries; i++) {
+		u16 pool = adapter->num_rx_pools;
+
 		vfreta |= (u32)adapter->rss_indir_tbl[i] << (i & 0x3) * 8;
-		if ((i & 3) == 3) {
-			IXGBE_WRITE_REG(hw, IXGBE_PFVFRETA(i >> 2, pf_pool),
+		if ((i & 3) != 3)
+			continue;
+
+		while (pool--)
+			IXGBE_WRITE_REG(hw,
+					IXGBE_PFVFRETA(i >> 2, VMDQ_P(pool)),
 					vfreta);
-			vfreta = 0;
-		}
+		vfreta = 0;
 	}
 }
 
@@ -3890,13 +3894,17 @@ static void ixgbe_setup_vfreta(struct ixgbe_adapter *adapter)
 {
 	struct ixgbe_hw *hw = &adapter->hw;
 	u16 rss_i = adapter->ring_feature[RING_F_RSS].indices;
-	unsigned int pf_pool = adapter->num_vfs;
 	int i, j;
 
 	/* Fill out hash function seeds */
-	for (i = 0; i < 10; i++)
-		IXGBE_WRITE_REG(hw, IXGBE_PFVFRSSRK(i, pf_pool),
-				*(adapter->rss_key + i));
+	for (i = 0; i < 10; i++) {
+		u16 pool = adapter->num_rx_pools;
+
+		while (pool--)
+			IXGBE_WRITE_REG(hw,
+					IXGBE_PFVFRSSRK(i, VMDQ_P(pool)),
+					*(adapter->rss_key + i));
+	}
 
 	/* Fill out the redirection table */
 	for (i = 0, j = 0; i < 64; i++, j++) {
@@ -3962,7 +3970,7 @@ static void ixgbe_setup_mrqc(struct ixgbe_adapter *adapter)
 
 	if ((hw->mac.type >= ixgbe_mac_X550) &&
 	    (adapter->flags & IXGBE_FLAG_SRIOV_ENABLED)) {
-		unsigned int pf_pool = adapter->num_vfs;
+		u16 pool = adapter->num_rx_pools;
 
 		/* Enable VF RSS mode */
 		mrqc |= IXGBE_MRQC_MULTIPLE_RSS;
@@ -3972,7 +3980,11 @@ static void ixgbe_setup_mrqc(struct ixgbe_adapter *adapter)
 		ixgbe_setup_vfreta(adapter);
 		vfmrqc = IXGBE_MRQC_RSSEN;
 		vfmrqc |= rss_field;
-		IXGBE_WRITE_REG(hw, IXGBE_PFVFMRQC(pf_pool), vfmrqc);
+
+		while (pool--)
+			IXGBE_WRITE_REG(hw,
+					IXGBE_PFVFMRQC(VMDQ_P(pool)),
+					vfmrqc);
 	} else {
 		ixgbe_setup_reta(adapter);
 		mrqc |= rss_field;
@@ -4135,7 +4147,7 @@ static void ixgbe_setup_psrtype(struct ixgbe_adapter *adapter)
 {
 	struct ixgbe_hw *hw = &adapter->hw;
 	int rss_i = adapter->ring_feature[RING_F_RSS].indices;
-	u16 pool;
+	u16 pool = adapter->num_rx_pools;
 
 	/* PSRTYPE must be initialized in non 82598 adapters */
 	u32 psrtype = IXGBE_PSRTYPE_TCPHDR |
@@ -4152,7 +4164,7 @@ static void ixgbe_setup_psrtype(struct ixgbe_adapter *adapter)
 	else if (rss_i > 1)
 		psrtype |= 1u << 29;
 
-	for_each_set_bit(pool, &adapter->fwd_bitmask, 32)
+	while (pool--)
 		IXGBE_WRITE_REG(hw, IXGBE_PSRTYPE(VMDQ_P(pool)), psrtype);
 }
 
@@ -5268,29 +5280,6 @@ static void ixgbe_macvlan_set_rx_mode(struct net_device *dev, unsigned int pool,
 	IXGBE_WRITE_REG(hw, IXGBE_VMOLR(pool), vmolr);
 }
 
-static void ixgbe_fwd_psrtype(struct ixgbe_fwd_adapter *vadapter)
-{
-	struct ixgbe_adapter *adapter = vadapter->real_adapter;
-	int rss_i = adapter->num_rx_queues_per_pool;
-	struct ixgbe_hw *hw = &adapter->hw;
-	u16 pool = vadapter->pool;
-	u32 psrtype = IXGBE_PSRTYPE_TCPHDR |
-		      IXGBE_PSRTYPE_UDPHDR |
-		      IXGBE_PSRTYPE_IPV4HDR |
-		      IXGBE_PSRTYPE_L2HDR |
-		      IXGBE_PSRTYPE_IPV6HDR;
-
-	if (hw->mac.type == ixgbe_mac_82598EB)
-		return;
-
-	if (rss_i > 3)
-		psrtype |= 2u << 29;
-	else if (rss_i > 1)
-		psrtype |= 1u << 29;
-
-	IXGBE_WRITE_REG(hw, IXGBE_PSRTYPE(VMDQ_P(pool)), psrtype);
-}
-
 /**
  * ixgbe_clean_rx_ring - Free Rx Buffers per Queue
  * @rx_ring: ring to free buffers from
@@ -5429,7 +5418,6 @@ static int ixgbe_fwd_ring_up(struct net_device *vdev,
 		ixgbe_add_mac_filter(adapter, vdev->dev_addr,
 				     VMDQ_P(accel->pool));
 
-	ixgbe_fwd_psrtype(accel);
 	ixgbe_macvlan_set_rx_mode(vdev, VMDQ_P(accel->pool), adapter);
 	return err;
 fwd_queue_err:

