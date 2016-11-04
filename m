From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Fri,  4 Nov 2016 10:36:04 -0700
Subject: [Intel-wired-lan] [next PATCH S52 07/11] i40e: Add support for 25G
	devices
In-Reply-To: <1478280968-8098-1-git-send-email-bimmy.pujari@intel.com>
References: <1478280968-8098-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1478280968-8098-8-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Carolyn Wyborny <carolyn.wyborny@intel.com>

Add support for 25G devices.

Signed-off-by: Carolyn Wyborny <carolyn.wyborny@intel.com>
Change-ID: I69b24d837d44cf9220bf5cb8dd46c5be89ce490b
---
Testing Hints : Check that 25G devices link and report
correct device speed.

 drivers/net/ethernet/intel/i40e/i40e_ethtool.c      | 20 +++++++++++++++++++-
 drivers/net/ethernet/intel/i40e/i40e_main.c         |  4 +++-
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c  |  3 +++
 drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c  |  8 ++++++++
 drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c |  3 +++
 5 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 92a2f03..834aa23 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -265,8 +265,9 @@ static void i40e_partition_setting_complaint(struct i40e_pf *pf)
 static void i40e_phy_type_to_ethtool(struct i40e_pf *pf, u32 *supported,
 				     u32 *advertising)
 {
-	enum i40e_aq_capabilities_phy_type phy_types = pf->hw.phy.phy_types;
 	struct i40e_link_status *hw_link_info = &pf->hw.phy.link_info;
+	u64 phy_types = pf->hw.phy.phy_types;
+
 	*supported = 0x0;
 	*advertising = 0x0;
 
@@ -365,6 +366,15 @@ static void i40e_phy_type_to_ethtool(struct i40e_pf *pf, u32 *supported,
 		if (hw_link_info->requested_speeds & I40E_LINK_SPEED_1GB)
 			*advertising |= ADVERTISED_1000baseKX_Full;
 	}
+	if (phy_types & I40E_CAP_PHY_TYPE_25GBASE_KR ||
+	    phy_types & I40E_CAP_PHY_TYPE_25GBASE_CR ||
+	    phy_types & I40E_CAP_PHY_TYPE_25GBASE_SR ||
+	    phy_types & I40E_CAP_PHY_TYPE_25GBASE_LR) {
+		*supported |= SUPPORTED_Autoneg |
+			     SUPPORTED_2500baseX_Full;
+		*advertising |= ADVERTISED_Autoneg |
+			       ADVERTISED_2500baseX_Full;
+	}
 }
 
 /**
@@ -487,6 +497,14 @@ static void i40e_get_settings_link_up(struct i40e_hw *hw,
 				     ADVERTISED_1000baseKX_Full |
 				     ADVERTISED_Autoneg;
 		break;
+	case I40E_PHY_TYPE_25GBASE_KR:
+	case I40E_PHY_TYPE_25GBASE_CR:
+	case I40E_PHY_TYPE_25GBASE_SR:
+	case I40E_PHY_TYPE_25GBASE_LR:
+		ecmd->supported |= SUPPORTED_2500baseX_Full |
+				   SUPPORTED_Autoneg;
+		ecmd->advertising |= ADVERTISED_2500baseX_Full |
+				     ADVERTISED_Autoneg;
 	default:
 		/* if we got here and link is up something bad is afoot */
 		netdev_info(netdev, "WARNING: Link is up but PHY type 0x%x is not recognized.\n",
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index c7b3a39..9df1496 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -5182,6 +5182,9 @@ void i40e_print_link_message(struct i40e_vsi *vsi, bool isup)
 	case I40E_LINK_SPEED_20GB:
 		speed = "20 G";
 		break;
+	case I40E_LINK_SPEED_25GB:
+		speed = "25 G";
+		break;
 	case I40E_LINK_SPEED_10GB:
 		speed = "10 G";
 		break;
@@ -11275,7 +11278,6 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		dev_dbg(&pf->pdev->dev, "get supported phy types ret =  %s last_status =  %s\n",
 			i40e_stat_str(&pf->hw, err),
 			i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
-	pf->hw.phy.phy_types = le32_to_cpu(abilities.phy_type);
 
 	/* Add a filter to drop all Flow control frames from any VSI from being
 	 * transmitted. By doing so we stop a malicious VF from sending out
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 46908c0..b414705 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -2914,6 +2914,9 @@ int i40e_ndo_set_vf_bw(struct net_device *netdev, int vf_id, int min_tx_rate,
 	case I40E_LINK_SPEED_40GB:
 		speed = 40000;
 		break;
+	case I40E_LINK_SPEED_25GB:
+		speed = 25000;
+		break;
 	case I40E_LINK_SPEED_20GB:
 		speed = 20000;
 		break;
diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c b/drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c
index a994015..272d600 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c
@@ -85,6 +85,14 @@ static int i40evf_get_settings(struct net_device *netdev,
 	case I40E_LINK_SPEED_40GB:
 		ethtool_cmd_speed_set(ecmd, SPEED_40000);
 		break;
+	case I40E_LINK_SPEED_25GB:
+#ifdef SPEED_25000
+		ethtool_cmd_speed_set(ecmd, SPEED_25000);
+#else
+		netdev_info(netdev,
+			    "Speed is 25G, display not supported by this version of ethtool.\n");
+#endif
+		break;
 	case I40E_LINK_SPEED_20GB:
 		ethtool_cmd_speed_set(ecmd, SPEED_20000);
 		break;
diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c b/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
index ddf478d..2059a8e 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
@@ -836,6 +836,9 @@ static void i40evf_print_link_message(struct i40evf_adapter *adapter)
 	case I40E_LINK_SPEED_40GB:
 		speed = "40 G";
 		break;
+	case I40E_LINK_SPEED_25GB:
+		speed = "25 G";
+		break;
 	case I40E_LINK_SPEED_20GB:
 		speed = "20 G";
 		break;
-- 
2.4.11

