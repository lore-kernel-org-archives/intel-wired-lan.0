From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 12 Jan 2017 15:59:42 -0800
Subject: [Intel-wired-lan] [PATCH 5/5] fm10k: disable receive queue when
	configuring ring
In-Reply-To: <20170112235942.5767-1-jacob.e.keller@intel.com>
References: <20170112235942.5767-1-jacob.e.keller@intel.com>
Message-ID: <20170112235942.5767-5-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Ngai-Mint Kwan <ngai-mint.kwan@intel.com>

Write to RXQCTL register to disable the receive queue when configuring
the RX ring.

Signed-off-by: Ngai-Mint Kwan <ngai-mint.kwan@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
index 57ed2a98c6ab..d6943cd9e85a 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
@@ -753,6 +753,7 @@ static void fm10k_configure_rx_ring(struct fm10k_intfc *interface,
 	/* disable queue to avoid issues while updating state */
 	rxqctl = fm10k_read_reg(hw, FM10K_RXQCTL(reg_idx));
 	rxqctl &= ~FM10K_RXQCTL_ENABLE;
+	fm10k_write_reg(hw, FM10K_RXQCTL(reg_idx), rxqctl);
 	fm10k_write_flush(hw);
 
 	/* possible poll here to verify ring resources have been cleaned */
-- 
2.11.0.403.g196674b8396b

