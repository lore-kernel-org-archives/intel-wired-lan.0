From: Mateusz Palczewski <mateusz.palczewski@intel.com>
Date: Mon, 20 Sep 2021 15:25:39 +0200
Subject: [Intel-wired-lan] [PATCH net-next v2] iavf: Add support for
 50G/100G in AIM algorithm
Message-ID: <20210920132539.24114-1-mateusz.palczewski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Advanced link speed support was added long back, but adding AIM support
was missed. Adding AIM support for advanced link speed support
allows the algorithm to take into account 50G/100G link speeds.
Also, other previous speeds are taken into consideration when advanced
link speeds are supported.

Signed-off-by: Brett Creeley brett.creeley at intel.com
Signed-off-by: Mateusz Palczewski mateusz.palczewski at intel.com
---
 v2: Removed build issues
---
 drivers/net/ethernet/intel/iavf/iavf_txrx.c | 70 +++++++++++++++------
 1 file changed, 51 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_txrx.c b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
index 3525eab..31286cf 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_txrx.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
@@ -368,35 +368,66 @@ void iavf_force_wb(struct iavf_vsi *vsi, struct iavf_q_vector *q_vector)
 	     val);
 }
 
-static inline bool iavf_container_is_rx(struct iavf_q_vector *q_vector,
-					struct iavf_ring_container *rc)
+static bool iavf_container_is_rx(struct iavf_q_vector *q_vector,
+				 struct iavf_ring_container *rc)
 {
 	return &q_vector->rx == rc;
 }
 
-static inline unsigned int iavf_itr_divisor(struct iavf_q_vector *q_vector)
-{
-	unsigned int divisor;
+#define IAVF_AIM_MULTIPLIER_100G	2560
+#define IAVF_AIM_MULTIPLIER_50G 	1280
+#define IAVF_AIM_MULTIPLIER_40G 	1024
+#define IAVF_AIM_MULTIPLIER_20G 	512
+#define IAVF_AIM_MULTIPLIER_10G 	256
+#define IAVF_AIM_MULTIPLIER_1G  	32
 
-	switch (q_vector->adapter->link_speed) {
+static unsigned int iavf_mbps_itr_multiplier(u32 speed_mbps)
+{
+	switch (speed_mbps) {
+	case SPEED_100000:
+		return IAVF_AIM_MULTIPLIER_100G;
+	case SPEED_50000:
+		return IAVF_AIM_MULTIPLIER_50G;
+	case SPEED_40000:
+		return IAVF_AIM_MULTIPLIER_40G;
+	case SPEED_25000:
+	case SPEED_20000:
+		return IAVF_AIM_MULTIPLIER_20G;
+	case SPEED_10000:
+	default:
+		return IAVF_AIM_MULTIPLIER_10G;
+	case SPEED_1000:
+	case SPEED_100:
+		return IAVF_AIM_MULTIPLIER_1G;
+	}
+}
+?
+static unsigned int
+iavf_virtchnl_itr_multiplier(enum virtchnl_link_speed speed_virtchnl)
+{
+	switch (speed_virtchnl) {
 	case VIRTCHNL_LINK_SPEED_40GB:
-		divisor = IAVF_ITR_ADAPTIVE_MIN_INC * 1024;
-		break;
+		return IAVF_AIM_MULTIPLIER_40G;
 	case VIRTCHNL_LINK_SPEED_25GB:
 	case VIRTCHNL_LINK_SPEED_20GB:
-		divisor = IAVF_ITR_ADAPTIVE_MIN_INC * 512;
-		break;
-	default:
+		return IAVF_AIM_MULTIPLIER_20G;
 	case VIRTCHNL_LINK_SPEED_10GB:
-		divisor = IAVF_ITR_ADAPTIVE_MIN_INC * 256;
-		break;
+	default:
+		return IAVF_AIM_MULTIPLIER_10G;
 	case VIRTCHNL_LINK_SPEED_1GB:
 	case VIRTCHNL_LINK_SPEED_100MB:
-		divisor = IAVF_ITR_ADAPTIVE_MIN_INC * 32;
-		break;
+		return IAVF_AIM_MULTIPLIER_1G;
 	}
-
-	return divisor;
+}
+?
+static unsigned int iavf_itr_divisor(struct iavf_adapter *adapter)
+{
+	if (ADV_LINK_SUPPORT(adapter))
+		return IAVF_ITR_ADAPTIVE_MIN_INC *
+			iavf_mbps_itr_multiplier(adapter->link_speed_mbps);
+	else
+		return IAVF_ITR_ADAPTIVE_MIN_INC *
+			iavf_virtchnl_itr_multiplier(adapter->link_speed);
 }
 
 /**
@@ -586,8 +617,9 @@ adjust_by_size:
 	 * Use addition as we have already recorded the new latency flag
 	 * for the ITR value.
 	 */
-	itr += DIV_ROUND_UP(avg_wire_size, iavf_itr_divisor(q_vector)) *
-	       IAVF_ITR_ADAPTIVE_MIN_INC;
+	itr += DIV_ROUND_UP(avg_wire_size,
+			    iavf_itr_divisor(q_vector->adapter)) *
+		IAVF_ITR_ADAPTIVE_MIN_INC;
 
 	if ((itr & IAVF_ITR_MASK) > IAVF_ITR_ADAPTIVE_MAX_USECS) {
 		itr &= IAVF_ITR_ADAPTIVE_LATENCY;
-- 
2.27.0

