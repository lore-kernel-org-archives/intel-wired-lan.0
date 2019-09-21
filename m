From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 20 Sep 2019 17:18:50 -0700
Subject: [Intel-wired-lan] [next PATCH] ixgbe: Make use of
 cpumask_local_spread to improve RSS locality
Message-ID: <20190921001818.3431.45376.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alexander Duyck <alexander.h.duyck@linux.intel.com>

This patch is meant to address locality issues present in the ixgbe driver
when it is loaded on a system supporting multiple NUMA nodes and more CPUs
then the device can map in a 1:1 fashion. Instead of just arbitrarily
mapping itself to CPUs 0-62 it would make much more sense to map itself to
the local CPUs first, and then map itself to any remaining CPUs that might
be used.

The first effect of this is that queue 0 should always be allocated on the
local CPU/NUMA node. This is important as it is the default destination if
a packet doesn't match any existing flow director filter or RSS rule and as
such having it local should help to reduce QPI cross-talk in the event of
an unrecognized traffic type.

In addition this should increase the likelihood of the RSS queues being
allocated and used on CPUs local to the device while the ATR/Flow Director
queues would be able to route traffic directly to the CPU that is likely to
be processing it.

Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
index cc3196ae5aea..fd9f5d41b594 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
@@ -832,9 +832,9 @@ static int ixgbe_alloc_q_vector(struct ixgbe_adapter *adapter,
 				int xdp_count, int xdp_idx,
 				int rxr_count, int rxr_idx)
 {
+	int node = dev_to_node(&adapter->pdev->dev);
 	struct ixgbe_q_vector *q_vector;
 	struct ixgbe_ring *ring;
-	int node = NUMA_NO_NODE;
 	int cpu = -1;
 	int ring_count;
 	u8 tcs = adapter->hw_tcs;
@@ -845,10 +845,8 @@ static int ixgbe_alloc_q_vector(struct ixgbe_adapter *adapter,
 	if ((tcs <= 1) && !(adapter->flags & IXGBE_FLAG_SRIOV_ENABLED)) {
 		u16 rss_i = adapter->ring_feature[RING_F_RSS].indices;
 		if (rss_i > 1 && adapter->atr_sample_rate) {
-			if (cpu_online(v_idx)) {
-				cpu = v_idx;
-				node = cpu_to_node(cpu);
-			}
+			cpu = cpumask_local_spread(v_idx, node);
+			node = cpu_to_node(cpu);
 		}
 	}
 

