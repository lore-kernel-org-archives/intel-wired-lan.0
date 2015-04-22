From: Yanir Lubetkin <yanirx.lubetkin@intel.com>
Date: Wed, 22 Apr 2015 19:25:17 +0300
Subject: [Intel-wired-lan] [PATCH] e1000e: fix logical error in
	flush_desc_rings
Message-ID: <1429719917-25985-1-git-send-email-yanirx.lubetkin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

the condition under which the flush should occur was reversed.
The fix should be applied before any HW reset (unless followed by bus reset)
and before any power state transition from D0.
if E1000_FEXTNVM7_NEED_DESCRING_FLUSH bit is set in FEXTNVM7 and TDLEN > 0
the tx ring should be flushed. (fixes ~95% of the hang states).
if the E1000_FEXTNVM7_NEED_DESCRING_FLUSH did not clear, we should also
flush the RX ring. Bug was caught by Alexander Duyck during a code review
when examining this fix.

Signed-off-by: Yanir Lubetkin <yanirx.lubetkin@intel.com>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 76b1a90..de8caf4 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -3878,7 +3878,7 @@ static void e1000_flush_desc_rings(struct e1000_adapter *adapter)
 	/* do nothing if we're not in faulty state, or if the queue is empty */
 	tdlen = er32(TDLEN(0));
 	hang_state = er32(FEXTNVM7);
-	if ((hang_state & E1000_FEXTNVM7_NEED_DESCRING_FLUSH) || tdlen)
+	if (!(hang_state & E1000_FEXTNVM7_NEED_DESCRING_FLUSH) || !tdlen)
 		return;
 	e1000_flush_tx_ring(adapter);
 	/* recheck, maybe the fault is caused by the rx ring */
-- 
1.9.3

---------------------------------------------------------------------
Intel Israel (74) Limited

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

