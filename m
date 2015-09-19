From: =?unknown-8bit?q?J=CE=B5an?= Sacren <sakiwit@gmail.com>
Date: Sat, 19 Sep 2015 05:08:41 -0600
Subject: [Intel-wired-lan] [next-queue v2 2/8] e1000: fix a typo in the
	comment
In-Reply-To: <1442660927-30431-1-git-send-email-sakiwit@gmail.com>
References: <1442660927-30431-1-git-send-email-sakiwit@gmail.com>
Message-ID: <1442660927-30431-2-git-send-email-sakiwit@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jean Sacren <sakiwit@gmail.com>

Use 'That' to replace 'The' so that the comment would make sense.

Signed-off-by: Jean Sacren <sakiwit@gmail.com>
---
v2: No changes.

 drivers/net/ethernet/intel/e1000/e1000_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/ethernet/intel/e1000/e1000_main.c
index 5ba8d13a068c..36d1d48a9c60 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_main.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
@@ -1263,7 +1263,7 @@ err_pci_reg:
  * @pdev: PCI device information struct
  *
  * e1000_remove is called by the PCI subsystem to alert the driver
- * that it should release a PCI device.  The could be caused by a
+ * that it should release a PCI device. That could be caused by a
  * Hot-Plug event, or because the driver is going to be removed from
  * memory.
  **/
