From: Alice Michael <alice.michael@intel.com>
Date: Fri, 16 Mar 2018 01:26:33 -0700
Subject: [Intel-wired-lan] [next PATCH S89 4/8] i40e: move
 I40E_FLAG_TEMP_LINK_POLLING to state field
In-Reply-To: <20180316082637.49915-1-alice.michael@intel.com>
References: <20180316082637.49915-1-alice.michael@intel.com>
Message-ID: <20180316082637.49915-4-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

This flag is modified outside of the RTNL lock and thus should not be
part of the pf->flags variable.

Use a state bit instead, so that we can use atomic bit operations.

This is part of a larger effort to remove cmpxchg64 in
i40e_set_priv_flags()

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h      | 3 ++-
 drivers/net/ethernet/intel/i40e/i40e_main.c | 7 +++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index c41d99b..2dd89f8 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -166,6 +166,7 @@ enum i40e_state_t {
 	__I40E_VF_DISABLE,
 	__I40E_MACVLAN_SYNC_PENDING,
 	__I40E_UDP_FILTER_SYNC_PENDING,
+	__I40E_TEMP_LINK_POLLING,
 	/* This must be last as it determines the size of the BITMAP */
 	__I40E_STATE_SIZE__,
 };
@@ -534,7 +535,7 @@ struct i40e_pf {
 #define I40E_FLAG_VEB_STATS_ENABLED		BIT_ULL(17)
 #define I40E_FLAG_LINK_POLLING_ENABLED		BIT_ULL(18)
 #define I40E_FLAG_TRUE_PROMISC_SUPPORT		BIT_ULL(19)
-#define I40E_FLAG_TEMP_LINK_POLLING		BIT_ULL(20)
+/* Gap for BIT_ULL(20) */
 #define I40E_FLAG_LEGACY_RX			BIT_ULL(21)
 #define I40E_FLAG_PTP				BIT_ULL(22)
 #define I40E_FLAG_IWARP_ENABLED			BIT_ULL(23)
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 44d15cf..01ecd9d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -8432,13 +8432,12 @@ static void i40e_link_event(struct i40e_pf *pf)
 
 	/* On success, disable temp link polling */
 	if (status == I40E_SUCCESS) {
-		if (pf->flags & I40E_FLAG_TEMP_LINK_POLLING)
-			pf->flags &= ~I40E_FLAG_TEMP_LINK_POLLING;
+		clear_bit(__I40E_TEMP_LINK_POLLING, pf->state);
 	} else {
 		/* Enable link polling temporarily until i40e_get_link_status
 		 * returns I40E_SUCCESS
 		 */
-		pf->flags |= I40E_FLAG_TEMP_LINK_POLLING;
+		set_bit(__I40E_TEMP_LINK_POLLING, pf->state);
 		dev_dbg(&pf->pdev->dev, "couldn't get link state, status: %d\n",
 			status);
 		return;
@@ -8490,7 +8489,7 @@ static void i40e_watchdog_subtask(struct i40e_pf *pf)
 	pf->service_timer_previous = jiffies;
 
 	if ((pf->flags & I40E_FLAG_LINK_POLLING_ENABLED) ||
-	    (pf->flags & I40E_FLAG_TEMP_LINK_POLLING))
+	    test_bit(__I40E_TEMP_LINK_POLLING, pf->state))
 		i40e_link_event(pf);
 
 	/* Update the stats for active netdevs so the network stack
-- 
2.9.5

