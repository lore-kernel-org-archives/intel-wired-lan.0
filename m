From: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
Date: Thu, 28 Feb 2019 17:57:02 +0000
Subject: [Intel-wired-lan] [next PATCH S3 3/9] i40e: remove error msg
 when vf with port vlan tries to remove vlan 0
In-Reply-To: <20190228175255.54754-3-alice.michael@intel.com>
References: <20190228175255.54754-1-alice.michael@intel.com>
 <20190228175255.54754-3-alice.michael@intel.com>
Message-ID: <0EF347314CF65544BA015993979A29CD25D179CB@irsmsx105.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

ACK

-----Original Message-----
From: Michael, Alice 
Sent: Thursday, February 28, 2019 6:53 PM
To: Michael, Alice <alice.michael@intel.com>; intel-wired-lan at lists.osuosl.org
Cc: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
Subject: [next PATCH S3 3/9] i40e: remove error msg when vf with port vlan tries to remove vlan 0

From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

VF's attempt to delete vlan 0 when a port vlan is configured is harmless in this case pf driver just does nothing.  If vf will try to remove other vlans when a port vlan is configured it will still produce error as before.

Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 71cd159e7902..24628de8e624 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -2766,7 +2766,8 @@ static int i40e_vc_remove_vlan_msg(struct i40e_vf *vf, u8 *msg)
 
 	vsi = pf->vsi[vf->lan_vsi_idx];
 	if (vsi->info.pvid) {
-		aq_ret = I40E_ERR_PARAM;
+		if (vfl->num_elements > 1 || vfl->vlan_id[0])
+			aq_ret = I40E_ERR_PARAM;
 		goto error_param;
 	}
 
--
2.19.2

--------------------------------------------------------------------

Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.

Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek
przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by
others is strictly prohibited.

