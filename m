From: Thomas Gleixner <tglx@linutronix.de>
Date: Sun, 27 Sep 2020 21:49:01 +0200
Subject: [Intel-wired-lan] [patch 15/35] net: sfc: Replace in_interrupt()
 usage.
References: <20200927194846.045411263@linutronix.de>
Message-ID: <20200927194921.344476620@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

efx_ef10_try_update_nic_stats_vf() uses in_interrupt() to figure out
whether it is safe to sleep or not.

The following callers are involved:

- efx_start_all() and efx_stop_all() are fully preemptible because a
  mutex is acquired near by.

- efx_ethtool_get_stats() is ivoked from ethtool_ops->get_ethtool_stats()
  and is fully preemptible.

- efx_net_stats() which can be invoked under dev_base_lock from
  net-sysfs::netstat_show(). dev_base_lock is a rwlock_t which disables
  preemption implicitly. 

  in_interrupt() cannot detect context which has only preemption disabled
  so the check fails to detect that this calling context is not safe to
  sleep.

  Obviously this is a bug and clearly this has never been tested with any
  of the relevant and mandatory debug options enabled, which would have
  caught it.

  Changing the condition to preemptible() is not useful either because on
  CONFIG_PREEMPT_COUNT=n kernels preemptible() is useless.

  Aside of that Linus clearly requested that functions which change their
  behaviour depending on execution context should either be split up or the
  callers provide context information via an argument.

Add a 'can_sleep' argument to efx_ef10_try_update_nic_stats_vf() and let
the callers indicate the context from which this is called.

Another oddity of that code is that it uses GFP_ATOMIC _after_ establishing
that the context is safe to sleep.

Convert it to GFP_KERNEL while at it.

Note, that the fixes tag is empty as it is unclear which of the commits to
blame.

Fixes: ????
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Solarflare linux maintainers <linux-net-drivers@solarflare.com>
Cc: Edward Cree <ecree@solarflare.com>
Cc: Martin Habets <mhabets@solarflare.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: netdev at vger.kernel.org
---
 drivers/net/ethernet/sfc/ef10.c           |   18 +++++++++---------
 drivers/net/ethernet/sfc/ef100_nic.c      |    3 ++-
 drivers/net/ethernet/sfc/efx_common.c     |    6 +++---
 drivers/net/ethernet/sfc/ethtool_common.c |    2 +-
 drivers/net/ethernet/sfc/net_driver.h     |    3 ++-
 drivers/net/ethernet/sfc/siena.c          |    3 ++-
 6 files changed, 19 insertions(+), 16 deletions(-)

--- a/drivers/net/ethernet/sfc/ef10.c
+++ b/drivers/net/ethernet/sfc/ef10.c
@@ -1797,7 +1797,8 @@ static size_t efx_ef10_update_stats_comm
 }
 
 static size_t efx_ef10_update_stats_pf(struct efx_nic *efx, u64 *full_stats,
-				       struct rtnl_link_stats64 *core_stats)
+				       struct rtnl_link_stats64 *core_stats,
+				       bool can_sleep)
 {
 	struct efx_ef10_nic_data *nic_data = efx->nic_data;
 	DECLARE_BITMAP(mask, EF10_STAT_COUNT);
@@ -1836,7 +1837,7 @@ static size_t efx_ef10_update_stats_pf(s
 	return efx_ef10_update_stats_common(efx, full_stats, core_stats);
 }
 
-static int efx_ef10_try_update_nic_stats_vf(struct efx_nic *efx)
+static int efx_ef10_try_update_nic_stats_vf(struct efx_nic *efx, bool can_sleep)
 	__must_hold(&efx->stats_lock)
 {
 	MCDI_DECLARE_BUF(inbuf, MC_CMD_MAC_STATS_IN_LEN);
@@ -1849,20 +1850,18 @@ static int efx_ef10_try_update_nic_stats
 	__le64 *dma_stats;
 	int rc;
 
-	spin_unlock_bh(&efx->stats_lock);
-
-	if (in_interrupt()) {
+	if (!can_sleep) {
 		/* If in atomic context, cannot update stats.  Just update the
 		 * software stats and return so the caller can continue.
 		 */
-		spin_lock_bh(&efx->stats_lock);
 		efx_update_sw_stats(efx, stats);
 		return 0;
 	}
 
+	spin_unlock_bh(&efx->stats_lock);
 	efx_ef10_get_stat_mask(efx, mask);
 
-	rc = efx_nic_alloc_buffer(efx, &stats_buf, dma_len, GFP_ATOMIC);
+	rc = efx_nic_alloc_buffer(efx, &stats_buf, dma_len, GFP_KERNEL);
 	if (rc) {
 		spin_lock_bh(&efx->stats_lock);
 		return rc;
@@ -1910,9 +1909,10 @@ static int efx_ef10_try_update_nic_stats
 }
 
 static size_t efx_ef10_update_stats_vf(struct efx_nic *efx, u64 *full_stats,
-				       struct rtnl_link_stats64 *core_stats)
+				       struct rtnl_link_stats64 *core_stats,
+				       bool can_sleep)
 {
-	if (efx_ef10_try_update_nic_stats_vf(efx))
+	if (efx_ef10_try_update_nic_stats_vf(efx, can_sleep))
 		return 0;
 
 	return efx_ef10_update_stats_common(efx, full_stats, core_stats);
--- a/drivers/net/ethernet/sfc/ef100_nic.c
+++ b/drivers/net/ethernet/sfc/ef100_nic.c
@@ -599,7 +599,8 @@ static size_t ef100_update_stats_common(
 
 static size_t ef100_update_stats(struct efx_nic *efx,
 				 u64 *full_stats,
-				 struct rtnl_link_stats64 *core_stats)
+				 struct rtnl_link_stats64 *core_stats,
+				 bool can_sleep)
 {
 	__le64 *mc_stats = kmalloc(array_size(efx->num_mac_stats, sizeof(__le64)), GFP_ATOMIC);
 	struct ef100_nic_data *nic_data = efx->nic_data;
--- a/drivers/net/ethernet/sfc/efx_common.c
+++ b/drivers/net/ethernet/sfc/efx_common.c
@@ -552,7 +552,7 @@ void efx_start_all(struct efx_nic *efx)
 		efx->type->start_stats(efx);
 		efx->type->pull_stats(efx);
 		spin_lock_bh(&efx->stats_lock);
-		efx->type->update_stats(efx, NULL, NULL);
+		efx->type->update_stats(efx, NULL, NULL, true);
 		spin_unlock_bh(&efx->stats_lock);
 	}
 }
@@ -576,7 +576,7 @@ void efx_stop_all(struct efx_nic *efx)
 		 */
 		efx->type->pull_stats(efx);
 		spin_lock_bh(&efx->stats_lock);
-		efx->type->update_stats(efx, NULL, NULL);
+		efx->type->update_stats(efx, NULL, NULL, true);
 		spin_unlock_bh(&efx->stats_lock);
 		efx->type->stop_stats(efx);
 	}
@@ -600,7 +600,7 @@ void efx_net_stats(struct net_device *ne
 	struct efx_nic *efx = netdev_priv(net_dev);
 
 	spin_lock_bh(&efx->stats_lock);
-	efx->type->update_stats(efx, NULL, stats);
+	efx->type->update_stats(efx, NULL, stats, false);
 	spin_unlock_bh(&efx->stats_lock);
 }
 
--- a/drivers/net/ethernet/sfc/ethtool_common.c
+++ b/drivers/net/ethernet/sfc/ethtool_common.c
@@ -502,7 +502,7 @@ void efx_ethtool_get_stats(struct net_de
 	spin_lock_bh(&efx->stats_lock);
 
 	/* Get NIC statistics */
-	data += efx->type->update_stats(efx, data, NULL);
+	data += efx->type->update_stats(efx, data, NULL, true);
 
 	/* Get software statistics */
 	for (i = 0; i < EFX_ETHTOOL_SW_STAT_COUNT; i++) {
--- a/drivers/net/ethernet/sfc/net_driver.h
+++ b/drivers/net/ethernet/sfc/net_driver.h
@@ -1358,7 +1358,8 @@ struct efx_nic_type {
 	void (*finish_flr)(struct efx_nic *efx);
 	size_t (*describe_stats)(struct efx_nic *efx, u8 *names);
 	size_t (*update_stats)(struct efx_nic *efx, u64 *full_stats,
-			       struct rtnl_link_stats64 *core_stats);
+			       struct rtnl_link_stats64 *core_stats,
+			       bool can_sleep);
 	void (*start_stats)(struct efx_nic *efx);
 	void (*pull_stats)(struct efx_nic *efx);
 	void (*stop_stats)(struct efx_nic *efx);
--- a/drivers/net/ethernet/sfc/siena.c
+++ b/drivers/net/ethernet/sfc/siena.c
@@ -587,7 +587,8 @@ static int siena_try_update_nic_stats(st
 }
 
 static size_t siena_update_nic_stats(struct efx_nic *efx, u64 *full_stats,
-				     struct rtnl_link_stats64 *core_stats)
+				     struct rtnl_link_stats64 *core_stats,
+				     bool can_sleep)
 {
 	struct siena_nic_data *nic_data = efx->nic_data;
 	u64 *stats = nic_data->stats;

