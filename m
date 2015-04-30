From: Alexander Duyck <alexander.h.duyck@redhat.com>
Date: Thu, 30 Apr 2015 13:58:24 -0700
Subject: [Intel-wired-lan] [PATCH 2/3] r8169: Use dev_kfree_skb in Tx
	cleanup path
In-Reply-To: <20150430205423.1512.13487.stgit@ahduyck-vm-fedora22>
References: <20150430205423.1512.13487.stgit@ahduyck-vm-fedora22>
Message-ID: <20150430205824.1512.35158.stgit@ahduyck-vm-fedora22>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This change replaces the use of either dev_kfree_skb_any or
dev_consume_skb_any in the Tx cleanup path of this driver with
dev_kfree_skb.  There isn't any need for the "_any" version of these
functions since the NAPI cleanup context is not a hard irq context.

This change allows us to drop one function call from the clean-up path
since dev_kfree_skb_any was just calling into dev_kfree_skb in these paths
anyway.

Signed-off-by: Alexander Duyck <alexander.h.duyck@redhat.com>
---
 drivers/net/ethernet/realtek/r8169.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/realtek/r8169.c b/drivers/net/ethernet/realtek/r8169.c
index c70ab40d8698..ca94040b0ec2 100644
--- a/drivers/net/ethernet/realtek/r8169.c
+++ b/drivers/net/ethernet/realtek/r8169.c
@@ -7215,7 +7215,7 @@ static void rtl_tx(struct net_device *dev, struct rtl8169_private *tp)
 			tp->tx_stats.packets++;
 			tp->tx_stats.bytes += tx_skb->skb->len;
 			u64_stats_update_end(&tp->tx_stats.syncp);
-			dev_kfree_skb_any(tx_skb->skb);
+			dev_kfree_skb(tx_skb->skb);
 			tx_skb->skb = NULL;
 		}
 		dirty_tx++;

