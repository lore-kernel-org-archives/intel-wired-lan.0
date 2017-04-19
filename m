From: Alice Michael <alice.michael@intel.com>
Date: Wed, 19 Apr 2017 09:25:56 -0400
Subject: [Intel-wired-lan] [next PATCH S71 07/10] i40evf: remove needless
	min_t() on num_online_cpus()*2
In-Reply-To: <20170419132559.20459-1-alice.michael@intel.com>
References: <20170419132559.20459-1-alice.michael@intel.com>
Message-ID: <20170419132559.20459-7-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

We already set pairs to the value of adapter->num_active_queues. This
value is limited by vsi_res->num_queue_pairs and num_online_cpus(). This
means that pairs by definition is already smaller than
num_online_cpus()*2, so we don't even need to bother with this check.

Lets just remove it and update the comment.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40evf/i40evf_main.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index 8e6276d8..89035ee 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -1271,13 +1271,13 @@ static int i40evf_set_interrupt_capability(struct i40evf_adapter *adapter)
 	}
 	pairs = adapter->num_active_queues;
 
-	/* It's easy to be greedy for MSI-X vectors, but it really
-	 * doesn't do us much good if we have a lot more vectors
-	 * than CPU's.  So let's be conservative and only ask for
-	 * (roughly) twice the number of vectors as there are CPU's.
+	/* It's easy to be greedy for MSI-X vectors, but it really doesn't do
+	 * us much good if we have more vectors than CPUs. However, we already
+	 * limit the total number of queues by the number of CPUs so we do not
+	 * need any further limiting here.
 	 */
-	v_budget = min_t(int, pairs, (int)(num_online_cpus() * 2)) + NONQ_VECS;
-	v_budget = min_t(int, v_budget, (int)adapter->vf_res->max_vectors);
+	v_budget = min_t(int, pairs + NONQ_VECS,
+			 (int)adapter->vf_res->max_vectors);
 
 	adapter->msix_entries = kcalloc(v_budget,
 					sizeof(struct msix_entry), GFP_KERNEL);
-- 
2.9.3

