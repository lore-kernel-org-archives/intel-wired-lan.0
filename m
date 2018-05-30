From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Wed, 30 May 2018 11:20:04 -0700
Subject: [Intel-wired-lan] [PATCH v2] ixgbe: check ipsec ip addr against
 mgmt filters
Message-ID: <1527704404-14759-1-git-send-email-shannon.nelson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Make sure we don't try to offload the decryption of an incoming
packet that should get delivered to the management engine.  This
is a corner case that will likely be very seldom seen, but could
really confuse someone if they were to hit it.

Suggested-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
---
v2 - added the BMC IP check

 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c | 88 ++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
index 99b170f..e1c9762 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
@@ -445,6 +445,89 @@ static int ixgbe_ipsec_parse_proto_keys(struct xfrm_state *xs,
 }
 
 /**
+ * ixgbe_ipsec_check_mgmt_ip - make sure there is no clash with mgmt IP filters
+ * @xs: pointer to transformer state struct
+ **/
+static int ixgbe_ipsec_check_mgmt_ip(struct xfrm_state *xs)
+{
+	struct net_device *dev = xs->xso.dev;
+	struct ixgbe_adapter *adapter = netdev_priv(dev);
+	struct ixgbe_hw *hw = &adapter->hw;
+	u32 mfval, manc, reg;
+	int num_filters = 4;
+	bool manc_ipv4;
+	u32 bmcipval;
+	int i, j;
+
+#define MANC_EN_IPV4_FILTER      BIT(24)
+#define MFVAL_IPV4_FILTER_SHIFT  16
+#define MFVAL_IPV6_FILTER_SHIFT  24
+#define MIPAF_ARR(_m, _n)        (IXGBE_MIPAF + ((_m) * 0x10) + ((_n) * 4))
+
+#define IXGBE_BMCIP(_n)          (0x5050 + ((_n) * 4))
+#define IXGBE_BMCIPVAL           0x5060
+#define BMCIP_V4                 0x2
+#define BMCIP_V6                 0x3
+#define BMCIP_MASK               0x3
+
+	manc = IXGBE_READ_REG(hw, IXGBE_MANC);
+	manc_ipv4 = !!(manc & MANC_EN_IPV4_FILTER);
+	mfval = IXGBE_READ_REG(hw, IXGBE_MFVAL);
+	bmcipval = IXGBE_READ_REG(hw, IXGBE_BMCIPVAL);
+
+	if (xs->props.family == AF_INET) {
+		/* are there any IPv4 filters to check? */
+		if (manc_ipv4) {
+			/* the 4 ipv4 filters are all in MIPAF(3, i) */
+			for (i = 0; i < num_filters; i++) {
+				if (!(mfval & BIT(MFVAL_IPV4_FILTER_SHIFT + i)))
+					continue;
+
+				reg = IXGBE_READ_REG(hw, MIPAF_ARR(3, i));
+				if (reg == xs->id.daddr.a4)
+					return 1;
+			}
+		}
+
+		if ((bmcipval & BMCIP_MASK) == BMCIP_V4) {
+			reg = IXGBE_READ_REG(hw, IXGBE_BMCIP(3));
+			if (reg == xs->id.daddr.a4)
+				return 1;
+		}
+
+	} else {
+		/* if there are ipv4 filters, they are in the last ipv6 slot */
+		if (manc_ipv4)
+			num_filters = 3;
+
+		for (i = 0; i < num_filters; i++) {
+			if (!(mfval & BIT(MFVAL_IPV6_FILTER_SHIFT + i)))
+				continue;
+
+			for (j = 0; j < 4; j++) {
+				reg = IXGBE_READ_REG(hw, MIPAF_ARR(i, j));
+				if (reg != xs->id.daddr.a6[j])
+					break;
+			}
+			if (j == 4)   /* did we match all 4 words? */
+				return 1;
+		}
+
+		if ((bmcipval & BMCIP_MASK) == BMCIP_V6) {
+			for (j = 0; j < 4; j++) {
+				reg = IXGBE_READ_REG(hw, IXGBE_BMCIP(j));
+				if (reg != xs->id.daddr.a6[j])
+					break;
+			}
+			if (j == 4)   /* did we match all 4 words? */
+				return 1;
+		}
+	}
+
+	return 0;
+}
+
+/**
  * ixgbe_ipsec_add_sa - program device with a security association
  * @xs: pointer to transformer state struct
  **/
@@ -465,6 +548,11 @@ static int ixgbe_ipsec_add_sa(struct xfrm_state *xs)
 		return -EINVAL;
 	}
 
+	if (ixgbe_ipsec_check_mgmt_ip(xs)) {
+		netdev_err(dev, "IPsec IP addr clash with mgmt filters\n");
+		return -EINVAL;
+	}
+
 	if (xs->xso.flags & XFRM_OFFLOAD_INBOUND) {
 		struct rx_sa rsa;
 
-- 
2.7.4

