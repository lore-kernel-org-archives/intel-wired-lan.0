From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Tue,  2 Mar 2021 10:12:11 -0800
Subject: [Intel-wired-lan] [PATCH S55 12/14] ice: rename ptype bitmap
In-Reply-To: <20210302181213.51718-1-anthony.l.nguyen@intel.com>
References: <20210302181213.51718-1-anthony.l.nguyen@intel.com>
Message-ID: <20210302181213.51718-12-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Qi Zhang <qi.z.zhang@intel.com>

Align all ptype bitmap to follow ice_ptypes_xxx prefix.

Signed-off-by: Qi Zhang <qi.z.zhang@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_flow.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_flow.c b/drivers/net/ethernet/intel/ice/ice_flow.c
index ceb802ab76c0..2eec44ef2346 100644
--- a/drivers/net/ethernet/intel/ice/ice_flow.c
+++ b/drivers/net/ethernet/intel/ice/ice_flow.c
@@ -237,7 +237,7 @@ static const u32 ice_ptypes_ipv6_il[] = {
 };
 
 /* Packet types for packets with an Outer/First/Single IPv4 header - no L4 */
-static const u32 ice_ipv4_ofos_no_l4[] = {
+static const u32 ice_ptypes_ipv4_ofos_no_l4[] = {
 	0x10C00000, 0x04000800, 0x00000000, 0x00000000,
 	0x00000000, 0x00000000, 0x00000000, 0x00000000,
 	0x00000000, 0x00000000, 0x00000000, 0x00000000,
@@ -261,7 +261,7 @@ static const u32 ice_ptypes_arp_of[] = {
 };
 
 /* Packet types for packets with an Innermost/Last IPv4 header - no L4 */
-static const u32 ice_ipv4_il_no_l4[] = {
+static const u32 ice_ptypes_ipv4_il_no_l4[] = {
 	0x60000000, 0x18043008, 0x80000002, 0x6010c021,
 	0x00000008, 0x00000000, 0x00000000, 0x00000000,
 	0x00000000, 0x00000000, 0x00000000, 0x00000000,
@@ -273,7 +273,7 @@ static const u32 ice_ipv4_il_no_l4[] = {
 };
 
 /* Packet types for packets with an Outer/First/Single IPv6 header - no L4 */
-static const u32 ice_ipv6_ofos_no_l4[] = {
+static const u32 ice_ptypes_ipv6_ofos_no_l4[] = {
 	0x00000000, 0x00000000, 0x43000000, 0x10002000,
 	0x00000000, 0x00000000, 0x00000000, 0x00000000,
 	0x00000000, 0x00000000, 0x00000000, 0x00000000,
@@ -285,7 +285,7 @@ static const u32 ice_ipv6_ofos_no_l4[] = {
 };
 
 /* Packet types for packets with an Innermost/Last IPv6 header - no L4 */
-static const u32 ice_ipv6_il_no_l4[] = {
+static const u32 ice_ptypes_ipv6_il_no_l4[] = {
 	0x00000000, 0x02180430, 0x0000010c, 0x086010c0,
 	0x00000430, 0x00000000, 0x00000000, 0x00000000,
 	0x00000000, 0x00000000, 0x00000000, 0x00000000,
@@ -749,8 +749,8 @@ ice_flow_proc_seg_hdrs(struct ice_flow_prof_params *params)
 				   ICE_FLOW_PTYPE_MAX);
 		} else if ((hdrs & ICE_FLOW_SEG_HDR_IPV4) &&
 			   !(hdrs & ICE_FLOW_SEG_HDRS_L4_MASK_NO_OTHER)) {
-			src = !i ? (const unsigned long *)ice_ipv4_ofos_no_l4 :
-				(const unsigned long *)ice_ipv4_il_no_l4;
+			src = !i ? (const unsigned long *)ice_ptypes_ipv4_ofos_no_l4 :
+				(const unsigned long *)ice_ptypes_ipv4_il_no_l4;
 			bitmap_and(params->ptypes, params->ptypes, src,
 				   ICE_FLOW_PTYPE_MAX);
 		} else if (hdrs & ICE_FLOW_SEG_HDR_IPV4) {
@@ -760,8 +760,8 @@ ice_flow_proc_seg_hdrs(struct ice_flow_prof_params *params)
 				   ICE_FLOW_PTYPE_MAX);
 		} else if ((hdrs & ICE_FLOW_SEG_HDR_IPV6) &&
 			   !(hdrs & ICE_FLOW_SEG_HDRS_L4_MASK_NO_OTHER)) {
-			src = !i ? (const unsigned long *)ice_ipv6_ofos_no_l4 :
-				(const unsigned long *)ice_ipv6_il_no_l4;
+			src = !i ? (const unsigned long *)ice_ptypes_ipv6_ofos_no_l4 :
+				(const unsigned long *)ice_ptypes_ipv6_il_no_l4;
 			bitmap_and(params->ptypes, params->ptypes, src,
 				   ICE_FLOW_PTYPE_MAX);
 		} else if (hdrs & ICE_FLOW_SEG_HDR_IPV6) {
-- 
2.20.1

