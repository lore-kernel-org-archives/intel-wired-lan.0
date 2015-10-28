From: Bruce Allan <bruce.w.allan@intel.com>
Date: Wed, 28 Oct 2015 16:04:40 -0700
Subject: [Intel-wired-lan] [next-queue PATCH] fm10k: do not inline
	fm10k_iov_select_vid()
Message-ID: <20151028230440.10576.56731.stgit@bwallan-cwp1.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The function declaration does not need to be 'inline'd here.

Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_pf.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pf.c b/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
index 02a58bf..b7c2f7e 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
@@ -1179,7 +1179,7 @@ s32 fm10k_iov_msg_msix_pf(struct fm10k_hw *hw, u32 **results,
  * Will report an error if the VLAN ID is out of range. For VID = 0, it will
  * return either the pf_vid or sw_vid depending on which one is set.
  */
-static inline s32 fm10k_iov_select_vid(struct fm10k_vf_info *vf_info, u16 vid)
+static s32 fm10k_iov_select_vid(struct fm10k_vf_info *vf_info, u16 vid)
 {
 	if (!vid)
 		return vf_info->pf_vid ? vf_info->pf_vid : vf_info->sw_vid;

