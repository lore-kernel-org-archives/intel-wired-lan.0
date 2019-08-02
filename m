From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri,  2 Aug 2019 01:25:32 -0700
Subject: [Intel-wired-lan] [PATCH S26 14/15] ice: print extra message if
 topology issue
In-Reply-To: <20190802082533.23083-1-anthony.l.nguyen@intel.com>
References: <20190802082533.23083-1-anthony.l.nguyen@intel.com>
Message-ID: <20190802082533.23083-14-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

The driver needs to inform the user if there is an issue
with the topology / configuration of the link.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index fb05871dc271..b0cec1bceece 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -613,6 +613,22 @@ static void ice_reset_subtask(struct ice_pf *pf)
 	}
 }
 
+/**
+ * ice_print_topo_conflict - print topology conflict message
+ * @vsi: the VSI whose topology status is being checked
+ */
+static void ice_print_topo_conflict(struct ice_vsi *vsi)
+{
+	switch (vsi->port_info->phy.link_info.topo_media_conflict) {
+	case ICE_AQ_LINK_TOPO_CONFLICT:
+	case ICE_AQ_LINK_MEDIA_CONFLICT:
+		netdev_info(vsi->netdev, "Possible mis-configuration of the Ethernet port detected, please use the Intel(R) Ethernet Port Configuration Tool application to address the issue.\n");
+		break;
+	default:
+		break;
+	}
+}
+
 /**
  * ice_print_link_msg - print link up or down message
  * @vsi: the VSI whose link status is being queried
@@ -742,6 +758,7 @@ void ice_print_link_msg(struct ice_vsi *vsi, bool isup)
 done:
 	netdev_info(vsi->netdev, "NIC Link is up %sbps, Requested FEC: %s, FEC: %s, Autoneg: %s, Flow Control: %s\n",
 		    speed, fec_req, fec, an, fc);
+	ice_print_topo_conflict(vsi);
 }
 
 /**
-- 
2.20.1

