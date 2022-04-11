From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 11 Apr 2022 16:29:07 -0700
Subject: [Intel-wired-lan] [PATCH net-next 6/6] ice: remove period on
 argument description in ice_for_each_vf
In-Reply-To: <20220411232907.1022602-1-jacob.e.keller@intel.com>
References: <20220411232907.1022602-1-jacob.e.keller@intel.com>
Message-ID: <20220411232907.1022602-7-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The ice_for_each_vf macros have comments describing the implementation.
One of the arguments has a period on the end, which is not our typical
style. Remove the unnecessary period.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_vf_lib.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.h b/drivers/net/ethernet/intel/ice/ice_vf_lib.h
index 831b667dc5b2..1b4380d6d949 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.h
@@ -176,7 +176,7 @@ static inline u16 ice_vf_get_port_vlan_tpid(struct ice_vf *vf)
  * ice_for_each_vf - Iterate over each VF entry
  * @pf: pointer to the PF private structure
  * @bkt: bucket index used for iteration
- * @vf: pointer to the VF entry currently being processed in the loop.
+ * @vf: pointer to the VF entry currently being processed in the loop
  *
  * The bkt variable is an unsigned integer iterator used to traverse the VF
  * entries. It is *not* guaranteed to be the VF's vf_id. Do not assume it is.
@@ -192,7 +192,7 @@ static inline u16 ice_vf_get_port_vlan_tpid(struct ice_vf *vf)
  * ice_for_each_vf_rcu - Iterate over each VF entry protected by RCU
  * @pf: pointer to the PF private structure
  * @bkt: bucket index used for iteration
- * @vf: pointer to the VF entry currently being processed in the loop.
+ * @vf: pointer to the VF entry currently being processed in the loop
  *
  * The bkt variable is an unsigned integer iterator used to traverse the VF
  * entries. It is *not* guaranteed to be the VF's vf_id. Do not assume it is.
-- 
2.35.1.456.ga9c7032d4631

