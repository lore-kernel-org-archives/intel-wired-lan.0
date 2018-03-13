From: Malek, Patryk <patryk.malek@intel.com>
Date: Tue, 13 Mar 2018 08:20:27 +0000
Subject: [Intel-wired-lan] [next PATCH S88 6/8] i40e: Prevent setting
 link speed on I40E_DEV_ID_25G_B
In-Reply-To: <20180312140022.59580-6-alice.michael@intel.com>
References: <20180312140022.59580-1-alice.michael@intel.com>
 <20180312140022.59580-6-alice.michael@intel.com>
Message-ID: <FA03331EB45A2544B0CBCB1A14B6429E296A0619@IRSMSX104.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

ACK, thanks

-----Original Message-----
From: Michael, Alice 
Sent: Monday, March 12, 2018 15:00
To: alice.michael; intel-wired-lan at lists.osuosl.org
Cc: Malek, Patryk <patryk.malek@intel.com>
Subject: [next PATCH S88 6/8] i40e: Prevent setting link speed on I40E_DEV_ID_25G_B

From: Patryk Ma?ek <patryk.malek@intel.com>

Setting link settings on backplane devices shouldn't be allowed.
This patch adds one more device id to the list which we check that against.

Signed-off-by: Patryk Ma?ek <patryk.malek@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index d86d090..722eb6b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -861,6 +861,7 @@ static int i40e_set_link_ksettings(struct net_device *netdev,
 	    hw->device_id == I40E_DEV_ID_KX_C ||
 	    hw->device_id == I40E_DEV_ID_20G_KR2 ||
 	    hw->device_id == I40E_DEV_ID_20G_KR2_A ||
+	    hw->device_id == I40E_DEV_ID_25G_B ||
 	    hw->device_id == I40E_DEV_ID_KX_X722) {
 		netdev_info(netdev, "Changing settings is not supported on backplane.\n");
 		return -EOPNOTSUPP;
--
2.9.5

--------------------------------------------------------------------

Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.

Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek
przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by
others is strictly prohibited.
