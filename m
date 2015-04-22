From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Wed, 22 Apr 2015 19:34:05 -0400
Subject: [Intel-wired-lan] [net-next S4 v2 10/15] i40e/i40evf: Add stats to
	track FD ATR and SB dynamic enable state
Message-ID: <1429745646-183026-1-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Anjali Singhai Jain <anjali.singhai@intel.com>

Since the driver can dynamically enable/disable FD ATR and SB features,
these stats help keep track of the current state and along with
fd_flush count provide a means to debug what could be going on
with the flow director filters. This will take away the need for
being verbose in our debug logs with respect to FD.

Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
Change-ID: I29224f750fe6602391043655d18996570720377d
---
v2: Change the binary and's in if statements to logical and's

 drivers/net/ethernet/intel/i40e/i40e_ethtool.c |  2 ++
 drivers/net/ethernet/intel/i40e/i40e_main.c    | 12 ++++++++++++
 drivers/net/ethernet/intel/i40e/i40e_type.h    |  2 ++
 drivers/net/ethernet/intel/i40evf/i40e_type.h  |  2 ++
 4 files changed, 18 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 9a68c65..0b68f61 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -148,7 +148,9 @@ static struct i40e_stats i40e_gstrings_stats[] = {
 	I40E_PF_STAT("fdir_flush_cnt", fd_flush_cnt),
 	I40E_PF_STAT("fdir_atr_match", stats.fd_atr_match),
 	I40E_PF_STAT("fdir_atr_tunnel_match", stats.fd_atr_tunnel_match),
+	I40E_PF_STAT("fdir_atr_status", stats.fd_atr_status),
 	I40E_PF_STAT("fdir_sb_match", stats.fd_sb_match),
+	I40E_PF_STAT("fdir_sb_status", stats.fd_sb_status),
 
 	/* LPI stats */
 	I40E_PF_STAT("tx_lpi_status", stats.tx_lpi_status),
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index d1ac807..29c7cdc 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -1123,6 +1123,18 @@ static void i40e_update_pf_stats(struct i40e_pf *pf)
 			   pf->stat_offsets_loaded,
 			   &osd->rx_lpi_count, &nsd->rx_lpi_count);
 
+	if (pf->flags & I40E_FLAG_FD_SB_ENABLED &&
+	    !(pf->auto_disable_flags & I40E_FLAG_FD_SB_ENABLED))
+		nsd->fd_sb_status = true;
+	else
+		nsd->fd_sb_status = false;
+
+	if (pf->flags & I40E_FLAG_FD_ATR_ENABLED &&
+	    !(pf->auto_disable_flags & I40E_FLAG_FD_ATR_ENABLED))
+		nsd->fd_atr_status = true;
+	else
+		nsd->fd_atr_status = false;
+
 	pf->stat_offsets_loaded = true;
 }
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_type.h b/drivers/net/ethernet/intel/i40e/i40e_type.h
index 9a5a75b..350c5ee 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_type.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_type.h
@@ -1134,6 +1134,8 @@ struct i40e_hw_port_stats {
 	u64 fd_atr_match;
 	u64 fd_sb_match;
 	u64 fd_atr_tunnel_match;
+	u32 fd_atr_status;
+	u32 fd_sb_status;
 	/* EEE LPI */
 	u32 tx_lpi_status;
 	u32 rx_lpi_status;
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_type.h b/drivers/net/ethernet/intel/i40evf/i40e_type.h
index c463ec4..068813d 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_type.h
+++ b/drivers/net/ethernet/intel/i40evf/i40e_type.h
@@ -1109,6 +1109,8 @@ struct i40e_hw_port_stats {
 	u64 fd_atr_match;
 	u64 fd_sb_match;
 	u64 fd_atr_tunnel_match;
+	u32 fd_atr_status;
+	u32 fd_sb_status;
 	/* EEE LPI */
 	u32 tx_lpi_status;
 	u32 rx_lpi_status;
-- 
1.9.3

