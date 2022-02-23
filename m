From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 22 Feb 2022 16:26:52 -0800
Subject: [Intel-wired-lan] [net-next PATCH 05/25] ice: remmove unused
 definitions from ice_sriov.h
In-Reply-To: <20220223002712.2771809-1-jacob.e.keller@intel.com>
References: <20220223002712.2771809-1-jacob.e.keller@intel.com>
Message-ID: <20220223002712.2771809-6-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

A few more macros exist in ice_sriov.h which are not used anywhere.
These can be safely removed. Note that ICE_VIRTCHNL_VF_CAP_L2 capability
is set but never checked anywhere in the driver. Thus it is also safe to
remove.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_sriov.c | 1 -
 drivers/net/ethernet/intel/ice/ice_sriov.h | 7 +------
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
index 8578317ceb8a..205d7e5003d8 100644
--- a/drivers/net/ethernet/intel/ice/ice_sriov.c
+++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
@@ -2012,7 +2012,6 @@ static int ice_create_vf_entries(struct ice_pf *pf, u16 num_vfs)
 
 		vf->vf_sw_id = pf->first_sw;
 		/* assign default capabilities */
-		set_bit(ICE_VIRTCHNL_VF_CAP_L2, &vf->vf_caps);
 		vf->spoofchk = true;
 		vf->num_vf_qs = pf->vfs.num_qps_per;
 		ice_vc_set_default_allowlist(vf);
diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.h b/drivers/net/ethernet/intel/ice/ice_sriov.h
index 01b6b08a73d8..525e3f0819e8 100644
--- a/drivers/net/ethernet/intel/ice/ice_sriov.h
+++ b/drivers/net/ethernet/intel/ice/ice_sriov.h
@@ -13,9 +13,6 @@
  */
 #define ICE_MAX_MACADDR_PER_VF		18
 
-/* Malicious Driver Detection */
-#define ICE_MDD_EVENTS_THRESHOLD		30
-
 /* Static VF transaction/status register def */
 #define VF_DEVICE_STATUS		0xAA
 #define VF_TRANS_PENDING_M		0x20
@@ -28,7 +25,6 @@
 #define ICE_MAX_VF_COUNT		256
 #define ICE_MIN_QS_PER_VF		1
 #define ICE_NONQ_VECS_VF		1
-#define ICE_MAX_SCATTER_QS_PER_VF	16
 #define ICE_MAX_RSS_QS_PER_VF		16
 #define ICE_NUM_VF_MSIX_MED		17
 #define ICE_NUM_VF_MSIX_SMALL		5
@@ -95,8 +91,7 @@ enum ice_vf_states {
 
 /* VF capabilities */
 enum ice_virtchnl_cap {
-	ICE_VIRTCHNL_VF_CAP_L2 = 0,
-	ICE_VIRTCHNL_VF_CAP_PRIVILEGE,
+	ICE_VIRTCHNL_VF_CAP_PRIVILEGE = 0,
 };
 
 struct ice_time_mac {
-- 
2.35.1.129.gb80121027d12

