From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed,  3 Aug 2016 15:05:27 -0700
Subject: [Intel-wired-lan] [PATCH v1 1/2] fm10k: don't clear the RXQCTL
	register when enabling or disabling queues
Message-ID: <20160803220528.26222-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Ensure that other bits in the RXQCTL register do not get cleared. This
ensures that bits related to queue ownership are maintained.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
index 59dc13f3f321..eea411472f1d 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
@@ -734,15 +734,15 @@ static void fm10k_configure_rx_ring(struct fm10k_intfc *interface,
 	u64 rdba = ring->dma;
 	struct fm10k_hw *hw = &interface->hw;
 	u32 size = ring->count * sizeof(union fm10k_rx_desc);
-	u32 rxqctl = FM10K_RXQCTL_ENABLE | FM10K_RXQCTL_PF;
-	u32 rxdctl = FM10K_RXDCTL_WRITE_BACK_MIN_DELAY;
+	u32 rxqctl, rxdctl = FM10K_RXDCTL_WRITE_BACK_MIN_DELAY;
 	u32 srrctl = FM10K_SRRCTL_BUFFER_CHAINING_EN;
 	u32 rxint = FM10K_INT_MAP_DISABLE;
 	u8 rx_pause = interface->rx_pause;
 	u8 reg_idx = ring->reg_idx;
 
 	/* disable queue to avoid issues while updating state */
-	fm10k_write_reg(hw, FM10K_RXQCTL(reg_idx), 0);
+	rxqctl = fm10k_read_reg(hw, FM10K_RXQCTL(reg_idx));
+	rxqctl &= ~FM10K_RXQCTL_ENABLE;
 	fm10k_write_flush(hw);
 
 	/* possible poll here to verify ring resources have been cleaned */
@@ -797,6 +797,8 @@ static void fm10k_configure_rx_ring(struct fm10k_intfc *interface,
 	fm10k_write_reg(hw, FM10K_RXINT(reg_idx), rxint);
 
 	/* enable queue */
+	rxqctl = fm10k_read_reg(hw, FM10K_RXQCTL(reg_idx));
+	rxqctl |= FM10K_RXQCTL_ENABLE;
 	fm10k_write_reg(hw, FM10K_RXQCTL(reg_idx), rxqctl);
 
 	/* place buffers on ring for receive data */
-- 
2.9.2.701.gf965a18

