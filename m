From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 22 Nov 2017 10:56:46 -0800
Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH 06/16] ixgbe: Use ring
 values to test for Tx pending
In-Reply-To: <20171122185256.29785.93548.stgit@localhost.localdomain>
References: <20171122185256.29785.93548.stgit@localhost.localdomain>
Message-ID: <20171122185646.29785.9424.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alexander Duyck <alexander.h.duyck@intel.com>

This patch simplifies the check for Tx pending traffic and makes it more
holistic as there being any difference between next_to_use and
next_to_clean is much more informative than if head and tail are equal, as
it is possible for us to either not update tail, or not be notified of
completed work in which case next_to_clean would not be equal to head.

In addition the simplification makes it so that we don't have to read
hardware which allows us to drop a number of variables that were previously
being used in the call.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 101b3521ab0b..69bababc0cf6 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -1064,24 +1064,12 @@ static u64 ixgbe_get_tx_completed(struct ixgbe_ring *ring)
 
 static u64 ixgbe_get_tx_pending(struct ixgbe_ring *ring)
 {
-	struct ixgbe_adapter *adapter;
-	struct ixgbe_hw *hw;
-	u32 head, tail;
+	unsigned int head, tail;
 
-	if (ring->l2_accel_priv)
-		adapter = ring->l2_accel_priv->real_adapter;
-	else
-		adapter = netdev_priv(ring->netdev);
+	head = ring->next_to_clean;
+	tail = ring->next_to_use;
 
-	hw = &adapter->hw;
-	head = IXGBE_READ_REG(hw, IXGBE_TDH(ring->reg_idx));
-	tail = IXGBE_READ_REG(hw, IXGBE_TDT(ring->reg_idx));
-
-	if (head != tail)
-		return (head < tail) ?
-			tail - head : (tail + ring->count - head);
-
-	return 0;
+	return ((head <= tail) ? tail : tail + ring->count) - head;
 }
 
 static inline bool ixgbe_check_tx_hang(struct ixgbe_ring *tx_ring)

