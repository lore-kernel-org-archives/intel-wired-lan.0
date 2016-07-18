From: kan.liang@intel.com <kan.liang@intel.com>
Date: Sun, 17 Jul 2016 23:55:57 -0700
Subject: [Intel-wired-lan] [RFC PATCH 03/30] i40e/netpolicy: Implement
	ndo_netpolicy_init
In-Reply-To: <1468824984-65318-1-git-send-email-kan.liang@intel.com>
References: <1468824984-65318-1-git-send-email-kan.liang@intel.com>
Message-ID: <1468824984-65318-4-git-send-email-kan.liang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Kan Liang <kan.liang@intel.com>

Support ndo_netpolicy_init in i40e driver.
For i40e driver, there is no extra initialization work to do. It only
needs to update the available policy bitmap.
policy_param will be filled according to different policies later.

Signed-off-by: Kan Liang <kan.liang@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 41 +++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 2b11405..ee1f0b2 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -8960,6 +8960,44 @@ static netdev_features_t i40e_features_check(struct sk_buff *skb,
 	return features;
 }
 
+#ifdef CONFIG_NETPOLICY
+
+#define NET_POLICY_NOT_SUPPORT	-2
+#define NET_POLICY_END		-3
+static int policy_param[NET_POLICY_MAX + 1][2] = {
+	/* rx-usec, tx-usec */
+	{0, 0},
+
+	{NET_POLICY_END, NET_POLICY_END},
+};
+
+/**
+ * i40e_ndo_netpolicy_init
+ * @dev: the net device pointer
+ * @info: netpolicy info which need to be updated
+ *
+ * Init and update available policy on i40e driver
+ * Returns 0 on success, negative on failure
+ */
+static int i40e_ndo_netpolicy_init(struct net_device *dev,
+				   struct netpolicy_info *info)
+{
+	int i;
+
+	for (i = 0; i < NET_POLICY_MAX; i++) {
+		if ((policy_param[i][0] == NET_POLICY_END) &&
+		    (policy_param[i][1] == NET_POLICY_END))
+			break;
+
+		if ((policy_param[i][0] != NET_POLICY_NOT_SUPPORT) &&
+		    (policy_param[i][1] != NET_POLICY_NOT_SUPPORT))
+			set_bit(i, info->avail_policy);
+	}
+
+	return 0;
+}
+#endif /* CONFIG_NETPOLICY */
+
 static const struct net_device_ops i40e_netdev_ops = {
 	.ndo_open		= i40e_open,
 	.ndo_stop		= i40e_close,
@@ -8996,6 +9034,9 @@ static const struct net_device_ops i40e_netdev_ops = {
 	.ndo_features_check	= i40e_features_check,
 	.ndo_bridge_getlink	= i40e_ndo_bridge_getlink,
 	.ndo_bridge_setlink	= i40e_ndo_bridge_setlink,
+#ifdef CONFIG_NETPOLICY
+	.ndo_netpolicy_init	= i40e_ndo_netpolicy_init,
+#endif /* CONFIG_NETPOLICY */
 };
 
 /**
-- 
2.5.5

