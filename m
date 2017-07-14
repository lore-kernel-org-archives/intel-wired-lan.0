From: Alice Michael <alice.michael@intel.com>
Date: Fri, 14 Jul 2017 09:10:14 -0400
Subject: [Intel-wired-lan] [next PATCH S76-V2 08/13] i40e/i40evf: rename
	bytes_per_int to bytes_per_usec
In-Reply-To: <20170714131019.52530-1-alice.michael@intel.com>
References: <20170714131019.52530-1-alice.michael@intel.com>
Message-ID: <20170714131019.52530-8-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

This value is not calculating bytes_per_int, which would actually just
be bytes/ITR_COUNTDOWN_START, but rather it's calculating bytes/usecs.

Rename the variable for clarity so that future developers understand
what the value is actually calculating.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 12 ++++++------
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 12 ++++++------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 74589ed..8cd8203 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -960,14 +960,14 @@ static bool i40e_set_new_dynamic_itr(struct i40e_ring_container *rc)
 {
 	enum i40e_latency_range new_latency_range = rc->latency_range;
 	u32 new_itr = rc->itr;
-	int bytes_per_int;
+	int bytes_per_usec;
 	unsigned int usecs, estimated_usecs;
 
 	if (rc->total_packets == 0 || !rc->itr)
 		return false;
 
 	usecs = (rc->itr << 1) * ITR_COUNTDOWN_START;
-	bytes_per_int = rc->total_bytes / usecs;
+	bytes_per_usec = rc->total_bytes / usecs;
 
 	/* The calculations in this algorithm depend on interrupts actually
 	 * firing at the ITR rate. This may not happen if the packet rate is
@@ -993,18 +993,18 @@ static bool i40e_set_new_dynamic_itr(struct i40e_ring_container *rc)
 	 */
 	switch (new_latency_range) {
 	case I40E_LOWEST_LATENCY:
-		if (bytes_per_int > 10)
+		if (bytes_per_usec > 10)
 			new_latency_range = I40E_LOW_LATENCY;
 		break;
 	case I40E_LOW_LATENCY:
-		if (bytes_per_int > 20)
+		if (bytes_per_usec > 20)
 			new_latency_range = I40E_BULK_LATENCY;
-		else if (bytes_per_int <= 10)
+		else if (bytes_per_usec <= 10)
 			new_latency_range = I40E_LOWEST_LATENCY;
 		break;
 	case I40E_BULK_LATENCY:
 	default:
-		if (bytes_per_int <= 20)
+		if (bytes_per_usec <= 20)
 			new_latency_range = I40E_LOW_LATENCY;
 		break;
 	}
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
index b56a193..8167617 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
@@ -358,14 +358,14 @@ static bool i40e_set_new_dynamic_itr(struct i40e_ring_container *rc)
 {
 	enum i40e_latency_range new_latency_range = rc->latency_range;
 	u32 new_itr = rc->itr;
-	int bytes_per_int;
+	int bytes_per_usec;
 	unsigned int usecs, estimated_usecs;
 
 	if (rc->total_packets == 0 || !rc->itr)
 		return false;
 
 	usecs = (rc->itr << 1) * ITR_COUNTDOWN_START;
-	bytes_per_int = rc->total_bytes / usecs;
+	bytes_per_usec = rc->total_bytes / usecs;
 
 	/* The calculations in this algorithm depend on interrupts actually
 	 * firing at the ITR rate. This may not happen if the packet rate is
@@ -391,18 +391,18 @@ static bool i40e_set_new_dynamic_itr(struct i40e_ring_container *rc)
 	 */
 	switch (new_latency_range) {
 	case I40E_LOWEST_LATENCY:
-		if (bytes_per_int > 10)
+		if (bytes_per_usec > 10)
 			new_latency_range = I40E_LOW_LATENCY;
 		break;
 	case I40E_LOW_LATENCY:
-		if (bytes_per_int > 20)
+		if (bytes_per_usec > 20)
 			new_latency_range = I40E_BULK_LATENCY;
-		else if (bytes_per_int <= 10)
+		else if (bytes_per_usec <= 10)
 			new_latency_range = I40E_LOWEST_LATENCY;
 		break;
 	case I40E_BULK_LATENCY:
 	default:
-		if (bytes_per_int <= 20)
+		if (bytes_per_usec <= 20)
 			new_latency_range = I40E_LOW_LATENCY;
 		break;
 	}
-- 
2.9.3

