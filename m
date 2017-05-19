From: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Date: Fri, 19 May 2017 10:18:49 +0300
Subject: [Intel-wired-lan] [PATCH] e1000e: use disable_hardirq() also for
 MSIX vectors in e1000_netpoll()
Message-ID: <149517832870.37403.16008624383220981105.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Replace disable_irq() which waits for threaded irq handlers with
disable_hardirq() which waits only for hardirq part.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Fixes: 311191297125 ("e1000: use disable_hardirq() for e1000_netpoll()")
---
 drivers/net/ethernet/intel/e1000e/netdev.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index b3679728caac..7f185f481b12 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -6733,20 +6733,20 @@ static irqreturn_t e1000_intr_msix(int __always_unused irq, void *data)
 
 		vector = 0;
 		msix_irq = adapter->msix_entries[vector].vector;
-		disable_irq(msix_irq);
-		e1000_intr_msix_rx(msix_irq, netdev);
+		if (disable_hardirq(msix_irq))
+			e1000_intr_msix_rx(msix_irq, netdev);
 		enable_irq(msix_irq);
 
 		vector++;
 		msix_irq = adapter->msix_entries[vector].vector;
-		disable_irq(msix_irq);
-		e1000_intr_msix_tx(msix_irq, netdev);
+		if (disable_hardirq(msix_irq))
+			e1000_intr_msix_tx(msix_irq, netdev);
 		enable_irq(msix_irq);
 
 		vector++;
 		msix_irq = adapter->msix_entries[vector].vector;
-		disable_irq(msix_irq);
-		e1000_msix_other(msix_irq, netdev);
+		if (disable_hardirq(msix_irq))
+			e1000_msix_other(msix_irq, netdev);
 		enable_irq(msix_irq);
 	}
 

