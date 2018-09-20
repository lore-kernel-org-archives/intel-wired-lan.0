From: Song Liu <songliubraving@fb.com>
Date: Thu, 20 Sep 2018 12:01:13 -0700
Subject: [Intel-wired-lan] [PATCH net] ixgbe: check return value of
 napi_complete_done()
Message-ID: <20180920190113.490005-1-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The NIC driver should only enable interrupts when napi_complete_done()
returns true. This patch adds the check for ixgbe.

Cc: stable at vger.kernel.org # 4.10+
Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Song Liu <songliubraving@fb.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 9a23d33a47ed..1497df6a8dff 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -3196,11 +3196,13 @@ int ixgbe_poll(struct napi_struct *napi, int budget)
 		return budget;
 
 	/* all work done, exit the polling mode */
-	napi_complete_done(napi, work_done);
-	if (adapter->rx_itr_setting & 1)
-		ixgbe_set_itr(q_vector);
-	if (!test_bit(__IXGBE_DOWN, &adapter->state))
-		ixgbe_irq_enable_queues(adapter, BIT_ULL(q_vector->v_idx));
+	if (likely(napi_complete_done(napi, work_done))) {
+		if (adapter->rx_itr_setting & 1)
+			ixgbe_set_itr(q_vector);
+		if (!test_bit(__IXGBE_DOWN, &adapter->state))
+			ixgbe_irq_enable_queues(adapter,
+						BIT_ULL(q_vector->v_idx));
+	}
 
 	return min(work_done, budget - 1);
 }
-- 
2.17.1

