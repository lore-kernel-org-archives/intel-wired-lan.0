From: Alice Michael <alice.michael@intel.com>
Date: Tue, 14 Nov 2017 07:00:46 -0500
Subject: [Intel-wired-lan] [next PATCH S82-V4 3/9] i40evf: Drop
 i40evf_fire_sw_int as it is prone to races
In-Reply-To: <20171114120052.86665-1-alice.michael@intel.com>
References: <20171114120052.86665-1-alice.michael@intel.com>
Message-ID: <20171114120052.86665-3-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alexander Duyck <alexander.h.duyck@intel.com>

Having the interrupts firing while we are polling causes extra overhead and
isn't needed for most systems out there. If an interrupt is lost us
experiencing a 2s latency spike before recovering is still not acceptable
and masks the issue. We are better off just identifying systems that lose
interrupts and instead enable workarounds for those systems.

To that end I am dropping the code that was strobing the interrupts as
there is a narrow window where having them enabled can actually cause
race issues anyway where a few stray packets might get misses if the
interrupt is re-enabled and fires before we call napi_complete.

Also replace one line where we were using bit 31 instead of the define
for the bit to represent masking the interrupt enable bit.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
---
 drivers/net/ethernet/intel/i40evf/i40evf_main.c | 34 -------------------------
 1 file changed, 34 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index 4dd3149..5e27619 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -282,33 +282,6 @@ void i40evf_irq_enable_queues(struct i40evf_adapter *adapter, u32 mask)
 }
 
 /**
- * i40evf_fire_sw_int - Generate SW interrupt for specified vectors
- * @adapter: board private structure
- * @mask: bitmap of vectors to trigger
- **/
-static void i40evf_fire_sw_int(struct i40evf_adapter *adapter, u32 mask)
-{
-	struct i40e_hw *hw = &adapter->hw;
-	int i;
-	u32 dyn_ctl;
-
-	if (mask & 1) {
-		dyn_ctl = rd32(hw, I40E_VFINT_DYN_CTL01);
-		dyn_ctl |= I40E_VFINT_DYN_CTLN1_SWINT_TRIG_MASK |
-			   I40E_VFINT_DYN_CTLN1_ITR_INDX_MASK;
-		wr32(hw, I40E_VFINT_DYN_CTL01, dyn_ctl);
-	}
-	for (i = 1; i < adapter->num_msix_vectors; i++) {
-		if (mask & BIT(i)) {
-			dyn_ctl = rd32(hw, I40E_VFINT_DYN_CTLN1(i - 1));
-			dyn_ctl |= I40E_VFINT_DYN_CTLN1_SWINT_TRIG_MASK |
-				   I40E_VFINT_DYN_CTLN1_ITR_INDX_MASK;
-			wr32(hw, I40E_VFINT_DYN_CTLN1(i - 1), dyn_ctl);
-		}
-	}
-}
-
-/**
  * i40evf_irq_enable - Enable default interrupt generation settings
  * @adapter: board private structure
  * @flush: boolean value whether to run rd32()
@@ -1743,13 +1716,6 @@ static void i40evf_watchdog_task(struct work_struct *work)
 	if (adapter->state == __I40EVF_RUNNING)
 		i40evf_request_stats(adapter);
 watchdog_done:
-	if (adapter->state == __I40EVF_RUNNING) {
-		i40evf_irq_enable_queues(adapter, ~0);
-		i40evf_fire_sw_int(adapter, 0xFF);
-	} else {
-		i40evf_fire_sw_int(adapter, 0x1);
-	}
-
 	clear_bit(__I40EVF_IN_CRITICAL_TASK, &adapter->crit_section);
 restart_watchdog:
 	if (adapter->state == __I40EVF_REMOVE)
-- 
2.9.5

