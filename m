From: Stefan Assmann <sassmann@kpanic.de>
Date: Mon, 27 Jun 2016 15:03:43 +0200
Subject: [Intel-wired-lan] [PATCH net-next] i40e: add missing link advertise
	setting
Message-ID: <1467032623-1078-1-git-send-email-sassmann@kpanic.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Adding the missing link advertise for some X710 NICs.
This can be observed by simply calling ethtool on the interface.
root at rhel7:~ # ethtool eth0
Settings for eth0:
        Supported ports: [ FIBRE ]
        Supported link modes:   10000baseT/Full
        Supported pause frame use: Symmetric
        Supports auto-negotiation: No
        Advertised link modes:  Not reported
[...]
With fix applied.
root at rhel7:~ # ethtool eth0
Settings for eth0:
        Supported ports: [ FIBRE ]
        Supported link modes:   10000baseT/Full
        Supported pause frame use: Symmetric
        Supports auto-negotiation: No
        Advertised link modes:  10000baseT/Full
[...]

Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 5e8d84f..88ef7cb 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -453,6 +453,7 @@ static void i40e_get_settings_link_up(struct i40e_hw *hw,
 	case I40E_PHY_TYPE_10GBASE_SFPP_CU:
 	case I40E_PHY_TYPE_10GBASE_AOC:
 		ecmd->supported = SUPPORTED_10000baseT_Full;
+		ecmd->advertising = SUPPORTED_10000baseT_Full;
 		break;
 	case I40E_PHY_TYPE_SGMII:
 		ecmd->supported = SUPPORTED_Autoneg |
-- 
2.5.5

