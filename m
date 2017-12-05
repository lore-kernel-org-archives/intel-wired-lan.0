From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Mon,  4 Dec 2017 21:35:16 -0800
Subject: [Intel-wired-lan] [next-queue 10/10] ixgbe: register ipsec offload
 with the xfrm subsystem
In-Reply-To: <1512452116-14795-1-git-send-email-shannon.nelson@oracle.com>
References: <1512452116-14795-1-git-send-email-shannon.nelson@oracle.com>
Message-ID: <1512452116-14795-11-git-send-email-shannon.nelson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

With all the support code in place we can now link in the ipsec
offload operations and set the ESP feature flag for the XFRM
subsystem to see.

Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c | 4 ++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c  | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
index d1220bf..0d5497b 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
@@ -884,6 +884,10 @@ void ixgbe_init_ipsec_offload(struct ixgbe_adapter *adapter)
 	ixgbe_ipsec_clear_hw_tables(adapter);
 	ixgbe_ipsec_stop_engine(adapter);
 
+	adapter->netdev->xfrmdev_ops = &ixgbe_xfrmdev_ops;
+	adapter->netdev->features |= NETIF_F_HW_ESP;
+	adapter->netdev->hw_enc_features |= NETIF_F_HW_ESP;
+
 	return;
 err:
 	if (ipsec) {
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index c857594..9231351 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -9799,6 +9799,10 @@ ixgbe_features_check(struct sk_buff *skb, struct net_device *dev,
 	if (skb->encapsulation && !(features & NETIF_F_TSO_MANGLEID))
 		features &= ~NETIF_F_TSO;
 
+	/* IPsec offload doesn't get along well with others *yet* */
+	if (skb->sp)
+		features &= ~(NETIF_F_TSO | NETIF_F_HW_CSUM_BIT);
+
 	return features;
 }
 
-- 
2.7.4

