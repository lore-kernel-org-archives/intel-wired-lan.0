From: =?unknown-8bit?q?J=CE=B5an?= Sacren <sakiwit@gmail.com>
Date: Tue, 13 Oct 2015 01:06:27 -0600
Subject: [Intel-wired-lan] [next-queue v2 1/6] i40evf: add missing
	kernel-doc argument
Message-ID: <1444719992-301-1-git-send-email-sakiwit@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jean Sacren <sakiwit@gmail.com>

@flush has been missing since the inception of i40evf_irq_enable(). Add
it for the kernel doc.

Signed-off-by: Jean Sacren <sakiwit@gmail.com>
---
v2: For the whole series, drop the first two due to the simple mistake.
    
    For this patch, no changes except for the serial number.

 drivers/net/ethernet/intel/i40evf/i40evf_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index 186914fe64bc..3b638f68b249 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -282,6 +282,7 @@ static void i40evf_fire_sw_int(struct i40evf_adapter *adapter, u32 mask)
 /**
  * i40evf_irq_enable - Enable default interrupt generation settings
  * @adapter: board private structure
+ * @flush: boolean value whether to run rd32()
  **/
 void i40evf_irq_enable(struct i40evf_adapter *adapter, bool flush)
 {
