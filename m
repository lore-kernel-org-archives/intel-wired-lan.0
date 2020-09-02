From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Wed,  2 Sep 2020 16:36:57 -0700
Subject: [Intel-wired-lan] [PATCH next-queue v1 2/2] igc: Reject schedules
 with a base_time in the future
In-Reply-To: <20200902233657.4051914-1-vinicius.gomes@intel.com>
References: <20200902233657.4051914-1-vinicius.gomes@intel.com>
Message-ID: <20200902233657.4051914-2-vinicius.gomes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

When we set the BASET registers of i225 with a base_time in the
future, i225 will "hold" all packets until that base_time is reached,
causing a lot of TX Hangs.

As this behaviour seems contrary to the expectations of the IEEE
802.1Q standard (section 8.6.9, specially 8.6.9.4.5), let's start by
rejecting these types of schedules. If this is too limiting, we can
for example, setup a timer to configure the BASET registers closer to
the start time, only blocking the packets for a "short" while.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 25 +++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 2cdf83e213b3..fd569cfa414f 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -4705,14 +4705,35 @@ static int igc_save_launchtime_params(struct igc_adapter *adapter, int queue,
 	return 0;
 }
 
-static bool validate_schedule(const struct tc_taprio_qopt_offload *qopt)
+static bool is_base_time_past(ktime_t base_time, const struct timespec64 *now)
+{
+	struct timespec64 b;
+
+	b = ktime_to_timespec64(base_time);
+
+	return timespec64_compare(now, &b) > 0;
+}
+
+static bool validate_schedule(struct igc_adapter *adapter,
+			      const struct tc_taprio_qopt_offload *qopt)
 {
 	int queue_uses[IGC_MAX_TX_QUEUES] = { };
+	struct timespec64 now;
 	size_t n;
 
 	if (qopt->cycle_time_extension)
 		return false;
 
+	igc_ptp_read(adapter, &now);
+
+	/* If we program the controller's BASET registers with a time
+	 * in the future, it will hold all the packets until that
+	 * time, causing a lot of TX Hangs, so to avoid that, we
+	 * reject schedules that would start in the future.
+	 */
+	if (!is_base_time_past(qopt->base_time, &now))
+		return false;
+
 	for (n = 0; n < qopt->num_entries; n++) {
 		const struct tc_taprio_sched_entry *e;
 		int i;
@@ -4767,7 +4788,7 @@ static int igc_save_qbv_schedule(struct igc_adapter *adapter,
 	if (adapter->base_time)
 		return -EALREADY;
 
-	if (!validate_schedule(qopt))
+	if (!validate_schedule(adapter, qopt))
 		return -EINVAL;
 
 	adapter->cycle_time = qopt->cycle_time;
-- 
2.28.0

