From: cgel.zte@gmail.com <cgel.zte@gmail.com>
Date: Thu, 11 Nov 2021 09:05:55 +0000
Subject: [Intel-wired-lan] [PATCH linux] e1000e: Delete redundant variable
 definitions
Message-ID: <20211111090555.158828-1-luo.penghao@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: luo penghao <luo.penghao@zte.com.cn>

The local variable is not used elsewhere in the function

The clang_analyzer complains as follows:

drivers/net/ethernet/intel/e1000e/ptp.c:241:19 warning

Value stored to 'hw' during its initialization is never read

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: luo penghao <luo.penghao@zte.com.cn>
---
 drivers/net/ethernet/intel/e1000e/ptp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000e/ptp.c b/drivers/net/ethernet/intel/e1000e/ptp.c
index eb5c014..e6dcac9 100644
--- a/drivers/net/ethernet/intel/e1000e/ptp.c
+++ b/drivers/net/ethernet/intel/e1000e/ptp.c
@@ -238,7 +238,6 @@ static void e1000e_systim_overflow_work(struct work_struct *work)
 {
 	struct e1000_adapter *adapter = container_of(work, struct e1000_adapter,
 						     systim_overflow_work.work);
-	struct e1000_hw *hw = &adapter->hw;
 	struct timespec64 ts;
 	u64 ns;
 
-- 
2.15.2


