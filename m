From: Alice Michael <alice.michael@intel.com>
Date: Mon, 29 Oct 2018 11:27:21 -0700
Subject: [Intel-wired-lan] [next PATCH] i40e: prevent overlapping tx_timeout
 recover
Message-ID: <20181029182721.19003-1-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alan Brady <alan.brady@intel.com>

If a TX hang occurs, we attempt to recover by incrementally resetting.
If we're starved for CPU time, it's possible the reset doesn't actually
complete (or even fire) before another tx_timeout fires causing us to
fly through the different resets without actually doing them.

This adds a bit to set and check if a timeout recovery is already
pending and, if so, bail out of tx_timeout.  The bit will get cleared at
the end of i40e_rebuild when reset is complete.

Signed-off-by: Alan Brady <alan.brady@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h      | 1 +
 drivers/net/ethernet/intel/i40e/i40e_main.c | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 876cac3..8245ff1 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -122,6 +122,7 @@ enum i40e_state_t {
 	__I40E_MDD_EVENT_PENDING,
 	__I40E_VFLR_EVENT_PENDING,
 	__I40E_RESET_RECOVERY_PENDING,
+	__I40E_TIMEOUT_RECOVERY_PENDING,
 	__I40E_MISC_IRQ_REQUESTED,
 	__I40E_RESET_INTR_RECEIVED,
 	__I40E_REINIT_REQUESTED,
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index f4905fe..9d52d7e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -338,6 +338,10 @@ static void i40e_tx_timeout(struct net_device *netdev)
 		      (pf->tx_timeout_last_recovery + netdev->watchdog_timeo)))
 		return;   /* don't do any new action before the next timeout */
 
+	/* don't kick off another recovery if one is already pending */
+	if (test_and_set_bit(__I40E_TIMEOUT_RECOVERY_PENDING, pf->state))
+		return;
+
 	if (tx_ring) {
 		head = i40e_get_head(tx_ring);
 		/* Read interrupt register */
@@ -9631,6 +9635,7 @@ static void i40e_rebuild(struct i40e_pf *pf, bool reinit, bool lock_acquired)
 	clear_bit(__I40E_RESET_FAILED, pf->state);
 clear_recovery:
 	clear_bit(__I40E_RESET_RECOVERY_PENDING, pf->state);
+	clear_bit(__I40E_TIMEOUT_RECOVERY_PENDING, pf->state);
 }
 
 /**
-- 
2.9.5

