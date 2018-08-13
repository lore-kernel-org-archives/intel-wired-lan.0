From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Mon, 13 Aug 2018 11:43:41 -0700
Subject: [Intel-wired-lan] [PATCH next-queue 4/8] ixgbe: add VF IPsec
 offload enable flag
In-Reply-To: <1534185825-12451-1-git-send-email-shannon.nelson@oracle.com>
References: <1534185825-12451-1-git-send-email-shannon.nelson@oracle.com>
Message-ID: <1534185825-12451-5-git-send-email-shannon.nelson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Add a private flag to expressly enable support for VF IPsec offload.
The VF will have to be "trusted" in order to use the hardware offload,
but because of the general concerns of managing VF access, we want to
be sure the user specifically is enabling the feature.

This is likely a candidate for becoming a netdev feature flag.

Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe.h         | 1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c | 9 +++++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c   | 3 ++-
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
index 4fc906c..89e709c 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
@@ -605,6 +605,7 @@ struct ixgbe_adapter {
 #define IXGBE_FLAG2_EEE_ENABLED			BIT(15)
 #define IXGBE_FLAG2_RX_LEGACY			BIT(16)
 #define IXGBE_FLAG2_IPSEC_ENABLED		BIT(17)
+#define IXGBE_FLAG2_VF_IPSEC_ENABLED		BIT(18)
 
 	/* Tx fast path data */
 	int num_tx_queues;
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index e5a8461..732b1e6 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -136,6 +136,8 @@ static const char ixgbe_gstrings_test[][ETH_GSTRING_LEN] = {
 static const char ixgbe_priv_flags_strings[][ETH_GSTRING_LEN] = {
 #define IXGBE_PRIV_FLAGS_LEGACY_RX	BIT(0)
 	"legacy-rx",
+#define IXGBE_PRIV_FLAGS_VF_IPSEC_EN	BIT(1)
+	"vf-ipsec",
 };
 
 #define IXGBE_PRIV_FLAGS_STR_LEN ARRAY_SIZE(ixgbe_priv_flags_strings)
@@ -3409,6 +3411,9 @@ static u32 ixgbe_get_priv_flags(struct net_device *netdev)
 	if (adapter->flags2 & IXGBE_FLAG2_RX_LEGACY)
 		priv_flags |= IXGBE_PRIV_FLAGS_LEGACY_RX;
 
+	if (adapter->flags2 & IXGBE_FLAG2_VF_IPSEC_ENABLED)
+		priv_flags |= IXGBE_PRIV_FLAGS_VF_IPSEC_EN;
+
 	return priv_flags;
 }
 
@@ -3421,6 +3426,10 @@ static int ixgbe_set_priv_flags(struct net_device *netdev, u32 priv_flags)
 	if (priv_flags & IXGBE_PRIV_FLAGS_LEGACY_RX)
 		flags2 |= IXGBE_FLAG2_RX_LEGACY;
 
+	flags2 &= ~IXGBE_FLAG2_VF_IPSEC_ENABLED;
+	if (priv_flags & IXGBE_PRIV_FLAGS_VF_IPSEC_EN)
+		flags2 |= IXGBE_FLAG2_VF_IPSEC_ENABLED;
+
 	if (flags2 != adapter->flags2) {
 		adapter->flags2 = flags2;
 
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
index 80108e1..ecd01fa 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
@@ -880,7 +880,8 @@ int ixgbe_ipsec_vf_add_sa(struct ixgbe_adapter *adapter, u32 *msgbuf, u32 vf)
 	int err;
 
 	sam = (struct sa_mbx_msg *)(&msgbuf[1]);
-	if (!adapter->vfinfo[vf].trusted) {
+	if (!adapter->vfinfo[vf].trusted ||
+	    !(adapter->flags2 & IXGBE_FLAG2_VF_IPSEC_ENABLED)) {
 		e_warn(drv, "VF %d attempted to add an IPsec SA\n", vf);
 		err = -EACCES;
 		goto err_out;
-- 
2.7.4

