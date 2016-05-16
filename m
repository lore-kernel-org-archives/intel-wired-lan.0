From: Dayanand, Avinash <avinash.dayanand@intel.com>
Date: Mon, 16 May 2016 18:26:30 +0000
Subject: [Intel-wired-lan] [next PATCH S37 10/15] i40e: Removing
 unnecessary code which caused supported link mode bug
In-Reply-To: <1463419605-30746-11-git-send-email-bimmy.pujari@intel.com>
References: <1463419605-30746-1-git-send-email-bimmy.pujari@intel.com>
 <1463419605-30746-11-git-send-email-bimmy.pujari@intel.com>
Message-ID: <475EF86EA1AC844AA3BA8EE1F912AD6903CCA105@ORSMSX111.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

ACK, looks good.. 

-----Original Message-----
From: Pujari, Bimmy 
Sent: Monday, May 16, 2016 10:27 AM
To: intel-wired-lan@lists.osuosl.org
Cc: Dayanand, Avinash <avinash.dayanand@intel.com>
Subject: [next PATCH S37 10/15] i40e: Removing unnecessary code which caused supported link mode bug

From: Avinash Dayanand <avinash.dayanand@intel.com>

Removing this code which wasn't allowing 100BaseT to show up in the supported link modes for 10GBaseT PHYs.

Signed-off-by: Avinash Dayanand <avinash.dayanand@intel.com>
Change-ID: Iada2eafa7ef6b4bac9a2a1380ff533ae5de51e1d
---
Testing Hints: Use 'ethtool ethx' check if 100BaseT is listed as one of the supported link modes.

 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 0e80b35..0a96c5a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -313,8 +313,7 @@ static void i40e_phy_type_to_ethtool(struct i40e_pf *pf, u32 *supported,
 		*advertising |= ADVERTISED_Autoneg |
 			       ADVERTISED_40000baseCR4_Full;
 	}
-	if ((phy_types & I40E_CAP_PHY_TYPE_100BASE_TX) &&
-	    !(phy_types & I40E_CAP_PHY_TYPE_1000BASE_T)) {
+	if (phy_types & I40E_CAP_PHY_TYPE_100BASE_TX) {
 		*supported |= SUPPORTED_Autoneg |
 			     SUPPORTED_100baseT_Full;
 		*advertising |= ADVERTISED_Autoneg |
--
2.4.11

