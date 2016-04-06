From: c00176621 <arika.chen@huawei.com>
Date: Wed, 6 Apr 2016 11:10:24 +0800
Subject: [Intel-wired-lan] [PATCH] Revert "igb: Fix a deadlock in
	igb_sriov_reinit"
Message-ID: <57047E20.1090700@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This reverts commit 3eb14ea8d958 ("igb: Fix a deadlock in
igb_sriov_reinit")
It is the same as commit f468adc944ef ("igb: missing rtnl_unlock in
igb_sriov_reinit()")
There is no rtnl_lock() in igb_resume before, rtnl_unlock will cause a
deadlock.

Signed-off-by: Arika Chen <arika.chen@huawei.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 55a1405c..b252f9c 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -7574,7 +7574,6 @@ static int igb_resume(struct device *dev)

        if (igb_init_interrupt_scheme(adapter, true)) {
                dev_err(&pdev->dev, "Unable to allocate memory for queues\n");
-               rtnl_unlock();
                return -ENOMEM;
        }

--
1.8.5.2


