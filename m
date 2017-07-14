From: Alice Michael <alice.michael@intel.com>
Date: Fri, 14 Jul 2017 09:27:00 -0400
Subject: [Intel-wired-lan] [next PATCH S77-V3 01/10] i40e: fix for flow
	director counters not wrapping as expected
Message-ID: <20170714132709.52657-1-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mariusz Stachura <mariusz.stachura@intel.com>

An eratta with GLQF_PCNT causes it to not wrap as expected. This
can cause an error in flow director statistics. This patch resets
affected counters just after reading.

Testing Hints (required if no HSD): DCR 2187

Signed-off-by: Mariusz Stachura <mariusz.stachura@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 35 +++++++++++++++++++----------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 647a7a6..43ed431 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -600,6 +600,20 @@ static void i40e_stat_update32(struct i40e_hw *hw, u32 reg,
 }
 
 /**
+ * i40e_stat_update_and_clear32 - read and clear hw reg, update a 32 bit stat
+ * @hw: ptr to the hardware info
+ * @reg: the hw reg to read and clear
+ * @stat: ptr to the stat
+ **/
+static void i40e_stat_update_and_clear32(struct i40e_hw *hw, u32 reg, u64 *stat)
+{
+	u32 new_data = rd32(hw, reg);
+
+	wr32(hw, reg, 1); /* must write a nonzero value to clear register */
+	*stat += new_data;
+}
+
+/**
  * i40e_update_eth_stats - Update VSI-specific ethernet statistics counters.
  * @vsi: the VSI to be updated
  **/
@@ -1040,18 +1054,15 @@ static void i40e_update_pf_stats(struct i40e_pf *pf)
 			   &osd->rx_jabber, &nsd->rx_jabber);
 
 	/* FDIR stats */
-	i40e_stat_update32(hw,
-			   I40E_GLQF_PCNT(I40E_FD_ATR_STAT_IDX(pf->hw.pf_id)),
-			   pf->stat_offsets_loaded,
-			   &osd->fd_atr_match, &nsd->fd_atr_match);
-	i40e_stat_update32(hw,
-			   I40E_GLQF_PCNT(I40E_FD_SB_STAT_IDX(pf->hw.pf_id)),
-			   pf->stat_offsets_loaded,
-			   &osd->fd_sb_match, &nsd->fd_sb_match);
-	i40e_stat_update32(hw,
-		      I40E_GLQF_PCNT(I40E_FD_ATR_TUNNEL_STAT_IDX(pf->hw.pf_id)),
-		      pf->stat_offsets_loaded,
-		      &osd->fd_atr_tunnel_match, &nsd->fd_atr_tunnel_match);
+	i40e_stat_update_and_clear32(hw,
+			I40E_GLQF_PCNT(I40E_FD_ATR_STAT_IDX(hw->pf_id)),
+			&nsd->fd_atr_match);
+	i40e_stat_update_and_clear32(hw,
+			I40E_GLQF_PCNT(I40E_FD_SB_STAT_IDX(hw->pf_id)),
+			&nsd->fd_sb_match);
+	i40e_stat_update_and_clear32(hw,
+			I40E_GLQF_PCNT(I40E_FD_ATR_TUNNEL_STAT_IDX(hw->pf_id)),
+			&nsd->fd_atr_tunnel_match);
 
 	val = rd32(hw, I40E_PRTPM_EEE_STAT);
 	nsd->tx_lpi_status =
-- 
2.9.3

