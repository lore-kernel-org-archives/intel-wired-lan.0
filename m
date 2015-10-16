From: Nicholas Krause <xerofoify@gmail.com>
Date: Fri, 16 Oct 2015 15:42:31 -0400
Subject: [Intel-wired-lan] [PATCH] fm10k:Fix error handling in the function
	fm10k_probe
Message-ID: <1445024551-21281-1-git-send-email-xerofoify@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This fixes error handling in the function fm10k_probe to properly
if the call to the function fm10k_iov_configure has failed by
returning a error code before jumping to a new goto label,
fm10k_iov_configure to clean up previously allocated resources
between this goto label and the previous goto label before finally
returning the error code to the callers of the function fm10k_probe

Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
index ce53ff2..3d7374e 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
@@ -1844,13 +1844,17 @@ static int fm10k_probe(struct pci_dev *pdev,
 	fm10k_slot_warn(interface);
 
 	/* enable SR-IOV after registering netdev to enforce PF/VF ordering */
-	fm10k_iov_configure(pdev, 0);
+	err = fm10k_iov_configure(pdev, 0);
+	if (err)
+		goto err_iov_configure;
 
 	/* clear the service task disable bit to allow service task to start */
 	clear_bit(__FM10K_SERVICE_DISABLE, &interface->state);
 
 	return 0;
-
+err_iov_configure:
+	fm10k_ptp_unregister(interface);
+	unregister_netdev(netdev);
 err_register:
 	fm10k_mbx_free_irq(interface);
 err_mbx_interrupt:
-- 
2.1.4

