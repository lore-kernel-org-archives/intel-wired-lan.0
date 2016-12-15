From: Weilong Chen <chenweilong@huawei.com>
Date: Thu, 15 Dec 2016 19:40:34 +0800
Subject: [Intel-wired-lan] [PATCH net-next] ixgbevf: fix 'Etherleak' in
	ixgbevf
Message-ID: <1481802034-77729-1-git-send-email-chenweilong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Nessus report the vf appears to leak memory in network packets.
Fix this by padding all small packets manually.

And the CVE-2003-0001.
https://ofirarkin.files.wordpress.com/2008/11/atstake_etherleak_report.pdf

Signed-off-by: Weilong Chen <chenweilong@huawei.com>
---
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index 6d4bef5..137a154 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -3654,6 +3654,13 @@ static int ixgbevf_xmit_frame(struct sk_buff *skb, struct net_device *netdev)
 		return NETDEV_TX_OK;
 	}
 
+	/* On PCI/PCI-X HW, if packet size is less than ETH_ZLEN,
+	 * packets may get corrupted during padding by HW.
+	 * To WA this issue, pad all small packets manually.
+	 */
+	if (eth_skb_pad(skb))
+		return NETDEV_TX_OK;
+
 	tx_ring = adapter->tx_ring[skb->queue_mapping];
 
 	/* need: 1 descriptor per page * PAGE_SIZE/IXGBE_MAX_DATA_PER_TXD,
-- 
1.7.12

