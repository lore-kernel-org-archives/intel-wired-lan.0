From: Alice Michael <alice.michael@intel.com>
Date: Wed, 19 Dec 2018 06:45:37 -0800
Subject: [Intel-wired-lan] [next PATCH S1 1/6] i40e: Limiting RSS queues to
 CPUs.
Message-ID: <20181219144542.85924-1-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Limiting RSS queues number to online CPUs number in order to
avoid issues with creating misconfigured RSS queues.

Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 1e61c22c27f4..b4ae4ba84aa3 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -11554,6 +11554,7 @@ int i40e_reconfig_rss_queues(struct i40e_pf *pf, int queue_count)
 	if (!(pf->flags & I40E_FLAG_RSS_ENABLED))
 		return 0;
 
+	queue_count = min_t(int, queue_count, num_online_cpus());
 	new_rss_size = min_t(int, queue_count, pf->rss_size_max);
 
 	if (queue_count != vsi->num_queue_pairs) {
-- 
2.19.2

