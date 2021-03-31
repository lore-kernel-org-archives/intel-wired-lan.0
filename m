From: Haiyue Wang <haiyue.wang@intel.com>
Date: Wed, 31 Mar 2021 10:08:37 +0800
Subject: [Intel-wired-lan] [Patch v1 3/3] iavf: redefine the magic number
 for FDIR GTP-U header fields
In-Reply-To: <20210331020837.3640-1-haiyue.wang@intel.com>
References: <20210331020837.3640-1-haiyue.wang@intel.com>
Message-ID: <20210331020837.3640-3-haiyue.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The flex-byte for GTP-U protocol header fields uses the magic number,
which is hard to maintain and understand, define the interested filelds
with meaningful macro name, based on the GTP-U protocol stack:

GTP-U header
     +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
     | 0x1 |1|0|1|0|0|     0xff      |           Length              |
     +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
     |                           TEID = 1654                         |
     +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
     |    Sequence Number = 0        |N-PDU Number=0 |NextExtHdr=0x85|
     +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+

GTP-U Extension Header (PDU Session Container)
     +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
     |  ExtHdrLen=2  |Type=0 | Spare |0|0|   QFI     | PPI |  Spare  |
     +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
     |                    Padding                    |NextExtHdr=0x0 |
     +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+

Signed-off-by: Haiyue Wang <haiyue.wang@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_fdir.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_fdir.c b/drivers/net/ethernet/intel/iavf/iavf_fdir.c
index af872ea3163f..6146203efd84 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_fdir.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_fdir.c
@@ -54,8 +54,13 @@ iavf_fill_fdir_gtpu_hdr(struct iavf_fdir_fltr *fltr,
 #define IAVF_GTPU_HDR_TEID_OFFS0	4
 #define IAVF_GTPU_HDR_TEID_OFFS1	6
 #define IAVF_GTPU_HDR_N_PDU_AND_NEXT_EXTHDR_OFFS	10
+#define IAVF_GTPU_HDR_NEXT_EXTHDR_TYPE_MASK		0x00FF /* skip N_PDU */
+/* PDU Session Container Extension Header (PSC) */
+#define IAVF_GTPU_PSC_EXTHDR_TYPE			0x85
 #define IAVF_GTPU_HDR_PSC_PDU_TYPE_AND_QFI_OFFS		13
-#define IAVF_GTPU_PSC_EXTHDR_TYPE	0x85 /* PDU Session Container Extension Header */
+#define IAVF_GTPU_HDR_PSC_PDU_QFI_MASK			0x3F /* skip Type */
+#define IAVF_GTPU_EH_QFI_IDX				1
+
 		if (fltr->flex_words[i].offset < adj_offs)
 			return -EINVAL;
 
@@ -71,7 +76,9 @@ iavf_fill_fdir_gtpu_hdr(struct iavf_fdir_fltr *fltr,
 			}
 			break;
 		case IAVF_GTPU_HDR_N_PDU_AND_NEXT_EXTHDR_OFFS:
-			if ((fltr->flex_words[i].word & 0xff) != IAVF_GTPU_PSC_EXTHDR_TYPE)
+			if ((fltr->flex_words[i].word &
+			     IAVF_GTPU_HDR_NEXT_EXTHDR_TYPE_MASK) !=
+						IAVF_GTPU_PSC_EXTHDR_TYPE)
 				return -EOPNOTSUPP;
 			if (!ehdr)
 				ehdr = &proto_hdrs->proto_hdr[proto_hdrs->count++];
@@ -80,7 +87,9 @@ iavf_fill_fdir_gtpu_hdr(struct iavf_fdir_fltr *fltr,
 		case IAVF_GTPU_HDR_PSC_PDU_TYPE_AND_QFI_OFFS:
 			if (!ehdr)
 				return -EINVAL;
-			ehdr->buffer[1] = fltr->flex_words[i].word & 0x3F;
+			ehdr->buffer[IAVF_GTPU_EH_QFI_IDX] =
+					fltr->flex_words[i].word &
+						IAVF_GTPU_HDR_PSC_PDU_QFI_MASK;
 			VIRTCHNL_ADD_PROTO_HDR_FIELD_BIT(ehdr, GTPU_EH, QFI);
 			break;
 		default:
-- 
2.31.1

