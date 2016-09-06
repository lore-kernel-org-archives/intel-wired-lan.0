From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Tue,  6 Sep 2016 12:40:04 -0700
Subject: [Intel-wired-lan] [next PATCH S45 07/10] i40e: cleanup ATR
	auto_disable_flags use
In-Reply-To: <1473190807-26377-1-git-send-email-bimmy.pujari@intel.com>
References: <1473190807-26377-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1473190807-26377-8-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

Some locations that disable ATR accidentally used the "full" disable by
disabling the flag in the standard flags field. This incorrectly forces
ATR off permanently instead of temporarily disabling it. In addition,
some code locations accidentally set the ATR flag enabled when they only
meant to clear the auto_disable_flags. This results in ignoring the
user's ethtool private flag settings.

Additionally, when disabling ATR via ethtool, we did not perform a flush
of the FD table. This results in the previously assigned ATR rules still
functioning which was not expected.

Cleanup all these areas so that automatic disable uses only the
auto_disable_flag. Fix the flush code so that we can trigger a flush
even when we've disabled ATR and SB support, as otherwise the flush
doesn't work. Fix ethtool setting to actually request a flush. Fix
NETIF_F_NTUPLE flag to only clear the auto_disable setting and not
enable the full feature.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Change-ID: Ib2486111f8031bd16943e9308757b276305c03b5
---
Testing-hints:
  See the marked HSDs for details

HSD-number: 5645176, 5645175

 drivers/net/ethernet/intel/i40e/i40e_ethtool.c |  3 +++
 drivers/net/ethernet/intel/i40e/i40e_main.c    | 20 +++++++-------------
 drivers/net/ethernet/intel/i40e/i40e_txrx.c    | 14 +++++++-------
 3 files changed, 17 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 2b2b55e..e842628 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -3021,6 +3021,9 @@ static int i40e_set_priv_flags(struct net_device *dev, u32 flags)
 	} else {
 		pf->flags &= ~I40E_FLAG_FD_ATR_ENABLED;
 		pf->auto_disable_flags |= I40E_FLAG_FD_ATR_ENABLED;
+
+		/* flush current ATR settings */
+		set_bit(__I40E_FD_FLUSH_REQUESTED, &pf->state);
 	}
 
 	if ((flags & I40E_PRIV_FLAGS_VEB_STATS) &&
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 4c3c6ce..9ab15e2d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -5226,7 +5226,7 @@ static int i40e_up_complete(struct i40e_vsi *vsi)
 		/* reset fd counters */
 		pf->fd_add_err = pf->fd_atr_cnt = 0;
 		if (pf->fd_tcp_rule > 0) {
-			pf->flags &= ~I40E_FLAG_FD_ATR_ENABLED;
+			pf->auto_disable_flags |= I40E_FLAG_FD_ATR_ENABLED;
 			if (I40E_DEBUG_FD & pf->hw.debug_mask)
 				dev_info(&pf->pdev->dev, "Forcing ATR off, sideband rules for TCP/IPv4 exist\n");
 			pf->fd_tcp_rule = 0;
@@ -5960,9 +5960,6 @@ static void i40e_fdir_flush_and_replay(struct i40e_pf *pf)
 	int fd_room;
 	int reg;
 
-	if (!(pf->flags & (I40E_FLAG_FD_SB_ENABLED | I40E_FLAG_FD_ATR_ENABLED)))
-		return;
-
 	if (!time_after(jiffies, pf->fd_flush_timestamp +
 				 (I40E_MIN_FD_FLUSH_INTERVAL * HZ)))
 		return;
@@ -5982,7 +5979,7 @@ static void i40e_fdir_flush_and_replay(struct i40e_pf *pf)
 	}
 
 	pf->fd_flush_timestamp = jiffies;
-	pf->flags &= ~I40E_FLAG_FD_ATR_ENABLED;
+	pf->auto_disable_flags |= I40E_FLAG_FD_ATR_ENABLED;
 	/* flush all filters */
 	wr32(&pf->hw, I40E_PFQF_CTL_1,
 	     I40E_PFQF_CTL_1_CLEARFDTABLE_MASK);
@@ -6002,7 +5999,7 @@ static void i40e_fdir_flush_and_replay(struct i40e_pf *pf)
 		/* replay sideband filters */
 		i40e_fdir_filter_restore(pf->vsi[pf->lan_vsi]);
 		if (!disable_atr)
-			pf->flags |= I40E_FLAG_FD_ATR_ENABLED;
+			pf->auto_disable_flags &= ~I40E_FLAG_FD_ATR_ENABLED;
 		clear_bit(__I40E_FD_FLUSH_REQUESTED, &pf->state);
 		if (I40E_DEBUG_FD & pf->hw.debug_mask)
 			dev_info(&pf->pdev->dev, "FD Filter table flushed and FD-SB replayed.\n");
@@ -6036,9 +6033,6 @@ static void i40e_fdir_reinit_subtask(struct i40e_pf *pf)
 	if (test_bit(__I40E_DOWN, &pf->state))
 		return;
 
-	if (!(pf->flags & (I40E_FLAG_FD_SB_ENABLED | I40E_FLAG_FD_ATR_ENABLED)))
-		return;
-
 	if (test_bit(__I40E_FD_FLUSH_REQUESTED, &pf->state))
 		i40e_fdir_flush_and_replay(pf);
 
@@ -8665,13 +8659,13 @@ bool i40e_set_ntuple(struct i40e_pf *pf, netdev_features_t features)
 		/* reset fd counters */
 		pf->fd_add_err = pf->fd_atr_cnt = pf->fd_tcp_rule = 0;
 		pf->fdir_pf_active_filters = 0;
-		pf->flags |= I40E_FLAG_FD_ATR_ENABLED;
-		if (I40E_DEBUG_FD & pf->hw.debug_mask)
-			dev_info(&pf->pdev->dev, "ATR re-enabled.\n");
 		/* if ATR was auto disabled it can be re-enabled. */
 		if ((pf->flags & I40E_FLAG_FD_ATR_ENABLED) &&
-		    (pf->auto_disable_flags & I40E_FLAG_FD_ATR_ENABLED))
+		    (pf->auto_disable_flags & I40E_FLAG_FD_ATR_ENABLED)) {
 			pf->auto_disable_flags &= ~I40E_FLAG_FD_ATR_ENABLED;
+			if (I40E_DEBUG_FD & pf->hw.debug_mask)
+				dev_info(&pf->pdev->dev, "ATR re-enabled.\n");
+		}
 	}
 	return need_reset;
 }
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index bf7bb7c..7ada05e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -282,18 +282,18 @@ static int i40e_add_del_fdir_tcpv4(struct i40e_vsi *vsi,
 
 	if (add) {
 		pf->fd_tcp_rule++;
-		if (pf->flags & I40E_FLAG_FD_ATR_ENABLED) {
-			if (I40E_DEBUG_FD & pf->hw.debug_mask)
-				dev_info(&pf->pdev->dev, "Forcing ATR off, sideband rules for TCP/IPv4 flow being applied\n");
-			pf->flags &= ~I40E_FLAG_FD_ATR_ENABLED;
-		}
+		if ((pf->flags & I40E_FLAG_FD_ATR_ENABLED) &&
+		    I40E_DEBUG_FD & pf->hw.debug_mask)
+			dev_info(&pf->pdev->dev, "Forcing ATR off, sideband rules for TCP/IPv4 flow being applied\n");
+		pf->auto_disable_flags |= I40E_FLAG_FD_ATR_ENABLED;
 	} else {
 		pf->fd_tcp_rule = (pf->fd_tcp_rule > 0) ?
 				  (pf->fd_tcp_rule - 1) : 0;
 		if (pf->fd_tcp_rule == 0) {
-			pf->flags |= I40E_FLAG_FD_ATR_ENABLED;
-			if (I40E_DEBUG_FD & pf->hw.debug_mask)
+			if ((pf->flags & I40E_FLAG_FD_ATR_ENABLED) &&
+			    I40E_DEBUG_FD & pf->hw.debug_mask)
 				dev_info(&pf->pdev->dev, "ATR re-enabled due to no sideband TCP/IPv4 rules\n");
+			pf->auto_disable_flags &= ~I40E_FLAG_FD_ATR_ENABLED;
 		}
 	}
 
-- 
2.4.11

