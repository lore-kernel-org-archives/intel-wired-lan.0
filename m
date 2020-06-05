From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri,  5 Jun 2020 10:09:45 -0700
Subject: [Intel-wired-lan] [PATCH 3/4] iavf: Fix reporting 2.5 Gb and 5Gb
 speeds
In-Reply-To: <20200605170946.23494-1-anthony.l.nguyen@intel.com>
References: <20200605170946.23494-1-anthony.l.nguyen@intel.com>
Message-ID: <20200605170946.23494-3-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Brett Creeley <brett.creeley@intel.com>

Commit 4ae4916b5643 ("i40e: fix 'Unknown bps' in dmesg for 2.5Gb/5Gb
speeds") added the ability for the PF to report 2.5 and 5Gb speeds,
however, the iavf driver does not recognize those speeds as the values were
not added there. Add the proper enums and values so that iavf can properly
deal with those speeds.

Fixes: 4ae4916b5643 ("i40e: fix 'Unknown bps' in dmesg for 2.5Gb/5Gb speeds")
Signed-off-by: Brett Creeley <brett.creeley@intel.com>
Signed-off-by: Witold Fijalkowski <witoldx.fijalkowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_ethtool.c |  6 ++++++
 drivers/net/ethernet/intel/iavf/iavf_main.c    | 18 ++++++++++++------
 .../net/ethernet/intel/iavf/iavf_virtchnl.c    |  6 ++++++
 3 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
index 86b6288b961e..c93567f4d0f7 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
@@ -303,6 +303,12 @@ static int iavf_get_link_ksettings(struct net_device *netdev,
 	case VIRTCHNL_LINK_SPEED_10GB:
 		cmd->base.speed = SPEED_10000;
 		break;
+	case VIRTCHNL_LINK_SPEED_5GB:
+		cmd->base.speed = SPEED_5000;
+		break;
+	case VIRTCHNL_LINK_SPEED_2_5GB:
+		cmd->base.speed = SPEED_2500;
+		break;
 	case VIRTCHNL_LINK_SPEED_1GB:
 		cmd->base.speed = SPEED_1000;
 		break;
diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 8307274fabc5..3f3c6260c5df 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -2488,22 +2488,28 @@ static int iavf_validate_tx_bandwidth(struct iavf_adapter *adapter,
 
 	switch (adapter->link_speed) {
 	case VIRTCHNL_LINK_SPEED_40GB:
-		speed = 40000;
+		speed = SPEED_40000;
 		break;
 	case VIRTCHNL_LINK_SPEED_25GB:
-		speed = 25000;
+		speed = SPEED_25000;
 		break;
 	case VIRTCHNL_LINK_SPEED_20GB:
-		speed = 20000;
+		speed = SPEED_20000;
 		break;
 	case VIRTCHNL_LINK_SPEED_10GB:
-		speed = 10000;
+		speed = SPEED_10000;
+		break;
+	case VIRTCHNL_LINK_SPEED_5GB:
+		speed = SPEED_5000;
+		break;
+	case VIRTCHNL_LINK_SPEED_2_5GB:
+		speed = SPEED_2500;
 		break;
 	case VIRTCHNL_LINK_SPEED_1GB:
-		speed = 1000;
+		speed = SPEED_1000;
 		break;
 	case VIRTCHNL_LINK_SPEED_100MB:
-		speed = 100;
+		speed = SPEED_100;
 		break;
 	default:
 		break;
diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index c4735589a296..ed08ace4f05a 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
@@ -933,6 +933,12 @@ static void iavf_print_link_message(struct iavf_adapter *adapter)
 	case VIRTCHNL_LINK_SPEED_10GB:
 		link_speed_mbps = SPEED_10000;
 		break;
+	case VIRTCHNL_LINK_SPEED_5GB:
+		link_speed_mbps = SPEED_5000;
+		break;
+	case VIRTCHNL_LINK_SPEED_2_5GB:
+		link_speed_mbps = SPEED_2500;
+		break;
 	case VIRTCHNL_LINK_SPEED_1GB:
 		link_speed_mbps = SPEED_1000;
 		break;
-- 
2.20.1

