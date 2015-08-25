From: Emil Tantilov <emil.s.tantilov@intel.com>
Date: Mon, 24 Aug 2015 18:08:31 -0700
Subject: [Intel-wired-lan] [PATCH] ixgbe: disable LRO by default
Message-ID: <20150825010831.13553.53705.stgit@localhost6.localdomain6>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch disables LRO by default in favor of GRO.

LRO is incompatible with forwarding and is disabled when forwarding
is turned on which makes the default offloads of the driver
inconsistent. LRO can still be enabled via ethtool.

Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 756f3a9..a2d2564 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -5307,7 +5307,6 @@ static int ixgbe_sw_init(struct ixgbe_adapter *adapter)
 	rss = min_t(int, ixgbe_max_rss_indices(adapter), num_online_cpus());
 	adapter->ring_feature[RING_F_RSS].limit = rss;
 	adapter->flags2 |= IXGBE_FLAG2_RSC_CAPABLE;
-	adapter->flags2 |= IXGBE_FLAG2_RSC_ENABLED;
 	adapter->max_q_vectors = MAX_Q_VECTORS_82599;
 	adapter->atr_sample_rate = 20;
 	fdir = min_t(int, IXGBE_MAX_FDIR_INDICES, num_online_cpus());
@@ -5333,7 +5332,6 @@ static int ixgbe_sw_init(struct ixgbe_adapter *adapter)
 	switch (hw->mac.type) {
 	case ixgbe_mac_82598EB:
 		adapter->flags2 &= ~IXGBE_FLAG2_RSC_CAPABLE;
-		adapter->flags2 &= ~IXGBE_FLAG2_RSC_ENABLED;
 
 		if (hw->device_id == IXGBE_DEV_ID_82598AT)
 			adapter->flags |= IXGBE_FLAG_FAN_FAIL_CAPABLE;

