From: Haiyue Wang <haiyue.wang@intel.com>
Date: Tue,  6 Apr 2021 09:00:25 +0800
Subject: [Intel-wired-lan] [PATCH net-next v1 6/6] iavf: Support ethtool
 SCTP flow RSS hash
In-Reply-To: <20210406010025.90549-1-haiyue.wang@intel.com>
References: <20210406010025.90549-1-haiyue.wang@intel.com>
Message-ID: <20210406010025.90549-7-haiyue.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Support to configure the SCTP flow RSS hash by ethtool.

Supported fields are: src-ip, dst-ip, src-port, dst-port.
Supported rx-flow-hash types are: sctp4, sctp6.

Signed-off-by: Haiyue Wang <haiyue.wang@intel.com>
---
 .../net/ethernet/intel/iavf/iavf_adv_rss.c    | 28 +++++++++++++++++--
 .../net/ethernet/intel/iavf/iavf_adv_rss.h    | 10 ++++++-
 .../net/ethernet/intel/iavf/iavf_ethtool.c    | 23 +++++++++++++--
 3 files changed, 56 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_adv_rss.c b/drivers/net/ethernet/intel/iavf/iavf_adv_rss.c
index f1568ff7b1dc..5a5419122fb7 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_adv_rss.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_adv_rss.c
@@ -73,6 +73,23 @@ iavf_fill_adv_rss_udp_hdr(struct virtchnl_proto_hdr *hdr, u64 hash_flds)
 		VIRTCHNL_ADD_PROTO_HDR_FIELD_BIT(hdr, UDP, DST_PORT);
 }
 
+/**
+ * iavf_fill_adv_rss_sctp_hdr - fill the SCTP RSS protocol header
+ * @hdr: the virtchnl message protocol header data structure
+ * @hash_flds: the RSS configuration protocol hash fields
+ */
+static void
+iavf_fill_adv_rss_sctp_hdr(struct virtchnl_proto_hdr *hdr, u64 hash_flds)
+{
+	VIRTCHNL_SET_PROTO_HDR_TYPE(hdr, SCTP);
+
+	if (hash_flds & IAVF_ADV_RSS_HASH_FLD_SCTP_SRC_PORT)
+		VIRTCHNL_ADD_PROTO_HDR_FIELD_BIT(hdr, SCTP, SRC_PORT);
+
+	if (hash_flds & IAVF_ADV_RSS_HASH_FLD_UDP_DST_PORT)
+		VIRTCHNL_ADD_PROTO_HDR_FIELD_BIT(hdr, SCTP, DST_PORT);
+}
+
 /**
  * iavf_fill_adv_rss_cfg_msg - fill the RSS configuration into virtchnl message
  * @rss_cfg: the virtchnl message to be filled with RSS configuration setting
@@ -112,6 +129,9 @@ iavf_fill_adv_rss_cfg_msg(struct virtchnl_rss_cfg *rss_cfg,
 	case IAVF_ADV_RSS_FLOW_SEG_HDR_UDP:
 		iavf_fill_adv_rss_udp_hdr(hdr, hash_flds);
 		break;
+	case IAVF_ADV_RSS_FLOW_SEG_HDR_SCTP:
+		iavf_fill_adv_rss_sctp_hdr(hdr, hash_flds);
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -166,6 +186,8 @@ iavf_print_adv_rss_cfg(const char *level, struct iavf_adapter *adapter,
 		proto = "TCP";
 	else if (packet_hdrs & IAVF_ADV_RSS_FLOW_SEG_HDR_UDP)
 		proto = "UDP";
+	else if (packet_hdrs & IAVF_ADV_RSS_FLOW_SEG_HDR_SCTP)
+		proto = "SCTP";
 	else
 		return;
 
@@ -184,10 +206,12 @@ iavf_print_adv_rss_cfg(const char *level, struct iavf_adapter *adapter,
 			 IAVF_ADV_RSS_HASH_FLD_IPV6_DA))
 		strcat(hash_opt, "IP DA,");
 	if (hash_flds & (IAVF_ADV_RSS_HASH_FLD_TCP_SRC_PORT |
-			 IAVF_ADV_RSS_HASH_FLD_UDP_SRC_PORT))
+			 IAVF_ADV_RSS_HASH_FLD_UDP_SRC_PORT |
+			 IAVF_ADV_RSS_HASH_FLD_SCTP_SRC_PORT))
 		strcat(hash_opt, "src port,");
 	if (hash_flds & (IAVF_ADV_RSS_HASH_FLD_TCP_DST_PORT |
-			 IAVF_ADV_RSS_HASH_FLD_UDP_DST_PORT))
+			 IAVF_ADV_RSS_HASH_FLD_UDP_DST_PORT |
+			 IAVF_ADV_RSS_HASH_FLD_SCTP_DST_PORT))
 		strcat(hash_opt, "dst port,");
 
 	if (!action)
diff --git a/drivers/net/ethernet/intel/iavf/iavf_adv_rss.h b/drivers/net/ethernet/intel/iavf/iavf_adv_rss.h
index b5834d688d07..56c083e35088 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_adv_rss.h
+++ b/drivers/net/ethernet/intel/iavf/iavf_adv_rss.h
@@ -21,6 +21,7 @@ enum iavf_adv_rss_flow_seg_hdr {
 	IAVF_ADV_RSS_FLOW_SEG_HDR_IPV6	= 0x00000002,
 	IAVF_ADV_RSS_FLOW_SEG_HDR_TCP	= 0x00000004,
 	IAVF_ADV_RSS_FLOW_SEG_HDR_UDP	= 0x00000008,
+	IAVF_ADV_RSS_FLOW_SEG_HDR_SCTP	= 0x00000010,
 };
 
 #define IAVF_ADV_RSS_FLOW_SEG_HDR_L3		\
@@ -29,7 +30,8 @@ enum iavf_adv_rss_flow_seg_hdr {
 
 #define IAVF_ADV_RSS_FLOW_SEG_HDR_L4		\
 	(IAVF_ADV_RSS_FLOW_SEG_HDR_TCP |	\
-	 IAVF_ADV_RSS_FLOW_SEG_HDR_UDP)
+	 IAVF_ADV_RSS_FLOW_SEG_HDR_UDP |	\
+	 IAVF_ADV_RSS_FLOW_SEG_HDR_SCTP)
 
 enum iavf_adv_rss_flow_field {
 	/* L3 */
@@ -42,6 +44,8 @@ enum iavf_adv_rss_flow_field {
 	IAVF_ADV_RSS_FLOW_FIELD_IDX_TCP_DST_PORT,
 	IAVF_ADV_RSS_FLOW_FIELD_IDX_UDP_SRC_PORT,
 	IAVF_ADV_RSS_FLOW_FIELD_IDX_UDP_DST_PORT,
+	IAVF_ADV_RSS_FLOW_FIELD_IDX_SCTP_SRC_PORT,
+	IAVF_ADV_RSS_FLOW_FIELD_IDX_SCTP_DST_PORT,
 
 	/* The total number of enums must not exceed 64 */
 	IAVF_ADV_RSS_FLOW_FIELD_IDX_MAX
@@ -64,6 +68,10 @@ enum iavf_adv_rss_flow_field {
 	BIT_ULL(IAVF_ADV_RSS_FLOW_FIELD_IDX_UDP_SRC_PORT)
 #define IAVF_ADV_RSS_HASH_FLD_UDP_DST_PORT	\
 	BIT_ULL(IAVF_ADV_RSS_FLOW_FIELD_IDX_UDP_DST_PORT)
+#define IAVF_ADV_RSS_HASH_FLD_SCTP_SRC_PORT	\
+	BIT_ULL(IAVF_ADV_RSS_FLOW_FIELD_IDX_SCTP_SRC_PORT)
+#define IAVF_ADV_RSS_HASH_FLD_SCTP_DST_PORT	\
+	BIT_ULL(IAVF_ADV_RSS_FLOW_FIELD_IDX_SCTP_DST_PORT)
 
 /* bookkeeping of advanced RSS configuration */
 struct iavf_adv_rss {
diff --git a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
index c99ebf642b44..56e40aae5e54 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
@@ -1438,6 +1438,10 @@ static u32 iavf_adv_rss_parse_hdrs(struct ethtool_rxnfc *cmd)
 		hdrs |= IAVF_ADV_RSS_FLOW_SEG_HDR_UDP |
 			IAVF_ADV_RSS_FLOW_SEG_HDR_IPV4;
 		break;
+	case SCTP_V4_FLOW:
+		hdrs |= IAVF_ADV_RSS_FLOW_SEG_HDR_SCTP |
+			IAVF_ADV_RSS_FLOW_SEG_HDR_IPV4;
+		break;
 	case TCP_V6_FLOW:
 		hdrs |= IAVF_ADV_RSS_FLOW_SEG_HDR_TCP |
 			IAVF_ADV_RSS_FLOW_SEG_HDR_IPV6;
@@ -1446,6 +1450,10 @@ static u32 iavf_adv_rss_parse_hdrs(struct ethtool_rxnfc *cmd)
 		hdrs |= IAVF_ADV_RSS_FLOW_SEG_HDR_UDP |
 			IAVF_ADV_RSS_FLOW_SEG_HDR_IPV6;
 		break;
+	case SCTP_V6_FLOW:
+		hdrs |= IAVF_ADV_RSS_FLOW_SEG_HDR_SCTP |
+			IAVF_ADV_RSS_FLOW_SEG_HDR_IPV6;
+		break;
 	default:
 		break;
 	}
@@ -1468,6 +1476,7 @@ static u64 iavf_adv_rss_parse_hash_flds(struct ethtool_rxnfc *cmd)
 		switch (cmd->flow_type) {
 		case TCP_V4_FLOW:
 		case UDP_V4_FLOW:
+		case SCTP_V4_FLOW:
 			if (cmd->data & RXH_IP_SRC)
 				hfld |= IAVF_ADV_RSS_HASH_FLD_IPV4_SA;
 			if (cmd->data & RXH_IP_DST)
@@ -1475,6 +1484,7 @@ static u64 iavf_adv_rss_parse_hash_flds(struct ethtool_rxnfc *cmd)
 			break;
 		case TCP_V6_FLOW:
 		case UDP_V6_FLOW:
+		case SCTP_V6_FLOW:
 			if (cmd->data & RXH_IP_SRC)
 				hfld |= IAVF_ADV_RSS_HASH_FLD_IPV6_SA;
 			if (cmd->data & RXH_IP_DST)
@@ -1501,6 +1511,13 @@ static u64 iavf_adv_rss_parse_hash_flds(struct ethtool_rxnfc *cmd)
 			if (cmd->data & RXH_L4_B_2_3)
 				hfld |= IAVF_ADV_RSS_HASH_FLD_UDP_DST_PORT;
 			break;
+		case SCTP_V4_FLOW:
+		case SCTP_V6_FLOW:
+			if (cmd->data & RXH_L4_B_0_1)
+				hfld |= IAVF_ADV_RSS_HASH_FLD_SCTP_SRC_PORT;
+			if (cmd->data & RXH_L4_B_2_3)
+				hfld |= IAVF_ADV_RSS_HASH_FLD_SCTP_DST_PORT;
+			break;
 		default:
 			break;
 		}
@@ -1636,11 +1653,13 @@ iavf_get_adv_rss_hash_opt(struct iavf_adapter *adapter,
 		cmd->data |= (u64)RXH_IP_DST;
 
 	if (hash_flds & (IAVF_ADV_RSS_HASH_FLD_TCP_SRC_PORT |
-			 IAVF_ADV_RSS_HASH_FLD_UDP_SRC_PORT))
+			 IAVF_ADV_RSS_HASH_FLD_UDP_SRC_PORT |
+			 IAVF_ADV_RSS_HASH_FLD_SCTP_SRC_PORT))
 		cmd->data |= (u64)RXH_L4_B_0_1;
 
 	if (hash_flds & (IAVF_ADV_RSS_HASH_FLD_TCP_DST_PORT |
-			 IAVF_ADV_RSS_HASH_FLD_UDP_DST_PORT))
+			 IAVF_ADV_RSS_HASH_FLD_UDP_DST_PORT |
+			 IAVF_ADV_RSS_HASH_FLD_SCTP_DST_PORT))
 		cmd->data |= (u64)RXH_L4_B_2_3;
 
 	return 0;
-- 
2.31.1

