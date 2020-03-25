From: Andre Guedes <andre.guedes@intel.com>
Date: Tue, 24 Mar 2020 17:38:17 -0700
Subject: [Intel-wired-lan] [PATCH 03/10] igc: Use netdev log helpers in
 igc_ptp.c
In-Reply-To: <20200325003824.5487-1-andre.guedes@intel.com>
References: <20200325003824.5487-1-andre.guedes@intel.com>
Message-ID: <20200325003824.5487-4-andre.guedes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

In igc_ptp.c we print log messages using dev_* helpers, generating
inconsistent output with the rest of the driver. Since this is a network
device driver, we should preferably use netdev_* helpers because they
append the interface name to the message, helping making sense out of
the logs.

This patch converts all dev_* calls to netdev_*. It also takes this
opportunity to remove the '\n' character at the end of messages since it
is automatically added by netdev_* log helpers.

Signed-off-by: Andre Guedes <andre.guedes@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_ptp.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_ptp.c b/drivers/net/ethernet/intel/igc/igc_ptp.c
index f99c514ad0f4..c292aaf7c79d 100644
--- a/drivers/net/ethernet/intel/igc/igc_ptp.c
+++ b/drivers/net/ethernet/intel/igc/igc_ptp.c
@@ -466,7 +466,7 @@ void igc_ptp_tx_hang(struct igc_adapter *adapter)
 		 * interrupt
 		 */
 		rd32(IGC_TXSTMPH);
-		dev_warn(&adapter->pdev->dev, "clearing Tx timestamp hang\n");
+		netdev_warn(adapter->netdev, "Clearing Tx timestamp hang");
 	}
 }
 
@@ -529,7 +529,7 @@ static void igc_ptp_tx_work(struct work_struct *work)
 		 * interrupt
 		 */
 		rd32(IGC_TXSTMPH);
-		dev_warn(&adapter->pdev->dev, "clearing Tx timestamp hang\n");
+		netdev_warn(adapter->netdev, "Clearing Tx timestamp hang");
 		return;
 	}
 
@@ -626,10 +626,9 @@ void igc_ptp_init(struct igc_adapter *adapter)
 						&adapter->pdev->dev);
 	if (IS_ERR(adapter->ptp_clock)) {
 		adapter->ptp_clock = NULL;
-		dev_err(&adapter->pdev->dev, "ptp_clock_register failed\n");
+		netdev_err(netdev, "ptp_clock_register failed");
 	} else if (adapter->ptp_clock) {
-		dev_info(&adapter->pdev->dev, "added PHC on %s\n",
-			 adapter->netdev->name);
+		netdev_info(netdev, "PHC added");
 		adapter->ptp_flags |= IGC_PTP_ENABLED;
 	}
 }
@@ -666,8 +665,7 @@ void igc_ptp_stop(struct igc_adapter *adapter)
 
 	if (adapter->ptp_clock) {
 		ptp_clock_unregister(adapter->ptp_clock);
-		dev_info(&adapter->pdev->dev, "removed PHC on %s\n",
-			 adapter->netdev->name);
+		netdev_info(adapter->netdev, "PHC removed");
 		adapter->ptp_flags &= ~IGC_PTP_ENABLED;
 	}
 }
-- 
2.25.0

