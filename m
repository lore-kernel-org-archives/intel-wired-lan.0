From: Nicholas Krause <xerofoify@gmail.com>
Date: Wed, 14 Oct 2015 18:57:58 -0400
Subject: [Intel-wired-lan] [PATCH RESEND 1/2] ixgb:Remove reducant error
	path after call to ixgb_sw_init in the function ixgb_probe
Message-ID: <1444863479-31570-1-git-send-email-xerofoify@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This removes the reducant error path and now no longer used goto
label  err_sw_init after the call to ixgb_probe in the function
ixgb_sw_init after calling this function due to it always returning
zero as it is guarantee to run successfully without any issues.

Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
---
 drivers/net/ethernet/intel/ixgb/ixgb_main.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgb/ixgb_main.c b/drivers/net/ethernet/intel/ixgb/ixgb_main.c
index 31f9145..4a90f36 100644
--- a/drivers/net/ethernet/intel/ixgb/ixgb_main.c
+++ b/drivers/net/ethernet/intel/ixgb/ixgb_main.c
@@ -469,9 +469,7 @@ ixgb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	/* setup the private structure */
 
-	err = ixgb_sw_init(adapter);
-	if (err)
-		goto err_sw_init;
+	ixgb_sw_init(adapter);
 
 	netdev->hw_features = NETIF_F_SG |
 			   NETIF_F_TSO |
@@ -531,7 +529,6 @@ ixgb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	return 0;
 
 err_register:
-err_sw_init:
 err_eeprom:
 	iounmap(adapter->hw.hw_addr);
 err_ioremap:
-- 
2.1.4

