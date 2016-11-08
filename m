From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Tue,  8 Nov 2016 13:05:09 -0800
Subject: [Intel-wired-lan] [next PATCH S52-V2 05/15] i40e: Fix for ethtool
	Supported link modes
In-Reply-To: <1478639119-14656-1-git-send-email-bimmy.pujari@intel.com>
References: <1478639119-14656-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1478639119-14656-6-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>

This patch fixes the problem where the ethtool Supported link
modes list backplane interfaces on X722 devices for 10GbE with
SFP+ and Cortina retimer. This patch fixes the problem by setting
and using a flag for this particular device since the backplane
interface is only between the internal PHY and the retimer and it
should not be seen by the user as they cannont use it.
Without this patch, the user wrongly thinks that backplane interfaces
are supported on their device when they actually are not.

Signed-off-by: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
Change-ID: I3882bc2928431d48a2db03a51a713a1f681a79e9
---
 drivers/net/ethernet/intel/i40e/i40e.h         |  1 +
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 16 ++++++++++------
 drivers/net/ethernet/intel/i40e/i40e_main.c    |  3 ++-
 3 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 29c2318..4cb8fb3 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -359,6 +359,7 @@ struct i40e_pf {
 #define I40E_FLAG_HAVE_10GBASET_PHY		BIT_ULL(48)
 #define I40E_FLAG_PF_MAC			BIT_ULL(50)
 #define I40E_FLAG_TRUE_PROMISC_SUPPORT		BIT_ULL(51)
+#define I40E_FLAG_HAVE_CRT_RETIMER		BIT_ULL(52)
 
 	/* tracks features that get auto disabled by errors */
 	u64 auto_disable_flags;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 92a2f03..9500e7b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -345,11 +345,13 @@ static void i40e_phy_type_to_ethtool(struct i40e_pf *pf, u32 *supported,
 			*advertising |= ADVERTISED_20000baseKR2_Full;
 	}
 	if (phy_types & I40E_CAP_PHY_TYPE_10GBASE_KR) {
-		*supported |= SUPPORTED_10000baseKR_Full |
-			      SUPPORTED_Autoneg;
+		if (!(pf->flags & I40E_FLAG_HAVE_CRT_RETIMER))
+			*supported |= SUPPORTED_10000baseKR_Full |
+				      SUPPORTED_Autoneg;
 		*advertising |= ADVERTISED_Autoneg;
 		if (hw_link_info->requested_speeds & I40E_LINK_SPEED_10GB)
-			*advertising |= ADVERTISED_10000baseKR_Full;
+			if (!(pf->flags & I40E_FLAG_HAVE_CRT_RETIMER))
+				*advertising |= ADVERTISED_10000baseKR_Full;
 	}
 	if (phy_types & I40E_CAP_PHY_TYPE_10GBASE_KX4) {
 		*supported |= SUPPORTED_10000baseKX4_Full |
@@ -359,11 +361,13 @@ static void i40e_phy_type_to_ethtool(struct i40e_pf *pf, u32 *supported,
 			*advertising |= ADVERTISED_10000baseKX4_Full;
 	}
 	if (phy_types & I40E_CAP_PHY_TYPE_1000BASE_KX) {
-		*supported |= SUPPORTED_1000baseKX_Full |
-			      SUPPORTED_Autoneg;
+		if (!(pf->flags & I40E_FLAG_HAVE_CRT_RETIMER))
+			*supported |= SUPPORTED_1000baseKX_Full |
+				      SUPPORTED_Autoneg;
 		*advertising |= ADVERTISED_Autoneg;
 		if (hw_link_info->requested_speeds & I40E_LINK_SPEED_1GB)
-			*advertising |= ADVERTISED_1000baseKX_Full;
+			if (!(pf->flags & I40E_FLAG_HAVE_CRT_RETIMER))
+				*advertising |= ADVERTISED_1000baseKX_Full;
 	}
 }
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index bae168c..3886119 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -11290,7 +11290,8 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if ((pf->hw.device_id == I40E_DEV_ID_10G_BASE_T) ||
 	    (pf->hw.device_id == I40E_DEV_ID_10G_BASE_T4))
 		pf->flags |= I40E_FLAG_HAVE_10GBASET_PHY;
-
+	if (pf->hw.device_id == I40E_DEV_ID_SFP_I_X722)
+		pf->flags |= I40E_FLAG_HAVE_CRT_RETIMER;
 	/* print a string summarizing features */
 	i40e_print_features(pf);
 
-- 
2.4.11

