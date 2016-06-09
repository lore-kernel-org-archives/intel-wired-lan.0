From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu,  9 Jun 2016 16:06:53 -0700
Subject: [Intel-wired-lan] [PATCH v2] compat: WQ_MEM_RECLAIM was renamed
	from WQ_RESCUER
Message-ID: <20160609230653.4576-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

In upstream commit 6370a6ad3b53 ("workqueue: add and use WQ_MEM_RECLAIM
flag", 2010-10-11), the WQ_RESCUER flag was renamed to WQ_MEM_RECLAIM.
Backport the rename here.

Change-Id: I217de4b3fecbcbdba753de8979f99c43f1053d5f
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 kcompat.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kcompat.h b/kcompat.h
index 3085e3ccd35e..db2f2575298a 100644
--- a/kcompat.h
+++ b/kcompat.h
@@ -3785,6 +3785,8 @@ static inline int __kc_netif_set_real_num_rx_queues(struct net_device __always_u
 #define ETH_FLAG_RXVLAN (1 << 8)
 #endif /* ETH_FLAG_RXVLAN */
 
+#define WQ_MEM_RECLAIM 0
+
 static inline void _kc_skb_checksum_none_assert(struct sk_buff *skb)
 {
 	WARN_ON(skb->ip_summed != CHECKSUM_NONE);
-- 
2.9.0.rc1.405.g81f467e

