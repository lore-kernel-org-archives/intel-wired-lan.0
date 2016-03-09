From: Bruce Allan <bruce.w.allan@intel.com>
Date: Wed, 09 Mar 2016 12:26:18 -0800
Subject: [Intel-wired-lan] [next-queue PATCH v3] fm10k: Avoid crashing the
	kernel
Message-ID: <20160309202557.137597.51678.stgit@bwallan-cwp1.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Use BUILD_BUG_ON() instead of BUG_ON() where appropriate to get a compile
error rather than crash the kernel.

Unfortunately, BUILD_BUG_ON() cannot be used to replace the second instance
of BUG_ON() as it will generate a compiletime assert when the compiler flag
-fsanitize=signed-integer-overflow is used (e.g. when UBSAN is enabled).
Instead, put in additional checks to prevent buffer overflow from occuring
and WARN if the code is ever mistakenly changed to get additional register
values without also updating the value of FM10K_REGS_LEN_VSI.

Also, replace associated magic numbers with existing defined constants and
correct an applicable comment.

Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
---
v3: changes described in 2nd and 3rd paragraphs in updated description
 drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c |   22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c b/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
index c8ee3b5..6952ce2 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
@@ -352,23 +352,27 @@ static void fm10k_get_reg_q(struct fm10k_hw *hw, u32 *buff, int i)
 	buff[idx++] = fm10k_read_reg(hw, FM10K_TX_SGLORT(i));
 	buff[idx++] = fm10k_read_reg(hw, FM10K_PFVTCTL(i));
 
-	BUG_ON(idx != FM10K_REGS_LEN_Q);
+	BUILD_BUG_ON(idx != FM10K_REGS_LEN_Q);
 }
 
-/* If function above adds more registers this define needs to be updated */
-#define FM10K_REGS_LEN_VSI 43
+/* If function below adds more registers this define needs to be updated */
+#define FM10K_REGS_LEN_VSI (1 + FM10K_RSSRK_SIZE + FM10K_RETA_SIZE)
 
 static void fm10k_get_reg_vsi(struct fm10k_hw *hw, u32 *buff, int i)
 {
 	int idx = 0, j;
 
 	buff[idx++] = fm10k_read_reg(hw, FM10K_MRQC(i));
-	for (j = 0; j < 10; j++)
-		buff[idx++] = fm10k_read_reg(hw, FM10K_RSSRK(i, j));
-	for (j = 0; j < 32; j++)
-		buff[idx++] = fm10k_read_reg(hw, FM10K_RETA(i, j));
-
-	BUG_ON(idx != FM10K_REGS_LEN_VSI);
+	for (j = 0; j < FM10K_RSSRK_SIZE; j++, idx++)
+		if (idx < FM10K_REGS_LEN_VSI)
+			buff[idx] = fm10k_read_reg(hw, FM10K_RSSRK(i, j));
+	for (j = 0; j < FM10K_RETA_SIZE; j++, idx++)
+		if (idx < FM10K_REGS_LEN_VSI)
+			buff[idx] = fm10k_read_reg(hw, FM10K_RETA(i, j));
+
+	WARN_ONCE(idx != FM10K_REGS_LEN_VSI,
+		  "Incorrect value for FM10K_REGS_LEN_VSI (expected %d, got %d)\n",
+		  idx, FM10K_REGS_LEN_VSI);
 }
 
 static void fm10k_get_regs(struct net_device *netdev,

