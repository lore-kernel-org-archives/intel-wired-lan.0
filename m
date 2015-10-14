From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 14 Oct 2015 09:32:46 -0700
Subject: [Intel-wired-lan] [next-queue v2 12/17] fm10k: introduce
	ITR_IS_ADAPTIVE macro
In-Reply-To: <1444840371-17328-1-git-send-email-jacob.e.keller@intel.com>
References: <1444840371-17328-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <1444840371-17328-12-git-send-email-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Define a macro for identifying when the itr value is dynamic or
adaptive. The concept was taken from i40e. This helps make clear what
the check is, and reduces the line length to something more reasonable
in a few places.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k.h         | 2 ++
 drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c | 6 ++----
 drivers/net/ethernet/intel/fm10k/fm10k_main.c    | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k.h b/drivers/net/ethernet/intel/fm10k/fm10k.h
index 3495e9337745..a2484cb88d86 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k.h
+++ b/drivers/net/ethernet/intel/fm10k/fm10k.h
@@ -172,6 +172,8 @@ struct fm10k_ring_container {
 #define FM10K_ITR_20K		50	/* 50us */
 #define FM10K_ITR_ADAPTIVE	0x8000	/* adaptive interrupt moderation flag */
 
+#define ITR_IS_ADAPTIVE(itr) (!!(itr & FM10K_ITR_ADAPTIVE))
+
 #define FM10K_ITR_ENABLE	(FM10K_ITR_AUTOMASK | FM10K_ITR_MASK_CLEAR)
 
 static inline struct netdev_queue *txring_txq(const struct fm10k_ring *ring)
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c b/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
index b903c4646cf8..2395877f0544 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
@@ -705,12 +705,10 @@ static int fm10k_get_coalesce(struct net_device *dev,
 {
 	struct fm10k_intfc *interface = netdev_priv(dev);
 
-	ec->use_adaptive_tx_coalesce =
-		!!(interface->tx_itr & FM10K_ITR_ADAPTIVE);
+	ec->use_adaptive_tx_coalesce = ITR_IS_ADAPTIVE(interface->tx_itr);
 	ec->tx_coalesce_usecs = interface->tx_itr & ~FM10K_ITR_ADAPTIVE;
 
-	ec->use_adaptive_rx_coalesce =
-		!!(interface->rx_itr & FM10K_ITR_ADAPTIVE);
+	ec->use_adaptive_rx_coalesce = ITR_IS_ADAPTIVE(interface->rx_itr);
 	ec->rx_coalesce_usecs = interface->rx_itr & ~FM10K_ITR_ADAPTIVE;
 
 	return 0;
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_main.c b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
index c5f7e0d919dc..8207ee189600 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_main.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
@@ -1370,7 +1370,7 @@ static void fm10k_update_itr(struct fm10k_ring_container *ring_container)
 	unsigned int avg_wire_size, packets;
 
 	/* Only update ITR if we are using adaptive setting */
-	if (!(ring_container->itr & FM10K_ITR_ADAPTIVE))
+	if (!ITR_IS_ADAPTIVE(ring_container->itr))
 		goto clear_counts;
 
 	packets = ring_container->total_packets;
-- 
2.6.1.264.gbab76a9

