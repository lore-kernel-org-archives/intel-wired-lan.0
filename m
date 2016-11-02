From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed,  2 Nov 2016 16:44:47 -0700
Subject: [Intel-wired-lan] [PATCH 4/4] fm10k: do not clear global mailbox
	interrupt bits
In-Reply-To: <20161102234447.17181-1-jacob.e.keller@intel.com>
References: <20161102234447.17181-1-jacob.e.keller@intel.com>
Message-ID: <20161102234447.17181-4-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Ngai-Mint Kwan <ngai-mint.kwan@intel.com>

Partially revert commit 5e93cbadd3e9 ("fm10k: Reset mailbox global
interrupts", 2016-06-07)

The register bits related to this commit are now solely being handled by
the IES API. Recent changes in the IES API will allow an automatic
recovery from improper handling of these bits.

Signed-off-by: Ngai-Mint Kwan <ngai-mint.kwan@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_pf.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pf.c b/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
index 23fb319fd2a0..40ee0242a80a 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
@@ -72,10 +72,6 @@ static s32 fm10k_reset_hw_pf(struct fm10k_hw *hw)
 	fm10k_write_flush(hw);
 	udelay(FM10K_RESET_TIMEOUT);
 
-	/* Reset mailbox global interrupts */
-	reg = FM10K_MBX_GLOBAL_REQ_INTERRUPT | FM10K_MBX_GLOBAL_ACK_INTERRUPT;
-	fm10k_write_reg(hw, FM10K_GMBX, reg);
-
 	/* Verify we made it out of reset */
 	reg = fm10k_read_reg(hw, FM10K_IP);
 	if (!(reg & FM10K_IP_NOTINRESET))
-- 
2.10.1.777.gd068e6b

