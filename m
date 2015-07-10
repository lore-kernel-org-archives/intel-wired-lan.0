From: Mark D Rustad <mark.d.rustad@intel.com>
Date: Fri, 10 Jul 2015 14:19:22 -0700
Subject: [Intel-wired-lan] [PATCH] ixgbe: Add support for reporting 2.5G
	link speed
Message-ID: <20150710211921.35052.49163.stgit@mdrustad-wks.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Now that we can do 2.5G link speed, we need to be able to report it.
Also change the nested triadic involved in creating the log message
to instead use a simpler switch statement to set a string pointer.

Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c |    7 ++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c    |   27 +++++++++++++++-------
 2 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index f7aeb560a504..cfdd79f24ec1 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -166,6 +166,8 @@ static int ixgbe_get_settings(struct net_device *netdev,
 	/* set the supported link speeds */
 	if (supported_link & IXGBE_LINK_SPEED_10GB_FULL)
 		ecmd->supported |= SUPPORTED_10000baseT_Full;
+	if (supported_link & IXGBE_LINK_SPEED_2_5GB_FULL)
+		ecmd->supported |= SUPPORTED_2500baseX_Full;
 	if (supported_link & IXGBE_LINK_SPEED_1GB_FULL)
 		ecmd->supported |= SUPPORTED_1000baseT_Full;
 	if (supported_link & IXGBE_LINK_SPEED_100_FULL)
@@ -177,6 +179,8 @@ static int ixgbe_get_settings(struct net_device *netdev,
 			ecmd->advertising |= ADVERTISED_100baseT_Full;
 		if (hw->phy.autoneg_advertised & IXGBE_LINK_SPEED_10GB_FULL)
 			ecmd->advertising |= ADVERTISED_10000baseT_Full;
+		if (hw->phy.autoneg_advertised & IXGBE_LINK_SPEED_2_5GB_FULL)
+			ecmd->advertising |= ADVERTISED_2500baseX_Full;
 		if (hw->phy.autoneg_advertised & IXGBE_LINK_SPEED_1GB_FULL)
 			ecmd->advertising |= ADVERTISED_1000baseT_Full;
 	} else {
@@ -286,6 +290,9 @@ static int ixgbe_get_settings(struct net_device *netdev,
 		case IXGBE_LINK_SPEED_10GB_FULL:
 			ethtool_cmd_speed_set(ecmd, SPEED_10000);
 			break;
+		case IXGBE_LINK_SPEED_2_5GB_FULL:
+			ethtool_cmd_speed_set(ecmd, SPEED_2500);
+			break;
 		case IXGBE_LINK_SPEED_1GB_FULL:
 			ethtool_cmd_speed_set(ecmd, SPEED_1000);
 			break;
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 193d5daa723d..4cf7c17cf899 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -6395,6 +6395,7 @@ static void ixgbe_watchdog_link_is_up(struct ixgbe_adapter *adapter)
 	struct net_device *upper;
 	struct list_head *iter;
 	u32 link_speed = adapter->link_speed;
+	const char *speed_str;
 	bool flow_rx, flow_tx;
 
 	/* only continue if link was previously down */
@@ -6432,14 +6433,24 @@ static void ixgbe_watchdog_link_is_up(struct ixgbe_adapter *adapter)
 	if (test_bit(__IXGBE_PTP_RUNNING, &adapter->state))
 		ixgbe_ptp_start_cyclecounter(adapter);
 
-	e_info(drv, "NIC Link is Up %s, Flow Control: %s\n",
-	       (link_speed == IXGBE_LINK_SPEED_10GB_FULL ?
-	       "10 Gbps" :
-	       (link_speed == IXGBE_LINK_SPEED_1GB_FULL ?
-	       "1 Gbps" :
-	       (link_speed == IXGBE_LINK_SPEED_100_FULL ?
-	       "100 Mbps" :
-	       "unknown speed"))),
+	switch (link_speed) {
+	case IXGBE_LINK_SPEED_10GB_FULL:
+		speed_str = "10 Gbps";
+		break;
+	case IXGBE_LINK_SPEED_2_5GB_FULL:
+		speed_str = "2.5 Gbps";
+		break;
+	case IXGBE_LINK_SPEED_1GB_FULL:
+		speed_str = "1 Gbps";
+		break;
+	case IXGBE_LINK_SPEED_100_FULL:
+		speed_str = "100 Mbps";
+		break;
+	default:
+		speed_str = "unknown speed";
+		break;
+	}
+	e_info(drv, "NIC Link is Up %s, Flow Control: %s\n", speed_str,
 	       ((flow_rx && flow_tx) ? "RX/TX" :
 	       (flow_rx ? "RX" :
 	       (flow_tx ? "TX" : "None"))));

