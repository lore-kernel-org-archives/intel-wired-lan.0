From: kan.liang@intel.com <kan.liang@intel.com>
Date: Tue,  1 Dec 2015 08:01:32 +0000
Subject: [Intel-wired-lan] [RFC 4/4] i40e: handle per queue rx_usecs setting
In-Reply-To: <1448956892-15509-1-git-send-email-kan.liang@intel.com>
References: <1448956892-15509-1-git-send-email-kan.liang@intel.com>
Message-ID: <1448956892-15509-4-git-send-email-kan.liang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Kan Liang <kan.liang@intel.com>

Handle ndo_get_per_queue_rx_usecs and ndo_set_per_queue_rx_usecs
options for i40e driver specifically.

Signed-off-by: Kan Liang <kan.liang@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 39 +++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index d4310ae..c0291bb 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -8710,6 +8710,43 @@ void i40e_ndo_set_per_queue_tx_usecs(struct net_device *dev, int index, u32 val)
 	i40e_flush(hw);
 }
 
+/**
+ * i40e_ndo_get_per_queue_rx_usecs - Get per queue coalesce parameter rx_usecs
+ * @dev: the netdev being configured
+ * @index: queue index
+ *
+ * Return rx_usecs for specific queue
+ **/
+u32 i40e_ndo_get_per_queue_rx_usecs(struct net_device *dev, int index)
+{
+	struct i40e_netdev_priv *np = netdev_priv(dev);
+	struct i40e_vsi *vsi = np->vsi;
+	struct i40e_pf *pf = vsi->back;
+	struct i40e_hw *hw = &pf->hw;
+	u32 val;
+
+	val = rd32(hw, I40E_PFINT_ITRN(0, index));
+
+	return (val * 2);
+}
+
+/**
+ * i40e_ndo_set_per_queue_rx_usecs - Set per queue coalesce parameter rx_usecs
+ * @dev: the netdev being configured
+ * @index: queue index
+ * @val: rx_usecs value
+ **/
+void i40e_ndo_set_per_queue_rx_usecs(struct net_device *dev, int index, u32 val)
+{
+	struct i40e_netdev_priv *np = netdev_priv(dev);
+	struct i40e_vsi *vsi = np->vsi;
+	struct i40e_pf *pf = vsi->back;
+	struct i40e_hw *hw = &pf->hw;
+
+	wr32(hw, I40E_PFINT_ITRN(0, index), val / 2);
+	i40e_flush(hw);
+}
+
 #define I40E_MAX_TUNNEL_HDR_LEN 80
 /**
  * i40e_features_check - Validate encapsulated packet conforms to limits
@@ -8768,6 +8805,8 @@ static const struct net_device_ops i40e_netdev_ops = {
 	.ndo_bridge_setlink	= i40e_ndo_bridge_setlink,
 	.ndo_get_per_queue_tx_usecs	= i40e_ndo_get_per_queue_tx_usecs,
 	.ndo_set_per_queue_tx_usecs	= i40e_ndo_set_per_queue_tx_usecs,
+	.ndo_get_per_queue_rx_usecs	= i40e_ndo_get_per_queue_rx_usecs,
+	.ndo_set_per_queue_rx_usecs	= i40e_ndo_set_per_queue_rx_usecs,
 };
 
 /**
-- 
1.7.11.7

