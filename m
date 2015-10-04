From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Sun,  4 Oct 2015 01:09:49 -0700
Subject: [Intel-wired-lan] [PATCH v2] i40evf: fix compiler warning of unused
	variable
Message-ID: <1443946189-8543-1-git-send-email-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

Compiler complained of an unused variable, which the driver was just
using to store the result of a rd32 which is used to clear a register
unconditionally.  Just drop the unused variable and re-use one.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
v2: Fix title since Jesse used the same title for two difference patches

 drivers/net/ethernet/intel/i40evf/i40evf_main.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index e5e132a..3abd36d 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -305,12 +305,10 @@ static irqreturn_t i40evf_msix_aq(int irq, void *data)
 	struct i40evf_adapter *adapter = netdev_priv(netdev);
 	struct i40e_hw *hw = &adapter->hw;
 	u32 val;
-	u32 ena_mask;
 
-	/* handle non-queue interrupts */
+	/* handle non-queue interrupts, these reads clear the registers */
 	val = rd32(hw, I40E_VFINT_ICR01);
-	ena_mask = rd32(hw, I40E_VFINT_ICR0_ENA1);
-
+	val = rd32(hw, I40E_VFINT_ICR0_ENA1);
 
 	val = rd32(hw, I40E_VFINT_DYN_CTL01);
 	val = val | I40E_VFINT_DYN_CTL01_CLEARPBA_MASK;
-- 
2.4.3

