From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Tue, 11 Dec 2018 15:59:38 +0800
Subject: [Intel-wired-lan] [PATCH 2/2] igb: Exclude device from suspend
 direct complete optimization
In-Reply-To: <20181211075938.32026-1-kai.heng.feng@canonical.com>
References: <20181211075938.32026-1-kai.heng.feng@canonical.com>
Message-ID: <20181211075938.32026-2-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

igb sets different WoL settings in system suspend callback and runtime
suspend callback.

The suspend direct complete optimization leaves igb in runtime suspneded
state with wrong WoL setting during system suspend.

To fix this, we need to disable suspend direct complete optimization to
let igb always use suspend callback to set correct WoL during system
suspend.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 2ce3f2cb156d..e0e8f7a708e9 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -3467,6 +3467,9 @@ static int igb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 			break;
 		}
 	}
+
+	dev_pm_set_driver_flags(&pdev->dev, DPM_FLAG_NEVER_SKIP);
+
 	pm_runtime_put_noidle(&pdev->dev);
 	return 0;
 
-- 
2.17.1

