From: Kwapulinski, Piotr <piotr.kwapulinski@intel.com>
Date: Fri, 20 Sep 2019 19:04:56 +0000
Subject: [Intel-wired-lan] [next PATCH S10 08/10] i40e: allow ethtool to
 report SW and FW versions in recovery mode
In-Reply-To: <20190920091724.51767-8-alice.michael@intel.com>
References: <20190920091724.51767-1-alice.michael@intel.com>
 <20190920091724.51767-8-alice.michael@intel.com>
Message-ID: <D4D6338F2E4CB34CB91C5312C72AAC81107033@IRSMSX104.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

ACK

-----Original Message-----
From: Michael, Alice 
Sent: Friday, September 20, 2019 11:17 AM
To: Michael, Alice <alice.michael@intel.com>; intel-wired-lan at lists.osuosl.org
Cc: Kwapulinski, Piotr <piotr.kwapulinski@intel.com>
Subject: [next PATCH S10 08/10] i40e: allow ethtool to report SW and FW versions in recovery mode

From: Piotr Kwapulinski <piotr.kwapulinski@intel.com>

Let ethtool print driver and firmware versions when NIC is in recovery mode.  Assign i40e_get_drvinfo() operation to ethtool recovery mode operations.  Previously ethtool did not report driver and firmware versions when NIC was in recovery mode.

Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 883b43ac9816..001a2fad297d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -5375,6 +5375,7 @@ static int i40e_set_eee(struct net_device *netdev, struct ethtool_eee *edata)  }
 
 static const struct ethtool_ops i40e_ethtool_recovery_mode_ops = {
+	.get_drvinfo		= i40e_get_drvinfo,
 	.set_eeprom		= i40e_set_eeprom,
 	.get_eeprom_len		= i40e_get_eeprom_len,
 	.get_eeprom		= i40e_get_eeprom,
--
2.21.0

--------------------------------------------------------------------

Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.

Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek
przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by
others is strictly prohibited.

