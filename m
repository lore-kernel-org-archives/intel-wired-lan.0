From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Thu, 16 Apr 2015 20:06:02 -0400
Subject: [Intel-wired-lan] [net-next S4 05/15] i40e: Remove unnecessary pf
	members
In-Reply-To: <1429229172-143692-1-git-send-email-catherine.sullivan@intel.com>
References: <1429229172-143692-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1429229172-143692-6-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Anjali Singhai Jain <anjali.singhai@intel.com>

We can use the stat index macro directly, a variable is not required.

Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
Change-ID: I19f08ac16353dc0cd87a1a8248d714e15a54aa8a
---
 drivers/net/ethernet/intel/i40e/i40e.h         |  2 --
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c |  2 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c    | 10 ++++------
 3 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 0bfa5a0..aca9cef 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -266,8 +266,6 @@ struct i40e_pf {
 
 	struct hlist_head fdir_filter_list;
 	u16 fdir_pf_active_filters;
-	u16 fd_sb_cnt_idx;
-	u16 fd_atr_cnt_idx;
 	unsigned long fd_flush_timestamp;
 	u32 fd_flush_cnt;
 	u32 fd_add_err;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index c568c90..9a68c65 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -2293,7 +2293,7 @@ static int i40e_add_fdir_ethtool(struct i40e_vsi *vsi,
 	input->pctype = 0;
 	input->dest_vsi = vsi->id;
 	input->fd_status = I40E_FILTER_PROGRAM_DESC_FD_STATUS_FD_ID;
-	input->cnt_index  = pf->fd_sb_cnt_idx;
+	input->cnt_index  = I40E_FD_SB_STAT_IDX(pf->hw.pf_id);
 	input->flow_type = fsp->flow_type;
 	input->ip4_proto = fsp->h_u.usr_ip4_spec.proto;
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 35a571d..a5c13de 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -1096,10 +1096,12 @@ static void i40e_update_pf_stats(struct i40e_pf *pf)
 			   &osd->rx_jabber, &nsd->rx_jabber);
 
 	/* FDIR stats */
-	i40e_stat_update32(hw, I40E_GLQF_PCNT(pf->fd_atr_cnt_idx),
+	i40e_stat_update32(hw,
+			   I40E_GLQF_PCNT(I40E_FD_ATR_STAT_IDX(pf->hw.pf_id)),
 			   pf->stat_offsets_loaded,
 			   &osd->fd_atr_match, &nsd->fd_atr_match);
-	i40e_stat_update32(hw, I40E_GLQF_PCNT(pf->fd_sb_cnt_idx),
+	i40e_stat_update32(hw,
+			   I40E_GLQF_PCNT(I40E_FD_SB_STAT_IDX(pf->hw.pf_id)),
 			   pf->stat_offsets_loaded,
 			   &osd->fd_sb_match, &nsd->fd_sb_match);
 	i40e_stat_update32(hw,
@@ -7679,12 +7681,8 @@ static int i40e_sw_init(struct i40e_pf *pf)
 	    (pf->hw.func_caps.fd_filters_best_effort > 0)) {
 		pf->flags |= I40E_FLAG_FD_ATR_ENABLED;
 		pf->atr_sample_rate = I40E_DEFAULT_ATR_SAMPLE_RATE;
-		/* Setup a counter for fd_atr per PF */
-		pf->fd_atr_cnt_idx = I40E_FD_ATR_STAT_IDX(pf->hw.pf_id);
 		if (!(pf->flags & I40E_FLAG_MFP_ENABLED)) {
 			pf->flags |= I40E_FLAG_FD_SB_ENABLED;
-			/* Setup a counter for fd_sb per PF */
-			pf->fd_sb_cnt_idx = I40E_FD_SB_STAT_IDX(pf->hw.pf_id);
 		} else {
 			dev_info(&pf->pdev->dev,
 				 "Flow Director Sideband mode Disabled in MFP mode\n");
-- 
1.9.3

