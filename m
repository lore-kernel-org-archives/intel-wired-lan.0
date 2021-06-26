From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Fri, 25 Jun 2021 17:33:13 -0700
Subject: [Intel-wired-lan] [PATCH net-next v4 11/12] igc: Check incompatible
 configs for Frame Preemption
In-Reply-To: <20210626003314.3159402-1-vinicius.gomes@intel.com>
References: <20210626003314.3159402-1-vinicius.gomes@intel.com>
Message-ID: <20210626003314.3159402-12-vinicius.gomes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Frame Preemption and LaunchTime cannot be enabled on the same queue.
If that situation happens, emit an error to the user, and log the
error.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 038383519b10..20dac04a02f2 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -5432,6 +5432,11 @@ static int igc_save_launchtime_params(struct igc_adapter *adapter, int queue,
 	if (queue < 0 || queue >= adapter->num_tx_queues)
 		return -EINVAL;
 
+	if (ring->preemptible) {
+		netdev_err(adapter->netdev, "Cannot enable LaunchTime on a preemptible queue\n");
+		return -EINVAL;
+	}
+
 	ring = adapter->tx_ring[queue];
 	ring->launchtime_enable = enable;
 
@@ -5573,8 +5578,14 @@ static int igc_save_frame_preemption(struct igc_adapter *adapter,
 
 	for (i = 0; i < adapter->num_tx_queues; i++) {
 		struct igc_ring *ring = adapter->tx_ring[i];
+		bool preemptible = preempt & BIT(i);
 
-		ring->preemptible = preempt & BIT(i);
+		if (ring->launchtime_enable && preemptible) {
+			netdev_err(adapter->netdev, "Cannot set queue as preemptible if LaunchTime is enabled\n");
+			return -EINVAL;
+		}
+
+		ring->preemptible = preemptible;
 	}
 
 	return 0;
-- 
2.32.0

