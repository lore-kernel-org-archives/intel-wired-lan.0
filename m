From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Thu, 25 Mar 2021 17:38:26 -0700
Subject: [Intel-wired-lan] [PATCH net-next v2 03/11] fm10k: move error check
In-Reply-To: <20210326003834.3886241-1-jesse.brandeburg@intel.com>
References: <20210326003834.3886241-1-jesse.brandeburg@intel.com>
Message-ID: <20210326003834.3886241-4-jesse.brandeburg@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The error check and set_bit are placed in such a way that sparse (C=2)
warns:
.../fm10k_pci.c:1395:9: warning: context imbalance in 'fm10k_msix_mbx_pf' - different lock contexts for basic block

Which seems a little odd, but the code can obviously be moved
to where the variable is being set without changing functionality
at all, and it even seems to make a bit more sense with the check
closer to the set.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
index 9e3103fae723..dbcae92bb18d 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
@@ -1370,7 +1370,6 @@ static irqreturn_t fm10k_msix_mbx_pf(int __always_unused irq, void *data)
 	struct fm10k_hw *hw = &interface->hw;
 	struct fm10k_mbx_info *mbx = &hw->mbx;
 	u32 eicr;
-	s32 err = 0;
 
 	/* unmask any set bits related to this interrupt */
 	eicr = fm10k_read_reg(hw, FM10K_EICR);
@@ -1386,15 +1385,16 @@ static irqreturn_t fm10k_msix_mbx_pf(int __always_unused irq, void *data)
 
 	/* service mailboxes */
 	if (fm10k_mbx_trylock(interface)) {
-		err = mbx->ops.process(hw, mbx);
+		s32 err = mbx->ops.process(hw, mbx);
+
+		if (err == FM10K_ERR_RESET_REQUESTED)
+			set_bit(FM10K_FLAG_RESET_REQUESTED, interface->flags);
+
 		/* handle VFLRE events */
 		fm10k_iov_event(interface);
 		fm10k_mbx_unlock(interface);
 	}
 
-	if (err == FM10K_ERR_RESET_REQUESTED)
-		set_bit(FM10K_FLAG_RESET_REQUESTED, interface->flags);
-
 	/* if switch toggled state we should reset GLORTs */
 	if (eicr & FM10K_EICR_SWITCHNOTREADY) {
 		/* force link down for at least 4 seconds */
-- 
2.30.2

