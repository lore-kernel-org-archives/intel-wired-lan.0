From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Tue, 19 Feb 2019 15:04:09 -0800
Subject: [Intel-wired-lan] [PATCH S15 09/14] ice: Update function header for
 __ice_vsi_get_qs
In-Reply-To: <20190219230414.25627-1-anirudh.venkataramanan@intel.com>
References: <20190219230414.25627-1-anirudh.venkataramanan@intel.com>
Message-ID: <20190219230414.25627-10-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Remove some redundant text in the function header for __ice_vsi_get_qs

Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 484c9bfd39ba..f248d08425e2 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -617,11 +617,10 @@ static int __ice_vsi_get_qs_sc(struct ice_qs_cfg *qs_cfg)
 
 /**
  * __ice_vsi_get_qs - helper function for assigning queues from PF to VSI
- * @qs_cfg: gathered variables needed for PF->VSI queues assignment
+ * @qs_cfg: gathered variables needed for pf->vsi queues assignment
  *
- * This is an internal function for assigning queues from the PF to VSI and
- * initially tries to find contiguous space.  If it is not successful to find
- * contiguous space, then it tries with the scatter approach.
+ * This function first tries to find contiguous space. If it is not successful,
+ * it tries with the scatter approach.
  *
  * Return 0 on success and -ENOMEM in case of no left space in PF queue bitmap
  */
-- 
2.14.5

