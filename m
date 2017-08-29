From: Alice Michael <alice.michael@intel.com>
Date: Tue, 29 Aug 2017 05:32:37 -0400
Subject: [Intel-wired-lan] [next PATCH S79-V2 08/13] i40e: Display error
	message if module does not meet thermal requirements
In-Reply-To: <20170829093242.41026-1-alice.michael@intel.com>
References: <20170829093242.41026-1-alice.michael@intel.com>
Message-ID: <20170829093242.41026-8-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Filip Sadowski <filip.sadowski@intel.com>

This patch causes error message to be displayed when NIC detects
insertion of module that does not meet thermal requirements.

Signed-off-by: Filip Sadowski <filip.sadowski@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h  |  1 +
 drivers/net/ethernet/intel/i40e/i40e_main.c        | 24 +++++++++++++++++-----
 .../net/ethernet/intel/i40evf/i40e_adminq_cmd.h    |  1 +
 3 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h b/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
index 50c5a4c..a8f65ae 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
@@ -1772,6 +1772,7 @@ enum i40e_aq_phy_type {
 	I40E_PHY_TYPE_25GBASE_SR		= 0x21,
 	I40E_PHY_TYPE_25GBASE_LR		= 0x22,
 	I40E_PHY_TYPE_MAX,
+	I40E_PHY_TYPE_NOT_SUPPORTED_HIGH_TEMP	= 0xFD,
 	I40E_PHY_TYPE_EMPTY			= 0xFE,
 	I40E_PHY_TYPE_DEFAULT			= 0xFF,
 };
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 85bf225..b1712b4 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -6559,12 +6559,26 @@ static void i40e_handle_link_event(struct i40e_pf *pf,
 	 */
 	i40e_link_event(pf);
 
-	/* check for unqualified module, if link is down */
-	if ((status->link_info & I40E_AQ_MEDIA_AVAILABLE) &&
-	    (!(status->an_info & I40E_AQ_QUALIFIED_MODULE)) &&
-	    (!(status->link_info & I40E_AQ_LINK_UP)))
+	/* Check if module meets thermal requirements */
+	if (status->phy_type == I40E_PHY_TYPE_NOT_SUPPORTED_HIGH_TEMP) {
 		dev_err(&pf->pdev->dev,
-			"The driver failed to link because an unqualified module was detected.\n");
+			"Rx/Tx is disabled on this device because the module does not meet thermal requirements.\n");
+		dev_err(&pf->pdev->dev,
+			"Refer to the Intel(R) Ethernet Adapters and Devices User Guide for a list of supported modules.\n");
+	} else {
+		/* check for unqualified module, if link is down, suppress
+		 * the message if link was forced to be down.
+		 */
+		if ((status->link_info & I40E_AQ_MEDIA_AVAILABLE) &&
+		    (!(status->an_info & I40E_AQ_QUALIFIED_MODULE)) &&
+		    (!(status->link_info & I40E_AQ_LINK_UP)) &&
+		    (!(pf->flags & I40E_FLAG_LINK_DOWN_ON_CLOSE_ENABLED))) {
+			dev_err(&pf->pdev->dev,
+				"Rx/Tx is disabled on this device because an unsupported SFP module type was detected.\n");
+			dev_err(&pf->pdev->dev,
+				"Refer to the Intel(R) Ethernet Adapters and Devices User Guide for a list of supported modules.\n");
+		}
+	}
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h b/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h
index dc6fc8b..60c892f 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h
@@ -1768,6 +1768,7 @@ enum i40e_aq_phy_type {
 	I40E_PHY_TYPE_25GBASE_SR		= 0x21,
 	I40E_PHY_TYPE_25GBASE_LR		= 0x22,
 	I40E_PHY_TYPE_MAX,
+	I40E_PHY_TYPE_NOT_SUPPORTED_HIGH_TEMP	= 0xFD,
 	I40E_PHY_TYPE_EMPTY			= 0xFE,
 	I40E_PHY_TYPE_DEFAULT			= 0xFF,
 };
-- 
2.9.4

