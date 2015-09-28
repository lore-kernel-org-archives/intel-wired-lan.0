From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Mon, 28 Sep 2015 14:16:52 -0400
Subject: [Intel-wired-lan] [next PATCH S17 03/11] i40e/i40evf: fix bug in
	throttle rate math
In-Reply-To: <1443464220-148318-1-git-send-email-catherine.sullivan@intel.com>
References: <1443464220-148318-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1443464220-148318-4-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

The driver was using a value expressed in 2us increments
for the divisor to figure out our bytes/usec values.

Fix the usecs variable to contain a value in microseconds.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Change-ID: I5c20493103c295d6f201947bb908add7040b7c41
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 9 ++++++++-
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 9 ++++++++-
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index c023b12..24e8f6b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -829,6 +829,7 @@ static bool i40e_set_new_dynamic_itr(struct i40e_ring_container *rc)
 	enum i40e_latency_range new_latency_range = rc->latency_range;
 	u32 new_itr = rc->itr;
 	int bytes_per_int;
+	int usecs;
 
 	if (rc->total_packets == 0 || !rc->itr)
 		return false;
@@ -837,8 +838,14 @@ static bool i40e_set_new_dynamic_itr(struct i40e_ring_container *rc)
 	 *   0-10MB/s   lowest (100000 ints/s)
 	 *  10-20MB/s   low    (20000 ints/s)
 	 *  20-1249MB/s bulk   (8000 ints/s)
+	 *
+	 * The math works out because the divisor is in 10^(-6) which
+	 * turns the bytes/us input value into MB/s values, but
+	 * make sure to use usecs, as the register values written
+	 * are in 2 usec increments in the ITR registers.
 	 */
-	bytes_per_int = rc->total_bytes / rc->itr;
+	usecs = (rc->itr << 1);
+	bytes_per_int = rc->total_bytes / usecs;
 	switch (new_latency_range) {
 	case I40E_LOWEST_LATENCY:
 		if (bytes_per_int > 10)
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
index 3d2646b..3f4a595 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
@@ -333,6 +333,7 @@ static bool i40e_set_new_dynamic_itr(struct i40e_ring_container *rc)
 	enum i40e_latency_range new_latency_range = rc->latency_range;
 	u32 new_itr = rc->itr;
 	int bytes_per_int;
+	int usecs;
 
 	if (rc->total_packets == 0 || !rc->itr)
 		return false;
@@ -341,8 +342,14 @@ static bool i40e_set_new_dynamic_itr(struct i40e_ring_container *rc)
 	 *   0-10MB/s   lowest (100000 ints/s)
 	 *  10-20MB/s   low    (20000 ints/s)
 	 *  20-1249MB/s bulk   (8000 ints/s)
+	 *
+	 * The math works out because the divisor is in 10^(-6) which
+	 * turns the bytes/us input value into MB/s values, but
+	 * make sure to use usecs, as the register values written
+	 * are in 2 usec increments in the ITR registers.
 	 */
-	bytes_per_int = rc->total_bytes / rc->itr;
+	usecs = (rc->itr << 1);
+	bytes_per_int = rc->total_bytes / usecs;
 	switch (new_latency_range) {
 	case I40E_LOWEST_LATENCY:
 		if (bytes_per_int > 10)
-- 
1.9.3

