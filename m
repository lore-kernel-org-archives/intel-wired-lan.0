From: Alice Michael <alice.michael@intel.com>
Date: Fri, 29 Mar 2019 15:08:35 -0700
Subject: [Intel-wired-lan] [next PATCH S4 06/11] i40e: Fix the typo in
 adding 40GE KR4 mode
In-Reply-To: <20190329220840.51187-1-alice.michael@intel.com>
References: <20190329220840.51187-1-alice.michael@intel.com>
Message-ID: <20190329220840.51187-6-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Grzegorz Siwik <grzegorz.siwik@intel.com>

This patch fixes the typo in I40E_CAP_PHY_TYPE mode link code.
It was fixed by changing 40000baseLR4_Full to 40000baseKR4_Full

Signed-off-by: Grzegorz Siwik <grzegorz.siwik@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index c056d47dfc72..74c2f15cf42e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -549,9 +549,9 @@ static void i40e_phy_type_to_ethtool(struct i40e_pf *pf,
 	}
 	if (phy_types & I40E_CAP_PHY_TYPE_40GBASE_KR4) {
 		ethtool_link_ksettings_add_link_mode(ks, supported,
-						     40000baseLR4_Full);
+						     40000baseKR4_Full);
 		ethtool_link_ksettings_add_link_mode(ks, advertising,
-						     40000baseLR4_Full);
+						     40000baseKR4_Full);
 	}
 	if (phy_types & I40E_CAP_PHY_TYPE_20GBASE_KR2) {
 		ethtool_link_ksettings_add_link_mode(ks, supported,
-- 
2.19.2

