From: Alice Michael <alice.michael@intel.com>
Date: Fri,  4 Aug 2017 09:52:19 -0400
Subject: [Intel-wired-lan] [next PATCH S78-V4 09/12] i40e: make
	i40evf_map_rings_to_vectors void
In-Reply-To: <20170804135222.46684-1-alice.michael@intel.com>
References: <20170804135222.46684-1-alice.michael@intel.com>
Message-ID: <20170804135222.46684-9-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

This function cannot fail, so why is it returning a value? And why are
we checking it? Why shouldn't we just make it void? Why is this commit
message made up of only questions?

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
---
 drivers/net/ethernet/intel/i40evf/i40evf_main.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index a803c6b..85e66db 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -430,12 +430,11 @@ i40evf_map_vector_to_txq(struct i40evf_adapter *adapter, int v_idx, int t_idx)
  * group the rings as "efficiently" as possible.  You would add new
  * mapping configurations in here.
  **/
-static int i40evf_map_rings_to_vectors(struct i40evf_adapter *adapter)
+static void i40evf_map_rings_to_vectors(struct i40evf_adapter *adapter)
 {
 	int rings_remaining = adapter->num_active_queues;
 	int ridx = 0, vidx = 0;
 	int q_vectors;
-	int err = 0;
 
 	q_vectors = adapter->num_msix_vectors - NONQ_VECS;
 
@@ -451,8 +450,6 @@ static int i40evf_map_rings_to_vectors(struct i40evf_adapter *adapter)
 	}
 
 	adapter->aq_required |= I40EVF_FLAG_AQ_MAP_VECTORS;
-
-	return err;
 }
 
 #ifdef CONFIG_NET_POLL_CONTROLLER
@@ -1578,9 +1575,7 @@ static int i40evf_reinit_interrupt_scheme(struct i40evf_adapter *adapter)
 
 	set_bit(__I40E_VSI_DOWN, adapter->vsi.state);
 
-	err = i40evf_map_rings_to_vectors(adapter);
-	if (err)
-		goto err;
+	i40evf_map_rings_to_vectors(adapter);
 
 	if (RSS_AQ(adapter))
 		adapter->aq_required |= I40EVF_FLAG_AQ_CONFIGURE_RSS;
-- 
2.9.4

