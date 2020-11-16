From: Mateusz Palczewski <mateusz.palczewski@intel.com>
Date: Mon, 16 Nov 2020 12:14:02 +0000
Subject: [Intel-wired-lan] [PATCH net v1] i40e: Add rx errors aggregation
 feature
Message-ID: <20201116121402.11318-1-mateusz.palczewski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Extend calculation of receive errors by aggregating them in the
existing netstat receive error counter.

Error counters added for:
rx_csum_bad, rx_length_errors, rx_undersize_, rx_fragments,
rx_oversize and rx_jabber.

The above were added in order to align statistics with other products.

Without this change only rx_crc_errors and illegal_bytes were
collected by netstat receive error counter.


Signed-off-by: Slawomir Laba <slawomirx.laba@intel.com>
Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 672dc2c..0799476 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -859,7 +859,14 @@ static void i40e_update_vsi_stats(struct i40e_vsi *vsi)
 	/* pull in a couple PF stats if this is the main vsi */
 	if (vsi == pf->vsi[pf->lan_vsi]) {
 		ns->rx_crc_errors = pf->stats.crc_errors;
-		ns->rx_errors = pf->stats.crc_errors + pf->stats.illegal_bytes;
+		ns->rx_errors = pf->stats.crc_errors +
+				pf->stats.illegal_bytes +
+				pf->hw_csum_rx_error +
+				pf->stats.rx_length_errors +
+				pf->stats.rx_undersize +
+				pf->stats.rx_fragments +
+				pf->stats.rx_oversize +
+				pf->stats.rx_jabber;
 		ns->rx_length_errors = pf->stats.rx_length_errors;
 	}
 }
-- 
2.17.1

---------------------------------------------------------------------
Intel Technology Poland sp. z o.o.
ul. Sowackiego 173 | 80-298 Gdask | Sd Rejonowy Gdask Pnoc | VII Wydzia Gospodarczy Krajowego Rejestru Sdowego - KRS 101882 | NIP 957-07-52-316 | Kapita zakadowy 200.000 PLN.
Ta wiadomo wraz z zacznikami jest przeznaczona dla okrelonego adresata i moe zawiera informacje poufne. W razie przypadkowego otrzymania tej wiadomoci, prosimy o powiadomienie nadawcy oraz trwae jej usunicie; jakiekolwiek przegldanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by others is strictly prohibited.
 

