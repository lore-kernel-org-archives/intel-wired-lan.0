From: Alexander Duyck <aduyck@mirantis.com>
Date: Wed, 06 Jan 2016 23:11:26 -0800
Subject: [Intel-wired-lan] [next PATCH 09/11] igb: Drop unnecessary checks
	in transmit path
In-Reply-To: <20160107070850.13648.21033.stgit@localhost.localdomain>
References: <20160107070850.13648.21033.stgit@localhost.localdomain>
Message-ID: <20160107071126.13648.59051.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch drops several checks that we dropped from ixgbe some ago.  It
should not be possible for us to be called with either of the conditional
statements returning true so we can just drop them from the hot-path.

Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c |   10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 04a23230c4dc..49daac3bb051 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -5317,16 +5317,6 @@ static netdev_tx_t igb_xmit_frame(struct sk_buff *skb,
 {
 	struct igb_adapter *adapter = netdev_priv(netdev);
 
-	if (test_bit(__IGB_DOWN, &adapter->state)) {
-		dev_kfree_skb_any(skb);
-		return NETDEV_TX_OK;
-	}
-
-	if (skb->len <= 0) {
-		dev_kfree_skb_any(skb);
-		return NETDEV_TX_OK;
-	}
-
 	/* The minimum packet size with TCTL.PSP set is 17 so pad the skb
 	 * in order to meet this minimum size requirement.
 	 */

