From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Thu, 19 May 2022 18:15:34 -0700
Subject: [Intel-wired-lan] [PATCH net-next v5 07/11] igc: Add support for
 enabling frame preemption via ethtool
In-Reply-To: <20220520011538.1098888-1-vinicius.gomes@intel.com>
References: <20220520011538.1098888-1-vinicius.gomes@intel.com>
Message-ID: <20220520011538.1098888-8-vinicius.gomes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Add support for enabling frame preemption via ethtool. All that's left
for ethtool is to save the settings in the adapter state, and the
request for those settings to be applied.

It's done this because the TSN features (frame preemption is part of
them) interact with one another and it's better to keep track from a
central place.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 drivers/net/ethernet/intel/igc/igc.h         |  3 ++
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 51 ++++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index 31e7b4c72894..df2fc71825a6 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -94,6 +94,7 @@ struct igc_ring {
 	u8 queue_index;                 /* logical index of the ring*/
 	u8 reg_idx;                     /* physical index of the ring */
 	bool launchtime_enable;         /* true if LaunchTime is enabled */
+	bool preemptible;               /* true if queue is preemptible */
 
 	u32 start_time;
 	u32 end_time;
@@ -182,6 +183,8 @@ struct igc_adapter {
 
 	ktime_t base_time;
 	ktime_t cycle_time;
+	bool frame_preemption_active;
+	u32 add_frag_size;
 
 	/* OS defined structs */
 	struct pci_dev *pdev;
diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index 8cc077b712ad..401d2cdb3e81 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -8,6 +8,7 @@
 
 #include "igc.h"
 #include "igc_diag.h"
+#include "igc_tsn.h"
 
 /* forward declaration */
 struct igc_stats {
@@ -1670,6 +1671,54 @@ static int igc_ethtool_set_eee(struct net_device *netdev,
 	return 0;
 }
 
+static int igc_ethtool_get_preempt(struct net_device *netdev,
+				   struct ethtool_fp *fpcmd)
+{
+	struct igc_adapter *adapter = netdev_priv(netdev);
+	u32 mask = 0;
+	int i;
+
+	fpcmd->enabled = adapter->frame_preemption_active;
+	fpcmd->add_frag_size = adapter->add_frag_size;
+
+	for (i = 0; i < adapter->num_tx_queues; i++) {
+		struct igc_ring *ring = adapter->tx_ring[i];
+
+		if (ring->preemptible)
+			mask |= BIT(i);
+	}
+
+	fpcmd->preemptible_mask = mask;
+
+	return 0;
+}
+
+static int igc_ethtool_set_preempt(struct net_device *netdev,
+				   struct ethtool_fp *fpcmd,
+				   struct netlink_ext_ack *extack)
+{
+	struct igc_adapter *adapter = netdev_priv(netdev);
+	u32 mask;
+	int i;
+
+	if (fpcmd->add_frag_size < 68 || fpcmd->add_frag_size > 260) {
+		NL_SET_ERR_MSG_MOD(extack, "Invalid value for add-frag-size");
+		return -EINVAL;
+	}
+
+	adapter->frame_preemption_active = fpcmd->enabled;
+	adapter->add_frag_size = fpcmd->add_frag_size;
+	mask = fpcmd->preemptible_mask;
+
+	for (i = 0; i < adapter->num_tx_queues; i++) {
+		struct igc_ring *ring = adapter->tx_ring[i];
+
+		ring->preemptible = (mask & BIT(i));
+	}
+
+	return igc_tsn_offload_apply(adapter);
+}
+
 static int igc_ethtool_begin(struct net_device *netdev)
 {
 	struct igc_adapter *adapter = netdev_priv(netdev);
@@ -1963,6 +2012,8 @@ static const struct ethtool_ops igc_ethtool_ops = {
 	.get_ts_info		= igc_ethtool_get_ts_info,
 	.get_channels		= igc_ethtool_get_channels,
 	.set_channels		= igc_ethtool_set_channels,
+	.get_preempt		= igc_ethtool_get_preempt,
+	.set_preempt		= igc_ethtool_set_preempt,
 	.get_priv_flags		= igc_ethtool_get_priv_flags,
 	.set_priv_flags		= igc_ethtool_set_priv_flags,
 	.get_eee		= igc_ethtool_get_eee,
-- 
2.35.3

