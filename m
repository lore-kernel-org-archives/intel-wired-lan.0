From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Thu, 16 Apr 2015 20:06:06 -0400
Subject: [Intel-wired-lan] [net-next S4 09/15] i40e: Move the FD ATR/SB
	messages to a higher debug level
In-Reply-To: <1429229172-143692-1-git-send-email-catherine.sullivan@intel.com>
References: <1429229172-143692-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1429229172-143692-10-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Anjali Singhai Jain <anjali.singhai@intel.com>

These are not useful unless SV is happening as there is a FD flush counter
that tracks this.

Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
Change-ID: If2655b5a29687247d03a51d35f69854bbeb711ce
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 18 ++++++++++++------
 drivers/net/ethernet/intel/i40e/i40e_txrx.c |  9 ++++++---
 2 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index a5c13de..567303e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -4744,7 +4744,8 @@ static int i40e_up_complete(struct i40e_vsi *vsi)
 		pf->fd_add_err = pf->fd_atr_cnt = 0;
 		if (pf->fd_tcp_rule > 0) {
 			pf->flags &= ~I40E_FLAG_FD_ATR_ENABLED;
-			dev_info(&pf->pdev->dev, "Forcing ATR off, sideband rules for TCP/IPv4 exist\n");
+			if (I40E_DEBUG_FD & pf->hw.debug_mask)
+				dev_info(&pf->pdev->dev, "Forcing ATR off, sideband rules for TCP/IPv4 exist\n");
 			pf->fd_tcp_rule = 0;
 		}
 		i40e_fdir_filter_restore(vsi);
@@ -5433,7 +5434,8 @@ void i40e_fdir_check_and_reenable(struct i40e_pf *pf)
 		if ((pf->flags & I40E_FLAG_FD_SB_ENABLED) &&
 		    (pf->auto_disable_flags & I40E_FLAG_FD_SB_ENABLED)) {
 			pf->auto_disable_flags &= ~I40E_FLAG_FD_SB_ENABLED;
-			dev_info(&pf->pdev->dev, "FD Sideband/ntuple is being enabled since we have space in the table now\n");
+			if (I40E_DEBUG_FD & pf->hw.debug_mask)
+				dev_info(&pf->pdev->dev, "FD Sideband/ntuple is being enabled since we have space in the table now\n");
 		}
 	}
 	/* Wait for some more space to be available to turn on ATR */
@@ -5441,7 +5443,8 @@ void i40e_fdir_check_and_reenable(struct i40e_pf *pf)
 		if ((pf->flags & I40E_FLAG_FD_ATR_ENABLED) &&
 		    (pf->auto_disable_flags & I40E_FLAG_FD_ATR_ENABLED)) {
 			pf->auto_disable_flags &= ~I40E_FLAG_FD_ATR_ENABLED;
-			dev_info(&pf->pdev->dev, "ATR is being enabled since we have space in the table now\n");
+			if (I40E_DEBUG_FD & pf->hw.debug_mask)
+				dev_info(&pf->pdev->dev, "ATR is being enabled since we have space in the table now\n");
 		}
 	}
 }
@@ -5474,7 +5477,8 @@ static void i40e_fdir_flush_and_replay(struct i40e_pf *pf)
 
 		if (!(time_after(jiffies, min_flush_time)) &&
 		    (fd_room < I40E_FDIR_BUFFER_HEAD_ROOM_FOR_ATR)) {
-			dev_info(&pf->pdev->dev, "ATR disabled, not enough FD filter space.\n");
+			if (I40E_DEBUG_FD & pf->hw.debug_mask)
+				dev_info(&pf->pdev->dev, "ATR disabled, not enough FD filter space.\n");
 			disable_atr = true;
 		}
 
@@ -5501,7 +5505,8 @@ static void i40e_fdir_flush_and_replay(struct i40e_pf *pf)
 			if (!disable_atr)
 				pf->flags |= I40E_FLAG_FD_ATR_ENABLED;
 			clear_bit(__I40E_FD_FLUSH_REQUESTED, &pf->state);
-			dev_info(&pf->pdev->dev, "FD Filter table flushed and FD-SB replayed.\n");
+			if (I40E_DEBUG_FD & pf->hw.debug_mask)
+				dev_info(&pf->pdev->dev, "FD Filter table flushed and FD-SB replayed.\n");
 		}
 	}
 }
@@ -7772,7 +7777,8 @@ bool i40e_set_ntuple(struct i40e_pf *pf, netdev_features_t features)
 		pf->fd_add_err = pf->fd_atr_cnt = pf->fd_tcp_rule = 0;
 		pf->fdir_pf_active_filters = 0;
 		pf->flags |= I40E_FLAG_FD_ATR_ENABLED;
-		dev_info(&pf->pdev->dev, "ATR re-enabled.\n");
+		if (I40E_DEBUG_FD & pf->hw.debug_mask)
+			dev_info(&pf->pdev->dev, "ATR re-enabled.\n");
 		/* if ATR was auto disabled it can be re-enabled. */
 		if ((pf->flags & I40E_FLAG_FD_ATR_ENABLED) &&
 		    (pf->auto_disable_flags & I40E_FLAG_FD_ATR_ENABLED))
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index d781a86..d6ad42b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -283,7 +283,8 @@ static int i40e_add_del_fdir_tcpv4(struct i40e_vsi *vsi,
 	if (add) {
 		pf->fd_tcp_rule++;
 		if (pf->flags & I40E_FLAG_FD_ATR_ENABLED) {
-			dev_info(&pf->pdev->dev, "Forcing ATR off, sideband rules for TCP/IPv4 flow being applied\n");
+			if (I40E_DEBUG_FD & pf->hw.debug_mask)
+				dev_info(&pf->pdev->dev, "Forcing ATR off, sideband rules for TCP/IPv4 flow being applied\n");
 			pf->flags &= ~I40E_FLAG_FD_ATR_ENABLED;
 		}
 	} else {
@@ -291,7 +292,8 @@ static int i40e_add_del_fdir_tcpv4(struct i40e_vsi *vsi,
 				  (pf->fd_tcp_rule - 1) : 0;
 		if (pf->fd_tcp_rule == 0) {
 			pf->flags |= I40E_FLAG_FD_ATR_ENABLED;
-			dev_info(&pf->pdev->dev, "ATR re-enabled due to no sideband TCP/IPv4 rules\n");
+			if (I40E_DEBUG_FD & pf->hw.debug_mask)
+				dev_info(&pf->pdev->dev, "ATR re-enabled due to no sideband TCP/IPv4 rules\n");
 		}
 	}
 
@@ -501,7 +503,8 @@ static void i40e_fd_handle_status(struct i40e_ring *rx_ring,
 			if ((pf->flags & I40E_FLAG_FD_SB_ENABLED) &&
 			    !(pf->auto_disable_flags &
 				     I40E_FLAG_FD_SB_ENABLED)) {
-				dev_warn(&pdev->dev, "FD filter space full, new ntuple rules will not be added\n");
+				if (I40E_DEBUG_FD & pf->hw.debug_mask)
+					dev_warn(&pdev->dev, "FD filter space full, new ntuple rules will not be added\n");
 				pf->auto_disable_flags |=
 							I40E_FLAG_FD_SB_ENABLED;
 			}
-- 
1.9.3

