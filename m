From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Thu, 18 Oct 2018 08:37:03 -0700
Subject: [Intel-wired-lan] [PATCH 1/7] ice: Make ice_msix_clean_rings static
In-Reply-To: <20181018153709.32664-1-anirudh.venkataramanan@intel.com>
References: <20181018153709.32664-1-anirudh.venkataramanan@intel.com>
Message-ID: <20181018153709.32664-2-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

commit 158a08a694c4e ("ice: remove ndo_poll_controller") removed
ice_netpoll and introduced a namespace warning for ice_msix_clean_rings.
Fix the namespace warning by making ice_msix_clean_rings static.

Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c | 2 +-
 drivers/net/ethernet/intel/ice/ice_lib.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 49f1940772ed..e750702bcdce 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -433,7 +433,7 @@ int ice_vsi_clear(struct ice_vsi *vsi)
  * @irq: interrupt number
  * @data: pointer to a q_vector
  */
-irqreturn_t ice_msix_clean_rings(int __always_unused irq, void *data)
+static irqreturn_t ice_msix_clean_rings(int __always_unused irq, void *data)
 {
 	struct ice_q_vector *q_vector = (struct ice_q_vector *)data;
 
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.h b/drivers/net/ethernet/intel/ice/ice_lib.h
index 677db40338f5..3831b4f0960a 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_lib.h
@@ -73,5 +73,4 @@ int ice_vsi_cfg_tc(struct ice_vsi *vsi, u8 ena_tc);
 
 int ice_vsi_manage_rss_lut(struct ice_vsi *vsi, bool ena);
 
-irqreturn_t ice_msix_clean_rings(int __always_unused irq, void *data);
 #endif /* !_ICE_LIB_H_ */
-- 
2.14.3

