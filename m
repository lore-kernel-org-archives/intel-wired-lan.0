From: Nicholas Krause <xerofoify@gmail.com>
Date: Sat, 17 Oct 2015 12:20:42 -0400
Subject: [Intel-wired-lan] [PATCH] fm10k:Fix error handling in the function
	fm10k_resume
Message-ID: <1445098842-28260-1-git-send-email-xerofoify@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This fixes error handling to proper check if the call to the function
fm10k_mbx_request_irq has failed by returning a error code and if
so return immediately to the caller of fm10k_resume to properly
signal a failure has occurred when accepting to resume this network

Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
index ce53ff2..cb3bfc8 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
@@ -1973,7 +1973,9 @@ static int fm10k_resume(struct pci_dev *pdev)
 
 	err = fm10k_init_queueing_scheme(interface);
 	if (!err) {
-		fm10k_mbx_request_irq(interface);
+		err = fm10k_mbx_request_irq(interface);
+		if (err)
+			return err;
 		if (netif_running(netdev))
 			err = fm10k_open(netdev);
 	}
-- 
2.1.4

