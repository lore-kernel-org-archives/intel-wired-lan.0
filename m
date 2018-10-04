From: Colin King <colin.king@canonical.com>
Date: Thu,  4 Oct 2018 18:57:32 +0100
Subject: [Intel-wired-lan] [PATCH][-next] ixgbe: don't clear_bit on
 xdp_ring->state if xdp_ring is null
Message-ID: <20181004175732.28329-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Colin Ian King <colin.king@canonical.com>

There is an earlier check to see if xdp_ring is null when configuring
the tx ring, so assuming that it can still be null, the clearing of
the xdp_ring->state currently could end up with a null pointer
dereference.  Fix this by only clearing the bit if xdp_ring is not null.

Detected by CoverityScan, CID#1473795 ("Dereference after null check")

Fixes: 024aa5800f32 ("ixgbe: added Rx/Tx ring disable/enable functions")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 0049a2becd7e..8e4756247324 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -10517,7 +10517,8 @@ void ixgbe_txrx_ring_enable(struct ixgbe_adapter *adapter, int ring)
 	ixgbe_configure_rx_ring(adapter, rx_ring);
 
 	clear_bit(__IXGBE_TX_DISABLED, &tx_ring->state);
-	clear_bit(__IXGBE_TX_DISABLED, &xdp_ring->state);
+	if (xdp_ring)
+		clear_bit(__IXGBE_TX_DISABLED, &xdp_ring->state);
 }
 
 /**
-- 
2.17.1

