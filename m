From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Thu, 25 Mar 2021 17:38:32 -0700
Subject: [Intel-wired-lan] [PATCH net-next v2 09/11] igbvf: convert to
 strongly typed descriptors
In-Reply-To: <20210326003834.3886241-1-jesse.brandeburg@intel.com>
References: <20210326003834.3886241-1-jesse.brandeburg@intel.com>
Message-ID: <20210326003834.3886241-10-jesse.brandeburg@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The igbvf driver for some reason never strongly typed it's descriptor
formats. Make this driver like the rest of the Intel drivers and use
__le* for our little endian descriptors.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
Warning Detail
.../igbvf/netdev.c:203:48: warning: incorrect type in assignment (different base types)
.../igbvf/netdev.c:203:48:    expected unsigned long long [usertype] pkt_addr
.../igbvf/netdev.c:203:48:    got restricted __le64 [usertype]
.../igbvf/netdev.c:205:48: warning: incorrect type in assignment (different base types)
.../igbvf/netdev.c:205:48:    expected unsigned long long [usertype] hdr_addr
.../igbvf/netdev.c:205:48:    got restricted __le64 [usertype]
.../igbvf/netdev.c:207:48: warning: incorrect type in assignment (different base types)
.../igbvf/netdev.c:207:48:    expected unsigned long long [usertype] pkt_addr
.../igbvf/netdev.c:207:48:    got restricted __le64 [usertype]
.../igbvf/netdev.c:261:19: warning: cast to restricted __le32
.../igbvf/netdev.c:276:25: warning: cast to restricted __le16
.../igbvf/netdev.c:282:26: warning: cast to restricted __le16
.../igbvf/netdev.c:356:52: warning: incorrect type in argument 5 (different base types)
.../igbvf/netdev.c:356:52:    expected restricted __le16 [usertype] vlan
.../igbvf/netdev.c:356:52:    got unsigned short [usertype] vlan
.../igbvf/netdev.c:371:27: warning: cast to restricted __le32
.../igbvf/netdev.c:797:45: warning: restricted __le32 degrades to integer
.../igbvf/netdev.c:1992:41: warning: incorrect type in assignment (different base types)
.../igbvf/netdev.c:1992:41:    expected unsigned int [usertype] vlan_macip_lens
.../igbvf/netdev.c:1992:41:    got restricted __le32 [usertype]
.../igbvf/netdev.c:1994:41: warning: incorrect type in assignment (different base types)
.../igbvf/netdev.c:1994:41:    expected unsigned int [usertype] type_tucmd_mlhl
.../igbvf/netdev.c:1994:41:    got restricted __le32 [usertype]
.../igbvf/netdev.c:1995:41: warning: incorrect type in assignment (different base types)
.../igbvf/netdev.c:1995:41:    expected unsigned int [usertype] mss_l4len_idx
.../igbvf/netdev.c:1995:41:    got restricted __le32 [usertype]
---
 drivers/net/ethernet/intel/igbvf/vf.h | 42 +++++++++++++--------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/intel/igbvf/vf.h b/drivers/net/ethernet/intel/igbvf/vf.h
index c71b0d7dbcee..ba9bb3132d5d 100644
--- a/drivers/net/ethernet/intel/igbvf/vf.h
+++ b/drivers/net/ethernet/intel/igbvf/vf.h
@@ -35,31 +35,31 @@ struct e1000_hw;
 /* Receive Descriptor - Advanced */
 union e1000_adv_rx_desc {
 	struct {
-		u64 pkt_addr; /* Packet buffer address */
-		u64 hdr_addr; /* Header buffer address */
+		__le64 pkt_addr; /* Packet buffer address */
+		__le64 hdr_addr; /* Header buffer address */
 	} read;
 	struct {
 		struct {
 			union {
-				u32 data;
+				__le32 data;
 				struct {
-					u16 pkt_info; /* RSS/Packet type */
+					__le16 pkt_info; /* RSS/Packet type */
 					/* Split Header, hdr buffer length */
-					u16 hdr_info;
+					__le16 hdr_info;
 				} hs_rss;
 			} lo_dword;
 			union {
-				u32 rss; /* RSS Hash */
+				__le32 rss; /* RSS Hash */
 				struct {
-					u16 ip_id; /* IP id */
-					u16 csum;  /* Packet Checksum */
+					__le16 ip_id; /* IP id */
+					__le16 csum;  /* Packet Checksum */
 				} csum_ip;
 			} hi_dword;
 		} lower;
 		struct {
-			u32 status_error; /* ext status/error */
-			u16 length; /* Packet length */
-			u16 vlan;   /* VLAN tag */
+			__le32 status_error; /* ext status/error */
+			__le16 length; /* Packet length */
+			__le16 vlan; /* VLAN tag */
 		} upper;
 	} wb;  /* writeback */
 };
@@ -70,14 +70,14 @@ union e1000_adv_rx_desc {
 /* Transmit Descriptor - Advanced */
 union e1000_adv_tx_desc {
 	struct {
-		u64 buffer_addr; /* Address of descriptor's data buf */
-		u32 cmd_type_len;
-		u32 olinfo_status;
+		__le64 buffer_addr; /* Address of descriptor's data buf */
+		__le32 cmd_type_len;
+		__le32 olinfo_status;
 	} read;
 	struct {
-		u64 rsvd; /* Reserved */
-		u32 nxtseq_seed;
-		u32 status;
+		__le64 rsvd; /* Reserved */
+		__le32 nxtseq_seed;
+		__le32 status;
 	} wb;
 };
 
@@ -94,10 +94,10 @@ union e1000_adv_tx_desc {
 
 /* Context descriptors */
 struct e1000_adv_tx_context_desc {
-	u32 vlan_macip_lens;
-	u32 seqnum_seed;
-	u32 type_tucmd_mlhl;
-	u32 mss_l4len_idx;
+	__le32 vlan_macip_lens;
+	__le32 seqnum_seed;
+	__le32 type_tucmd_mlhl;
+	__le32 mss_l4len_idx;
 };
 
 #define E1000_ADVTXD_MACLEN_SHIFT	9  /* Adv ctxt desc mac len shift */
-- 
2.30.2

