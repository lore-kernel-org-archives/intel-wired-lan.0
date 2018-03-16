From: Alice Michael <alice.michael@intel.com>
Date: Fri, 16 Mar 2018 01:26:32 -0700
Subject: [Intel-wired-lan] [next PATCH S89 3/8] i40e: move AUTO_DISABLED
 flags into the state field
In-Reply-To: <20180316082637.49915-1-alice.michael@intel.com>
References: <20180316082637.49915-1-alice.michael@intel.com>
Message-ID: <20180316082637.49915-3-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

The two Flow Directory auto disable flags are used at run time to mark
when the flow director features needed to be disabled. Thus the flags
could change even when the RTNL lock is not held.

They also have some code constructions which really should be
test_and_set or test_and_clear using atomic bit operations.

Create new state fields to mark this, and stop including them in
pf->flags.

This is part of a larger effort to remove the need for cmpxchg64 in
i40e_set_priv_flags().

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h         |  5 +++--
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c |  4 ++--
 drivers/net/ethernet/intel/i40e/i40e_main.c    | 23 +++++++++--------------
 drivers/net/ethernet/intel/i40e/i40e_txrx.c    | 21 +++++++++++++--------
 4 files changed, 27 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index ff309501..c41d99b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -159,6 +159,8 @@ enum i40e_state_t {
 	__I40E_BAD_EEPROM,
 	__I40E_DOWN_REQUESTED,
 	__I40E_FD_FLUSH_REQUESTED,
+	__I40E_FD_ATR_AUTO_DISABLED,
+	__I40E_FD_SB_AUTO_DISABLED,
 	__I40E_RESET_FAILED,
 	__I40E_PORT_SUSPENDED,
 	__I40E_VF_DISABLE,
@@ -524,8 +526,7 @@ struct i40e_pf {
 #define I40E_FLAG_DCB_ENABLED			BIT_ULL(8)
 #define I40E_FLAG_FD_SB_ENABLED			BIT_ULL(9)
 #define I40E_FLAG_FD_ATR_ENABLED		BIT_ULL(10)
-#define I40E_FLAG_FD_SB_AUTO_DISABLED		BIT_ULL(11)
-#define I40E_FLAG_FD_ATR_AUTO_DISABLED		BIT_ULL(12)
+/* Gap for BIT_ULL(11) and BIT_ULL(12) */
 #define I40E_FLAG_MFP_ENABLED			BIT_ULL(13)
 /* Gap for BIT_ULL(14) */
 #define I40E_FLAG_HW_ATR_EVICT_ENABLED		BIT_ULL(15)
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 722eb6b..031bc7c 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -3951,7 +3951,7 @@ static int i40e_add_fdir_ethtool(struct i40e_vsi *vsi,
 	if (!(pf->flags & I40E_FLAG_FD_SB_ENABLED))
 		return -EOPNOTSUPP;
 
-	if (pf->flags & I40E_FLAG_FD_SB_AUTO_DISABLED)
+	if (test_bit(__I40E_FD_SB_AUTO_DISABLED, pf->state))
 		return -ENOSPC;
 
 	if (test_bit(__I40E_RESET_RECOVERY_PENDING, pf->state) ||
@@ -4460,7 +4460,7 @@ static int i40e_set_priv_flags(struct net_device *dev, u32 flags)
 	/* Flush current ATR settings if ATR was disabled */
 	if ((changed_flags & I40E_FLAG_FD_ATR_ENABLED) &&
 	    !(pf->flags & I40E_FLAG_FD_ATR_ENABLED)) {
-		pf->flags |= I40E_FLAG_FD_ATR_AUTO_DISABLED;
+		set_bit(__I40E_FD_ATR_AUTO_DISABLED, pf->state);
 		set_bit(__I40E_FD_FLUSH_REQUESTED, pf->state);
 	}
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index a24f99a..44d15cf 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -1083,13 +1083,13 @@ static void i40e_update_pf_stats(struct i40e_pf *pf)
 			   &osd->rx_lpi_count, &nsd->rx_lpi_count);
 
 	if (pf->flags & I40E_FLAG_FD_SB_ENABLED &&
-	    !(pf->flags & I40E_FLAG_FD_SB_AUTO_DISABLED))
+	    !test_bit(__I40E_FD_SB_AUTO_DISABLED, pf->state))
 		nsd->fd_sb_status = true;
 	else
 		nsd->fd_sb_status = false;
 
 	if (pf->flags & I40E_FLAG_FD_ATR_ENABLED &&
-	    !(pf->flags & I40E_FLAG_FD_ATR_AUTO_DISABLED))
+	    !test_bit(__I40E_FD_ATR_AUTO_DISABLED, pf->state))
 		nsd->fd_atr_status = true;
 	else
 		nsd->fd_atr_status = false;
@@ -8144,12 +8144,10 @@ u32 i40e_get_global_fd_count(struct i40e_pf *pf)
  **/
 static void i40e_reenable_fdir_sb(struct i40e_pf *pf)
 {
-	if (pf->flags & I40E_FLAG_FD_SB_AUTO_DISABLED) {
-		pf->flags &= ~I40E_FLAG_FD_SB_AUTO_DISABLED;
+	if (test_and_clear_bit(__I40E_FD_SB_AUTO_DISABLED, pf->state))
 		if ((pf->flags & I40E_FLAG_FD_SB_ENABLED) &&
 		    (I40E_DEBUG_FD & pf->hw.debug_mask))
 			dev_info(&pf->pdev->dev, "FD Sideband/ntuple is being enabled since we have space in the table now\n");
-	}
 }
 
 /**
@@ -8158,7 +8156,7 @@ static void i40e_reenable_fdir_sb(struct i40e_pf *pf)
  **/
 static void i40e_reenable_fdir_atr(struct i40e_pf *pf)
 {
-	if (pf->flags & I40E_FLAG_FD_ATR_AUTO_DISABLED) {
+	if (test_and_clear_bit(__I40E_FD_ATR_AUTO_DISABLED, pf->state)) {
 		/* ATR uses the same filtering logic as SB rules. It only
 		 * functions properly if the input set mask is at the default
 		 * settings. It is safe to restore the default input set
@@ -8168,7 +8166,6 @@ static void i40e_reenable_fdir_atr(struct i40e_pf *pf)
 					I40E_L3_SRC_MASK | I40E_L3_DST_MASK |
 					I40E_L4_SRC_MASK | I40E_L4_DST_MASK);
 
-		pf->flags &= ~I40E_FLAG_FD_ATR_AUTO_DISABLED;
 		if ((pf->flags & I40E_FLAG_FD_ATR_ENABLED) &&
 		    (I40E_DEBUG_FD & pf->hw.debug_mask))
 			dev_info(&pf->pdev->dev, "ATR is being enabled since we have space in the table and there are no conflicting ntuple rules\n");
@@ -8291,7 +8288,7 @@ static void i40e_fdir_flush_and_replay(struct i40e_pf *pf)
 	}
 
 	pf->fd_flush_timestamp = jiffies;
-	pf->flags |= I40E_FLAG_FD_ATR_AUTO_DISABLED;
+	set_bit(__I40E_FD_ATR_AUTO_DISABLED, pf->state);
 	/* flush all filters */
 	wr32(&pf->hw, I40E_PFQF_CTL_1,
 	     I40E_PFQF_CTL_1_CLEARFDTABLE_MASK);
@@ -8311,7 +8308,7 @@ static void i40e_fdir_flush_and_replay(struct i40e_pf *pf)
 		/* replay sideband filters */
 		i40e_fdir_filter_restore(pf->vsi[pf->lan_vsi]);
 		if (!disable_atr && !pf->fd_tcp4_filter_cnt)
-			pf->flags &= ~I40E_FLAG_FD_ATR_AUTO_DISABLED;
+			clear_bit(__I40E_FD_ATR_AUTO_DISABLED, pf->state);
 		clear_bit(__I40E_FD_FLUSH_REQUESTED, pf->state);
 		if (I40E_DEBUG_FD & pf->hw.debug_mask)
 			dev_info(&pf->pdev->dev, "FD Filter table flushed and FD-SB replayed.\n");
@@ -11291,20 +11288,18 @@ bool i40e_set_ntuple(struct i40e_pf *pf, netdev_features_t features)
 			need_reset = true;
 			i40e_fdir_filter_exit(pf);
 		}
-		pf->flags &= ~(I40E_FLAG_FD_SB_ENABLED |
-			       I40E_FLAG_FD_SB_AUTO_DISABLED);
+		pf->flags &= ~I40E_FLAG_FD_SB_ENABLED;
+		clear_bit(__I40E_FD_SB_AUTO_DISABLED, pf->state);
 		pf->flags |= I40E_FLAG_FD_SB_INACTIVE;
 
 		/* reset fd counters */
 		pf->fd_add_err = 0;
 		pf->fd_atr_cnt = 0;
 		/* if ATR was auto disabled it can be re-enabled. */
-		if (pf->flags & I40E_FLAG_FD_ATR_AUTO_DISABLED) {
-			pf->flags &= ~I40E_FLAG_FD_ATR_AUTO_DISABLED;
+		if (test_and_clear_bit(__I40E_FD_ATR_AUTO_DISABLED, pf->state))
 			if ((pf->flags & I40E_FLAG_FD_ATR_ENABLED) &&
 			    (I40E_DEBUG_FD & pf->hw.debug_mask))
 				dev_info(&pf->pdev->dev, "ATR re-enabled.\n");
-		}
 	}
 	return need_reset;
 }
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 91dfe1c..c6972bd 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -336,7 +336,7 @@ static int i40e_add_del_fdir_tcpv4(struct i40e_vsi *vsi,
 		if ((pf->flags & I40E_FLAG_FD_ATR_ENABLED) &&
 		    I40E_DEBUG_FD & pf->hw.debug_mask)
 			dev_info(&pf->pdev->dev, "Forcing ATR off, sideband rules for TCP/IPv4 flow being applied\n");
-		pf->flags |= I40E_FLAG_FD_ATR_AUTO_DISABLED;
+		set_bit(__I40E_FD_ATR_AUTO_DISABLED, pf->state);
 	} else {
 		pf->fd_tcp4_filter_cnt--;
 	}
@@ -594,8 +594,14 @@ static void i40e_fd_handle_status(struct i40e_ring *rx_ring,
 		pf->fd_atr_cnt = i40e_get_current_atr_cnt(pf);
 
 		if ((rx_desc->wb.qword0.hi_dword.fd_id == 0) &&
-		    pf->flags & I40E_FLAG_FD_SB_AUTO_DISABLED) {
-			pf->flags |= I40E_FLAG_FD_ATR_AUTO_DISABLED;
+		    test_bit(__I40E_FD_SB_AUTO_DISABLED, pf->state)) {
+			/* These set_bit() calls aren't atomic with the
+			 * test_bit() here, but worse case we potentially
+			 * disable ATR and queue a flush right after SB
+			 * support is re-enabled. That shouldn't cause an
+			 * issue in practice
+			 */
+			set_bit(__I40E_FD_ATR_AUTO_DISABLED, pf->state);
 			set_bit(__I40E_FD_FLUSH_REQUESTED, pf->state);
 		}
 
@@ -608,11 +614,10 @@ static void i40e_fd_handle_status(struct i40e_ring *rx_ring,
 		 */
 		if (fcnt_prog >= (fcnt_avail - I40E_FDIR_BUFFER_FULL_MARGIN)) {
 			if ((pf->flags & I40E_FLAG_FD_SB_ENABLED) &&
-			    !(pf->flags & I40E_FLAG_FD_SB_AUTO_DISABLED)) {
-				pf->flags |= I40E_FLAG_FD_SB_AUTO_DISABLED;
+			    !test_and_set_bit(__I40E_FD_SB_AUTO_DISABLED,
+					      pf->state))
 				if (I40E_DEBUG_FD & pf->hw.debug_mask)
 					dev_warn(&pdev->dev, "FD filter space full, new ntuple rules will not be added\n");
-			}
 		}
 	} else if (error == BIT(I40E_RX_PROG_STATUS_DESC_NO_FD_ENTRY_SHIFT)) {
 		if (I40E_DEBUG_FD & pf->hw.debug_mask)
@@ -2647,7 +2652,7 @@ static void i40e_atr(struct i40e_ring *tx_ring, struct sk_buff *skb,
 	if (!(pf->flags & I40E_FLAG_FD_ATR_ENABLED))
 		return;
 
-	if (pf->flags & I40E_FLAG_FD_ATR_AUTO_DISABLED)
+	if (test_bit(__I40E_FD_ATR_AUTO_DISABLED, pf->state))
 		return;
 
 	/* if sampling is disabled do nothing */
@@ -2687,7 +2692,7 @@ static void i40e_atr(struct i40e_ring *tx_ring, struct sk_buff *skb,
 	th = (struct tcphdr *)(hdr.network + hlen);
 
 	/* Due to lack of space, no more new filters can be programmed */
-	if (th->syn && (pf->flags & I40E_FLAG_FD_ATR_AUTO_DISABLED))
+	if (th->syn && test_bit(__I40E_FD_ATR_AUTO_DISABLED, pf->state))
 		return;
 	if (pf->flags & I40E_FLAG_HW_ATR_EVICT_ENABLED) {
 		/* HW ATR eviction will take care of removing filters on FIN
-- 
2.9.5

