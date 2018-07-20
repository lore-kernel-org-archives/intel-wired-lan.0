From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Fri, 20 Jul 2018 12:54:41 -0700
Subject: [Intel-wired-lan] [RFC 08/13] ice: Don't explicitly set
 port_vlan_bits to 0
In-Reply-To: <20180720195446.4346-1-anirudh.venkataramanan@intel.com>
References: <20180720195446.4346-1-anirudh.venkataramanan@intel.com>
Message-ID: <20180720195446.4346-9-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Brett Creeley <brett.creeley@intel.com>

This patch fixes the following smatch warning originally reported by
Dan Carpenter:
ice_set_dflt_vsi_ctx() warn: odd binop '0x0 & 0x18'

In ice_set_dflt_vsi_ctx() we are currently doing logic that is intended
to explicitly clear bits 3 and 4 for port_vlan_flags. Clearing these
bits results in legacy behavior (showing VLAN, DEI, and UP) in the
descriptors. The issue was this was reporting the Smatch error shown
below.  To fix this remove this logic because the port_vlan_flags field
is set to 0 initially by memset so by default we have the correct legacy
behavior for bits 3 and 4.  A comment was added above where we set
port_vlan_flags in ice_set_dflt_vsi_ctx() to note that this is the
desired behavior.

Signed-off-by: Brett Creeley <brett.creeley@intel.com>
[Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> cleaned up commit message]
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index feeca75912ec..586c6e615a98 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -1367,14 +1367,13 @@ static void ice_set_dflt_vsi_ctx(struct ice_vsi_ctx *ctxt)
 	ctxt->info.sw_flags = ICE_AQ_VSI_SW_FLAG_SRC_PRUNE;
 	/* Traffic from VSI can be sent to LAN */
 	ctxt->info.sw_flags2 = ICE_AQ_VSI_SW_FLAG_LAN_ENA;
-	/* Allow all packets untagged/tagged */
+	/* By default bits 3 and 4 in port_vlan_flags are 0's which results in
+	 * legacy behavior (show VLAN, DEI, and UP) in descriptor. Also, allow
+	 * all packets untagged/tagged.
+	 */
 	ctxt->info.port_vlan_flags = ((ICE_AQ_VSI_PVLAN_MODE_ALL &
 				       ICE_AQ_VSI_PVLAN_MODE_M) >>
 				      ICE_AQ_VSI_PVLAN_MODE_S);
-	/* Show VLAN/UP from packets in Rx descriptors */
-	ctxt->info.port_vlan_flags |= ((ICE_AQ_VSI_PVLAN_EMOD_STR_BOTH &
-					ICE_AQ_VSI_PVLAN_EMOD_M) >>
-				       ICE_AQ_VSI_PVLAN_EMOD_S);
 	/* Have 1:1 UP mapping for both ingress/egress tables */
 	table |= ICE_UP_TABLE_TRANSLATE(0, 0);
 	table |= ICE_UP_TABLE_TRANSLATE(1, 1);
-- 
2.14.3

