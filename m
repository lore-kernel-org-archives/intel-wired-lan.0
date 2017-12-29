From: Alice Michael <alice.michael@intel.com>
Date: Fri, 29 Dec 2017 08:49:10 -0500
Subject: [Intel-wired-lan] [next PATCH S85-V1 03/14] i40e: Do not allow use
 more TC queue pairs than MSI-X vectors exist
Message-ID: <20171229134910.14233-1-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Pawe? Jab?o?ski <pawel.jablonski@intel.com>

This patch suppresses the message about invalid TC mapping and wrong
selected TX queue. The root cause of this bug was setting too many
TC queue pairs on huge multiprocessor machines. When quantity of the
TC queue pairs is exceeding MSI-X vectors count then TX queue number
can be selected beyond actual TX queues amount.

Signed-off-by: Pawe? Jab?o?ski <pawel.jablonski@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 14e4a2b..ea8be7c 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -1811,6 +1811,10 @@ static void i40e_vsi_setup_queue_map(struct i40e_vsi *vsi,
 	num_tc_qps = qcount / numtc;
 	num_tc_qps = min_t(int, num_tc_qps, i40e_pf_get_max_q_per_tc(pf));
 
+	/* Do not allow use more TC queue pairs than MSI-X vectors exist */
+	if (pf->flags & I40E_FLAG_MSIX_ENABLED)
+		num_tc_qps = min_t(int, num_tc_qps, pf->num_lan_msix);
+
 	/* Setup queue offset/count for all TCs for given VSI */
 	for (i = 0; i < I40E_MAX_TRAFFIC_CLASS; i++) {
 		/* See if the given TC is enabled for the given VSI */
-- 
2.9.5

