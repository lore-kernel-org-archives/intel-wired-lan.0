From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri,  1 Apr 2016 16:17:38 -0700
Subject: [Intel-wired-lan] [PATCH v1 8/9] fm10k: update comment regarding
	reserved bits check
In-Reply-To: <1459552659-22959-1-git-send-email-jacob.e.keller@intel.com>
References: <1459552659-22959-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <1459552659-22959-9-git-send-email-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The original comment may be read incorrectly as referring to checking
the *entire* length is zero. However, it merely checks only the reserved
bits of both length and reserved in a small amount of code. Update the
comment to indicate this is a clever trick and clearly spell out that it
only checks the reserve bits.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_vf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_vf.c b/drivers/net/ethernet/intel/fm10k/fm10k_vf.c
index 801238dec624..0440706eeb82 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_vf.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_vf.c
@@ -188,7 +188,7 @@ static s32 fm10k_update_vlan_vf(struct fm10k_hw *hw, u32 vid, u8 vsi, bool set)
 	if (vsi)
 		return FM10K_ERR_PARAM;
 
-	/* verify upper 4 bits of vid and length are 0 */
+	/* clever trick to verify reserved bits in both vid and length */
 	if ((vid << 16 | vid) >> 28)
 		return FM10K_ERR_PARAM;
 
-- 
2.8.0.rc1.177.g5628860

