From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Fri, 26 Oct 2018 10:40:57 -0700
Subject: [Intel-wired-lan] [PATCH S8 08/16] ice: Fix napi delete calls for
 remove
In-Reply-To: <20181026174105.11628-1-anirudh.venkataramanan@intel.com>
References: <20181026174105.11628-1-anirudh.venkataramanan@intel.com>
Message-ID: <20181026174105.11628-9-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Dave Ertman <david.m.ertman@intel.com>

In the remove path, the vsi->netdev is being set to NULL before the call
to free vectors. This is causing the netif_napi_del call to never be made.

Add a call to ice_napi_del to the same location as the calls to
unregister_netdev and just prior to them. This will use the reverse flow
as the register and netif_napi_add calls.

Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h      | 1 +
 drivers/net/ethernet/intel/ice/ice_lib.c  | 1 +
 drivers/net/ethernet/intel/ice/ice_main.c | 2 +-
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 1639e955f158..b8548370f1c7 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -370,5 +370,6 @@ int ice_set_rss(struct ice_vsi *vsi, u8 *seed, u8 *lut, u16 lut_size);
 int ice_get_rss(struct ice_vsi *vsi, u8 *seed, u8 *lut, u16 lut_size);
 void ice_fill_rss_lut(u8 *lut, u16 rss_table_size, u16 rss_size);
 void ice_print_link_msg(struct ice_vsi *vsi, bool isup);
+void ice_napi_del(struct ice_vsi *vsi);
 
 #endif /* _ICE_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index c604a44c8cfb..1041fa2a7767 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -2458,6 +2458,7 @@ int ice_vsi_release(struct ice_vsi *vsi)
 	 * on this wq
 	 */
 	if (vsi->netdev && !ice_is_reset_in_progress(pf->state)) {
+		ice_napi_del(vsi);
 		unregister_netdev(vsi->netdev);
 		free_netdev(vsi->netdev);
 		vsi->netdev = NULL;
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 338abb1b9233..82f49dbd762c 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -1465,7 +1465,7 @@ static int ice_req_irq_msix_misc(struct ice_pf *pf)
  * ice_napi_del - Remove NAPI handler for the VSI
  * @vsi: VSI for which NAPI handler is to be removed
  */
-static void ice_napi_del(struct ice_vsi *vsi)
+void ice_napi_del(struct ice_vsi *vsi)
 {
 	int v_idx;
 
-- 
2.14.3

