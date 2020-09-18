From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Date: Fri, 18 Sep 2020 16:09:27 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: Add info trace at loading xdp
 program
Message-ID: <20200918160927.11265-1-arkadiusz.kubalewski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

New trace indicates that the XDP program was loaded.
The trace has a note that in case of using XDP_REDIRECT,
number of queues on both interfaces shall be the same.
This is required for optimal performance of XDP_REDIRECT,
if interface used for TX has lower number of queues than
a RX interface, the packets may be dropped (depending on
RSS queue assignment).

Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 05c6d3e..85eac48 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -12643,11 +12643,14 @@ static int i40e_xdp_setup(struct i40e_vsi *vsi,
 	/* Kick start the NAPI context if there is an AF_XDP socket open
 	 * on that queue id. This so that receiving will start.
 	 */
-	if (need_reset && prog)
+	if (need_reset && prog) {
+		dev_info(&pf->pdev->dev,
+			 "Loading XDP program, please note: XDP_REDIRECT action requires the same number of queues on both interfaces\n");
 		for (i = 0; i < vsi->num_queue_pairs; i++)
 			if (vsi->xdp_rings[i]->xsk_pool)
 				(void)i40e_xsk_wakeup(vsi->netdev, i,
 						      XDP_WAKEUP_RX);
+	}
 
 	return 0;
 }
-- 
2.26.0

---------------------------------------------------------------------
Intel Technology Poland sp. z o.o.
ul. Sowackiego 173 | 80-298 Gdask | Sd Rejonowy Gdask Pnoc | VII Wydzia Gospodarczy Krajowego Rejestru Sdowego - KRS 101882 | NIP 957-07-52-316 | Kapita zakadowy 200.000 PLN.
Ta wiadomo wraz z zacznikami jest przeznaczona dla okrelonego adresata i moe zawiera informacje poufne. W razie przypadkowego otrzymania tej wiadomoci, prosimy o powiadomienie nadawcy oraz trwae jej usunicie; jakiekolwiek przegldanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by others is strictly prohibited.
 

