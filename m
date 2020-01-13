From: Sasha Neftin <sasha.neftin@intel.com>
Date: Mon, 13 Jan 2020 11:36:30 +0200
Subject: [Intel-wired-lan] [PATCH v1] igc: Complete to commit Add legacy
 power management support
Message-ID: <20200113093630.6758-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

commit 9513d2a5dc7f ("igc: Add legacy power management support")
Add power management resume and schedule suspend requests.

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 069287a17957..273d3dfa11bd 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -4029,6 +4029,9 @@ static void igc_watchdog_task(struct work_struct *work)
 		}
 	}
 	if (link) {
+		/* Cancel scheduled suspend requests. */
+		pm_runtime_resume(netdev->dev.parent);
+
 		if (!netif_carrier_ok(netdev)) {
 			u32 ctrl;
 
@@ -4114,6 +4117,8 @@ static void igc_watchdog_task(struct work_struct *work)
 					return;
 				}
 			}
+			pm_schedule_suspend(netdev->dev.parent,
+					    MSEC_PER_SEC * 5);
 
 		/* also check for alternate media here */
 		} else if (!netif_carrier_ok(netdev) &&
-- 
2.11.0

