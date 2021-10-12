From: Michal Maloszewski <michal.maloszewski@intel.com>
Date: Tue, 12 Oct 2021 13:04:47 +0000
Subject: [Intel-wired-lan] [PATCH net v1] iavf: Fix handling of vlan strip
 virtual channel messages
Message-ID: <20211012130447.6177-1-michal.maloszewski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Modify netdev->features for vlan stripping based on virtual
channel messages received from the PF. Change is needed
to synchronize vlan strip status between PF sysfs and iavf ethtool.

Fixes: 54a4f0239f2e ("KVM: MMU: make kvm_mmu_zap_page() return the number of pages it actually freed")
Signed-off-by: Norbert Ciosek <norbertx.ciosek@intel.com>
Signed-off-by: Michal Maloszewski <michal.maloszewski@intel.com>
---
v2: commit message and comments corrected
    note that splitting lines is necessary because the number of allowable characters on the line is exceeded
---
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   | 44 ++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index 9c128462ed..68761b92f6 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
@@ -1456,6 +1456,22 @@ void iavf_request_reset(struct iavf_adapter *adapter)
 	adapter->current_op = VIRTCHNL_OP_UNKNOWN;
 }
 
+/**
+ * iavf_netdev_features_vlan_strip_set
+ * @netdev: ptr to netdev being adjusted
+ * @enable: enable or disable vlan strip
+ *
+ * Helper function to change vlan strip status in netdev->features.
+ **/
+static void iavf_netdev_features_vlan_strip_set(struct net_device *netdev,
+					       const bool enable)
+{
+	if (enable)
+	     netdev->features |= NETIF_F_HW_VLAN_CTAG_RX | NETIF_F_HW_VLAN_RX;
+	else
+	     netdev->features &= ~NETIF_F_HW_VLAN_CTAG_RX & ~NETIF_F_HW_VLAN_RX;
+}
+
 /**
  * iavf_virtchnl_completion
  * @adapter: adapter structure
@@ -1679,8 +1695,20 @@ void iavf_virtchnl_completion(struct iavf_adapter *adapter,
 			}
 			break;
 		case VIRTCHNL_OP_ENABLE_VLAN_STRIPPING:
+			dev_warn(&adapter->pdev->dev,
+				 "Changing VLAN Stripping is not allowed when Port VLAN is configured\n");
+			/*Vlan stripping could not be enabled by ethtool.
+			 * Disable it in netdev->features.
+			 */
+			iavf_netdev_features_vlan_strip_set(netdev, false);
+			break;
 		case VIRTCHNL_OP_DISABLE_VLAN_STRIPPING:
-			dev_warn(&adapter->pdev->dev, "Changing VLAN Stripping is not allowed when Port VLAN is configured\n");
+			dev_warn(&adapter->pdev->dev,
+				 "Changing VLAN Stripping is not allowed when Port VLAN is configured\n");
+			/*Vlan stripping could not be disabled by ethtool.
+			 * Enable it in netdev->features.
+			 */
+			iavf_netdev_features_vlan_strip_set(netdev, true);
 			break;
 		default:
 			dev_err(&adapter->pdev->dev, "PF returned error %d (%s) to our request %d\n",
@@ -1897,6 +1925,20 @@ void iavf_virtchnl_completion(struct iavf_adapter *adapter,
 		spin_unlock_bh(&adapter->adv_rss_lock);
 		}
 		break;
+	case VIRTCHNL_OP_ENABLE_VLAN_STRIPPING:
+		/*Got information that PF enabled vlan strip on this VF.
+		 * Update netdev->features if needed to be in sync with ethtool.
+		 */
+		if (!v_retval)
+			iavf_netdev_features_vlan_strip_set(netdev, true);
+		break;
+	case VIRTCHNL_OP_DISABLE_VLAN_STRIPPING:
+		/* Got information that PF disabled vlan strip on this VF.
+		 * Update netdev->features if needed to be in sync with ethtool.
+		 */
+		if (!v_retval)
+			iavf_netdev_features_vlan_strip_set(netdev, false);
+		break;
 	default:
 		if (adapter->current_op && (v_opcode != adapter->current_op))
 			dev_dbg(&adapter->pdev->dev, "Expected response %d from PF, received %d\n",
-- 
2.27.0

