From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 10 Feb 2016 14:45:46 -0800
Subject: [Intel-wired-lan] [PATCH 1/6] fm10k: Avoid crashing the kernel
Message-ID: <1455144351-14758-1-git-send-email-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bruce Allan <bruce.w.allan@intel.com>

Use BUILD_BUG_ON() instead of BUG_ON() where appropriate to get a compile
error rather than crash the kernel.

Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
---
This is a direct copy of a patch from our out-of-tree driver written
by Bruce, hence the authorship and signed-off-by line.

 drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c b/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
index fecc51aeb6c7..7a959713daa3 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
@@ -468,7 +468,7 @@ static void fm10k_get_reg_q(struct fm10k_hw *hw, u32 *buff, int i)
 	buff[idx++] = fm10k_read_reg(hw, FM10K_TX_SGLORT(i));
 	buff[idx++] = fm10k_read_reg(hw, FM10K_PFVTCTL(i));
 
-	BUG_ON(idx != FM10K_REGS_LEN_Q);
+	BUILD_BUG_ON(idx != FM10K_REGS_LEN_Q);
 }
 
 /* If function above adds more registers this define needs to be updated */
@@ -484,7 +484,7 @@ static void fm10k_get_reg_vsi(struct fm10k_hw *hw, u32 *buff, int i)
 	for (j = 0; j < 32; j++)
 		buff[idx++] = fm10k_read_reg(hw, FM10K_RETA(i, j));
 
-	BUG_ON(idx != FM10K_REGS_LEN_VSI);
+	BUILD_BUG_ON(idx != FM10K_REGS_LEN_VSI);
 }
 
 static void fm10k_get_regs(struct net_device *netdev,
-- 
2.7.0.236.gda096a0.dirty

