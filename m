From: Maciej Machnikowski <maciej.machnikowski@intel.com>
Date: Mon, 30 Aug 2021 14:26:14 +0200
Subject: [Intel-wired-lan] [PATCH v3 intel-next] ice: Refactor
 ice_aqc_link_topo_addr
Message-ID: <20210830122614.4031053-1-maciej.machnikowski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Separate link topo parameters in struct ice_aqc_link_topo_addr into
new struct ice_aqc_link_topo_params.
This keeps input parameters for the get_link_topo command in a separate
structure and is required by future commands that operate only on link
topo params without the node handle.

Signed-off-by: Maciej Machnikowski <maciej.machnikowski@intel.com>
---
v2: Fix code style errors, Change pca9575_handle type returned by
    ice_get_pca9575_handle to u16
v3: Clarified commit message
---
 drivers/net/ethernet/intel/ice/ice_adminq_cmd.h | 6 +++++-
 drivers/net/ethernet/intel/ice/ice_common.c     | 8 +++++---
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
index 6c727745bb29..941342f4be85 100644
--- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
@@ -1283,7 +1283,7 @@ struct ice_aqc_set_mac_lb {
 	u8 reserved[15];
 };
 
-struct ice_aqc_link_topo_addr {
+struct ice_aqc_link_topo_params {
 	u8 lport_num;
 	u8 lport_num_valid;
 #define ICE_AQC_LINK_TOPO_PORT_NUM_VALID	BIT(0)
@@ -1309,6 +1309,10 @@ struct ice_aqc_link_topo_addr {
 #define ICE_AQC_LINK_TOPO_NODE_CTX_PROVIDED	4
 #define ICE_AQC_LINK_TOPO_NODE_CTX_OVERRIDE	5
 	u8 index;
+};
+
+struct ice_aqc_link_topo_addr {
+	struct ice_aqc_link_topo_params topo_params;
 	__le16 handle;
 #define ICE_AQC_LINK_TOPO_HANDLE_S	0
 #define ICE_AQC_LINK_TOPO_HANDLE_M	(0x3FF << ICE_AQC_LINK_TOPO_HANDLE_S)
diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 1a3c6b60fdca..5822589aebdc 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -240,11 +240,13 @@ ice_aq_get_link_topo_handle(struct ice_port_info *pi, u8 node_type,
 
 	ice_fill_dflt_direct_cmd_desc(&desc, ice_aqc_opc_get_link_topo);
 
-	cmd->addr.node_type_ctx = (ICE_AQC_LINK_TOPO_NODE_CTX_PORT <<
-				   ICE_AQC_LINK_TOPO_NODE_CTX_S);
+	cmd->addr.topo_params.node_type_ctx =
+		(ICE_AQC_LINK_TOPO_NODE_CTX_PORT <<
+		 ICE_AQC_LINK_TOPO_NODE_CTX_S);
 
 	/* set node type */
-	cmd->addr.node_type_ctx |= (ICE_AQC_LINK_TOPO_NODE_TYPE_M & node_type);
+	cmd->addr.topo_params.node_type_ctx |=
+		(ICE_AQC_LINK_TOPO_NODE_TYPE_M & node_type);
 
 	return ice_aq_send_cmd(pi->hw, &desc, NULL, 0, cd);
 }
-- 
2.26.3

