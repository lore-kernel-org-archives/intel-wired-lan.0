From: Marcin Szycik <marcin.szycik@intel.com>
Date: Mon, 16 Aug 2021 16:48:48 +0200
Subject: [Intel-wired-lan] [PATCH net-next] ice: fix ethtool set channel
 when in switchdev mode
Message-ID: <20210816144848.437-1-marcin.szycik@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Grzegorz Nitka <grzegorz.nitka@intel.com>

When running ethtool set channel (-L) command on PF interface,
DCB reconfiguration is triggered which in turn involves TC
re-configuration and ring to vector mapping. It applies to
all VSI instances, regardles of VSI type, so also including
switchdev ctrl VSI when device is running in switchdev mode.

Skip ring to vector mapping for switchdev ctrl VSI, as it
uses non-standard mapping and is already properly configured
when PF VSI is rebuilt.

Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
Signed-off-by: Marcin Szycik <marcin.szycik@intel.com>
---
This commit should be squashed with "ice: add port representor ethtool
ops and stats"

 drivers/net/ethernet/intel/ice/ice_dcb_lib.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
index 26b4d5f579e6..73714685fb68 100644
--- a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
@@ -683,6 +683,11 @@ void ice_pf_dcb_recfg(struct ice_pf *pf)
 				vsi->idx);
 			continue;
 		}
+		/* no need to proceed with remaining cfg if it is switchdev
+		 * VSI
+		 */
+		if (vsi->type == ICE_VSI_SWITCHDEV_CTRL)
+			continue;
 
 		ice_vsi_map_rings_to_vectors(vsi);
 		if (vsi->type == ICE_VSI_PF)
-- 
2.30.1

--------------------------------------------------------------------

Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.

Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek
przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by
others is strictly prohibited.

