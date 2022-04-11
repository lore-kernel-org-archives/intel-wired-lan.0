From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 11 Apr 2022 16:29:04 -0700
Subject: [Intel-wired-lan] [PATCH net-next 3/6] ice: remove return value
 comment for ice_reset_all_vfs
In-Reply-To: <20220411232907.1022602-1-jacob.e.keller@intel.com>
References: <20220411232907.1022602-1-jacob.e.keller@intel.com>
Message-ID: <20220411232907.1022602-4-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Since commit fe99d1c06c16 ("ice: make ice_reset_all_vfs void"), the
ice_reset_all_vfs function has not returned anything. The function
comment still indicated it did. Fix this.

While here, also add a line to clarify the function resets all VFs at
once in response to hardware resets such as a PF reset.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_vf_lib.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.c b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
index aefd66a4db80..24cf6a5b49fe 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
@@ -359,12 +359,12 @@ ice_vf_clear_vsi_promisc(struct ice_vf *vf, struct ice_vsi *vsi, u8 promisc_m)
  * ice_reset_all_vfs - reset all allocated VFs in one go
  * @pf: pointer to the PF structure
  *
+ * Reset all VFs at once, in response to a PF or other device reset.
+ *
  * First, tell the hardware to reset each VF, then do all the waiting in one
  * chunk, and finally finish restoring each VF after the wait. This is useful
  * during PF routines which need to reset all VFs, as otherwise it must perform
  * these resets in a serialized fashion.
- *
- * Returns true if any VFs were reset, and false otherwise.
  */
 void ice_reset_all_vfs(struct ice_pf *pf)
 {
-- 
2.35.1.456.ga9c7032d4631

