From: Donald C Skidmore <donald.c.skidmore@intel.com>
Date: Tue, 12 Jul 2016 18:47:38 -0400
Subject: [Intel-wired-lan] [PATCH] ixgbevf: Protect ixgbevf_reset_subtask
	from remove event
Message-ID: <1468363658-29163-1-git-send-email-donald.c.skidmore@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

In ixgbevf_reset_subtask We weren't verifying that the port haven't
been removed, we are with this patch.

Signed-off-by: Don Skidmore <donald.c.skidmore@intel.com>
---
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index 1bffac3..fe0661f 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -2774,6 +2774,7 @@ static void ixgbevf_reset_subtask(struct ixgbevf_adapter *adapter)
 
 	/* If we're already down or resetting, just bail */
 	if (test_bit(__IXGBEVF_DOWN, &adapter->state) ||
+	    test_bit(__IXGBEVF_REMOVING, &adapter->state) ||
 	    test_bit(__IXGBEVF_RESETTING, &adapter->state))
 		return;
 
-- 
2.4.3

