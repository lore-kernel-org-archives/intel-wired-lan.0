From: Jia-Ju Bai <baijiaju1990@163.com>
Date: Mon,  3 Aug 2015 11:36:26 +0800
Subject: [Intel-wired-lan] [PATCH] igb: Fix a deadlock in igb_sriov_reinit
Message-ID: <1438572986-32708-1-git-send-email-baijiaju1990@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

When igb_init_interrupt_scheme in igb_sriov_reinit is failed, the lock 
acquired by rtnl_lock() is not released, which causes a deadlock.
This patch adds rtnl_unlock() in error handling to fix it.

Signed-off-by: Jia-Ju Bai <baijiaju1990@163.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 2f70a9b..311d1ca 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -7539,6 +7539,7 @@ static int igb_sriov_reinit(struct pci_dev *dev)
 
 	if (igb_init_interrupt_scheme(adapter, true)) {
 		dev_err(&pdev->dev, "Unable to allocate memory for queues\n");
+		rtnl_unlock();
 		return -ENOMEM;
 	}
 
-- 
1.7.9.5


