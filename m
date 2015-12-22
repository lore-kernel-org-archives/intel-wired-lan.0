From: Deepthi Kavalur <deepthi.kavalur@intel.com>
Date: Tue, 22 Dec 2015 14:25:14 -0800
Subject: [Intel-wired-lan] [next PATCH S24 12/12] i40e: add 100Mb ethtool
	reporting
In-Reply-To: <1450823114-29514-1-git-send-email-deepthi.kavalur@intel.com>
References: <1450823114-29514-1-git-send-email-deepthi.kavalur@intel.com>
Message-ID: <1450823114-29514-13-git-send-email-deepthi.kavalur@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Catherine Sullivan <catherine.sullivan@intel.com>

Add some missing reporting/advertisement of 100Mb capability
for adapters that support it.

Signed-off-by: Catherine Sullivan <catherine.sullivan@intel.com>
Change-ID: I8b8523fbdc99517bec29d90c71b3744db11542ac
---
Testing-Hints:
Check that 100M SGMII is not listed as supported on X710
devices and is listed as supported on X722 devices.

 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 4 ++++
 drivers/net/ethernet/intel/i40e/i40e_main.c    | 3 ++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 29eb718..e13ee93 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -412,6 +412,10 @@ static void i40e_get_settings_link_down(struct i40e_hw *hw,
 		if (pf->hw.mac.type == I40E_MAC_X722) {
 			ecmd->supported |= SUPPORTED_100baseT_Full;
 			ecmd->advertising |= ADVERTISED_100baseT_Full;
+			if (pf->flags & I40E_FLAG_100M_SGMII_CAPABLE) {
+				ecmd->supported |= SUPPORTED_100baseT_Full;
+				ecmd->advertising |= ADVERTISED_100baseT_Full;
+			}
 		}
 	}
 	if (phy_types & I40E_CAP_PHY_TYPE_XAUI ||
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 5bb1eae..66cc702 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -8448,7 +8448,8 @@ static int i40e_sw_init(struct i40e_pf *pf)
 			     I40E_FLAG_HW_ATR_EVICT_CAPABLE |
 			     I40E_FLAG_OUTER_UDP_CSUM_CAPABLE |
 			     I40E_FLAG_WB_ON_ITR_CAPABLE |
-			     I40E_FLAG_MULTIPLE_TCP_UDP_RSS_PCTYPE;
+			     I40E_FLAG_MULTIPLE_TCP_UDP_RSS_PCTYPE |
+			     I40E_FLAG_100M_SGMII_CAPABLE;
 	} else {
 		pf->auto_disable_flags = I40E_FLAG_HW_ATR_EVICT_CAPABLE;
 	}
-- 
2.1.0

