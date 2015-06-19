From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri, 19 Jun 2015 16:37:38 -0700
Subject: [Intel-wired-lan] [net-next 09/10] fm10k: Only trigger data path
	reset if fabric is up
In-Reply-To: <1434757059-3384-1-git-send-email-jacob.e.keller@intel.com>
References: <1434757059-3384-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <1434757059-3384-9-git-send-email-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alexander Duyck <alexander.h.duyck@intel.com>

This change makes it so that we only trigger the data path reset if the
fabric is ready to handle traffic.  The general idea is to avoid
triggering the reset unless the switch API is ready for us.  Otherwise
we can just postpone the reset until we receive a switch ready
notification.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_pf.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pf.c b/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
index 241b969626bc..d806d87a6192 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
@@ -59,6 +59,11 @@ static s32 fm10k_reset_hw_pf(struct fm10k_hw *hw)
 	if (reg & (FM10K_DMA_CTRL_TX_ACTIVE | FM10K_DMA_CTRL_RX_ACTIVE))
 		return FM10K_ERR_DMA_PENDING;
 
+	/* verify the switch is ready for reset */
+	reg = fm10k_read_reg(hw, FM10K_DMA_CTRL2);
+	if (!(reg & FM10K_DMA_CTRL2_SWITCH_READY))
+		goto out;
+
 	/* Inititate data path reset */
 	reg |= FM10K_DMA_CTRL_DATAPATH_RESET;
 	fm10k_write_reg(hw, FM10K_DMA_CTRL, reg);
@@ -72,6 +77,7 @@ static s32 fm10k_reset_hw_pf(struct fm10k_hw *hw)
 	if (!(reg & FM10K_IP_NOTINRESET))
 		err = FM10K_ERR_RESET_FAILED;
 
+out:
 	return err;
 }
 
-- 
2.4.3

