From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Wed,  6 Dec 2017 09:25:14 -0800
Subject: [Intel-wired-lan] [PATCH 5/6] fm10k: correct typo in fm10k_pf.c
In-Reply-To: <20171206172515.37577-1-jeffrey.t.kirsher@intel.com>
References: <20171206172515.37577-1-jeffrey.t.kirsher@intel.com>
Message-ID: <20171206172515.37577-5-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Ngai-Mint Kwan <ngai-mint.kwan@intel.com>

Signed-off-by: Ngai-Mint Kwan <ngai-mint.kwan@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_pf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pf.c b/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
index 425d814aed4d..d6406fc31ffb 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
@@ -866,7 +866,7 @@ static s32 fm10k_iov_assign_default_mac_vlan_pf(struct fm10k_hw *hw,
 	/* Determine correct default VLAN ID. The FM10K_VLAN_OVERRIDE bit is
 	 * used here to indicate to the VF that it will not have privilege to
 	 * write VLAN_TABLE. All policy is enforced on the PF but this allows
-	 * the VF to correctly report errors to userspace rqeuests.
+	 * the VF to correctly report errors to userspace requests.
 	 */
 	if (vf_info->pf_vid)
 		vf_vid = vf_info->pf_vid | FM10K_VLAN_OVERRIDE;
-- 
2.15.0

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan at osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan

