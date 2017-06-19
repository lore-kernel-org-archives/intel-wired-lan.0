From: Cliff Spradlin <cspradlin@google.com>
Date: Mon, 19 Jun 2017 13:30:43 -0700
Subject: [Intel-wired-lan] [PATCH] igb: protect TX timestamping from API
	misuse
Message-ID: <20170619203043.120598-1-cspradlin@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

HW timestamping can only be requested for a packet if the NIC is first
setup via ioctl(SIOCSHWTSTAMP). If this step was skipped, then the igb
driver still allowed TX packets to request HW timestamping. In this
situation, the _IGB_PTP_TX_IN_PROGRESS flag was set and would never
clear. This prevented any future HW timestamping requests to succeed.

Fix this by checking that the NIC is configured for HW TX timestamping
before accepting a HW TX timestamping request.

Signed-off-by: Cliff Spradlin <cspradlin@google.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 63b035454cd0..4077a09fd4c2 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -5388,7 +5388,8 @@ netdev_tx_t igb_xmit_frame_ring(struct sk_buff *skb,
 	if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP)) {
 		struct igb_adapter *adapter = netdev_priv(tx_ring->netdev);
 
-		if (!test_and_set_bit_lock(__IGB_PTP_TX_IN_PROGRESS,
+		if (adapter->tstamp_config.tx_type & HWTSTAMP_TX_ON &&
+		    !test_and_set_bit_lock(__IGB_PTP_TX_IN_PROGRESS,
 					   &adapter->state)) {
 			skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
 			tx_flags |= IGB_TX_FLAGS_TSTAMP;
-- 
2.13.1.518.g3df882009-goog

