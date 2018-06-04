From: Alexander Duyck <alexander.h.duyck@intel.com>
Date: Mon, 04 Jun 2018 16:51:20 -0400
Subject: [Intel-wired-lan] [net-queue PATCH v2 1/2] ixgbe: Use
 CONFIG_XFRM_OFFLOAD instead of CONFIG_XFRM
In-Reply-To: <20180604204931.5474.94068.stgit@ahduyck-green-test.jf.intel.com>
References: <20180604204931.5474.94068.stgit@ahduyck-green-test.jf.intel.com>
Message-ID: <20180604205120.5474.22753.stgit@ahduyck-green-test.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

There is no point in adding code if CONFIG_XFRM is defined that we won't
use unless CONFIG_XFRM_OFFLOAD is defined. So instead of leaving this code
floating around I am replacing the ifdef with what I believe is the correct
one so that we only include the code and variables if they will actually be
used.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe.h      |    4 ++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
index fc534e9..144d5fe 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
@@ -760,9 +760,9 @@ struct ixgbe_adapter {
 #define IXGBE_RSS_KEY_SIZE     40  /* size of RSS Hash Key in bytes */
 	u32 *rss_key;
 
-#ifdef CONFIG_XFRM
+#ifdef CONFIG_XFRM_OFFLOAD
 	struct ixgbe_ipsec *ipsec;
-#endif /* CONFIG_XFRM */
+#endif /* CONFIG_XFRM_OFFLOAD */
 };
 
 static inline u8 ixgbe_max_rss_indices(struct ixgbe_adapter *adapter)
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 6d20295..8cab0c5 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -9945,7 +9945,7 @@ static void ixgbe_fwd_del(struct net_device *pdev, void *priv)
 	 * the TSO, so it's the exception.
 	 */
 	if (skb->encapsulation && !(features & NETIF_F_TSO_MANGLEID)) {
-#ifdef CONFIG_XFRM
+#ifdef CONFIG_XFRM_OFFLOAD
 		if (!skb->sp)
 #endif
 			features &= ~NETIF_F_TSO;

