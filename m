From: Alice Michael <alice.michael@intel.com>
Date: Tue, 14 Nov 2017 07:00:44 -0500
Subject: [Intel-wired-lan] [next PATCH S82-V4 1/9] i40evf: Do not clear
 MSI-X PBA manually
Message-ID: <20171114120052.86665-1-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alexander Duyck <alexander.h.duyck@intel.com>

We should not be clearing the pending bit array for each vector manually.
The documentation for the hardware states that when in MSI-X mode the
pending bit array wil be cleared automatically. Us clearing it ourselves
just results in multiple opportunities for us to drop an interrupt.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
---
 drivers/net/ethernet/intel/i40evf/i40evf_main.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index 75dc94f..4dd3149 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -276,8 +276,7 @@ void i40evf_irq_enable_queues(struct i40evf_adapter *adapter, u32 mask)
 		if (mask & BIT(i - 1)) {
 			wr32(hw, I40E_VFINT_DYN_CTLN1(i - 1),
 			     I40E_VFINT_DYN_CTLN1_INTENA_MASK |
-			     I40E_VFINT_DYN_CTLN1_ITR_INDX_MASK |
-			     I40E_VFINT_DYN_CTLN1_CLEARPBA_MASK);
+			     I40E_VFINT_DYN_CTLN1_ITR_INDX_MASK);
 		}
 	}
 }
@@ -296,16 +295,14 @@ static void i40evf_fire_sw_int(struct i40evf_adapter *adapter, u32 mask)
 	if (mask & 1) {
 		dyn_ctl = rd32(hw, I40E_VFINT_DYN_CTL01);
 		dyn_ctl |= I40E_VFINT_DYN_CTLN1_SWINT_TRIG_MASK |
-			   I40E_VFINT_DYN_CTLN1_ITR_INDX_MASK |
-			   I40E_VFINT_DYN_CTLN1_CLEARPBA_MASK;
+			   I40E_VFINT_DYN_CTLN1_ITR_INDX_MASK;
 		wr32(hw, I40E_VFINT_DYN_CTL01, dyn_ctl);
 	}
 	for (i = 1; i < adapter->num_msix_vectors; i++) {
 		if (mask & BIT(i)) {
 			dyn_ctl = rd32(hw, I40E_VFINT_DYN_CTLN1(i - 1));
 			dyn_ctl |= I40E_VFINT_DYN_CTLN1_SWINT_TRIG_MASK |
-				   I40E_VFINT_DYN_CTLN1_ITR_INDX_MASK |
-				   I40E_VFINT_DYN_CTLN1_CLEARPBA_MASK;
+				   I40E_VFINT_DYN_CTLN1_ITR_INDX_MASK;
 			wr32(hw, I40E_VFINT_DYN_CTLN1(i - 1), dyn_ctl);
 		}
 	}
@@ -337,15 +334,10 @@ static irqreturn_t i40evf_msix_aq(int irq, void *data)
 	struct net_device *netdev = data;
 	struct i40evf_adapter *adapter = netdev_priv(netdev);
 	struct i40e_hw *hw = &adapter->hw;
-	u32 val;
 
 	/* handle non-queue interrupts, these reads clear the registers */
-	val = rd32(hw, I40E_VFINT_ICR01);
-	val = rd32(hw, I40E_VFINT_ICR0_ENA1);
-
-	val = rd32(hw, I40E_VFINT_DYN_CTL01) |
-	      I40E_VFINT_DYN_CTL01_CLEARPBA_MASK;
-	wr32(hw, I40E_VFINT_DYN_CTL01, val);
+	rd32(hw, I40E_VFINT_ICR01);
+	rd32(hw, I40E_VFINT_ICR0_ENA1);
 
 	/* schedule work on the private workqueue */
 	schedule_work(&adapter->adminq_task);
-- 
2.9.5

