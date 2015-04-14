From: Jesse Gross <jesse@nicira.com>
Date: Tue, 14 Apr 2015 16:35:49 -0700
Subject: [Intel-wired-lan] [PATCH net] i40e: Implement ndo_features_check()
Message-ID: <1429054549-118911-1-git-send-email-jesse@nicira.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Joe Stringer <joestringer@nicira.com>

i40e supports UDP tunnel headers up to 80 bytes in length, so
this adds a check to ensure that it doesn't try to offload
packets that exceed that.

Signed-off-by: Joe Stringer <joestringer@nicira.com>
Signed-off-by: Jesse Gross <jesse@nicira.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index dadda3c..16357b9 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -7653,6 +7653,25 @@ static int i40e_ndo_fdb_add(struct ndmsg *ndm, struct nlattr *tb[],
 	return err;
 }
 
+/**
+ * i40e_features_check - Validate encapsulated packet conforms to limits
+ * @skb: skb buff
+ * @netdev: This physical port's netdev
+ * @features: Offload features that the stack believes apply
+ **/
+#define I40E_MAX_TUNNEL_HDR_LEN                80
+static netdev_features_t i40e_features_check(struct sk_buff *skb,
+					     struct net_device *dev,
+					     netdev_features_t features)
+{
+	if (skb->encapsulation &&
+	    (skb_inner_mac_header(skb) - skb_transport_header(skb) >
+	     I40E_MAX_TUNNEL_HDR_LEN))
+		return features & ~(NETIF_F_ALL_CSUM | NETIF_F_GSO_MASK);
+
+	return features;
+}
+
 static const struct net_device_ops i40e_netdev_ops = {
 	.ndo_open		= i40e_open,
 	.ndo_stop		= i40e_close,
@@ -7687,6 +7706,7 @@ static const struct net_device_ops i40e_netdev_ops = {
 #endif
 	.ndo_get_phys_port_id	= i40e_get_phys_port_id,
 	.ndo_fdb_add		= i40e_ndo_fdb_add,
+	.ndo_features_check	= i40e_features_check,
 };
 
 /**
-- 
1.9.1

