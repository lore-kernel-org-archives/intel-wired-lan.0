From: Emil Tantilov <emil.s.tantilov@intel.com>
Date: Fri, 04 Nov 2016 14:03:03 -0700
Subject: [Intel-wired-lan] [PATCH] ixgbe: add mask for 64 RSS queues
Message-ID: <20161104210303.10489.64989.stgit@localhost6.localdomain6>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The indirection table was reported incorrectly for X550 and newer
where we can support up to 64 RSS queues.

Reported-by Krishneil Singh <krishneil.k.singh@intel.com>
Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
index 15ab337..10d2967 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
@@ -308,6 +308,7 @@ static void ixgbe_cache_ring_register(struct ixgbe_adapter *adapter)
 	ixgbe_cache_ring_rss(adapter);
 }
 
+#define IXGBE_RSS_64Q_MASK	0x3F
 #define IXGBE_RSS_16Q_MASK	0xF
 #define IXGBE_RSS_8Q_MASK	0x7
 #define IXGBE_RSS_4Q_MASK	0x3
@@ -604,6 +605,7 @@ static bool ixgbe_set_sriov_queues(struct ixgbe_adapter *adapter)
  **/
 static bool ixgbe_set_rss_queues(struct ixgbe_adapter *adapter)
 {
+	struct ixgbe_hw *hw = &adapter->hw;
 	struct ixgbe_ring_feature *f;
 	u16 rss_i;
 
@@ -612,7 +614,11 @@ static bool ixgbe_set_rss_queues(struct ixgbe_adapter *adapter)
 	rss_i = f->limit;
 
 	f->indices = rss_i;
-	f->mask = IXGBE_RSS_16Q_MASK;
+
+	if (hw->mac.type < ixgbe_mac_X550)
+		f->mask = IXGBE_RSS_16Q_MASK;
+	else
+		f->mask = IXGBE_RSS_64Q_MASK;
 
 	/* disable ATR by default, it will be configured below */
 	adapter->flags &= ~IXGBE_FLAG_FDIR_HASH_CAPABLE;

