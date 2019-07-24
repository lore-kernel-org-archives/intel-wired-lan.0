From: Formela, Marcin <marcin.formela@intel.com>
Date: Wed, 24 Jul 2019 06:16:07 +0000
Subject: [Intel-wired-lan] [next PATCH S8 12/12] i40e: fix retrying in
 i40e_aq_get_phy_capabilities
In-Reply-To: <20190723100345.57522-12-alice.michael@intel.com>
References: <20190723100345.57522-1-alice.michael@intel.com>
 <20190723100345.57522-12-alice.michael@intel.com>
Message-ID: <5820F02C2ABDA54685910F8970C642582A39EEB5@IRSMSX106.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Ack. Thx Alice.

--Marcin

-----Original Message-----
From: Michael, Alice 
Sent: Tuesday, July 23, 2019 12:04 PM
To: Michael, Alice <alice.michael@intel.com>; intel-wired-lan at lists.osuosl.org
Cc: Formela, Marcin <marcin.formela@intel.com>
Subject: [next PATCH S8 12/12] i40e: fix retrying in i40e_aq_get_phy_capabilities

From: Marcin Formela <marcin.formela@intel.com>

Fixed a bug where driver was breaking out of the loop and reporting an error without retrying first.

Signed-off-by: Marcin Formela <marcin.formela@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_common.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index de996a80013e..46e649c09f72 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -1577,19 +1577,22 @@ i40e_status i40e_aq_get_phy_capabilities(struct i40e_hw *hw,
 		status = i40e_asq_send_command(hw, &desc, abilities,
 					       abilities_size, cmd_details);
 
-		if (status)
-			break;
-
-		if (hw->aq.asq_last_status == I40E_AQ_RC_EIO) {
+		switch (hw->aq.asq_last_status) {
+		case I40E_AQ_RC_EIO:
 			status = I40E_ERR_UNKNOWN_PHY;
 			break;
-		} else if (hw->aq.asq_last_status == I40E_AQ_RC_EAGAIN) {
+		case I40E_AQ_RC_EAGAIN:
 			usleep_range(1000, 2000);
 			total_delay++;
 			status = I40E_ERR_TIMEOUT;
+			break;
+		/* also covers I40E_AQ_RC_OK */
+		default:
+			break;
 		}
-	} while ((hw->aq.asq_last_status != I40E_AQ_RC_OK) &&
-		 (total_delay < max_delay));
+
+	} while ((hw->aq.asq_last_status == I40E_AQ_RC_EAGAIN) &&
+		(total_delay < max_delay));
 
 	if (status)
 		return status;
--
2.21.0

--------------------------------------------------------------------

Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.

Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek
przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by
others is strictly prohibited.

