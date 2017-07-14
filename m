From: Alice Michael <alice.michael@intel.com>
Date: Fri, 14 Jul 2017 09:10:12 -0400
Subject: [Intel-wired-lan] [next PATCH S76-V2 06/13] i40e/i40evf: remove
	ULTRA latency mode
In-Reply-To: <20170714131019.52530-1-alice.michael@intel.com>
References: <20170714131019.52530-1-alice.michael@intel.com>
Message-ID: <20170714131019.52530-6-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

Since commit c56625d59726 ("i40e/i40evf: change dynamic interrupt
thresholds") a new higher latency ITR setting called I40E_ULTRA_LATENCY
was added with a cryptic comment about how it was meant for adjusting Rx
more aggressively when streaming small packets.

This mode was attempting to calculate packets per second and then kick
in when we have a huge number of small packets.

Unfortunately, the ULTRA setting was kicking in for workloads it wasn't
intended for including single-thread UDP_STREAM workloads.

This wasn't caught for a variety of reasons. First, the ip_defrag
routines were improved somewhat which makes the UDP_STREAM test still
reasonable at 10GbE, even when dropped down to 8k interrupts a second.
Additionally, some other obvious workloads appear to work fine, such
as TCP_STREAM.

The number 40k doesn't make sense for a number of reasons. First, we
absolutely can do more than 40k packets per second. Second, we calculate
the value inline in an integer, which sometimes can overflow resulting
in using incorrect values.

If we fix this overflow it makes it even more likely that we'll enter
ULTRA mode which is the opposite of what we want.

The ULTRA mode was added originally as a way to reduce CPU utilization
during a small packet workload where we weren't keeping up anyways. It
should never have been kicking in during these other workloads.

Given the issues outlined above, let's remove the ULTRA latency mode. If
necessary, a better solution to the CPU utilization issue for small
packet workloads will be added in a future patch.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 17 -----------------
 drivers/net/ethernet/intel/i40e/i40e_txrx.h   |  1 -
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 17 -----------------
 drivers/net/ethernet/intel/i40evf/i40e_txrx.h |  1 -
 4 files changed, 36 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index b323677..c056f60 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -959,7 +959,6 @@ void i40e_force_wb(struct i40e_vsi *vsi, struct i40e_q_vector *q_vector)
 static bool i40e_set_new_dynamic_itr(struct i40e_ring_container *rc)
 {
 	enum i40e_latency_range new_latency_range = rc->latency_range;
-	struct i40e_q_vector *qv = rc->ring->q_vector;
 	u32 new_itr = rc->itr;
 	int bytes_per_int;
 	int usecs;
@@ -971,7 +970,6 @@ static bool i40e_set_new_dynamic_itr(struct i40e_ring_container *rc)
 	 *   0-10MB/s   lowest (50000 ints/s)
 	 *  10-20MB/s   low    (20000 ints/s)
 	 *  20-1249MB/s bulk   (18000 ints/s)
-	 *  > 40000 Rx packets per second (8000 ints/s)
 	 *
 	 * The math works out because the divisor is in 10^(-6) which
 	 * turns the bytes/us input value into MB/s values, but
@@ -994,24 +992,12 @@ static bool i40e_set_new_dynamic_itr(struct i40e_ring_container *rc)
 			new_latency_range = I40E_LOWEST_LATENCY;
 		break;
 	case I40E_BULK_LATENCY:
-	case I40E_ULTRA_LATENCY:
 	default:
 		if (bytes_per_int <= 20)
 			new_latency_range = I40E_LOW_LATENCY;
 		break;
 	}
 
-	/* this is to adjust RX more aggressively when streaming small
-	 * packets.  The value of 40000 was picked as it is just beyond
-	 * what the hardware can receive per second if in low latency
-	 * mode.
-	 */
-#define RX_ULTRA_PACKET_RATE 40000
-
-	if ((((rc->total_packets * 1000000) / usecs) > RX_ULTRA_PACKET_RATE) &&
-	    (&qv->rx == rc))
-		new_latency_range = I40E_ULTRA_LATENCY;
-
 	rc->latency_range = new_latency_range;
 
 	switch (new_latency_range) {
@@ -1024,9 +1010,6 @@ static bool i40e_set_new_dynamic_itr(struct i40e_ring_container *rc)
 	case I40E_BULK_LATENCY:
 		new_itr = I40E_ITR_18K;
 		break;
-	case I40E_ULTRA_LATENCY:
-		new_itr = I40E_ITR_8K;
-		break;
 	default:
 		break;
 	}
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.h b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
index f0a0eab..e6456e8 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
@@ -454,7 +454,6 @@ enum i40e_latency_range {
 	I40E_LOWEST_LATENCY = 0,
 	I40E_LOW_LATENCY = 1,
 	I40E_BULK_LATENCY = 2,
-	I40E_ULTRA_LATENCY = 3,
 };
 
 struct i40e_ring_container {
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
index a8dc1d9..b9acb20 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
@@ -357,7 +357,6 @@ void i40evf_force_wb(struct i40e_vsi *vsi, struct i40e_q_vector *q_vector)
 static bool i40e_set_new_dynamic_itr(struct i40e_ring_container *rc)
 {
 	enum i40e_latency_range new_latency_range = rc->latency_range;
-	struct i40e_q_vector *qv = rc->ring->q_vector;
 	u32 new_itr = rc->itr;
 	int bytes_per_int;
 	int usecs;
@@ -369,7 +368,6 @@ static bool i40e_set_new_dynamic_itr(struct i40e_ring_container *rc)
 	 *   0-10MB/s   lowest (50000 ints/s)
 	 *  10-20MB/s   low    (20000 ints/s)
 	 *  20-1249MB/s bulk   (18000 ints/s)
-	 *  > 40000 Rx packets per second (8000 ints/s)
 	 *
 	 * The math works out because the divisor is in 10^(-6) which
 	 * turns the bytes/us input value into MB/s values, but
@@ -392,24 +390,12 @@ static bool i40e_set_new_dynamic_itr(struct i40e_ring_container *rc)
 			new_latency_range = I40E_LOWEST_LATENCY;
 		break;
 	case I40E_BULK_LATENCY:
-	case I40E_ULTRA_LATENCY:
 	default:
 		if (bytes_per_int <= 20)
 			new_latency_range = I40E_LOW_LATENCY;
 		break;
 	}
 
-	/* this is to adjust RX more aggressively when streaming small
-	 * packets.  The value of 40000 was picked as it is just beyond
-	 * what the hardware can receive per second if in low latency
-	 * mode.
-	 */
-#define RX_ULTRA_PACKET_RATE 40000
-
-	if ((((rc->total_packets * 1000000) / usecs) > RX_ULTRA_PACKET_RATE) &&
-	    (&qv->rx == rc))
-		new_latency_range = I40E_ULTRA_LATENCY;
-
 	rc->latency_range = new_latency_range;
 
 	switch (new_latency_range) {
@@ -422,9 +408,6 @@ static bool i40e_set_new_dynamic_itr(struct i40e_ring_container *rc)
 	case I40E_BULK_LATENCY:
 		new_itr = I40E_ITR_18K;
 		break;
-	case I40E_ULTRA_LATENCY:
-		new_itr = I40E_ITR_8K;
-		break;
 	default:
 		break;
 	}
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_txrx.h b/drivers/net/ethernet/intel/i40evf/i40e_txrx.h
index 4896840..fb506c9 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.h
+++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.h
@@ -425,7 +425,6 @@ enum i40e_latency_range {
 	I40E_LOWEST_LATENCY = 0,
 	I40E_LOW_LATENCY = 1,
 	I40E_BULK_LATENCY = 2,
-	I40E_ULTRA_LATENCY = 3,
 };
 
 struct i40e_ring_container {
-- 
2.9.3

