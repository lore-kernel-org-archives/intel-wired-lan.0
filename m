From: Vasily Averin <vvs@virtuozzo.com>
Date: Tue, 07 Jul 2015 18:53:38 +0300
Subject: [Intel-wired-lan] [PATCH 1/3] missing rtnl_unlock in i40evf_resume()
Message-ID: <559BF602.406@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 drivers/net/ethernet/intel/i40evf/i40evf_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index 4ab4ebb..dd6a428 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -2402,6 +2402,7 @@ static int i40evf_resume(struct pci_dev *pdev)
 	rtnl_lock();
 	err = i40evf_set_interrupt_capability(adapter);
 	if (err) {
+		rtnl_unlock();
 		dev_err(&pdev->dev, "Cannot enable MSI-X interrupts.\n");
 		return err;
 	}
-- 
1.9.1

