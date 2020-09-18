From: Sasha Levin <sashal@kernel.org>
Date: Thu, 17 Sep 2020 22:00:20 -0400
Subject: [Intel-wired-lan] [PATCH AUTOSEL 5.4 280/330] e1000: Do not perform
 reset in reset_task if we are already down
In-Reply-To: <20200918020110.2063155-1-sashal@kernel.org>
References: <20200918020110.2063155-1-sashal@kernel.org>
Message-ID: <20200918020110.2063155-280-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alexander Duyck <alexander.h.duyck@linux.intel.com>

[ Upstream commit 49ee3c2ab5234757bfb56a0b3a3cb422f427e3a3 ]

We are seeing a deadlock in e1000 down when NAPI is being disabled. Looking
over the kernel function trace of the system it appears that the interface
is being closed and then a reset is hitting which deadlocks the interface
as the NAPI interface is already disabled.

To prevent this from happening I am disabling the reset task when
__E1000_DOWN is already set. In addition code has been added so that we set
the __E1000_DOWN while holding the __E1000_RESET flag in e1000_close in
order to guarantee that the reset task will not run after we have started
the close call.

Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Tested-by: Maxim Zhukov <mussitantesmortem@gmail.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/e1000/e1000_main.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/ethernet/intel/e1000/e1000_main.c
index f93ed70709c65..a2ee28e487a6f 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_main.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
@@ -542,8 +542,13 @@ void e1000_reinit_locked(struct e1000_adapter *adapter)
 	WARN_ON(in_interrupt());
 	while (test_and_set_bit(__E1000_RESETTING, &adapter->flags))
 		msleep(1);
-	e1000_down(adapter);
-	e1000_up(adapter);
+
+	/* only run the task if not already down */
+	if (!test_bit(__E1000_DOWN, &adapter->flags)) {
+		e1000_down(adapter);
+		e1000_up(adapter);
+	}
+
 	clear_bit(__E1000_RESETTING, &adapter->flags);
 }
 
@@ -1433,10 +1438,15 @@ int e1000_close(struct net_device *netdev)
 	struct e1000_hw *hw = &adapter->hw;
 	int count = E1000_CHECK_RESET_COUNT;
 
-	while (test_bit(__E1000_RESETTING, &adapter->flags) && count--)
+	while (test_and_set_bit(__E1000_RESETTING, &adapter->flags) && count--)
 		usleep_range(10000, 20000);
 
-	WARN_ON(test_bit(__E1000_RESETTING, &adapter->flags));
+	WARN_ON(count < 0);
+
+	/* signal that we're down so that the reset task will no longer run */
+	set_bit(__E1000_DOWN, &adapter->flags);
+	clear_bit(__E1000_RESETTING, &adapter->flags);
+
 	e1000_down(adapter);
 	e1000_power_down_phy(adapter);
 	e1000_free_irq(adapter);
-- 
2.25.1

