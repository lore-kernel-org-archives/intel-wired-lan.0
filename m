From: =?unknown-8bit?q?J=C4=99drzej?= Jagielski <jedrzej.jagielski@intel.com>
Date: Mon, 21 Jun 2021 08:10:00 +0000
Subject: [Intel-wired-lan] [PATCH net-next v1] iavf: Add trace while
 removing device
Message-ID: <1624263000-8709-1-git-send-email-jedrzej.jagielski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Add kernel trace that device was removed.
Currently there is no such information.
I.e. Host admin removes a PCI device from a VM,
than on VM shall be info about the event.

This patch adds info log to iavf_remove function.

Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Signed-off-by: J?drzej Jagielski <jedrzej.jagielski@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 4fead59..b2a5fcb 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -3973,6 +3973,7 @@ static void iavf_remove(struct pci_dev *pdev)
 				 err);
 	}
 
+	dev_info(&adapter->pdev->dev, "Removing device\n");
 	/* Shut down all the garbage mashers on the detention level */
 	adapter->state = __IAVF_REMOVE;
 	adapter->aq_required = 0;
-- 
1.8.3.1

