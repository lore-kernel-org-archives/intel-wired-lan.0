From: Florian Fainelli <f.fainelli@gmail.com>
Date: Tue,  1 Aug 2017 12:11:08 -0700
Subject: [Intel-wired-lan] [PATCH net 3/7] ixgbe: Initialize 64-bit stats
	seqcounts
In-Reply-To: <20170801191113.8754-1-f.fainelli@gmail.com>
References: <20170801191113.8754-1-f.fainelli@gmail.com>
Message-ID: <20170801191113.8754-4-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 32-bit hosts and with CONFIG_DEBUG_LOCK_ALLOC we should be seeing a
lockdep splat indicating this seqcount is not correctly initialized, fix
that.

Fixes: 4197aa7bb818 ("ixgbevf: provide 64 bit statistics")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index 084c53582793..032f8ac06357 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -2988,6 +2988,8 @@ int ixgbevf_setup_tx_resources(struct ixgbevf_ring *tx_ring)
 	if (!tx_ring->tx_buffer_info)
 		goto err;
 
+	u64_stats_init(&tx_ring->syncp);
+
 	/* round up to nearest 4K */
 	tx_ring->size = tx_ring->count * sizeof(union ixgbe_adv_tx_desc);
 	tx_ring->size = ALIGN(tx_ring->size, 4096);
@@ -3046,6 +3048,8 @@ int ixgbevf_setup_rx_resources(struct ixgbevf_ring *rx_ring)
 	if (!rx_ring->rx_buffer_info)
 		goto err;
 
+	u64_stats_init(&rx_ring->syncp);
+
 	/* Round up to nearest 4K */
 	rx_ring->size = rx_ring->count * sizeof(union ixgbe_adv_rx_desc);
 	rx_ring->size = ALIGN(rx_ring->size, 4096);
-- 
2.9.3

