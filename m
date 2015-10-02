From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Fri, 02 Oct 2015 06:13:20 -0000
Subject: [Intel-wired-lan] [next PATCH v2 1/2] i40evf: fix overlong BIT
	defines
In-Reply-To: <1442455270-6681-2-git-send-email-jesse.brandeburg@intel.com>
References: <1442455270-6681-1-git-send-email-jesse.brandeburg@intel.com>
 <1442455270-6681-2-git-send-email-jesse.brandeburg@intel.com>
Message-ID: <1442455270-6681-3-git-send-email-jesse.brandeburg@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Compiler complained of an unused variable, which the driver was just
using to store the result of a rd32 which is used to clear a register
unconditionally.  Just drop the unused variable and re-use one.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
 drivers/net/ethernet/intel/i40evf/i40evf_main.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index 429a46c..eb9a32b 100644
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
2.1.0


