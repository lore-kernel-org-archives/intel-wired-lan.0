From: Guangbin Huang <huangguangbin2@huawei.com>
Date: Wed, 19 May 2021 14:14:41 +0800
Subject: [Intel-wired-lan] [PATCH net-next 1/5] net: e1000: remove repeated
 word "slot" for e1000_main.c
In-Reply-To: <1621404885-20075-1-git-send-email-huangguangbin2@huawei.com>
References: <1621404885-20075-1-git-send-email-huangguangbin2@huawei.com>
Message-ID: <1621404885-20075-2-git-send-email-huangguangbin2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Hao Chen <chenhao288@hisilicon.com>

There are double "slot" in comment, so remove the redundant one.

Signed-off-by: Hao Chen <chenhao288@hisilicon.com>
Signed-off-by: Guangbin Huang <huangguangbin2@huawei.com>
---
 drivers/net/ethernet/intel/e1000/e1000_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/ethernet/intel/e1000/e1000_main.c
index 042de276e632..c2a109126c27 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_main.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
@@ -5245,7 +5245,7 @@ static pci_ers_result_t e1000_io_error_detected(struct pci_dev *pdev,
 	if (!test_and_set_bit(__E1000_DISABLED, &adapter->flags))
 		pci_disable_device(pdev);
 
-	/* Request a slot slot reset. */
+	/* Request a slot reset. */
 	return PCI_ERS_RESULT_NEED_RESET;
 }
 
-- 
2.8.1

