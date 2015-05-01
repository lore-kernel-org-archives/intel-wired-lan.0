From: Alexander Duyck <alexander.h.duyck@redhat.com>
Date: Fri, 01 May 2015 10:34:50 -0700
Subject: [Intel-wired-lan] [net PATCH 3/3] ixgbevf: Use dev_kfree_skb_any in
 xmit path, not dev_kfree_skb
In-Reply-To: <20150501173049.1029.54421.stgit@ahduyck-vm-fedora22>
References: <20150501173049.1029.54421.stgit@ahduyck-vm-fedora22>
Message-ID: <20150501173450.1029.86224.stgit@ahduyck-vm-fedora22>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

With netpoll making use of the transmit function it is possible for the
ndo_start_xmit function to be called with irqs disabled.  As such we need
to use dev_kfree_skb_any in the Tx cleanup path for frames that are
dropped.

Signed-off-by: Alexander Duyck <alexander.h.duyck@redhat.com>
---
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index cca8936f2fc3..acfa05154436 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -3584,7 +3584,7 @@ static int ixgbevf_xmit_frame(struct sk_buff *skb, struct net_device *netdev)
 	u8 *dst_mac = skb_header_pointer(skb, 0, 0, NULL);
 
 	if (!dst_mac || is_link_local_ether_addr(dst_mac)) {
-		dev_kfree_skb(skb);
+		dev_kfree_skb_any(skb);
 		return NETDEV_TX_OK;
 	}
 

