From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Thu, 19 May 2022 18:15:37 -0700
Subject: [Intel-wired-lan] [PATCH net-next v5 10/11] igc: Check incompatible
 configs for Frame Preemption
In-Reply-To: <20220520011538.1098888-1-vinicius.gomes@intel.com>
References: <20220520011538.1098888-1-vinicius.gomes@intel.com>
Message-ID: <20220520011538.1098888-11-vinicius.gomes@intel.com>
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
 drivers/net/ethernet/intel/igc/igc_main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 69e96e9a3ec8..96ad00e33f4b 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -5916,6 +5916,11 @@ static int igc_save_launchtime_params(struct igc_adapter *adapter, int queue,
 	if (queue < 0 || queue >= adapter->num_tx_queues)
 		return -EINVAL;
 
+	if (ring->preemptible) {
+		netdev_err(adapter->netdev, "Cannot enable LaunchTime on a preemptible queue\n");
+		return -EINVAL;
+	}
+
 	ring = adapter->tx_ring[queue];
 	ring->launchtime_enable = enable;
 
-- 
2.35.3

