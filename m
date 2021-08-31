From: Karen Sornek <karen.sornek@intel.com>
Date: Tue, 31 Aug 2021 13:39:01 +0200
Subject: [Intel-wired-lan] [PATCH net-next v1] iavf: Refactor string format
 to avoid static analysis warnings
Message-ID: <20210831113901.156388-1-karen.sornek@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Change format to match variable type that is used in string.

Use %u format for unsigned variable and %d format for signed variable
to remove static analysis warnings.

Signed-off-by: Michal Swiatkowski <michal.swiatkowski@intel.com>
Signed-off-by: Karen Sornek <karen.sornek@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c     | 6 +++---
 drivers/net/ethernet/intel/iavf/iavf_virtchnl.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 80437ef26..4eea47a47 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -441,14 +441,14 @@ iavf_request_traffic_irqs(struct iavf_adapter *adapter, char *basename)
 
 		if (q_vector->tx.ring && q_vector->rx.ring) {
 			snprintf(q_vector->name, sizeof(q_vector->name),
-				 "iavf-%s-TxRx-%d", basename, rx_int_idx++);
+				 "iavf-%s-TxRx-%u", basename, rx_int_idx++);
 			tx_int_idx++;
 		} else if (q_vector->rx.ring) {
 			snprintf(q_vector->name, sizeof(q_vector->name),
-				 "iavf-%s-rx-%d", basename, rx_int_idx++);
+				 "iavf-%s-rx-%u", basename, rx_int_idx++);
 		} else if (q_vector->tx.ring) {
 			snprintf(q_vector->name, sizeof(q_vector->name),
-				 "iavf-%s-tx-%d", basename, tx_int_idx++);
+				 "iavf-%s-tx-%u", basename, tx_int_idx++);
 		} else {
 			/* skip this unused q_vector */
 			continue;
diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index 9c128462e..4030cd764 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
@@ -1013,7 +1013,7 @@ print_link_msg:
 	} else if (link_speed_mbps == SPEED_UNKNOWN) {
 		snprintf(speed, IAVF_MAX_SPEED_STRLEN, "%s", "Unknown Mbps");
 	} else {
-		snprintf(speed, IAVF_MAX_SPEED_STRLEN, "%u %s",
+		snprintf(speed, IAVF_MAX_SPEED_STRLEN, "%d %s",
 			 link_speed_mbps, "Mbps");
 	}
 
-- 
2.27.0

