From: Todd Fujinaka <todd.fujinaka@intel.com>
Date: Thu, 04 Jun 2015 14:26:56 -0700
Subject: [Intel-wired-lan] [PATCH v2] igb: report unsupported ethtool
	settings in set_coalesce
Message-ID: <20150604212640.7229.93966.stgit@htfujina-fc.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

There are many settings possible using ethtool -C/--coalesce, but not
all of them are supported in igb. Report failure when an unsupported
option is set.

Signed-off-by: Todd Fujinaka <todd.fujinaka@intel.com>
---
 drivers/net/ethernet/intel/igb/igb_ethtool.c |   21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
index 109cad9..b7b9c67 100644
--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
@@ -2159,6 +2159,27 @@ static int igb_set_coalesce(struct net_device *netdev,
 	struct igb_adapter *adapter = netdev_priv(netdev);
 	int i;
 
+	if (ec->rx_max_coalesced_frames ||
+	    ec->rx_coalesce_usecs_irq ||
+	    ec->rx_max_coalesced_frames_irq ||
+	    ec->tx_max_coalesced_frames ||
+	    ec->tx_coalesce_usecs_irq ||
+	    ec->stats_block_coalesce_usecs ||
+	    ec->use_adaptive_rx_coalesce ||
+	    ec->use_adaptive_tx_coalesce ||
+	    ec->pkt_rate_low ||
+	    ec->rx_coalesce_usecs_low ||
+	    ec->rx_max_coalesced_frames_low ||
+	    ec->tx_coalesce_usecs_low ||
+	    ec->tx_max_coalesced_frames_low ||
+	    ec->pkt_rate_high ||
+	    ec->rx_coalesce_usecs_high ||
+	    ec->rx_max_coalesced_frames_high ||
+	    ec->tx_coalesce_usecs_high ||
+	    ec->tx_max_coalesced_frames_high ||
+	    ec->rate_sample_interval)
+		return -ENOTSUPP;
+
 	if ((ec->rx_coalesce_usecs > IGB_MAX_ITR_USECS) ||
 	    ((ec->rx_coalesce_usecs > 3) &&
 	     (ec->rx_coalesce_usecs < IGB_MIN_ITR_USECS)) ||

