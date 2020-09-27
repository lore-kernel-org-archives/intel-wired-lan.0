From: Thomas Gleixner <tglx@linutronix.de>
Date: Sun, 27 Sep 2020 21:48:58 +0200
Subject: [Intel-wired-lan] [patch 12/35] net: ionic: Remove
 WARN_ON(in_interrupt()).
References: <20200927194846.045411263@linutronix.de>
Message-ID: <20200927194921.026798214@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

in_interrupt() is ill defined and does not provide what the name
suggests. The usage especially in driver code is deprecated and a tree wide
effort to clean up and consolidate the (ab)usage of in_interrupt() and
related checks is happening.

In this case the check covers only parts of the contexts in which these
functions cannot be called. It fails to detect preemption or interrupt
disabled invocations.

As the functions which are invoked from ionic_adminq_post() and
ionic_dev_cmd_wait() contain a broad variety of checks (always enabled or
debug option dependent) which cover all invalid conditions already, there
is no point in having inconsistent warnings in those drivers.

Just remove them.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Shannon Nelson <snelson@pensando.io>
Cc: Pensando Drivers <drivers@pensando.io>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: netdev at vger.kernel.org

---
 drivers/net/ethernet/pensando/ionic/ionic_main.c |    4 ----
 1 file changed, 4 deletions(-)

--- a/drivers/net/ethernet/pensando/ionic/ionic_main.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_main.c
@@ -248,8 +248,6 @@ static int ionic_adminq_post(struct ioni
 	struct ionic_queue *adminq;
 	int err = 0;
 
-	WARN_ON(in_interrupt());
-
 	if (!lif->adminqcq)
 		return -EIO;
 
@@ -346,8 +344,6 @@ int ionic_dev_cmd_wait(struct ionic *ion
 	int done;
 	int err;
 
-	WARN_ON(in_interrupt());
-
 	/* Wait for dev cmd to complete, retrying if we get EAGAIN,
 	 * but don't wait any longer than max_seconds.
 	 */

