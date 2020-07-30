From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Wed, 29 Jul 2020 17:19:16 -0700
Subject: [Intel-wired-lan] [PATCH S51 07/13] ice: Allow 2 queue pairs per VF
 on SR-IOV initialization
In-Reply-To: <20200730001922.52568-1-anthony.l.nguyen@intel.com>
References: <20200730001922.52568-1-anthony.l.nguyen@intel.com>
Message-ID: <20200730001922.52568-7-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Brett Creeley <brett.creeley@intel.com>

Currently VFs are only allowed to get 16, 4, and 1 queue pair by
default, which require 17, 5, and 2 MSI-X vectors respectively. This
is because each VF needs a MSI-X per data queue and a MSI-X for its
other interrupt. The calculation is based on the number of VFs created,
MSI-X available, and queue pairs available at the time of VF creation.

Unfortunately the values above exclude 2 queue pairs when only 3 MSI-X
are available to each VF based on resource constraints. The current
calculation would default to 2 MSI-X and 1 queue pair. This is a waste
of resources, so fix this by allowing 2 queue pairs per VF when there
are between 2 and 5 MSI-X available per VF.

Signed-off-by: Brett Creeley <brett.creeley@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 2 ++
 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
index d48452e3a49b..0ba54b39ab43 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
@@ -932,6 +932,8 @@ static int ice_set_per_vf_res(struct ice_pf *pf)
 		num_msix_per_vf = ICE_NUM_VF_MSIX_MED;
 	} else if (msix_avail_per_vf >= ICE_NUM_VF_MSIX_SMALL) {
 		num_msix_per_vf = ICE_NUM_VF_MSIX_SMALL;
+	} else if (msix_avail_per_vf >= ICE_NUM_VF_MSIX_MULTIQ_MIN) {
+		num_msix_per_vf = ICE_NUM_VF_MSIX_MULTIQ_MIN;
 	} else if (msix_avail_per_vf >= ICE_MIN_INTR_PER_VF) {
 		num_msix_per_vf = ICE_MIN_INTR_PER_VF;
 	} else {
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h
index 049e0b583383..0f519fba3770 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h
@@ -32,6 +32,7 @@
 #define ICE_MAX_RSS_QS_PER_VF		16
 #define ICE_NUM_VF_MSIX_MED		17
 #define ICE_NUM_VF_MSIX_SMALL		5
+#define ICE_NUM_VF_MSIX_MULTIQ_MIN	3
 #define ICE_MIN_INTR_PER_VF		(ICE_MIN_QS_PER_VF + 1)
 #define ICE_MAX_VF_RESET_TRIES		40
 #define ICE_MAX_VF_RESET_SLEEP_MS	20
-- 
2.20.1

