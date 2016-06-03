From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri,  3 Jun 2016 15:42:16 -0700
Subject: [Intel-wired-lan] [PATCH v1 06/18] fm10k: perform data path reset
	even when switch is not ready
In-Reply-To: <20160603224228.10192-1-jacob.e.keller@intel.com>
References: <20160603224228.10192-1-jacob.e.keller@intel.com>
Message-ID: <20160603224228.10192-7-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

A while ago, an additional check for the switch being ready was added to
reset_hw. A recent refactor accidentally made this check return an error
code on failure which caused fm10k_probe to fail when the switch wasn't
brought up first. The original reasoning for the check was to prevent
additional data path reset when the fabric wasn't ready yet. However,
there isn't a compelling reason to keep the check, as the data path
reset will restore hardware to a known good state. Remove the check and
perform the data path reset regardless of the switch manager state.

An alternative fix is to return FM10K_SUCCESS instead, and bypass the
actual data path reset. This should be fine as we will perform
a reset_hw once the switch is active. However, since data path reset
will reset many parts of the hardware it seems better to just perform
the reset regardless of switch state.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_pf.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pf.c b/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
index 7fbd94ba6745..23f3566b17fc 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
@@ -63,11 +63,6 @@ static s32 fm10k_reset_hw_pf(struct fm10k_hw *hw)
 	if (reg & (FM10K_DMA_CTRL_TX_ACTIVE | FM10K_DMA_CTRL_RX_ACTIVE))
 		return FM10K_ERR_DMA_PENDING;
 
-	/* verify the switch is ready for reset */
-	reg = fm10k_read_reg(hw, FM10K_DMA_CTRL2);
-	if (!(reg & FM10K_DMA_CTRL2_SWITCH_READY))
-		return FM10K_ERR_DMA_PENDING;
-
 force_reset:
 	/* Inititate data path reset */
 	reg = FM10K_DMA_CTRL_DATAPATH_RESET;
-- 
2.8.2.820.gd1c5f70

