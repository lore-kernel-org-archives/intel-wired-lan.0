From: Avinash Dayanand <avinash.dayanand@intel.com>
Date: Wed, 17 Jan 2018 08:16:02 -0800
Subject: [Intel-wired-lan] [PATCH v2 next-queue 07/12] i40evf: Add support
 to configure bw via tc tool
In-Reply-To: <20180117161607.49344-1-avinash.dayanand@intel.com>
References: <20180117161607.49344-1-avinash.dayanand@intel.com>
Message-ID: <20180117161607.49344-8-avinash.dayanand@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>

This patch adds support to configure bandwidth for the traffic
classes via tc tool. The required information is passed to the PF
which is used in the process of setting up the traffic classes.

Signed-off-by: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
---
 drivers/net/ethernet/intel/i40evf/i40evf.h         |  1 +
 drivers/net/ethernet/intel/i40evf/i40evf_main.c    | 66 +++++++++++++++++++++-
 .../net/ethernet/intel/i40evf/i40evf_virtchnl.c    |  3 +
 3 files changed, 67 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf.h b/drivers/net/ethernet/intel/i40evf/i40evf.h
index c8d68c8..150d676 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf.h
+++ b/drivers/net/ethernet/intel/i40evf/i40evf.h
@@ -107,6 +107,7 @@ struct i40e_vsi {
 
 #define I40EVF_HKEY_ARRAY_SIZE ((I40E_VFQF_HKEY_MAX_INDEX + 1) * 4)
 #define I40EVF_HLUT_ARRAY_SIZE ((I40E_VFQF_HLUT_MAX_INDEX + 1) * 4)
+#define I40EVF_MBPS_DIVISOR	125000 /* divisor to convert to Mbps */
 
 /* MAX_MSIX_Q_VECTORS of these are allocated,
  * but we only use one per queue-specific vector.
diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index 9d36553..91fff5f 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -2218,6 +2218,48 @@ void i40evf_free_all_rx_resources(struct i40evf_adapter *adapter)
 }
 
 /**
+ * i40evf_validate_tx_bandwidth - validate the max tx bandwidth
+ * @adapter: board private structure
+ * @max_tx_rate: max tx bw for a tc
+ **/
+static int i40evf_validate_tx_bandwidth(struct i40evf_adapter *adapter,
+					u64 max_tx_rate)
+{
+	int speed = 0, ret = 0;
+
+	switch (adapter->link_speed) {
+	case I40E_LINK_SPEED_40GB:
+		speed = 40000;
+		break;
+	case I40E_LINK_SPEED_25GB:
+		speed = 25000;
+		break;
+	case I40E_LINK_SPEED_20GB:
+		speed = 20000;
+		break;
+	case I40E_LINK_SPEED_10GB:
+		speed = 10000;
+		break;
+	case I40E_LINK_SPEED_1GB:
+		speed = 1000;
+		break;
+	case I40E_LINK_SPEED_100MB:
+		speed = 100;
+		break;
+	default:
+		break;
+	}
+
+	if (max_tx_rate > speed) {
+		dev_err(&adapter->pdev->dev,
+			"Invalid tx rate specified\n");
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+/**
  * i40evf_validate_channel_config - validate queue mapping info
  * @adapter: board private structure
  * @mqprio_qopt: queue parameters
@@ -2229,7 +2271,10 @@ void i40evf_free_all_rx_resources(struct i40evf_adapter *adapter)
 static int i40evf_validate_ch_config(struct i40evf_adapter *adapter,
 				     struct tc_mqprio_qopt_offload *mqprio_qopt)
 {
+	u64 total_max_rate = 0;
 	int i, num_qps = 0;
+	u64 tx_rate = 0;
+	int ret = 0;
 
 	if (mqprio_qopt->qopt.num_tc > I40EVF_MAX_TRAFFIC_CLASS ||
 	    mqprio_qopt->qopt.num_tc < 1)
@@ -2237,16 +2282,24 @@ static int i40evf_validate_ch_config(struct i40evf_adapter *adapter,
 
 	for (i = 0; i <= mqprio_qopt->qopt.num_tc - 1; i++) {
 		if (!mqprio_qopt->qopt.count[i] ||
-		    mqprio_qopt->min_rate[i] ||
-		    mqprio_qopt->max_rate[i] ||
 		    mqprio_qopt->qopt.offset[i] != num_qps)
 			return -EINVAL;
+		if (mqprio_qopt->min_rate[i]) {
+			dev_err(&adapter->pdev->dev,
+				"Invalid min tx rate (greater than 0) specified\n");
+			return -EINVAL;
+		}
+		/*convert to Mbps */
+		tx_rate = div_u64(mqprio_qopt->max_rate[i],
+				  I40EVF_MBPS_DIVISOR);
+		total_max_rate += tx_rate;
 		num_qps += mqprio_qopt->qopt.count[i];
 	}
 	if (num_qps > MAX_QUEUES)
 		return -EINVAL;
 
-	return 0;
+	ret = i40evf_validate_tx_bandwidth(adapter, total_max_rate);
+	return ret;
 }
 
 /**
@@ -2267,6 +2320,7 @@ static int __i40evf_setup_tc(struct net_device *netdev, void *type_data)
 	struct virtchnl_vf_resource *vfres = adapter->vf_res;
 	u8 num_tc = 0, total_qps = 0;
 	int ret = 0, netdev_tc = 0;
+	u64 max_tx_rate;
 	u16 mode;
 	int i;
 
@@ -2314,6 +2368,12 @@ static int __i40evf_setup_tc(struct net_device *netdev, void *type_data)
 				adapter->ch_config.ch_info[i].offset =
 					mqprio_qopt->qopt.offset[i];
 				total_qps += mqprio_qopt->qopt.count[i];
+				max_tx_rate = mqprio_qopt->max_rate[i];
+				/* convert to Mbps */
+				max_tx_rate = div_u64(max_tx_rate,
+						      I40EVF_MBPS_DIVISOR);
+				adapter->ch_config.ch_info[i].max_tx_rate =
+					max_tx_rate;
 			} else {
 				adapter->ch_config.ch_info[i].count = 1;
 				adapter->ch_config.ch_info[i].offset = 0;
diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c b/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
index c4b3105..b5a509f 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
@@ -1003,6 +1003,9 @@ void i40evf_enable_channels(struct i40evf_adapter *adapter)
 	for (i = 0; i < vti->num_tc; i++) {
 		vti->list[i].count = adapter->ch_config.ch_info[i].count;
 		vti->list[i].offset = adapter->ch_config.ch_info[i].offset;
+		vti->list[i].pad = 0;
+		vti->list[i].max_tx_rate =
+				adapter->ch_config.ch_info[i].max_tx_rate;
 	}
 
 	adapter->ch_config.state = __I40EVF_TC_RUNNING;
-- 
2.9.4

