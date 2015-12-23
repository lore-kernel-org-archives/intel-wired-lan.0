From: Deepthi Kavalur <deepthi.kavalur@intel.com>
Date: Wed, 23 Dec 2015 12:05:48 -0800
Subject: [Intel-wired-lan] [next PATCH S25 08/16] i40e: add counter for arq
	overflows
In-Reply-To: <1450901156-30904-1-git-send-email-deepthi.kavalur@intel.com>
References: <1450901156-30904-1-git-send-email-deepthi.kavalur@intel.com>
Message-ID: <1450901156-30904-9-git-send-email-deepthi.kavalur@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

Sometimes, ARQ overflows are a big deal and tell us that the
firmware/hardware/driver/something is having problems. But normally
they're no big deal. To assist in assessing this, add a counter to
our Ethtool stats. A handful of ARQ overflows during VF init is no
problem. A large, ever-growing number indicates that Something Bad is
happening.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Change-ID: Ie5348bfbc8a54a890559cb00279c28d976a55096
---
 drivers/net/ethernet/intel/i40e/i40e.h         | 1 +
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 1 +
 drivers/net/ethernet/intel/i40e/i40e_main.c    | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 7ec304c..9ad2f37 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -392,6 +392,7 @@ struct i40e_pf {
 	struct i40e_vf *vf;
 	int num_alloc_vfs;	/* actual number of VFs allocated */
 	u32 vf_aq_requests;
+	u32 arq_overflows;	/* Not fatal, possibly indicative of problems */
 
 	/* DCBx/DCBNL capability for PF that indicates
 	 * whether DCBx is managed by firmware or host
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index e13ee93..691939d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -143,6 +143,7 @@ static struct i40e_stats i40e_gstrings_stats[] = {
 	I40E_PF_STAT("rx_oversize", stats.rx_oversize),
 	I40E_PF_STAT("rx_jabber", stats.rx_jabber),
 	I40E_PF_STAT("VF_admin_queue_requests", vf_aq_requests),
+	I40E_PF_STAT("arq_overflows", arq_overflows),
 	I40E_PF_STAT("rx_hwtstamp_cleared", rx_hwtstamp_cleared),
 	I40E_PF_STAT("fdir_flush_cnt", fd_flush_cnt),
 	I40E_PF_STAT("fdir_atr_match", stats.fd_atr_match),
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 66cc702..f751a80 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -6242,6 +6242,7 @@ static void i40e_clean_adminq_subtask(struct i40e_pf *pf)
 		if (hw->debug_mask & I40E_DEBUG_AQ)
 			dev_info(&pf->pdev->dev, "ARQ Overflow Error detected\n");
 		val &= ~I40E_PF_ARQLEN_ARQOVFL_MASK;
+		pf->arq_overflows++;
 	}
 	if (val & I40E_PF_ARQLEN_ARQCRIT_MASK) {
 		if (hw->debug_mask & I40E_DEBUG_AQ)
-- 
2.1.0

