From: Dave Ertman <david.m.ertman@intel.com>
Date: Mon,  4 Oct 2021 05:14:31 -0700
Subject: [Intel-wired-lan] [PATCH net] ice: Simplify tracking status of RDMA
 support
Message-ID: <20211004121431.6313-1-david.m.ertman@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The status of support for RDMA is currently being tracked with two
separate status flags.  This is unnecessary with the current state of
the driver.

Simplify status tracking down to a single flag.

Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h      | 3 ---
 drivers/net/ethernet/intel/ice/ice_lib.c  | 2 +-
 drivers/net/ethernet/intel/ice/ice_main.c | 2 --
 3 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 3c4f08d20414..453dbc6d2469 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -393,7 +393,6 @@ enum ice_pf_flags {
 	ICE_FLAG_FD_ENA,
 	ICE_FLAG_PTP_SUPPORTED,		/* PTP is supported by NVM */
 	ICE_FLAG_PTP,			/* PTP is enabled by software */
-	ICE_FLAG_AUX_ENA,
 	ICE_FLAG_ADV_FEATURES,
 	ICE_FLAG_LINK_DOWN_ON_CLOSE_ENA,
 	ICE_FLAG_TOTAL_PORT_SHUTDOWN_ENA,
@@ -695,7 +694,6 @@ static inline void ice_set_rdma_cap(struct ice_pf *pf)
 {
 	if (pf->hw.func_caps.common_cap.rdma && pf->num_rdma_msix) {
 		set_bit(ICE_FLAG_RDMA_ENA, pf->flags);
-		set_bit(ICE_FLAG_AUX_ENA, pf->flags);
 		ice_plug_aux_dev(pf);
 	}
 }
@@ -708,6 +706,5 @@ static inline void ice_clear_rdma_cap(struct ice_pf *pf)
 {
 	ice_unplug_aux_dev(pf);
 	clear_bit(ICE_FLAG_RDMA_ENA, pf->flags);
-	clear_bit(ICE_FLAG_AUX_ENA, pf->flags);
 }
 #endif /* _ICE_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index dde9802c6c72..deef7354a1af 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -638,7 +638,7 @@ bool ice_is_safe_mode(struct ice_pf *pf)
  */
 bool ice_is_aux_ena(struct ice_pf *pf)
 {
-	return test_bit(ICE_FLAG_AUX_ENA, pf->flags);
+	return test_bit(ICE_FLAG_RDMA_ENA, pf->flags);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 0d6c143f6653..d458ea941ce6 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3425,10 +3425,8 @@ static void ice_set_pf_caps(struct ice_pf *pf)
 	struct ice_hw_func_caps *func_caps = &pf->hw.func_caps;
 
 	clear_bit(ICE_FLAG_RDMA_ENA, pf->flags);
-	clear_bit(ICE_FLAG_AUX_ENA, pf->flags);
 	if (func_caps->common_cap.rdma) {
 		set_bit(ICE_FLAG_RDMA_ENA, pf->flags);
-		set_bit(ICE_FLAG_AUX_ENA, pf->flags);
 	}
 	clear_bit(ICE_FLAG_DCB_CAPABLE, pf->flags);
 	if (func_caps->common_cap.dcb)
-- 
2.31.1

