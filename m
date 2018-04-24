From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Date: Tue, 24 Apr 2018 15:16:48 +0200
Subject: [Intel-wired-lan] [PATCH] net: ixgbevf: fix ixgbevf_xmit_frame()'s
 return type
Message-ID: <20180424131649.3955-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
which is a typedef for an enum type, but the implementation in this
driver returns an 'int'.

Fix this by returning 'netdev_tx_t' in this driver too.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index 3d9033f26..ce217a2e9 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -4137,7 +4137,7 @@ static int ixgbevf_xmit_frame_ring(struct sk_buff *skb,
 	return NETDEV_TX_OK;
 }
 
-static int ixgbevf_xmit_frame(struct sk_buff *skb, struct net_device *netdev)
+static netdev_tx_t ixgbevf_xmit_frame(struct sk_buff *skb, struct net_device *netdev)
 {
 	struct ixgbevf_adapter *adapter = netdev_priv(netdev);
 	struct ixgbevf_ring *tx_ring;
-- 
2.17.0

