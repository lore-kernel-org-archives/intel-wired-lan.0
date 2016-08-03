From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Wed,  3 Aug 2016 11:06:15 -0700
Subject: [Intel-wired-lan] [next PATCH S41 2/5] i40evf: report link speed
In-Reply-To: <1470247578-32044-1-git-send-email-bimmy.pujari@intel.com>
References: <1470247578-32044-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1470247578-32044-3-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

The PF driver tells us the link speed, so do something with that
information. Add link speed to log messages, and report speed through
ethtool.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Change-Id: I279dc9540cc5203376406050a3e8d67e128d5882
---
Testing Hints : Test reporting of link up/down and
various speeds.

 drivers/net/ethernet/intel/i40evf/i40evf.h         |  1 +
 drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c | 26 ++++++++--
 .../net/ethernet/intel/i40evf/i40evf_virtchnl.c    | 55 ++++++++++++++++++----
 3 files changed, 70 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf.h b/drivers/net/ethernet/intel/i40evf/i40evf.h
index 2ef12a0..be1ca4c 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf.h
+++ b/drivers/net/ethernet/intel/i40evf/i40evf.h
@@ -251,6 +251,7 @@ struct i40evf_adapter {
 	struct work_struct watchdog_task;
 	bool netdev_registered;
 	bool link_up;
+	enum i40e_aq_link_speed link_speed;
 	enum i40e_virtchnl_ops current_op;
 #define CLIENT_ENABLED(_a) ((_a)->vf_res ? \
 			    (_a)->vf_res->vf_offload_flags & \
diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c b/drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c
index c6bd659..daae492 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c
@@ -74,13 +74,33 @@ static const struct i40evf_stats i40evf_gstrings_stats[] = {
 static int i40evf_get_settings(struct net_device *netdev,
 			       struct ethtool_cmd *ecmd)
 {
-	/* In the future the VF will be able to query the PF for
-	 * some information - for now use a dummy value
-	 */
+	struct i40evf_adapter *adapter = netdev_priv(netdev);
+
 	ecmd->supported = 0;
 	ecmd->autoneg = AUTONEG_DISABLE;
 	ecmd->transceiver = XCVR_DUMMY1;
 	ecmd->port = PORT_NONE;
+	/* Set speed and duplex */
+	switch (adapter->link_speed) {
+	case I40E_LINK_SPEED_40GB:
+		ethtool_cmd_speed_set(ecmd, SPEED_40000);
+		break;
+	case I40E_LINK_SPEED_20GB:
+		ethtool_cmd_speed_set(ecmd, SPEED_20000);
+		break;
+	case I40E_LINK_SPEED_10GB:
+		ethtool_cmd_speed_set(ecmd, SPEED_10000);
+		break;
+	case I40E_LINK_SPEED_1GB:
+		ethtool_cmd_speed_set(ecmd, SPEED_1000);
+		break;
+	case I40E_LINK_SPEED_100MB:
+		ethtool_cmd_speed_set(ecmd, SPEED_100);
+		break;
+	default:
+		break;
+	}
+	ecmd->duplex = DUPLEX_FULL;
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c b/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
index d76c221..cc6cb30 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
@@ -817,6 +817,45 @@ void i40evf_set_rss_lut(struct i40evf_adapter *adapter)
 }
 
 /**
+ * i40evf_print_link_message - print link up or down
+ * @adapter: adapter structure
+ *
+ * Log a message telling the world of our wonderous link status
+ */
+static void i40evf_print_link_message(struct i40evf_adapter *adapter)
+{
+	struct net_device *netdev = adapter->netdev;
+	char *speed = "Unknown ";
+
+	if (!adapter->link_up) {
+		netdev_info(netdev, "NIC Link is Down\n");
+		return;
+	}
+
+	switch (adapter->link_speed) {
+	case I40E_LINK_SPEED_40GB:
+		speed = "40 G";
+		break;
+	case I40E_LINK_SPEED_20GB:
+		speed = "20 G";
+		break;
+	case I40E_LINK_SPEED_10GB:
+		speed = "10 G";
+		break;
+	case I40E_LINK_SPEED_1GB:
+		speed = "1000 M";
+		break;
+	case I40E_LINK_SPEED_100MB:
+		speed = "100 M";
+		break;
+	default:
+		break;
+	}
+
+	netdev_info(netdev, "NIC Link is Up %sbps Full Duplex\n", speed);
+}
+
+/**
  * i40evf_request_reset
  * @adapter: adapter structure
  *
@@ -853,15 +892,13 @@ void i40evf_virtchnl_completion(struct i40evf_adapter *adapter,
 			(struct i40e_virtchnl_pf_event *)msg;
 		switch (vpe->event) {
 		case I40E_VIRTCHNL_EVENT_LINK_CHANGE:
-			adapter->link_up =
-				vpe->event_data.link_event.link_status;
-			if (adapter->link_up && !netif_carrier_ok(netdev)) {
-				dev_info(&adapter->pdev->dev, "NIC Link is Up\n");
-				netif_carrier_on(netdev);
-				netif_tx_wake_all_queues(netdev);
-			} else if (!adapter->link_up) {
-				dev_info(&adapter->pdev->dev, "NIC Link is Down\n");
-				netif_carrier_off(netdev);
+			adapter->link_speed =
+				vpe->event_data.link_event.link_speed;
+			if (adapter->link_up !=
+			    vpe->event_data.link_event.link_status) {
+				adapter->link_up =
+					vpe->event_data.link_event.link_status;
+				i40evf_print_link_message(adapter);
 				netif_tx_stop_all_queues(netdev);
 			}
 			break;
-- 
2.4.11

