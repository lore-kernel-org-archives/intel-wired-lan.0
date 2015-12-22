From: Bruce Allan <bruce.w.allan@intel.com>
Date: Tue, 22 Dec 2015 14:10:12 -0800
Subject: [Intel-wired-lan] [next-queue PATCH] fm10k: Avoid crashing the
	kernel
Message-ID: <20151222221012.91665.98612.stgit@bwallan-cwp1.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Use BUILD_BUG_ON() instead of BUG_ON() where appropriate to get a compile
error rather than crash the kernel.

Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c b/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
index 28837ae..6a9f988 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
@@ -398,7 +398,7 @@ static void fm10k_get_reg_q(struct fm10k_hw *hw, u32 *buff, int i)
 	buff[idx++] = fm10k_read_reg(hw, FM10K_TX_SGLORT(i));
 	buff[idx++] = fm10k_read_reg(hw, FM10K_PFVTCTL(i));
 
-	BUG_ON(idx != FM10K_REGS_LEN_Q);
+	BUILD_BUG_ON(idx != FM10K_REGS_LEN_Q);
 }
 
 /* If function above adds more registers this define needs to be updated */
@@ -414,7 +414,7 @@ static void fm10k_get_reg_vsi(struct fm10k_hw *hw, u32 *buff, int i)
 	for (j = 0; j < 32; j++)
 		buff[idx++] = fm10k_read_reg(hw, FM10K_RETA(i, j));
 
-	BUG_ON(idx != FM10K_REGS_LEN_VSI);
+	BUILD_BUG_ON(idx != FM10K_REGS_LEN_VSI);
 }
 
 static void fm10k_get_regs(struct net_device *netdev,

