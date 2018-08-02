From: Alice Michael <alice.michael@intel.com>
Date: Wed,  1 Aug 2018 17:40:35 -0700
Subject: [Intel-wired-lan] [next PATCH S94 12/13] i40e: Lock the rtnl lock
 when restoring interrupt scheme for recovery mode
In-Reply-To: <20180802004036.89363-1-alice.michael@intel.com>
References: <20180802004036.89363-1-alice.michael@intel.com>
Message-ID: <20180802004036.89363-12-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Patryk Ma?ek <patryk.malek@intel.com>

When going out of recovery mode we have to check if rtnl lock is locked,
if it isn't then we have to lock it since i40e_restore_interrupt_scheme
will reinitialize queues and this needs to be done under the lock.

This patch fixes it by adding a rtnl_lock() call when the lock is not
held.

Signed-off-by: Patryk Ma?ek <patryk.malek@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index ff04dc4..e46f8ab 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -9393,6 +9393,8 @@ static void i40e_rebuild(struct i40e_pf *pf, bool reinit, bool lock_acquired)
 			if (i40e_setup_misc_vector_for_recovery_mode(pf))
 				goto end_unlock;
 		} else {
+			if (!lock_acquired)
+				rtnl_lock();
 			/* we're going out of recovery mode so we'll free
 			 * the IRQ allocated specifically for recovery mode
 			 * and restore the interrupt scheme
-- 
2.9.5

