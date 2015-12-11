From: Shota Suzuki <suzuki_shota_t3@lab.ntt.co.jp>
Date: Fri, 11 Dec 2015 18:44:00 +0900
Subject: [Intel-wired-lan] [PATCH net-next 2/2] igb: Unpair the queues when
	changing the number of queues
In-Reply-To: <1449827040-1806-1-git-send-email-suzuki_shota_t3@lab.ntt.co.jp>
References: <1449827040-1806-1-git-send-email-suzuki_shota_t3@lab.ntt.co.jp>
Message-ID: <1449827040-1806-2-git-send-email-suzuki_shota_t3@lab.ntt.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

By the commit 72ddef0506da ("igb: Fix oops caused by missing queue
pairing"), the IGB_FLAG_QUEUE_PAIRS flag can now be set when changing the
number of queues by "ethtool -L", but it is never cleared unless the igb
driver is reloaded.
This patch clears it if queue pairing becomes unnecessary as a result of
"ethtool -L".

Signed-off-by: Shota Suzuki <suzuki_shota_t3@lab.ntt.co.jp>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 340ba4fb..75ee25e 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -2932,6 +2932,8 @@ void igb_set_flag_queue_pairs(struct igb_adapter *adapter,
 		 */
 		if (adapter->rss_queues > (max_rss_queues / 2))
 			adapter->flags |= IGB_FLAG_QUEUE_PAIRS;
+		else
+			adapter->flags &= ~IGB_FLAG_QUEUE_PAIRS;
 		break;
 	}
 }
-- 
1.8.3.1



