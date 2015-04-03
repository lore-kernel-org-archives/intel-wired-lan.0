From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Fri,  3 Apr 2015 13:27:04 -0700
Subject: [Intel-wired-lan] [net-next 14/25] fm10k: Set PF queues to
	unlimited bandwidth during virtualization
In-Reply-To: <1428092835-16834-1-git-send-email-jeffrey.t.kirsher@intel.com>
References: <1428092835-16834-1-git-send-email-jeffrey.t.kirsher@intel.com>
Message-ID: <1428092835-16834-14-git-send-email-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

When returning virtualization queues from the VF back to the PF, do not
retain the VF rate limiter.

Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Todd Russell <todd.a.russell@intel.com>
Acked-by: Matthew Vick <matthew.vick@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_pf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pf.c b/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
index 159cd84..a92b58d 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
@@ -676,7 +676,8 @@ static s32 fm10k_iov_assign_resources_pf(struct fm10k_hw *hw, u16 num_vfs,
 	/* loop through unallocated rings assigning them back to PF */
 	for (i = FM10K_MAX_QUEUES_PF; i < vf_q_idx; i++) {
 		fm10k_write_reg(hw, FM10K_TXDCTL(i), 0);
-		fm10k_write_reg(hw, FM10K_TXQCTL(i), FM10K_TXQCTL_PF | vid);
+		fm10k_write_reg(hw, FM10K_TXQCTL(i), FM10K_TXQCTL_PF |
+				FM10K_TXQCTL_UNLIMITED_BW | vid);
 		fm10k_write_reg(hw, FM10K_RXQCTL(i), FM10K_RXQCTL_PF);
 	}
 
-- 
1.9.3

