From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Wed,  9 Oct 2019 07:09:49 -0700
Subject: [Intel-wired-lan] [PATCH S31 11/15] ice: print unsupported module
 message
In-Reply-To: <20191009140953.14087-1-anthony.l.nguyen@intel.com>
References: <20191009140953.14087-1-anthony.l.nguyen@intel.com>
Message-ID: <20191009140953.14087-11-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Paul Greenwalt <paul.greenwalt@intel.com>

Print message to inform user if unsupported module is inserted, and
extend the topology / configuration detection.

Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_adminq_cmd.h | 4 ++++
 drivers/net/ethernet/intel/ice/ice_main.c       | 6 ++++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
index cfdd72fbd0da..e2779be0cb29 100644
--- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
@@ -1045,6 +1045,10 @@ struct ice_aqc_get_link_status_data {
 #define ICE_AQ_LINK_TOPO_CONFLICT	BIT(0)
 #define ICE_AQ_LINK_MEDIA_CONFLICT	BIT(1)
 #define ICE_AQ_LINK_TOPO_CORRUPT	BIT(2)
+#define ICE_AQ_LINK_TOPO_UNREACH_PRT	BIT(4)
+#define ICE_AQ_LINK_TOPO_UNDRUTIL_PRT	BIT(5)
+#define ICE_AQ_LINK_TOPO_UNDRUTIL_MEDIA	BIT(6)
+#define ICE_AQ_LINK_TOPO_UNSUPP_MEDIA	BIT(7)
 	u8 reserved1;
 	u8 link_info;
 #define ICE_AQ_LINK_UP			BIT(0)	/* Link Status */
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 2493be3289ed..58b90fc95eb3 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -779,8 +779,14 @@ static void ice_print_topo_conflict(struct ice_vsi *vsi)
 	switch (vsi->port_info->phy.link_info.topo_media_conflict) {
 	case ICE_AQ_LINK_TOPO_CONFLICT:
 	case ICE_AQ_LINK_MEDIA_CONFLICT:
+	case ICE_AQ_LINK_TOPO_UNREACH_PRT:
+	case ICE_AQ_LINK_TOPO_UNDRUTIL_PRT:
+	case ICE_AQ_LINK_TOPO_UNDRUTIL_MEDIA:
 		netdev_info(vsi->netdev, "Possible mis-configuration of the Ethernet port detected, please use the Intel(R) Ethernet Port Configuration Tool application to address the issue.\n");
 		break;
+	case ICE_AQ_LINK_TOPO_UNSUPP_MEDIA:
+		netdev_info(vsi->netdev, "Rx/Tx is disabled on this device because an unsupported module type was detected. Refer to the Intel(R) Ethernet Adapters and Devices User Guide for a list of supported modules.\n");
+		break;
 	default:
 		break;
 	}
-- 
2.20.1

