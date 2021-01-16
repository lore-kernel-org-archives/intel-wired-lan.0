From: Xin Long <lucien.xin@gmail.com>
Date: Sat, 16 Jan 2021 14:13:37 +0800
Subject: [Intel-wired-lan] [PATCH net-next 1/6] net: add inline function
 skb_csum_is_sctp
In-Reply-To: <cover.1610777159.git.lucien.xin@gmail.com>
References: <cover.1610777159.git.lucien.xin@gmail.com>
Message-ID: <34c9f5b8c31610687925d9db1f151d5bc87deba7.1610777159.git.lucien.xin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch is to define a inline function skb_csum_is_sctp(), and
also replace all places where it checks if it's a SCTP CSUM skb.
This function would be used later in many networking drivers in
the following patches.

Suggested-by: Alexander Duyck <alexander.duyck@gmail.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_txrx.c | 2 +-
 include/linux/skbuff.h                           | 5 +++++
 net/core/dev.c                                   | 2 +-
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
index ac4cd5d..162a1ff 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
@@ -979,7 +979,7 @@ static int ionic_tx_calc_csum(struct ionic_queue *q, struct sk_buff *skb)
 		stats->vlan_inserted++;
 	}
 
-	if (skb->csum_not_inet)
+	if (skb_csum_is_sctp(skb))
 		stats->crc32_csum++;
 	else
 		stats->csum++;
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index c9568cf..46f901a 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4621,6 +4621,11 @@ static inline void skb_reset_redirect(struct sk_buff *skb)
 #endif
 }
 
+static inline bool skb_csum_is_sctp(struct sk_buff *skb)
+{
+	return skb->csum_not_inet;
+}
+
 static inline void skb_set_kcov_handle(struct sk_buff *skb,
 				       const u64 kcov_handle)
 {
diff --git a/net/core/dev.c b/net/core/dev.c
index 0a31d4e..bbd306f 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3617,7 +3617,7 @@ static struct sk_buff *validate_xmit_vlan(struct sk_buff *skb,
 int skb_csum_hwoffload_help(struct sk_buff *skb,
 			    const netdev_features_t features)
 {
-	if (unlikely(skb->csum_not_inet))
+	if (unlikely(skb_csum_is_sctp(skb)))
 		return !!(features & NETIF_F_SCTP_CRC) ? 0 :
 			skb_crc32c_csum_help(skb);
 
-- 
2.1.0

