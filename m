From: Haiyue Wang <haiyue.wang@intel.com>
Date: Wed, 27 Jan 2021 11:09:10 +0800
Subject: [Intel-wired-lan] [Patch v3 12/20] ice: Add non-IP Layer2 protocol
 FDIR filter for AVF
In-Reply-To: <20210127030918.200919-1-haiyue.wang@intel.com>
References: <20210127030918.200919-1-haiyue.wang@intel.com>
Message-ID: <20210127030918.200919-13-haiyue.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Qi Zhang <qi.z.zhang@intel.com>

Add new filter type that allow forward non-IP Ethernet packets base on its
ethertype. The filter is only enabled when COMMS DDP package is loaded.

Signed-off-by: Yahui Cao <yahui.cao@intel.com>
Signed-off-by: Qi Zhang <qi.z.zhang@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_fdir.c     | 15 ++++++++
 drivers/net/ethernet/intel/ice/ice_fdir.h     |  2 +
 drivers/net/ethernet/intel/ice/ice_flow.c     | 17 ++++++++-
 drivers/net/ethernet/intel/ice/ice_flow.h     |  1 +
 drivers/net/ethernet/intel/ice/ice_type.h     |  1 +
 .../ethernet/intel/ice/ice_virtchnl_fdir.c    | 38 ++++++++++++++++++-
 6 files changed, 72 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_fdir.c b/drivers/net/ethernet/intel/ice/ice_fdir.c
index 5f8d7a9ca068..b9c65d0c9271 100644
--- a/drivers/net/ethernet/intel/ice/ice_fdir.c
+++ b/drivers/net/ethernet/intel/ice/ice_fdir.c
@@ -40,6 +40,12 @@ static const u8 ice_fdir_ipv4_pkt[] = {
 	0x00, 0x00
 };
 
+static const u8 ice_fdir_non_ip_l2_pkt[] = {
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+};
+
 static const u8 ice_fdir_tcpv6_pkt[] = {
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 	0x00, 0x00, 0x00, 0x00, 0x86, 0xDD, 0x60, 0x00,
@@ -238,6 +244,11 @@ static const struct ice_fdir_base_pkt ice_fdir_pkt[] = {
 		sizeof(ice_fdir_ipv4_pkt), ice_fdir_ipv4_pkt,
 		sizeof(ice_fdir_ip4_tun_pkt), ice_fdir_ip4_tun_pkt,
 	},
+	{
+		ICE_FLTR_PTYPE_NON_IP_L2,
+		sizeof(ice_fdir_non_ip_l2_pkt), ice_fdir_non_ip_l2_pkt,
+		sizeof(ice_fdir_non_ip_l2_pkt), ice_fdir_non_ip_l2_pkt,
+	},
 	{
 		ICE_FLTR_PTYPE_NONF_IPV6_TCP,
 		sizeof(ice_fdir_tcpv6_pkt), ice_fdir_tcpv6_pkt,
@@ -674,6 +685,10 @@ ice_fdir_get_gen_prgm_pkt(struct ice_hw *hw, struct ice_fdir_fltr *input,
 				  input->ip.v4.proto);
 		ice_pkt_insert_mac_addr(loc, input->ext_data.dst_mac);
 		break;
+	case ICE_FLTR_PTYPE_NON_IP_L2:
+		ice_pkt_insert_u16(loc, ICE_MAC_ETHTYPE_OFFSET,
+				   input->ext_data.ether_type);
+		break;
 	case ICE_FLTR_PTYPE_NONF_IPV6_TCP:
 		ice_pkt_insert_ipv6_addr(loc, ICE_IPV6_DST_ADDR_OFFSET,
 					 input->ip.v6.src_ip);
diff --git a/drivers/net/ethernet/intel/ice/ice_fdir.h b/drivers/net/ethernet/intel/ice/ice_fdir.h
index adf237925b3c..58c927cbc953 100644
--- a/drivers/net/ethernet/intel/ice/ice_fdir.h
+++ b/drivers/net/ethernet/intel/ice/ice_fdir.h
@@ -30,6 +30,7 @@
 #define ICE_IPV6_TC_OFFSET		14
 #define ICE_IPV6_HLIM_OFFSET		21
 #define ICE_IPV6_PROTO_OFFSET		20
+#define ICE_MAC_ETHTYPE_OFFSET		12
 
 #define ICE_FDIR_MAX_FLTRS		16384
 
@@ -116,6 +117,7 @@ struct ice_fdir_v6 {
 struct ice_fdir_extra {
 	u8 dst_mac[ETH_ALEN];	/* dest MAC address */
 	u8 src_mac[ETH_ALEN];	/* src MAC address */
+	__be16 ether_type;      /* for NON_IP_L2 */
 	u32 usr_def[2];		/* user data */
 	__be16 vlan_type;	/* VLAN ethertype */
 	__be16 vlan_tag;	/* VLAN tag info */
diff --git a/drivers/net/ethernet/intel/ice/ice_flow.c b/drivers/net/ethernet/intel/ice/ice_flow.c
index 6bf467e09307..b06758c5ad93 100644
--- a/drivers/net/ethernet/intel/ice/ice_flow.c
+++ b/drivers/net/ethernet/intel/ice/ice_flow.c
@@ -571,6 +571,17 @@ static const u32 ice_ptypes_nat_t_esp[] = {
 	0x00000000, 0x00000000, 0x00000000, 0x00000000,
 };
 
+static const u32 ice_ptypes_mac_non_ip_ofos[] = {
+	0x00000846, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00400000, 0x03FFF000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+};
+
 /* Manage parameters and info. used during the creation of a flow profile */
 struct ice_flow_prof_params {
 	enum ice_block blk;
@@ -760,7 +771,11 @@ ice_flow_proc_seg_hdrs(struct ice_flow_prof_params *params)
 				   ICE_FLOW_PTYPE_MAX);
 		}
 
-		if (hdrs & ICE_FLOW_SEG_HDR_PPPOE) {
+		if (hdrs & ICE_FLOW_SEG_HDR_ETH_NON_IP) {
+			src = (const unsigned long *)ice_ptypes_mac_non_ip_ofos;
+			bitmap_and(params->ptypes, params->ptypes, src,
+				   ICE_FLOW_PTYPE_MAX);
+		} else if (hdrs & ICE_FLOW_SEG_HDR_PPPOE) {
 			src = (const unsigned long *)ice_ptypes_pppoe;
 			bitmap_and(params->ptypes, params->ptypes, src,
 				   ICE_FLOW_PTYPE_MAX);
diff --git a/drivers/net/ethernet/intel/ice/ice_flow.h b/drivers/net/ethernet/intel/ice/ice_flow.h
index d5e7f2dadd56..f1bed16abc64 100644
--- a/drivers/net/ethernet/intel/ice/ice_flow.h
+++ b/drivers/net/ethernet/intel/ice/ice_flow.h
@@ -138,6 +138,7 @@ enum ice_flow_seg_hdr {
 	ICE_FLOW_SEG_HDR_ESP		= 0x00100000,
 	ICE_FLOW_SEG_HDR_AH		= 0x00200000,
 	ICE_FLOW_SEG_HDR_NAT_T_ESP	= 0x00400000,
+	ICE_FLOW_SEG_HDR_ETH_NON_IP	= 0x00800000,
 	/* The following is an additive bit for ICE_FLOW_SEG_HDR_IPV4 and
 	 * ICE_FLOW_SEG_HDR_IPV6 which include the IPV4 other PTYPEs
 	 */
diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
index 7a57d5f88c96..dc8b6cb8e9f2 100644
--- a/drivers/net/ethernet/intel/ice/ice_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_type.h
@@ -192,6 +192,7 @@ enum ice_fltr_ptype {
 	ICE_FLTR_PTYPE_NONF_IPV4_TCP,
 	ICE_FLTR_PTYPE_NONF_IPV4_SCTP,
 	ICE_FLTR_PTYPE_NONF_IPV4_OTHER,
+	ICE_FLTR_PTYPE_NON_IP_L2,
 	ICE_FLTR_PTYPE_FRAG_IPV4,
 	ICE_FLTR_PTYPE_NONF_IPV6_UDP,
 	ICE_FLTR_PTYPE_NONF_IPV6_TCP,
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
index 6b6ac57426c5..43caaae865b1 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
@@ -26,6 +26,11 @@ struct virtchnl_fdir_fltr_conf {
 	struct ice_fdir_fltr input;
 };
 
+static enum virtchnl_proto_hdr_type vc_pattern_ether[] = {
+	VIRTCHNL_PROTO_HDR_ETH,
+	VIRTCHNL_PROTO_HDR_NONE,
+};
+
 static enum virtchnl_proto_hdr_type vc_pattern_ipv4[] = {
 	VIRTCHNL_PROTO_HDR_ETH,
 	VIRTCHNL_PROTO_HDR_IPV4,
@@ -86,7 +91,7 @@ struct virtchnl_fdir_pattern_match_item {
 	u64 *meta;
 };
 
-static const struct virtchnl_fdir_pattern_match_item vc_fdir_pattern[] = {
+static const struct virtchnl_fdir_pattern_match_item vc_fdir_pattern_os[] = {
 	{vc_pattern_ipv4,                     0,         NULL},
 	{vc_pattern_ipv4_tcp,                 0,         NULL},
 	{vc_pattern_ipv4_udp,                 0,         NULL},
@@ -97,6 +102,18 @@ static const struct virtchnl_fdir_pattern_match_item vc_fdir_pattern[] = {
 	{vc_pattern_ipv6_sctp,                0,         NULL},
 };
 
+static const struct virtchnl_fdir_pattern_match_item vc_fdir_pattern_comms[] = {
+	{vc_pattern_ipv4,                     0,         NULL},
+	{vc_pattern_ipv4_tcp,                 0,         NULL},
+	{vc_pattern_ipv4_udp,                 0,         NULL},
+	{vc_pattern_ipv4_sctp,                0,         NULL},
+	{vc_pattern_ipv6,                     0,         NULL},
+	{vc_pattern_ipv6_tcp,                 0,         NULL},
+	{vc_pattern_ipv6_udp,                 0,         NULL},
+	{vc_pattern_ipv6_sctp,                0,         NULL},
+	{vc_pattern_ether,                    0,         NULL},
+};
+
 struct virtchnl_fdir_inset_map {
 	enum virtchnl_proto_hdr_field field;
 	enum ice_flow_field fld;
@@ -371,6 +388,9 @@ ice_vc_fdir_set_flow_hdr(struct ice_vf *vf,
 	struct device *dev = ice_pf_to_dev(vf->pf);
 
 	switch (flow) {
+	case ICE_FLTR_PTYPE_NON_IP_L2:
+		ICE_FLOW_SET_HDRS(seg, ICE_FLOW_SEG_HDR_ETH_NON_IP);
+		break;
 	case ICE_FLTR_PTYPE_NONF_IPV4_OTHER:
 		ICE_FLOW_SET_HDRS(seg, ICE_FLOW_SEG_HDR_IPV4 |
 				  ICE_FLOW_SEG_HDR_IPV_OTHER);
@@ -708,9 +728,19 @@ ice_vc_fdir_get_pattern(struct ice_vf *vf, int *len)
 {
 	const struct virtchnl_fdir_pattern_match_item *item;
 	struct ice_pf *pf = vf->pf;
+	struct ice_hw *hw;
 
 	item = vc_fdir_pattern;
 	*len = ARRAY_SIZE(vc_fdir_pattern);
+	hw = &pf->hw;
+	if (!strncmp(hw->active_pkg_name, "ICE COMMS Package",
+		     sizeof(hw->active_pkg_name))) {
+		item = vc_fdir_pattern_comms;
+		*len = ARRAY_SIZE(vc_fdir_pattern_comms);
+	} else {
+		item = vc_fdir_pattern_os;
+		*len = ARRAY_SIZE(vc_fdir_pattern_os);
+	}
 
 	return item;
 }
@@ -771,10 +801,16 @@ ice_vc_fdir_parse_pattern(struct ice_vf *vf, struct virtchnl_fdir_add *fltr,
 		struct ipv6hdr *ip6h;
 		struct udphdr *udph;
 		struct tcphdr *tcph;
+		struct ethhdr *eth;
 		struct iphdr *iph;
 
 		switch (hdr->type) {
 		case VIRTCHNL_PROTO_HDR_ETH:
+			eth = (struct ethhdr *)hdr->buffer;
+			input->flow_type = ICE_FLTR_PTYPE_NON_IP_L2;
+
+			if (hdr->field_selector)
+				input->ext_data.ether_type = eth->h_proto;
 			break;
 		case VIRTCHNL_PROTO_HDR_IPV4:
 			iph = (struct iphdr *)hdr->buffer;
-- 
2.30.0

