From: Donald C Skidmore <donald.c.skidmore@intel.com>
Date: Mon, 11 Jul 2016 21:29:56 -0400
Subject: [Intel-wired-lan] [PATCH] ixgbevf: Add lock around
	ixgbevf_reinit_locked call.
Message-ID: <1468286996-27931-1-git-send-email-donald.c.skidmore@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The function ixgbevf_reinit_locked() assumes you have the rtnl lock
however we didn't when calling from the service task.  This patch
corrects that.

Signed-off-by: Don Skidmore <donald.c.skidmore@intel.com>
---
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index a1c83c1..76df95d 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -2777,7 +2777,9 @@ static void ixgbevf_reset_subtask(struct ixgbevf_adapter *adapter)
 
 	adapter->tx_timeout_count++;
 
+	rtnl_lock();
 	ixgbevf_reinit_locked(adapter);
+	rtnl_unlock();
 }
 
 /**
-- 
2.4.3

