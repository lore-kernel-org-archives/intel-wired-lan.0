From: Qi Zhang <qi.z.zhang@intel.com>
Date: Wed,  8 Jul 2020 10:50:03 +0800
Subject: [Intel-wired-lan] [PATCH S48 v4 13/16] ice: Add non-IP Layer2
 protocol FDIR filter for AVF
In-Reply-To: <20200708025006.44071-1-qi.z.zhang@intel.com>
References: <20200708025006.44071-1-qi.z.zhang@intel.com>
Message-ID: <20200708025006.44071-14-qi.z.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Add new filter type that allow forward non-IP Ethernet packets base on its
ethertype. The filter is only enabled when COMMS DDP package is loaded.

Signed-off-by: Yahui Cao <yahui.cao@intel.com>
Signed-off-by: Qi Zhang <qi.z.zhang@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_fdir.c          | 11 +++++++
 drivers/net/ethernet/intel/ice/ice_fdir.h          |  1 +
 drivers/net/ethernet/intel/ice/ice_flow.c          | 17 +++++++++-
 drivers/net/ethernet/intel/ice/ice_flow.h          |  1 +
 drivers/net/ethernet/intel/ice/ice_type.h          |  1 +
 drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c | 38 ++++++++++++++++++++--
 6 files changed, 65 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_fdir.c b/drivers/net/ethernet/intel/ice/ice_fdir.c
index d97d9197135d..6055a13488b6 100644
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
@@ -239,6 +245,11 @@ static const struct ice_fdir_base_pkt ice_fdir_pkt[] = {
 		sizeof(ice_fdir_ip4_tun_pkt), ice_fdir_ip4_tun_pkt,
 	},
 	{
+		ICE_FLTR_PTYPE_NON_IP_L2,
+		sizeof(ice_fdir_non_ip_l2_pkt), ice_fdir_non_ip_l2_pkt,
+		sizeof(ice_fdir_non_ip_l2_pkt), ice_fdir_non_ip_l2_pkt,
+	},
+	{
 		ICE_FLTR_PTYPE_NONF_IPV6_TCP,
 		sizeof(ice_fdir_tcpv6_pkt), ice_fdir_tcpv6_pkt,
 		sizeof(ice_fdir_tcp6_tun_pkt), ice_fdir_tcp6_tun_pkt,
diff --git a/drivers/net/ethernet/intel/ice/ice_fdir.h b/drivers/net/ethernet/intel/ice/ice_fdir.h
index 6b7d8ccd39b7..a46449f23720 100644
--- a/drivers/net/ethernet/intel/ice/ice_fdir.h
+++ b/drivers/net/ethernet/intel/ice/ice_fdir.h
@@ -108,6 +108,7 @@ struct ice_fdir_v6 {
 
 struct ice_fdir_extra {
 	u8 dst_mac[ETH_ALEN];	/* dest MAC address */
+	__be16 ether_type;      /* for NON_IP_L2 */
 	u32 usr_def[2];		/* user data */
 	__be16 vlan_type;	/* VLAN ethertype */
 	__be16 vlan_tag;	/* VLAN tag info */
diff --git a/drivers/net/ethernet/intel/ice/ice_flow.c b/drivers/net/ethernet/intel/ice/ice_flow.c
index e7925274007c..087da031ec3f 100644
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
index 46b9fbb3dbe7..26c42fada9f9 100644
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
index c2eff68d5469..f58824834342 100644
--- a/drivers/net/ethernet/intel/ice/ice_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_type.h
@@ -170,6 +170,7 @@ enum ice_fltr_ptype {
 	ICE_FLTR_PTYPE_NONF_IPV4_TCP,
 	ICE_FLTR_PTYPE_NONF_IPV4_SCTP,
 	ICE_FLTR_PTYPE_NONF_IPV4_OTHER,
+	ICE_FLTR_PTYPE_NON_IP_L2,
 	ICE_FLTR_PTYPE_FRAG_IPV4,
 	ICE_FLTR_PTYPE_NONF_IPV6_UDP,
 	ICE_FLTR_PTYPE_NONF_IPV6_TCP,
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
index aa5e6f24be95..33d8e3914511 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
@@ -27,6 +27,11 @@ struct virtchnl_fdir_fltr_conf {
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
@@ -87,7 +92,7 @@ struct virtchnl_fdir_pattern_match_item {
 	u64 *meta;
 };
 
-static const struct virtchnl_fdir_pattern_match_item vc_fdir_pattern[] = {
+static const struct virtchnl_fdir_pattern_match_item vc_fdir_pattern_os[] = {
 	{vc_pattern_ipv4,                     0,         NULL},
 	{vc_pattern_ipv4_tcp,                 0,         NULL},
 	{vc_pattern_ipv4_udp,                 0,         NULL},
@@ -98,6 +103,18 @@ static const struct virtchnl_fdir_pattern_match_item vc_fdir_pattern[] = {
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
@@ -372,6 +389,9 @@ ice_vc_fdir_set_flow_hdr(struct ice_vf *vf,
 	struct device *dev = ice_pf_to_dev(vf->pf);
 
 	switch (flow) {
+	case ICE_FLTR_PTYPE_NON_IP_L2:
+		ICE_FLOW_SET_HDRS(seg, ICE_FLOW_SEG_HDR_ETH_NON_IP);
+		break;
 	case ICE_FLTR_PTYPE_NONF_IPV4_OTHER:
 		ICE_FLOW_SET_HDRS(seg, ICE_FLOW_SEG_HDR_IPV4 |
 				  ICE_FLOW_SEG_HDR_IPV_OTHER);
@@ -712,8 +732,14 @@ ice_vc_fdir_get_pattern(struct ice_vf *vf, int *len)
 	struct ice_hw *hw;
 
 	hw = &pf->hw;
-	item = vc_fdir_pattern;
-	*len = ARRAY_SIZE(vc_fdir_pattern);
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
@@ -775,10 +801,16 @@ ice_vc_fdir_parse_pattern(struct ice_vf *vf, struct virtchnl_fdir_add *fltr,
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
2.13.6

