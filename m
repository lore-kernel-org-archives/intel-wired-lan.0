From: trix@redhat.com <trix@redhat.com>
Date: Wed, 23 Dec 2020 11:44:25 -0800
Subject: [Intel-wired-lan] [PATCH] igb: remove h from printk format specifier
Message-ID: <20201223194425.125605-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Tom Rix <trix@redhat.com>

This change fixes the checkpatch warning described in this commit
commit cbacb5ab0aa0 ("docs: printk-formats: Stop encouraging use of unnecessary %h[xudi] and %hh[xudi]")

Standard integer promotion is already done and %hx and %hhx is useless
so do not encourage the use of %hh[xudi] or %h[xudi].

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 03f78fdb0dcd..cb682232df16 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -3156,7 +3156,7 @@ static int igb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	 * the PCIe SR-IOV capability.
 	 */
 	if (pdev->is_virtfn) {
-		WARN(1, KERN_ERR "%s (%hx:%hx) should not be a VF!\n",
+		WARN(1, KERN_ERR "%s (%x:%x) should not be a VF!\n",
 			pci_name(pdev), pdev->vendor, pdev->device);
 		return -EINVAL;
 	}
-- 
2.27.0

