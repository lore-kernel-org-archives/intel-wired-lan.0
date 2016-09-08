From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 07 Sep 2016 20:28:17 -0700
Subject: [Intel-wired-lan] [next PATCH 2/3] ixgbe: Limit reporting of
 redirection table if SR-IOV is enabled
In-Reply-To: <20160908032606.25312.86849.stgit@localhost.localdomain>
References: <20160908032606.25312.86849.stgit@localhost.localdomain>
Message-ID: <20160908032817.25312.89293.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alexander Duyck <alexander.h.duyck@intel.com>

The hardware redirection table can support more queues then the PF
currently has when SR-IOV is enabled.  In order to account for this use the
RSS mask to trim of the bits that are not used.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index 2d872be336bb..f49f80380aa5 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -2947,9 +2947,13 @@ static u32 ixgbe_rss_indir_size(struct net_device *netdev)
 static void ixgbe_get_reta(struct ixgbe_adapter *adapter, u32 *indir)
 {
 	int i, reta_size = ixgbe_rss_indir_tbl_entries(adapter);
+	u16 rss_m = adapter->ring_feature[RING_F_RSS].mask;
+
+	if (adapter->flags & IXGBE_FLAG_SRIOV_ENABLED)
+		rss_m = adapter->ring_feature[RING_F_RSS].indices - 1;
 
 	for (i = 0; i < reta_size; i++)
-		indir[i] = adapter->rss_indir_tbl[i];
+		indir[i] = adapter->rss_indir_tbl[i] & rss_m;
 }
 
 static int ixgbe_get_rxfh(struct net_device *netdev, u32 *indir, u8 *key,

