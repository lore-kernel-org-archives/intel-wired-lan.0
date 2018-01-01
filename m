From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 1 Jan 2018 20:56:55 +0100
Subject: [Intel-wired-lan] [PATCH] igb: Delete an error message for a failed
 memory allocation in igb_enable_sriov()
Message-ID: <d6fe0ffd-4439-1f2b-1f78-2a3552f5dd09@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 1 Jan 2018 20:53:10 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index e94d3c256667..1621aaa3eb28 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -3200,8 +3200,6 @@ static int igb_enable_sriov(struct pci_dev *pdev, int num_vfs)
 	/* if allocation failed then we do not support SR-IOV */
 	if (!adapter->vf_data) {
 		adapter->vfs_allocated_count = 0;
-		dev_err(&pdev->dev,
-			"Unable to allocate memory for VF Data Storage\n");
 		err = -ENOMEM;
 		goto out;
 	}
-- 
2.15.1

