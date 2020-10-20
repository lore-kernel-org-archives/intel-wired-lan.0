From: Sasha Neftin <sasha.neftin@intel.com>
Date: Tue, 20 Oct 2020 16:34:00 +0300
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: reinit_locked() should be
 called with rtnl_lock
Message-ID: <20201020133400.2187467-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This commit applies to the igc_reset_task the same changes that
were applied to the igb driver in commit 024a8168b749 ("igb:
reinit_locked() should be called with rtnl_lock")
and fix possible race in reset subtask.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 32817a28e34c..ec3a1a8bb65b 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -3849,10 +3849,19 @@ static void igc_reset_task(struct work_struct *work)
 
 	adapter = container_of(work, struct igc_adapter, reset_task);
 
+	rtnl_lock();
+	/* If we're already down or resetting, just bail */
+	if (test_bit(__IGC_DOWN, &adapter->state) ||
+	    test_bit(__IGC_RESETTING, &adapter->state)) {
+		rtnl_unlock();
+		return;
+	}
+
 	igc_rings_dump(adapter);
 	igc_regs_dump(adapter);
 	netdev_err(adapter->netdev, "Reset adapter\n");
 	igc_reinit_locked(adapter);
+	rtnl_unlock();
 }
 
 /**
-- 
2.25.1

