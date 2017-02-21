From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Tue, 21 Feb 2017 15:55:40 -0800
Subject: [Intel-wired-lan] [next PATCH S61 02/10] i40e: fix configuration of
	RSS table with DCB
In-Reply-To: <1487721348-25617-1-git-send-email-bimmy.pujari@intel.com>
References: <1487721348-25617-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1487721348-25617-3-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>

There exists a bug in the driver where the calculation of the
RSS size was not taking into account the number of traffic classes
enabled. This patch factors in the traffic classes both in
the initial configuration of the table as well as reconfiguration.

Signed-off-by: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
Change-ID: I34dcd345ce52faf1d6b9614bea28d450cfd5f621
---
Testing Hints: Change the number of queues and RSS hash table via
ethtool and ensure that no packets are dropped.

 drivers/net/ethernet/intel/i40e/i40e_main.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index d587237..db09914 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -8733,9 +8733,12 @@ static int i40e_pf_config_rss(struct i40e_pf *pf)
 	i40e_write_rx_ctl(hw, I40E_PFQF_CTL_0, reg_val);
 
 	/* Determine the RSS size of the VSI */
-	if (!vsi->rss_size)
-		vsi->rss_size = min_t(int, pf->alloc_rss_size,
-				      vsi->num_queue_pairs);
+	if (!vsi->rss_size) {
+		u16 qcount;
+
+		qcount = vsi->num_queue_pairs / vsi->tc_config.numtc;
+		vsi->rss_size = min_t(int, pf->alloc_rss_size, qcount);
+	}
 	if (!vsi->rss_size)
 		return -EINVAL;
 
@@ -8781,6 +8784,8 @@ int i40e_reconfig_rss_queues(struct i40e_pf *pf, int queue_count)
 	new_rss_size = min_t(int, queue_count, pf->rss_size_max);
 
 	if (queue_count != vsi->num_queue_pairs) {
+		u16 qcount;
+
 		vsi->req_queue_pairs = queue_count;
 		i40e_prep_for_reset(pf);
 
@@ -8798,8 +8803,8 @@ int i40e_reconfig_rss_queues(struct i40e_pf *pf, int queue_count)
 		}
 
 		/* Reset vsi->rss_size, as number of enabled queues changed */
-		vsi->rss_size = min_t(int, pf->alloc_rss_size,
-				      vsi->num_queue_pairs);
+		qcount = vsi->num_queue_pairs / vsi->tc_config.numtc;
+		vsi->rss_size = min_t(int, pf->alloc_rss_size, qcount);
 
 		i40e_pf_config_rss(pf);
 	}
-- 
2.4.11

