From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Date: Tue, 22 Jun 2021 15:43:48 +0200
Subject: [Intel-wired-lan] [PATCH net-next v3] iavf: Add trace while
 removing device
Message-ID: <20210622134348.342191-1-jedrzej.jagielski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: =  Jedrzej Jagielski <jedrzej.jagielski@intel.com>

Add kernel trace that device was removed.
Currently there is no such information.
I.e. Host admin removes a PCI device from a VM,
than on VM shall be info about the event.

This patch adds info log to iavf_remove function.

Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index d64e2567e16e..60f08a5276b2 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -4012,6 +4012,7 @@ static void iavf_remove(struct pci_dev *pdev)
 	if (iavf_lock_timeout(adapter, __IAVF_IN_CRITICAL_TASK, 5000))
 		dev_warn(&adapter->pdev->dev, "failed to set __IAVF_IN_CRITICAL_TASK in %s\n", __FUNCTION__);
 
+	dev_info(&adapter->pdev->dev, "Removing device\n");
 	/* Shut down all the garbage mashers on the detention level */
 	adapter->state = __IAVF_REMOVE;
 	adapter->aq_required = 0;
-- 
2.27.0

