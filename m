From: Ludkiewicz, Adam <adam.ludkiewicz@intel.com>
Date: Tue, 12 Feb 2019 09:41:59 +0000
Subject: [Intel-wired-lan] [next PATCH S2-V2 10/12] i40e: Report
 advertised link modes on 40GBASE_SR4
In-Reply-To: <20190206230826.24970-10-alice.michael@intel.com>
References: <20190206230826.24970-1-alice.michael@intel.com>
 <20190206230826.24970-10-alice.michael@intel.com>
Message-ID: <DF8E614BFAF5EA4981FDD45CE6FAFAED3661BEEF@irsmsx105.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

ACK

-----Original Message-----
From: Michael, Alice 
Sent: Thursday, February 7, 2019 12:08 AM
To: Michael, Alice <alice.michael@intel.com>; intel-wired-lan at lists.osuosl.org
Cc: Ludkiewicz, Adam <adam.ludkiewicz@intel.com>
Subject: [next PATCH S2-V2 10/12] i40e: Report advertised link modes on 40GBASE_SR4

From: Adam Ludkiewicz <adam.ludkiewicz@intel.com>

Defined the advertised link mode field for 40000baseSR4_Full for use with ethtool.

Signed-off-by: Adam Ludkiewicz <adam.ludkiewicz@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 4e347637e36a..14b52f8aedd0 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -535,9 +535,12 @@ static void i40e_phy_type_to_ethtool(struct i40e_pf *pf,
 			ethtool_link_ksettings_add_link_mode(ks, advertising,
 							     1000baseT_Full);
 	}
-	if (phy_types & I40E_CAP_PHY_TYPE_40GBASE_SR4)
+	if (phy_types & I40E_CAP_PHY_TYPE_40GBASE_SR4) {
 		ethtool_link_ksettings_add_link_mode(ks, supported,
 						     40000baseSR4_Full);
+		ethtool_link_ksettings_add_link_mode(ks, advertising,
+						     40000baseSR4_Full);
+	}
 	if (phy_types & I40E_CAP_PHY_TYPE_40GBASE_LR4)
 		ethtool_link_ksettings_add_link_mode(ks, supported,
 						     40000baseLR4_Full);
@@ -724,6 +727,8 @@ static void i40e_get_settings_link_up(struct i40e_hw *hw,
 	case I40E_PHY_TYPE_40GBASE_SR4:
 		ethtool_link_ksettings_add_link_mode(ks, supported,
 						     40000baseSR4_Full);
+		ethtool_link_ksettings_add_link_mode(ks, advertising,
+						     40000baseSR4_Full);
 		break;
 	case I40E_PHY_TYPE_40GBASE_LR4:
 		ethtool_link_ksettings_add_link_mode(ks, supported,
--
2.19.2

--------------------------------------------------------------------

Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.

Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek
przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by
others is strictly prohibited.

