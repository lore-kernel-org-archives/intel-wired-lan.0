From: weiyj_lk@163.com <weiyj_lk@163.com>
Date: Tue, 12 Jul 2016 15:17:02 +0000
Subject: [Intel-wired-lan] [PATCH -next] ixgbe: Add missing
	destroy_workqueue() on error in ixgbe_init_module()
Message-ID: <1468336622-10538-1-git-send-email-weiyj_lk@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Add the missing destroy_workqueue() before return from
ixgbe_init_module() in the error handling case.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index ef82cf9..c5c3d68 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -10109,6 +10109,7 @@ static int __init ixgbe_init_module(void)
 
 	ret = pci_register_driver(&ixgbe_driver);
 	if (ret) {
+		destroy_workqueue(ixgbe_wq);
 		ixgbe_dbg_exit();
 		return ret;
 	}




