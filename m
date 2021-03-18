From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Thu, 18 Mar 2021 15:18:44 -0700
Subject: [Intel-wired-lan] [PATCH net-next dev-queue v1 2/2] intel: fix
 recently introduced warnings
In-Reply-To: <20210318221844.1795558-1-jesse.brandeburg@intel.com>
References: <20210318221844.1795558-1-jesse.brandeburg@intel.com>
Message-ID: <20210318221844.1795558-2-jesse.brandeburg@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch shows the warnings introduced between
git log --oneline net-next...dev-queue

It is likely these should all be fixed on dev-queue before the
patches are sent.

make W=1 M=`pwd`/drivers/net/ethernet/intel

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_fdir.c             | 2 +-
 drivers/net/ethernet/intel/ice/ice_virtchnl_allowlist.c | 4 ++--
 drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c      | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_fdir.c b/drivers/net/ethernet/intel/iavf/iavf_fdir.c
index 2a355cd6e7c8..3e687189d737 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_fdir.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_fdir.c
@@ -734,7 +734,7 @@ bool iavf_fdir_is_dup_fltr(struct iavf_adapter *adapter, struct iavf_fdir_fltr *
 }
 
 /**
- * iavf_fdir_fltr - find filter with location
+ * iavf_find_fdir_fltr_by_loc - find filter with location
  * @adapter: pointer to the VF adapter structure
  * @loc: location to find.
  *
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_allowlist.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_allowlist.c
index 64b1314d4761..58d395db4219 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_allowlist.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_allowlist.c
@@ -86,7 +86,7 @@ static const struct allowlist_opcode_info allowlist_opcodes[] = {
 };
 
 /**
- * ice_vc_opcode_is_allowed - check if this opcode is allowed on this VF
+ * ice_vc_is_opcode_allowed - check if this opcode is allowed on this VF
  * @vf: pointer to VF structure
  * @opcode: virtchnl opcode
  *
@@ -151,7 +151,7 @@ void ice_vc_set_working_allowlist(struct ice_vf *vf)
 }
 
 /**
- * ice_vc_set_allowlist_based_on_caps - allowlist VF opcodes according caps
+ * ice_vc_set_caps_allowlist - allowlist VF opcodes according caps
  * @vf: pointer to VF structure
  */
 void ice_vc_set_caps_allowlist(struct ice_vf *vf)
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
index eb10ca79a42a..9ffe7ba865ee 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
@@ -513,7 +513,7 @@ ice_vc_fdir_set_flow_fld(struct ice_vf *vf, struct virtchnl_fdir_add *fltr,
 }
 
 /**
- * ice_vc_fdir_set_flow_fld - config the flow's packet segment header
+ * ice_vc_fdir_set_flow_hdr - config the flow's packet segment header
  * @vf: pointer to the VF structure
  * @conf: FDIR configuration for each filter
  * @seg: array of one or more packet segments that describe the flow
-- 
2.30.2

