From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Thu, 17 May 2018 11:22:45 -0700
Subject: [Intel-wired-lan] [RFC PATCH 1/6] ixgbe: prep ipsec constants for
 later use
In-Reply-To: <1526581370-30307-1-git-send-email-shannon.nelson@oracle.com>
References: <1526581370-30307-1-git-send-email-shannon.nelson@oracle.com>
Message-ID: <1526581370-30307-2-git-send-email-shannon.nelson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Pull out a couple of values from a function so they can be used
later elsewhere.

Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
index 68af127..92f95f6 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
@@ -29,6 +29,9 @@
 #include <net/xfrm.h>
 #include <crypto/aead.h>
 
+#define IXGBE_IPSEC_KEY_BITS  160
+static const char aes_gcm_name[] = "rfc4106(gcm(aes))";
+
 /**
  * ixgbe_ipsec_set_tx_sa - set the Tx SA registers
  * @hw: hw specific details
@@ -420,7 +423,6 @@ static int ixgbe_ipsec_parse_proto_keys(struct xfrm_state *xs,
 	struct net_device *dev = xs->xso.dev;
 	unsigned char *key_data;
 	char *alg_name = NULL;
-	const char aes_gcm_name[] = "rfc4106(gcm(aes))";
 	int key_len;
 
 	if (!xs->aead) {
@@ -448,9 +450,9 @@ static int ixgbe_ipsec_parse_proto_keys(struct xfrm_state *xs,
 	 * we don't need to do any byteswapping.
 	 * 160 accounts for 16 byte key and 4 byte salt
 	 */
-	if (key_len == 160) {
+	if (key_len == IXGBE_IPSEC_KEY_BITS) {
 		*mysalt = ((u32 *)key_data)[4];
-	} else if (key_len != 128) {
+	} else if (key_len != (IXGBE_IPSEC_KEY_BITS - (sizeof(*mysalt) * 8))) {
 		netdev_err(dev, "IPsec hw offload only supports keys up to 128 bits with a 32 bit salt\n");
 		return -EINVAL;
 	} else {
-- 
2.7.4

