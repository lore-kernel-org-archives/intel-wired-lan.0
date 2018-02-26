From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Mon, 26 Feb 2018 10:15:43 -0800
Subject: [Intel-wired-lan] [PATCH 1/3] ixgbe: check for 128-bit
 authentication
Message-ID: <20180226181545.11151-1-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Shannon Nelson <shannon.nelson@oracle.com>

Make sure the Security Association is using
a 128-bit authentication, since that's the only
size that the hardware offload supports.

Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c | 16 +++++++++++-----
 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.h |  1 +
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
index 93eacddb6704..8b7dbc8057eb 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
@@ -423,15 +423,21 @@ static int ixgbe_ipsec_parse_proto_keys(struct xfrm_state *xs,
 	const char aes_gcm_name[] = "rfc4106(gcm(aes))";
 	int key_len;
 
-	if (xs->aead) {
-		key_data = &xs->aead->alg_key[0];
-		key_len = xs->aead->alg_key_len;
-		alg_name = xs->aead->alg_name;
-	} else {
+	if (!xs->aead) {
 		netdev_err(dev, "Unsupported IPsec algorithm\n");
 		return -EINVAL;
 	}
 
+	if (xs->aead->alg_icv_len != IXGBE_IPSEC_AUTH_BITS) {
+		netdev_err(dev, "IPsec offload requires %d bit authentication\n",
+			   IXGBE_IPSEC_AUTH_BITS);
+		return -EINVAL;
+	}
+
+	key_data = &xs->aead->alg_key[0];
+	key_len = xs->aead->alg_key_len;
+	alg_name = xs->aead->alg_name;
+
 	if (strcmp(alg_name, aes_gcm_name)) {
 		netdev_err(dev, "Unsupported IPsec algorithm - please use %s\n",
 			   aes_gcm_name);
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.h
index 9c00e413c8e9..4f099f516645 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.h
@@ -33,6 +33,7 @@
 #define IXGBE_IPSEC_MAX_RX_IP_COUNT	128
 #define IXGBE_IPSEC_BASE_RX_INDEX	0
 #define IXGBE_IPSEC_BASE_TX_INDEX	IXGBE_IPSEC_MAX_SA_COUNT
+#define IXGBE_IPSEC_AUTH_BITS		128
 
 #define IXGBE_RXTXIDX_IPS_EN		0x00000001
 #define IXGBE_RXIDX_TBL_SHIFT		1
-- 
2.14.3

