From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri, 16 Oct 2015 10:57:08 -0700
Subject: [Intel-wired-lan] [next-queue v5 14/17] fm10k: use macro for
	default Tx and Rx ITR values
In-Reply-To: <1445018231-3196-1-git-send-email-jacob.e.keller@intel.com>
References: <1445018231-3196-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <1445018231-3196-14-git-send-email-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k.h         | 2 ++
 drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c | 4 ++--
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c     | 4 ++--
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k.h b/drivers/net/ethernet/intel/fm10k/fm10k.h
index bdbb804a594f..7bf0c2ddce75 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k.h
+++ b/drivers/net/ethernet/intel/fm10k/fm10k.h
@@ -175,6 +175,8 @@ struct fm10k_ring_container {
 
 #define ITR_IS_ADAPTIVE(itr) (!!(itr & FM10K_ITR_ADAPTIVE))
 
+#define FM10K_TX_ITR_DEFAULT	FM10K_ITR_10K
+#define FM10K_RX_ITR_DEFAULT	FM10K_ITR_20K
 #define FM10K_ITR_ENABLE	(FM10K_ITR_AUTOMASK | FM10K_ITR_MASK_CLEAR)
 
 static inline struct netdev_queue *txring_txq(const struct fm10k_ring *ring)
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c b/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
index 2395877f0544..2432b6e0528f 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
@@ -733,10 +733,10 @@ static int fm10k_set_coalesce(struct net_device *dev,
 
 	/* set initial values for adaptive ITR */
 	if (ec->use_adaptive_tx_coalesce)
-		tx_itr = FM10K_ITR_ADAPTIVE | FM10K_ITR_10K;
+		tx_itr = FM10K_ITR_ADAPTIVE | FM10K_TX_ITR_DEFAULT;
 
 	if (ec->use_adaptive_rx_coalesce)
-		rx_itr = FM10K_ITR_ADAPTIVE | FM10K_ITR_20K;
+		rx_itr = FM10K_ITR_ADAPTIVE | FM10K_RX_ITR_DEFAULT;
 
 	/* update interface */
 	interface->tx_itr = tx_itr;
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
index 1f0d9bc3bf7b..0cdb79e8b36e 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
@@ -1771,8 +1771,8 @@ static int fm10k_sw_init(struct fm10k_intfc *interface,
 	interface->rx_ring_count = FM10K_DEFAULT_RXD;
 
 	/* set default interrupt moderation */
-	interface->tx_itr = FM10K_ITR_10K;
-	interface->rx_itr = FM10K_ITR_ADAPTIVE | FM10K_ITR_20K;
+	interface->tx_itr = FM10K_TX_ITR_DEFAULT;
+	interface->rx_itr = FM10K_ITR_ADAPTIVE | FM10K_RX_ITR_DEFAULT;
 
 	/* initialize vxlan_port list */
 	INIT_LIST_HEAD(&interface->vxlan_port);
-- 
2.6.1.264.gbab76a9

