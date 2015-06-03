From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed,  3 Jun 2015 15:56:29 -0700
Subject: [Intel-wired-lan] [PATCH 03/15] fm10k: move setting shinfo inside
	ts_tx_enqueue
In-Reply-To: <1433372201-12007-1-git-send-email-jacob.e.keller@intel.com>
References: <1433372201-12007-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <1433372201-12007-3-git-send-email-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch simplifies the code flow for setting the IN_PROGRESS bit of
the shinfo for an skb we will be timestamping.

Reported-by: Eric Dumazet <eric.dumazet@gmail.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_ptp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_ptp.c b/drivers/net/ethernet/intel/fm10k/fm10k_ptp.c
index bb7d3bfca6ef..448d60ae98ce 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_ptp.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_ptp.c
@@ -70,16 +70,16 @@ void fm10k_ts_tx_enqueue(struct fm10k_intfc *interface, struct sk_buff *skb)
 	 * if none are present then insert skb in tail of list
 	 */
 	skb = fm10k_ts_tx_skb(interface, FM10K_CB(clone)->fi.w.dglort);
-	if (!skb)
+	if (!skb) {
+		skb_shinfo(clone)->tx_flags |= SKBTX_IN_PROGRESS;
 		__skb_queue_tail(list, clone);
+	}
 
 	spin_unlock_irqrestore(&list->lock, flags);
 
 	/* if list is already has one then we just free the clone */
 	if (skb)
 		kfree_skb(skb);
-	else
-		skb_shinfo(clone)->tx_flags |= SKBTX_IN_PROGRESS;
 }
 
 void fm10k_ts_tx_hwtstamp(struct fm10k_intfc *interface, __le16 dglort,
-- 
2.1.0

