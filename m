From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Thu, 24 Sep 2015 12:20:42 -0700
Subject: [Intel-wired-lan] [net PATCH v1] i40e: fix recursive rtnl lock
Message-ID: <1443122442-21345-1-git-send-email-jesse.brandeburg@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Anjali Singhai Jain <anjali.singhai@intel.com>

The sync_vsi_filters function can be called directly under RTNL
or through the timer subtask without one.  This was causing
a deadlock.

If sync_vsi_filter is called from a thread which held the lock,
and in another thread the PROMISC setting got changed we would be
executing the PROMISC change in the thread which already held the
lock alongside the other filter update. The PROMISC change
requires a reset if we are on a VEB, which requires it to be
called under RTNL.

Earlier the driver would call reset for PROMISC change without
checking if we were already under RTNL and would try to grab
it causing a deadlock. This patch changes the flow to see if we
are already under RTNL before trying to grab it.

Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Reviewed-by: Kiran Patil <kiran.patil@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 3410fb3..7557c02 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -5340,9 +5340,13 @@ exit:
  **/
 void i40e_do_reset_safe(struct i40e_pf *pf, u32 reset_flags)
 {
-	rtnl_lock();
-	i40e_do_reset(pf, reset_flags);
-	rtnl_unlock();
+	if (!rtnl_is_locked()) {
+		rtnl_lock();
+		i40e_do_reset(pf, reset_flags);
+		rtnl_unlock();
+	} else {
+		i40e_do_reset(pf, reset_flags);
+	}
 }
 
 /**
-- 
2.4.3

