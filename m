From: Bruce Allan <bruce.w.allan@intel.com>
Date: Wed, 28 Oct 2015 16:04:19 -0700
Subject: [Intel-wired-lan] [next-queue PATCH] fm10k: whitespace cleanups
Message-ID: <20151028230419.10576.54159.stgit@bwallan-cwp1.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c |    1 -
 drivers/net/ethernet/intel/fm10k/fm10k_netdev.c  |    2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c b/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
index 109e211..6ded27b 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
@@ -1020,7 +1020,6 @@ static int fm10k_set_priv_flags(struct net_device *netdev, u32 priv_flags)
 	return 0;
 }
 
-
 static u32 fm10k_get_reta_size(struct net_device __always_unused *netdev)
 {
 	return FM10K_RETA_SIZE * FM10K_RETA_ENTRIES_PER_REG;
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c b/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
index 1be8083..1ea0f30 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
@@ -608,7 +608,7 @@ static netdev_tx_t fm10k_xmit_frame(struct sk_buff *skb, struct net_device *dev)
 	unsigned int r_idx = skb->queue_mapping;
 	int err;
 
-	if ((skb->protocol ==  htons(ETH_P_8021Q)) &&
+	if ((skb->protocol == htons(ETH_P_8021Q)) &&
 	    !skb_vlan_tag_present(skb)) {
 		/* FM10K only supports hardware tagging, any tags in frame
 		 * are considered 2nd level or "outer" tags

