From: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
Date: Thu, 20 Dec 2018 08:36:26 +0000
Subject: [Intel-wired-lan] [next PATCH S1 1/6] i40e: Limiting RSS queues
 to CPUs.
In-Reply-To: <20181219144542.85924-1-alice.michael@intel.com>
References: <20181219144542.85924-1-alice.michael@intel.com>
Message-ID: <0EF347314CF65544BA015993979A29CD0F45B852@IRSMSX104.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

ACK

-----Original Message-----
From: Michael, Alice 
Sent: Wednesday, December 19, 2018 3:46 PM
To: Michael, Alice <alice.michael@intel.com>; intel-wired-lan at lists.osuosl.org
Cc: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
Subject: [next PATCH S1 1/6] i40e: Limiting RSS queues to CPUs.

From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Limiting RSS queues number to online CPUs number in order to avoid issues with creating misconfigured RSS queues.

Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 1e61c22c27f4..b4ae4ba84aa3 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -11554,6 +11554,7 @@ int i40e_reconfig_rss_queues(struct i40e_pf *pf, int queue_count)
 	if (!(pf->flags & I40E_FLAG_RSS_ENABLED))
 		return 0;
 
+	queue_count = min_t(int, queue_count, num_online_cpus());
 	new_rss_size = min_t(int, queue_count, pf->rss_size_max);
 
 	if (queue_count != vsi->num_queue_pairs) {
--
2.19.2

--------------------------------------------------------------------

Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.

Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek
przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by
others is strictly prohibited.

