From: Thomas Gleixner <tglx@linutronix.de>
Date: Tue, 29 Sep 2020 22:25:17 +0200
Subject: [Intel-wired-lan] [patch V2 08/36] net: e100: Remove in_interrupt()
 usage and pointless GFP_ATOMIC allocation
References: <20200929202509.673358734@linutronix.de>
Message-ID: <20200929203500.277654701@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

e100_hw_init() invokes e100_self_test() only if in_interrupt() returns
false as e100_self_test() uses msleep() which requires sleepable task
context. The in_interrupt() check is incomplete because in_interrupt()
cannot catch callers from contexts which have just preemption or interrupts
disabled.

e100_hw_init() is invoked from:

  - e100_loopback_test() which clearly is sleepable task context as the
    function uses msleep() itself.

  - e100_up() which clearly is sleepable task context as well because it
    invokes e100_alloc_cbs() abd request_irq() which both require sleepable
    task context due to GFP_KERNEL allocations and mutex_lock() operations.

Remove the pointless in_interrupt() check.

As a side effect of this analysis it turned out that e100_rx_alloc_list()
which is only invoked from e100_loopback_test() and e100_up() pointlessly
uses a GFP_ATOMIC allocation. The next invoked function e100_alloc_cbs() is
using GFP_KERNEL already.

Change the allocation mode in e100_rx_alloc_list() to GFP_KERNEL as well.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>


---
 drivers/net/ethernet/intel/e100.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/intel/e100.c
+++ b/drivers/net/ethernet/intel/e100.c
@@ -1531,7 +1531,7 @@ static int e100_hw_init(struct nic *nic)
 	e100_hw_reset(nic);
 
 	netif_err(nic, hw, nic->netdev, "e100_hw_init\n");
-	if (!in_interrupt() && (err = e100_self_test(nic)))
+	if ((err = e100_self_test(nic)))
 		return err;
 
 	if ((err = e100_phy_init(nic)))
@@ -2155,7 +2155,7 @@ static int e100_rx_alloc_list(struct nic
 	nic->rx_to_use = nic->rx_to_clean = NULL;
 	nic->ru_running = RU_UNINITIALIZED;
 
-	if (!(nic->rxs = kcalloc(count, sizeof(struct rx), GFP_ATOMIC)))
+	if (!(nic->rxs = kcalloc(count, sizeof(struct rx), GFP_KERNEL)))
 		return -ENOMEM;
 
 	for (rx = nic->rxs, i = 0; i < count; rx++, i++) {


