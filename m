From: Kwapulinski, Piotr <piotr.kwapulinski@intel.com>
Date: Tue, 28 May 2019 19:42:10 +0000
Subject: [Intel-wired-lan] [next PATCH S6 4/7] i40e: Add log entry while
 creating or deleting TC0
In-Reply-To: <20190528175921.30534-4-alice.michael@intel.com>
References: <20190528175921.30534-1-alice.michael@intel.com>
 <20190528175921.30534-4-alice.michael@intel.com>
Message-ID: <D4D6338F2E4CB34CB91C5312C72AAC81088F73@IRSMSX104.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

ACK

-----Original Message-----
From: Michael, Alice 
Sent: Tuesday, May 28, 2019 7:59 PM
To: alice.micheal@intel.com; intel-wired-lan at lists.osuosl.org
Cc: Kwapulinski, Piotr <piotr.kwapulinski@intel.com>
Subject: [next PATCH S6 4/7] i40e: Add log entry while creating or deleting TC0

From: Piotr Kwapulinski <piotr.kwapulinski@intel.com>

Generate log entry when TC0 is created or deleted.
Log entry is generated during main VSI setup.
Before there was no log info about adding or deleting TC0.

Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 931862c0f39d..7c93f28b7b1d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -7432,6 +7432,10 @@ static int i40e_setup_tc(struct net_device *netdev, void *type_data)
 			    vsi->seid);
 		need_reset = true;
 		goto exit;
+	} else {
+		dev_info(&vsi->back->pdev->dev,
+			 "Setup channel (id:%u) utilizing num_queues %d\n",
+			 vsi->seid, vsi->tc_config.tc_info[0].qcount);
 	}
 
 	if (pf->flags & I40E_FLAG_TC_MQPRIO) {
-- 
2.19.2

--------------------------------------------------------------------

Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.

Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek
przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by
others is strictly prohibited.

