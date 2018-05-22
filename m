From: Emil Tantilov <emil.s.tantilov@intel.com>
Date: Tue, 22 May 2018 09:18:46 -0700
Subject: [Intel-wired-lan] [PATCH] ixgbevf: fix possible race in the reset
 subtask
Message-ID: <20180522161846.2844.21726.stgit@localhost6.localdomain6>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Extend the RTNL lock in ixgbevf_reset_subtask() to protect the state bits
check in addition to the call to ixgbevf_reinit_locked().

This is to make sure that we get the most up-to-date values for the bits
and avoid a possible race when going down.

Suggested-by: Zhiping du <zhipingdu@tencent.com>
Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
---
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index 0830411..1e0c5ae 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -3119,15 +3119,17 @@ static void ixgbevf_reset_subtask(struct ixgbevf_adapter *adapter)
 	if (!test_and_clear_bit(__IXGBEVF_RESET_REQUESTED, &adapter->state))
 		return;
 
+	rtnl_lock();
 	/* If we're already down or resetting, just bail */
 	if (test_bit(__IXGBEVF_DOWN, &adapter->state) ||
 	    test_bit(__IXGBEVF_REMOVING, &adapter->state) ||
-	    test_bit(__IXGBEVF_RESETTING, &adapter->state))
+	    test_bit(__IXGBEVF_RESETTING, &adapter->state)) {
+		rtnl_unlock();
 		return;
+	}
 
 	adapter->tx_timeout_count++;
 
-	rtnl_lock();
 	ixgbevf_reinit_locked(adapter);
 	rtnl_unlock();
 }

