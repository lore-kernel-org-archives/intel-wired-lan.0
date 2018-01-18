From: Benjamin Poirier <bpoirier@suse.com>
Date: Thu, 18 Jan 2018 15:50:54 +0900
Subject: [Intel-wired-lan] [RFC PATCH] e1000e: Remove Other from EIAC.
Message-ID: <20180118065054.29844-1-bpoirier@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

It was reported that emulated e1000e devices in vmware esxi 6.5 Build
7526125 do not link up after commit 4aea7a5c5e94 ("e1000e: Avoid receiver
overrun interrupt bursts", v4.15-rc1). Some tracing shows that after
e1000e_trigger_lsc() is called, ICR reads out as 0x0 in e1000_msix_other()
on emulated e1000e devices. In comparison, on real e1000e 82574 hardware,
icr=0x80000004 (_INT_ASSERTED | _OTHER) in the same situation.

Some experimentation showed that this flaw in vmware e1000e emulation can
be worked around by not setting Other in EIAC. This is how it was before
16ecba59bc33 ("e1000e: Do not read ICR in Other interrupt", v4.5-rc1).

Fixes: 4aea7a5c5e94 ("e1000e: Avoid receiver overrun interrupt bursts")
Signed-off-by: Benjamin Poirier <bpoirier@suse.com>
---

Jeff, I'm sending as RFC since it looks like a problem that should be fixed
in vmware. If you'd like to have the workaround in e1000e, I'll submit.

---
 drivers/net/ethernet/intel/e1000e/netdev.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 9f18d39bdc8f..625a4c9a86a4 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -1918,6 +1918,8 @@ static irqreturn_t e1000_msix_other(int __always_unused irq, void *data)
 	bool enable = true;
 
 	icr = er32(ICR);
+	ew32(ICR, E1000_ICR_OTHER);
+
 	if (icr & E1000_ICR_RXO) {
 		ew32(ICR, E1000_ICR_RXO);
 		enable = false;
@@ -2040,7 +2042,6 @@ static void e1000_configure_msix(struct e1000_adapter *adapter)
 		       hw->hw_addr + E1000_EITR_82574(vector));
 	else
 		writel(1, hw->hw_addr + E1000_EITR_82574(vector));
-	adapter->eiac_mask |= E1000_IMS_OTHER;
 
 	/* Cause Tx interrupts on every write back */
 	ivar |= BIT(31);
@@ -2265,7 +2266,7 @@ static void e1000_irq_enable(struct e1000_adapter *adapter)
 
 	if (adapter->msix_entries) {
 		ew32(EIAC_82574, adapter->eiac_mask & E1000_EIAC_MASK_82574);
-		ew32(IMS, adapter->eiac_mask | E1000_IMS_LSC);
+		ew32(IMS, adapter->eiac_mask | E1000_IMS_OTHER | E1000_IMS_LSC);
 	} else if (hw->mac.type >= e1000_pch_lpt) {
 		ew32(IMS, IMS_ENABLE_MASK | E1000_IMS_ECCER);
 	} else {
-- 
2.15.1

