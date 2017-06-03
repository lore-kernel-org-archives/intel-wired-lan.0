From: Jeff Mahoney <jeffm@suse.com>
Date: Sat, 3 Jun 2017 18:01:17 -0400
Subject: [Intel-wired-lan] [PATCH] ixgbe: pci_set_drvdata must be called
	before register_netdev
Message-ID: <12c75353-174a-d6de-27bc-83cebba68c13@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

We call pci_set_drvdata immediately after calling register_netdev,
which leaves a window where tasks writing to the sriov_numvfs sysfs
attribute can sneak in and crash the kernel.  register_netdev cleans
up after itself so placing pci_set_drvdata immediately before it
should preserve the intent of commit 0fb6a55cc31f (ixgbe: fix crash
on rmmod after probe fail).

Fixes: 0fb6a55cc31f (ixgbe: fix crash on rmmod after probe fail)
Signed-off-by: Jeff Mahoney <jeffm@suse.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index d39cba214320..ec257eeb2ca1 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -10341,12 +10341,11 @@ static int ixgbe_probe(struct pci_dev *pdev,
const struct pci_device_id *ent)
 			   "hardware.\n");
 	}
 	strcpy(netdev->name, "eth%d");
+	pci_set_drvdata(pdev, adapter);
 	err = register_netdev(netdev);
 	if (err)
 		goto err_register;

-	pci_set_drvdata(pdev, adapter);
-
 	/* power down the optics for 82599 SFP+ fiber */
 	if (hw->mac.ops.disable_tx_laser)
 		hw->mac.ops.disable_tx_laser(hw);


-- 
Jeff Mahoney
SUSE Labs
