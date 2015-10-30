From: William Dauchy <william@gandi.net>
Date: Fri, 30 Oct 2015 18:16:30 +0100
Subject: [Intel-wired-lan] [PATCH] ixgbevf: Fix handling of napi budget when
	multiple queues are enabled per vector
Message-ID: <1446225390-19140-1-git-send-email-william@gandi.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This is the same patch as for ixgbe but applied differently according to
busy polling.
see commit "ixgbe: Fix handling of napi budget when multiple queues are
 enabled per vector"

Signed-off-by: William Dauchy <william@gandi.net>
---
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index 149a0b4..ff6e21d 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -1014,6 +1014,8 @@ static int ixgbevf_poll(struct napi_struct *napi, int budget)
 	ixgbevf_for_each_ring(ring, q_vector->tx)
 		clean_complete &= ixgbevf_clean_tx_irq(q_vector, ring);
 
+	if (budget <= 0)
+		return budget;
 #ifdef CONFIG_NET_RX_BUSY_POLL
 	if (!ixgbevf_qv_lock_napi(q_vector))
 		return budget;
-- 
2.6.1

