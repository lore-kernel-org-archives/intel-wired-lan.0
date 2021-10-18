From: Marcin Szycik <marcin.szycik@intel.com>
Date: Mon, 18 Oct 2021 13:30:32 +0200
Subject: [Intel-wired-lan] [PATCH net-next] ice: Add support for changing
 MTU on PR in switchdev mode
Message-ID: <20211018113032.76288-1-marcin.szycik@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This change adds support for changing MTU on port representor in
switchdev mode, by setting the min/max MTU values on port representor
netdev. Before it was possible to change the MTU only in a limited,
default range (68-1500).

Signed-off-by: Marcin Szycik <marcin.szycik@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_repr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_repr.c b/drivers/net/ethernet/intel/ice/ice_repr.c
index c49eeea7cb67..af8e6ef5f571 100644
--- a/drivers/net/ethernet/intel/ice/ice_repr.c
+++ b/drivers/net/ethernet/intel/ice/ice_repr.c
@@ -267,6 +267,9 @@ static int ice_repr_add(struct ice_vf *vf)
 	if (err)
 		goto err_devlink;
 
+	repr->netdev->min_mtu = ETH_MIN_MTU;
+	repr->netdev->max_mtu = ICE_MAX_MTU;
+
 	err = ice_repr_reg_netdev(repr->netdev);
 	if (err)
 		goto err_netdev;
-- 
2.31.1

---------------------------------------------------------------------
Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.
Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by others is strictly prohibited.

