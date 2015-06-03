From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed,  3 Jun 2015 16:31:01 -0700
Subject: [Intel-wired-lan] [rc2 04/15] fm10k: fix incorrect free on skb in
	ts_tx_enqueue
In-Reply-To: <1433374272-6684-1-git-send-email-jacob.e.keller@intel.com>
References: <1433374272-6684-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <1433374272-6684-5-git-send-email-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch resolves a bug in the ts_tx_enqueue code responsible for a
NULL pointer dereference and invalid access of the skb list. We
incorrectly freed the actual skb we found instead of our copy. Thus the
skb queue is essentially invalidated. Resolve this by freeing our clone
in the cases where we did not add it to the queue. This also avoids the
skb memory leak caused by failure to free the clone.

[  589.719320] BUG: unable to handle kernel NULL pointer dereference at           (null)
[  589.722344] IP: [<ffffffffa0310e60>] fm10k_ts_tx_subtask+0xb0/0x160 [fm10k]
[  589.723796] PGD 0
[  589.725228] Oops: 0000 [#1] SMP

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_ptp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_ptp.c b/drivers/net/ethernet/intel/fm10k/fm10k_ptp.c
index 39b832889b75..b4945e8abe03 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_ptp.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_ptp.c
@@ -79,7 +79,7 @@ void fm10k_ts_tx_enqueue(struct fm10k_intfc *interface, struct sk_buff *skb)
 
 	/* if list is already has one then we just free the clone */
 	if (skb)
-		kfree_skb(skb);
+		dev_kfree_skb(clone);
 }
 
 void fm10k_ts_tx_hwtstamp(struct fm10k_intfc *interface, __le16 dglort,
-- 
2.1.0

