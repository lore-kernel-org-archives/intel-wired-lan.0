From: Joe Perches <joe@perches.com>
Date: Thu, 01 Nov 2018 00:03:31 -0700
Subject: [Intel-wired-lan] [PATCH] igb: Fix format with line continuation
 whitespace
Message-ID: <1b31c663afa1aa7b3d231917f00f58b9cb604231.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The line continuation unintentionally adds whitespace so
instead use a coalesced format to remove the whitespace.

Miscellanea:

o Use a more typical style for ternaries and arguments
  for this logging message

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 5df88ad8ac81..3a3410f03d04 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -1850,13 +1850,12 @@ static void igb_config_tx_modes(struct igb_adapter *adapter, int queue)
 	 * configuration' in respect to these parameters.
 	 */
 
-	netdev_dbg(netdev, "Qav Tx mode: cbs %s, launchtime %s, queue %d \
-			    idleslope %d sendslope %d hiCredit %d \
-			    locredit %d\n",
-		   (ring->cbs_enable) ? "enabled" : "disabled",
-		   (ring->launchtime_enable) ? "enabled" : "disabled", queue,
-		   ring->idleslope, ring->sendslope, ring->hicredit,
-		   ring->locredit);
+	netdev_dbg(netdev, "Qav Tx mode: cbs %s, launchtime %s, queue %d idleslope %d sendslope %d hiCredit %d locredit %d\n",
+		   ring->cbs_enable ? "enabled" : "disabled",
+		   ring->launchtime_enable ? "enabled" : "disabled",
+		   queue,
+		   ring->idleslope, ring->sendslope,
+		   ring->hicredit, ring->locredit);
 }
 
 static int igb_save_txtime_params(struct igb_adapter *adapter, int queue,

