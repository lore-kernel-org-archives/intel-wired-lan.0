From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Mon, 15 Jul 2019 20:25:55 +0800
Subject: [Intel-wired-lan] [PATCH v2] e1000e: Make speed detection on
 hotplugging cable more reliable
In-Reply-To: <20190715084355.9962-1-kai.heng.feng@canonical.com>
References: <20190715084355.9962-1-kai.heng.feng@canonical.com>
Message-ID: <20190715122555.11922-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

After hotplugging an 1Gbps ethernet cable with 1Gbps link partner, the
MII_BMSR may report 10Mbps, renders the network rather slow.

The issue has much lower fail rate after commit 59653e6497d1 ("e1000e:
Make watchdog use delayed work"), which essentially introduces some
delay before running the watchdog task.

But there's still a chance that the hotplugging event and the queued
watchdog task gets run at the same time, then the original issue can be
observed once again.

So let's use mod_delayed_work() to add a deterministic 1 second delay
before running watchdog task, after an interrupt.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index e4baa13b3cda..c83bf5349d53 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -1780,8 +1780,8 @@ static irqreturn_t e1000_intr_msi(int __always_unused irq, void *data)
 		}
 		/* guard against interrupt when we're going down */
 		if (!test_bit(__E1000_DOWN, &adapter->state))
-			queue_delayed_work(adapter->e1000_workqueue,
-					   &adapter->watchdog_task, 1);
+			mod_delayed_work(adapter->e1000_workqueue,
+					 &adapter->watchdog_task, HZ);
 	}
 
 	/* Reset on uncorrectable ECC error */
@@ -1861,8 +1861,8 @@ static irqreturn_t e1000_intr(int __always_unused irq, void *data)
 		}
 		/* guard against interrupt when we're going down */
 		if (!test_bit(__E1000_DOWN, &adapter->state))
-			queue_delayed_work(adapter->e1000_workqueue,
-					   &adapter->watchdog_task, 1);
+			mod_delayed_work(adapter->e1000_workqueue,
+					 &adapter->watchdog_task, HZ);
 	}
 
 	/* Reset on uncorrectable ECC error */
@@ -1907,8 +1907,8 @@ static irqreturn_t e1000_msix_other(int __always_unused irq, void *data)
 		hw->mac.get_link_status = true;
 		/* guard against interrupt when we're going down */
 		if (!test_bit(__E1000_DOWN, &adapter->state))
-			queue_delayed_work(adapter->e1000_workqueue,
-					   &adapter->watchdog_task, 1);
+			mod_delayed_work(adapter->e1000_workqueue,
+					 &adapter->watchdog_task, HZ);
 	}
 
 	if (!test_bit(__E1000_DOWN, &adapter->state))
-- 
2.17.1

