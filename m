From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Sun,  3 Feb 2019 01:40:16 +0800
Subject: [Intel-wired-lan] [PATCH] e1000e: Disable runtime PM on CNP+
Message-ID: <20190202174016.28539-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

There are some new e1000e devices can only be woken up from D3 one time,
by plugging ethernet cable. Subsequent cable plugging does set PME bit
correctly, but it still doesn't get woken up.

Since e1000e connects to the root complex directly, we rely on ACPI to
wake it up. In this case, the GPE from _PRW only works once and stops
working after that. Though it appears to be a platform bug, e1000e
maintainers confirmed that I219 does not support D3.

So disable runtime PM on CNP+ chips. We may need to disable earlier
generations if this bug also hit older platforms.

Bugzilla: https://bugzilla.kernel.org/attachment.cgi?id=280819
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 189f231075c2..9366b9d19a6f 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -7351,7 +7351,7 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	e1000_print_device_info(adapter);
 
-	if (pci_dev_run_wake(pdev))
+	if (pci_dev_run_wake(pdev) && hw->mac.type < e1000_pch_cnp)
 		pm_runtime_put_noidle(&pdev->dev);
 
 	return 0;
-- 
2.17.1

