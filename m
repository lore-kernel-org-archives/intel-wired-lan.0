From: Andrew Melnychenko <andrew@daynix.com>
Date: Thu,  3 Dec 2020 15:32:36 +0200
Subject: [Intel-wired-lan] [PATCH v2] e1000e: Added ICR clearing by
 corresponding IMS bit.
Message-ID: <20201203133236.222207-1-andrew@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1707441
Added ICR clearing if there is IMS bit - according to the note by
section 13.3.27 of the 8257X developers manual.

Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
---
 hw/net/e1000e_core.c | 10 ++++++++++
 hw/net/trace-events  |  1 +
 2 files changed, 11 insertions(+)

diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
index 095c01ebc6..9705f5c52e 100644
--- a/hw/net/e1000e_core.c
+++ b/hw/net/e1000e_core.c
@@ -2624,6 +2624,16 @@ e1000e_mac_icr_read(E1000ECore *core, int index)
         e1000e_clear_ims_bits(core, core->mac[IAM]);
     }
 
+    /*
+     * PCIe* GbE Controllers Open Source Software Developer's Manual
+     * 13.3.27 Interrupt Cause Read Register
+     */
+    if ((core->mac[ICR] & E1000_ICR_ASSERTED) &&
+        (core->mac[ICR] & core->mac[IMS])) {
+        trace_e1000e_irq_icr_clear_icr_bit_ims(core->mac[ICR], core->mac[IMS]);
+        core->mac[ICR] = 0;
+    }
+
     trace_e1000e_irq_icr_read_exit(core->mac[ICR]);
     e1000e_update_interrupt_state(core);
     return ret;
diff --git a/hw/net/trace-events b/hw/net/trace-events
index 5db45456d9..2c3521a19c 100644
--- a/hw/net/trace-events
+++ b/hw/net/trace-events
@@ -237,6 +237,7 @@ e1000e_irq_icr_read_entry(uint32_t icr) "Starting ICR read. Current ICR: 0x%x"
 e1000e_irq_icr_read_exit(uint32_t icr) "Ending ICR read. Current ICR: 0x%x"
 e1000e_irq_icr_clear_zero_ims(void) "Clearing ICR on read due to zero IMS"
 e1000e_irq_icr_clear_iame(void) "Clearing ICR on read due to IAME"
+e1000e_irq_icr_clear_icr_bit_ims(uint32_t icr, uint32_t ims) "Clearing ICR on read due corresponding IMS bit: 0x%x & 0x%x"
 e1000e_irq_iam_clear_eiame(uint32_t iam, uint32_t cause) "Clearing IMS due to EIAME, IAM: 0x%X, cause: 0x%X"
 e1000e_irq_icr_clear_eiac(uint32_t icr, uint32_t eiac) "Clearing ICR bits due to EIAC, ICR: 0x%X, EIAC: 0x%X"
 e1000e_irq_ims_clear_set_imc(uint32_t val) "Clearing IMS bits due to IMC write 0x%x"
-- 
2.29.2

