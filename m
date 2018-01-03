From: Malek, Patryk <patryk.malek@intel.com>
Date: Wed, 3 Jan 2018 11:04:50 +0000
Subject: [Intel-wired-lan] [next PATCH S84-V2 02/13] i40e: Fix for
 adding multiple ethtool filters on the same location
In-Reply-To: <20171227123242.22356-2-alice.michael@intel.com>
References: <20171227123242.22356-1-alice.michael@intel.com>
 <20171227123242.22356-2-alice.michael@intel.com>
Message-ID: <FA03331EB45A2544B0CBCB1A14B6429E29682A0A@IRSMSX104.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

ACK

-----Original Message-----
From: Michael, Alice 
Sent: Wednesday, December 27, 2017 13:33
To: Michael, Alice <alice.michael@intel.com>; intel-wired-lan at lists.osuosl.org
Cc: Malek, Patryk <patryk.malek@intel.com>
Subject: [next PATCH S84-V2 02/13] i40e: Fix for adding multiple ethtool filters on the same location

From: Patryk Ma?ek <patryk.malek@intel.com>

This patch reorders i40e_add_del_fdir and i40e_update_ethtool_fdir_entry calls so that we first remove an already existing filter (inside i40e_update_ethtool_fdir_entry using i40e_add_del_fdir) and then we add a new one with i40e_add_del_fdir.
After applying this patch, creating multiple identical filters (with the same location) one after another doesn't revert their behavior but behaves correctly.

Signed-off-by: Patryk Ma?ek <patryk.malek@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 86329a3..099b170 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -3939,19 +3939,19 @@ static int i40e_add_fdir_ethtool(struct i40e_vsi *vsi,
 		input->flex_offset = userdef.flex_offset;
 	}
 
-	ret = i40e_add_del_fdir(vsi, input, true);
-	if (ret)
-		goto free_input;
-
 	/* Add the input filter to the fdir_input_list, possibly replacing
 	 * a previous filter. Do not free the input structure after adding it
 	 * to the list as this would cause a use-after-free bug.
 	 */
 	i40e_update_ethtool_fdir_entry(vsi, input, fsp->location, NULL);
-
+	ret = i40e_add_del_fdir(vsi, input, true);
+	if (ret)
+		goto remove_sw_rule;
 	return 0;
 
-free_input:
+remove_sw_rule:
+	hlist_del(&input->fdir_node);
+	pf->fdir_pf_active_filters--;
 	kfree(input);
 	return ret;
 }
--
2.9.5

--------------------------------------------------------------------

Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.

Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek
przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by
others is strictly prohibited.
