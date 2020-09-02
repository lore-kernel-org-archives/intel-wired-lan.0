From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Wed,  2 Sep 2020 08:53:43 -0700
Subject: [Intel-wired-lan] [net 2/6] ice: fix adding IP4 IP6 Flow Director
 rules
In-Reply-To: <20200902155347.16972-1-anthony.l.nguyen@intel.com>
References: <20200902155347.16972-1-anthony.l.nguyen@intel.com>
Message-ID: <20200902155347.16972-2-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Dan Nowlin <dan.nowlin@intel.com>

A subsequent addition of an IP4 or IP6 rule after other rules would
overwrite any existing TCAM entries of related L4 protocols(ex: tcp4 or
udp6). This was due to the mask including too many TCAM entries. Add new
packet type masks with bits properly excluded so rules are not overwritten.

Fixes: 31ad4e4ee1e4 ("ice: Allocate flow profile")
Signed-off-by: Dan Nowlin <dan.nowlin@intel.com>
Signed-off-by: Henry Tieman <henry.w.tieman@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_flow.c | 62 ++++++++++++++++++++++-
 1 file changed, 61 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_flow.c b/drivers/net/ethernet/intel/ice/ice_flow.c
index fe677621dd51..26fa2c915ac6 100644
--- a/drivers/net/ethernet/intel/ice/ice_flow.c
+++ b/drivers/net/ethernet/intel/ice/ice_flow.c
@@ -99,6 +99,54 @@ static const u32 ice_ptypes_ipv6_il[] = {
 	0x00000000, 0x00000000, 0x00000000, 0x00000000,
 };
 
+/* Packet types for packets with an Outer/First/Single IPv4 header - no L4 */
+static const u32 ice_ipv4_ofos_no_l4[] = {
+	0x10C00000, 0x04000800, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+};
+
+/* Packet types for packets with an Innermost/Last IPv4 header - no L4 */
+static const u32 ice_ipv4_il_no_l4[] = {
+	0x60000000, 0x18043008, 0x80000002, 0x6010c021,
+	0x00000008, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+};
+
+/* Packet types for packets with an Outer/First/Single IPv6 header - no L4 */
+static const u32 ice_ipv6_ofos_no_l4[] = {
+	0x00000000, 0x00000000, 0x43000000, 0x10002000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+};
+
+/* Packet types for packets with an Innermost/Last IPv6 header - no L4 */
+static const u32 ice_ipv6_il_no_l4[] = {
+	0x00000000, 0x02180430, 0x0000010c, 0x086010c0,
+	0x00000430, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+};
+
 /* UDP Packet types for non-tunneled packets or tunneled
  * packets with inner UDP.
  */
@@ -250,11 +298,23 @@ ice_flow_proc_seg_hdrs(struct ice_flow_prof_params *params)
 
 		hdrs = prof->segs[i].hdrs;
 
-		if (hdrs & ICE_FLOW_SEG_HDR_IPV4) {
+		if ((hdrs & ICE_FLOW_SEG_HDR_IPV4) &&
+		    !(hdrs & ICE_FLOW_SEG_HDRS_L4_MASK)) {
+			src = !i ? (const unsigned long *)ice_ipv4_ofos_no_l4 :
+				(const unsigned long *)ice_ipv4_il_no_l4;
+			bitmap_and(params->ptypes, params->ptypes, src,
+				   ICE_FLOW_PTYPE_MAX);
+		} else if (hdrs & ICE_FLOW_SEG_HDR_IPV4) {
 			src = !i ? (const unsigned long *)ice_ptypes_ipv4_ofos :
 				(const unsigned long *)ice_ptypes_ipv4_il;
 			bitmap_and(params->ptypes, params->ptypes, src,
 				   ICE_FLOW_PTYPE_MAX);
+		} else if ((hdrs & ICE_FLOW_SEG_HDR_IPV6) &&
+			   !(hdrs & ICE_FLOW_SEG_HDRS_L4_MASK)) {
+			src = !i ? (const unsigned long *)ice_ipv6_ofos_no_l4 :
+				(const unsigned long *)ice_ipv6_il_no_l4;
+			bitmap_and(params->ptypes, params->ptypes, src,
+				   ICE_FLOW_PTYPE_MAX);
 		} else if (hdrs & ICE_FLOW_SEG_HDR_IPV6) {
 			src = !i ? (const unsigned long *)ice_ptypes_ipv6_ofos :
 				(const unsigned long *)ice_ptypes_ipv6_il;
-- 
2.20.1

