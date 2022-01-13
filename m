From: Michal Maloszewski <michal.maloszewski@intel.com>
Date: Thu, 13 Jan 2022 13:51:44 +0000
Subject: [Intel-wired-lan] [PATCH net v1] iavf: Fix handling of vlan strip
 virtual channel messages
Message-ID: <20220113135144.25320-1-michal.maloszewski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Modify netdev->features for vlan stripping based on virtual
channel messages received from the PF. Change is needed
to synchronize vlan strip status between PF sysfs and iavf ethtool.

Fixes: 310a2ad92e3f ("virtchnl: rename i40e to generic virtchnl")
Signed-off-by: Norbert Ciosek <norbertx.ciosek@intel.com>
Signed-off-by: Michal Maloszewski <michal.maloszewski@intel.com>
---
v3: NETIF_F_HW_VLAN_RX changed into NETIF_F_HW_VLAN_CTAG_RX because there's
no such definition since Linux 3.10. The code is the same as the one from OOT.
Code successfully passed inner review. netdev_update_features() function is not added 
because it causes infinite loop.
---
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index a40e29455f7d..1805c1ae3bf4 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
@@ -1490,6 +1490,24 @@ void iavf_request_reset(struct iavf_adapter *adapter)
 	adapter->current_op = VIRTCHNL_OP_UNKNOWN;
 }
 
+/**
+ * iavf_netdev_features_vlan_strip_set - update vlan strip status
+ * @netdev: ptr to netdev being adjusted
+ * @enable: enable or disable vlan strip
+ *
+ * Helper function to change vlan strip status in netdev->features.
+ */
+static void iavf_netdev_features_vlan_strip_set(struct net_device *netdev,
+						const bool enable)
+{
+	if (enable)
+		netdev->features |=
+			NETIF_F_HW_VLAN_CTAG_RX | NETIF_F_HW_VLAN_CTAG_RX;
+	else
+		netdev->features &=
+			~NETIF_F_HW_VLAN_CTAG_RX & ~NETIF_F_HW_VLAN_CTAG_RX;
+}
+
 /**
  * iavf_virtchnl_completion
  * @adapter: adapter structure
@@ -1713,8 +1731,18 @@ void iavf_virtchnl_completion(struct iavf_adapter *adapter,
 			}
 			break;
 		case VIRTCHNL_OP_ENABLE_VLAN_STRIPPING:
+			dev_warn(&adapter->pdev->dev, "Changing VLAN Stripping is not allowed when Port VLAN is configured\n");
+			/* Vlan stripping could not be enabled by ethtool.
+			 * Disable it in netdev->features.
+			 */
+			iavf_netdev_features_vlan_strip_set(netdev, false);
+			break;
 		case VIRTCHNL_OP_DISABLE_VLAN_STRIPPING:
 			dev_warn(&adapter->pdev->dev, "Changing VLAN Stripping is not allowed when Port VLAN is configured\n");
+			/* Vlan stripping could not be disabled by ethtool.
+			 * Enable it in netdev->features.
+			 */
+			iavf_netdev_features_vlan_strip_set(netdev, true);
 			break;
 		default:
 			dev_err(&adapter->pdev->dev, "PF returned error %d (%s) to our request %d\n",
@@ -1960,6 +1988,20 @@ void iavf_virtchnl_completion(struct iavf_adapter *adapter,
 		spin_unlock_bh(&adapter->adv_rss_lock);
 		}
 		break;
+	case VIRTCHNL_OP_ENABLE_VLAN_STRIPPING:
+		/* PF enabled vlan strip on this VF.
+		 * Update netdev->features if needed to be in sync with ethtool.
+		 */
+		if (!v_retval)
+			iavf_netdev_features_vlan_strip_set(netdev, true);
+		break;
+	case VIRTCHNL_OP_DISABLE_VLAN_STRIPPING:
+		/* PF disabled vlan strip on this VF.
+		 * Update netdev->features if needed to be in sync with ethtool.
+		 */
+		if (!v_retval)
+			iavf_netdev_features_vlan_strip_set(netdev, false);
+		break;
 	default:
 		if (adapter->current_op && (v_opcode != adapter->current_op))
 			dev_warn(&adapter->pdev->dev, "Expected response %d from PF, received %d\n",
-- 
2.27.0

