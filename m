From: Vaishali Thakkar <vthakkar1994@gmail.com>
Date: Mon, 1 Jun 2015 10:13:49 +0530
Subject: [Intel-wired-lan] [PATCH] ethernet/intel: Use setup_timer
Message-ID: <20150601044349.GA4730@vaishali-Ideapad-Z570>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Use the timer API function setup_timer instead of structure field
assignments to initialize a timer.

A simplified version of the Coccinelle semantic patch that performs
this transformation is as follows:

@change@
expression e1, e2, e3, e4, a, b;
@@

-init_timer(&e1);
+setup_timer(&e1, a, b);

... when != a = e2
    when != b = e3

-e1.function = a;
... when != b = e4
-e1.data = b;

Signed-off-by: Vaishali Thakkar <vthakkar1994@gmail.com>
---
 drivers/net/ethernet/intel/e100.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/e100.c b/drivers/net/ethernet/intel/e100.c
index 1a450f4..8ae9c0d 100644
--- a/drivers/net/ethernet/intel/e100.c
+++ b/drivers/net/ethernet/intel/e100.c
@@ -2922,9 +2922,7 @@ static int e100_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	pci_set_master(pdev);
 
-	init_timer(&nic->watchdog);
-	nic->watchdog.function = e100_watchdog;
-	nic->watchdog.data = (unsigned long)nic;
+	setup_timer(&nic->watchdog, e100_watchdog, (unsigned long)nic);
 
 	INIT_WORK(&nic->tx_timeout_task, e100_tx_timeout_task);
 
-- 
1.9.1

