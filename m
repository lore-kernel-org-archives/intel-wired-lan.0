From: Vasily Averin <vvs@virtuozzo.com>
Date: Tue, 07 Jul 2015 18:53:45 +0300
Subject: [Intel-wired-lan] [PATCH 2/3] missing rtnl_unlock in
	igb_sriov_reinit()
Message-ID: <559BF609.4020705@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 2f70a9b..5881458 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -7538,6 +7538,7 @@ static int igb_sriov_reinit(struct pci_dev *dev)
 	igb_init_queue_configuration(adapter);
 
 	if (igb_init_interrupt_scheme(adapter, true)) {
+		rtnl_unlock();
 		dev_err(&pdev->dev, "Unable to allocate memory for queues\n");
 		return -ENOMEM;
 	}
-- 
1.9.1

