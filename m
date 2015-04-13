From: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Date: Mon, 13 Apr 2015 18:15:10 +0900
Subject: [Intel-wired-lan] [PATCH net 1/2] igb: Fix oops on changing number
	of rings
Message-ID: <1428916512-25559-1-git-send-email-makita.toshiaki@lab.ntt.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

When changing the number of rings by ethtool -L, q_vectors are reused,
which causes oops because of uninitialized pointers.

- When an rx is reused as a tx, q_vector->rx.ring is not set to NULL, which
  misleads igb_poll() to determine that it has an rx ring although it
  actually points to the tx ring.
- When a tx is reused as an rx, q_vector->rx.ring->skb
  (q_vector->ring[0].skb) has a value that was used as tx_stats before.

Fix these problems by zeroing it out on reuseing it.

Fixes: 02ef6e1d0b00 ("igb: Fix queue allocation method to accommodate changing during runtime")
Signed-off-by: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index f366b3b..010ddcb 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -1207,6 +1207,8 @@ static int igb_alloc_q_vector(struct igb_adapter *adapter,
 	q_vector = adapter->q_vector[v_idx];
 	if (!q_vector)
 		q_vector = kzalloc(size, GFP_KERNEL);
+	else
+		memset(q_vector, 0, size);
 	if (!q_vector)
 		return -ENOMEM;
 
-- 
1.8.1.2


