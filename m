From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Fri,  4 Nov 2016 10:36:08 -0700
Subject: [Intel-wired-lan] [next PATCH S52 11/11] i40e: Add media type
	detection for 25G link
In-Reply-To: <1478280968-8098-1-git-send-email-bimmy.pujari@intel.com>
References: <1478280968-8098-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1478280968-8098-12-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Michal Kosiarz <michal.kosiarz@intel.com>

This fixes incorrect media detection for 25G cables.

Signed-off-by: Michal Kosiarz <michal.kosiarz@intel.com>
Change-ID: I0a32e5db16d983e48e468a597e8e97a1cc4f83a1
---
 drivers/net/ethernet/intel/i40e/i40e_common.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index 91d7550..ceff80a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -1185,6 +1185,8 @@ static enum i40e_media_type i40e_get_media_type(struct i40e_hw *hw)
 	case I40E_PHY_TYPE_1000BASE_LX:
 	case I40E_PHY_TYPE_40GBASE_SR4:
 	case I40E_PHY_TYPE_40GBASE_LR4:
+	case I40E_PHY_TYPE_25GBASE_LR:
+	case I40E_PHY_TYPE_25GBASE_SR:
 		media = I40E_MEDIA_TYPE_FIBER;
 		break;
 	case I40E_PHY_TYPE_100BASE_TX:
@@ -1199,6 +1201,7 @@ static enum i40e_media_type i40e_get_media_type(struct i40e_hw *hw)
 	case I40E_PHY_TYPE_10GBASE_SFPP_CU:
 	case I40E_PHY_TYPE_40GBASE_AOC:
 	case I40E_PHY_TYPE_10GBASE_AOC:
+	case I40E_PHY_TYPE_25GBASE_CR:
 		media = I40E_MEDIA_TYPE_DA;
 		break;
 	case I40E_PHY_TYPE_1000BASE_KX:
@@ -1206,6 +1209,7 @@ static enum i40e_media_type i40e_get_media_type(struct i40e_hw *hw)
 	case I40E_PHY_TYPE_10GBASE_KR:
 	case I40E_PHY_TYPE_40GBASE_KR4:
 	case I40E_PHY_TYPE_20GBASE_KR2:
+	case I40E_PHY_TYPE_25GBASE_KR:
 		media = I40E_MEDIA_TYPE_BACKPLANE;
 		break;
 	case I40E_PHY_TYPE_SGMII:
-- 
2.4.11

