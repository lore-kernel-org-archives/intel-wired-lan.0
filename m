From: Hao Chen <chenhaoa@uniontech.com>
Date: Fri, 17 Sep 2021 14:11:46 +0000
Subject: [Intel-wired-lan] [net-next,
 v1] net: e1000e: solve insmod 'Unknown symbol mutex_lock' error
Message-ID: <20210917141146.5822-1-chenhaoa@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

After I turn on the CONFIG_LOCK_STAT=y, insmod e1000e.ko will report:
[    5.641579] e1000e: Unknown symbol mutex_lock (err -2)
[   90.775705] e1000e: Unknown symbol mutex_lock (err -2)
[  132.252339] e1000e: Unknown symbol mutex_lock (err -2)

This problem fixed after include <linux/mutex.h>.

Signed-off-by: Hao Chen <chenhaoa@uniontech.com>
---
 drivers/net/ethernet/intel/e1000e/e1000.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/e1000e/e1000.h b/drivers/net/ethernet/intel/e1000e/e1000.h
index 5b2143f4b1f8..f3424255bd2b 100644
--- a/drivers/net/ethernet/intel/e1000e/e1000.h
+++ b/drivers/net/ethernet/intel/e1000e/e1000.h
@@ -21,6 +21,7 @@
 #include <linux/ptp_classify.h>
 #include <linux/mii.h>
 #include <linux/mdio.h>
+#include <linux/mutex.h>
 #include <linux/pm_qos.h>
 #include "hw.h"
 
-- 
2.20.1



