From: Shota Suzuki <suzuki_shota_t3@lab.ntt.co.jp>
Date: Fri, 11 Dec 2015 18:43:59 +0900
Subject: [Intel-wired-lan] [PATCH net-next 1/2] igb: Remove unnecessary flag
	setting in igb_set_flag_queue_pairs()
Message-ID: <1449827040-1806-1-git-send-email-suzuki_shota_t3@lab.ntt.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

If VFs are enabled (max_vfs >= 1), both max_rss_queues and
adapter->rss_queues are set to 2 in the case of e1000_82576.
In this case, IGB_FLAG_QUEUE_PAIRS is always set in the default block as a
result of fall-through, thus setting it in the e1000_82576 block is not
necessary.

Signed-off-by: Shota Suzuki <suzuki_shota_t3@lab.ntt.co.jp>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 3d4b502..340ba4fb 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -2922,14 +2922,6 @@ void igb_set_flag_queue_pairs(struct igb_adapter *adapter,
 		/* Device supports enough interrupts without queue pairing. */
 		break;
 	case e1000_82576:
-		/* If VFs are going to be allocated with RSS queues then we
-		 * should pair the queues in order to conserve interrupts due
-		 * to limited supply.
-		 */
-		if ((adapter->rss_queues > 1) &&
-		    (adapter->vfs_allocated_count > 6))
-			adapter->flags |= IGB_FLAG_QUEUE_PAIRS;
-		/* fall through */
 	case e1000_82580:
 	case e1000_i350:
 	case e1000_i354:
-- 
1.8.3.1



