From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 16 Feb 2016 16:19:25 -0800
Subject: [Intel-wired-lan] [PATCH 2/2] fm10k: Avoid crashing the kernel
In-Reply-To: <1455668365-30782-1-git-send-email-jacob.e.keller@intel.com>
References: <1455668365-30782-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <1455668365-30782-2-git-send-email-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Use BUILD_BUG_ON() instead of BUG_ON() where appropriate to get a compile
error rather than crash the kernel.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
I checked this works against allmodconfig, and defconfig. Note that
only allmodconfig seems to break the use of BUILD_BUG_ON in the latter
case, so I added a comment to indicate this. Sorry for the failures
earlier.

 drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c b/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
index a1342be34be4..0b0531417835 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
@@ -468,7 +468,7 @@ static void fm10k_get_reg_q(struct fm10k_hw *hw, u32 *buff, int i)
 	buff[idx++] = fm10k_read_reg(hw, FM10K_TX_SGLORT(i));
 	buff[idx++] = fm10k_read_reg(hw, FM10K_PFVTCTL(i));
 
-	BUG_ON(idx != FM10K_REGS_LEN_Q);
+	BUILD_BUG_ON(idx != FM10K_REGS_LEN_Q);
 }
 
 /* If function above adds more registers this define needs to be updated */
@@ -484,6 +484,9 @@ static void fm10k_get_reg_vsi(struct fm10k_hw *hw, u32 *buff, int i)
 	for (j = 0; j < 32; j++)
 		buff[idx++] = fm10k_read_reg(hw, FM10K_RETA(i, j));
 
+	/* Unfortunately some kernel configurations prevent us from using
+	 * BUILD_BUG_ON here, notably allmodconfig.
+	 */
 	BUG_ON(idx != FM10K_REGS_LEN_VSI);
 }
 
-- 
2.7.0.236.gda096a0.dirty

