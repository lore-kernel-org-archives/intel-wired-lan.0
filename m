From: Sasha Neftin <sasha.neftin@intel.com>
Date: Tue, 12 Nov 2019 17:13:32 +0200
Subject: [Intel-wired-lan] [PATCH v1] igc: Fix parameter descriptions for a
 several functions
Message-ID: <20191112151332.5893-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

igc_watchdog, igc_set_interrupt_capability, igc_init_interrupt_scheme,
__igc_open and __igc_close parameter desriptions has not reflected
functions meaning. Add meaningful description.

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 5d3023ea8a44..fe9edcce42e8 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -3110,7 +3110,7 @@ bool igc_has_link(struct igc_adapter *adapter)
 
 /**
  * igc_watchdog - Timer Call-back
- * @data: pointer to adapter cast into an unsigned long
+ * @t: timer for the watchdog
  */
 static void igc_watchdog(struct timer_list *t)
 {
@@ -3639,6 +3639,7 @@ static int igc_poll(struct napi_struct *napi, int budget)
 /**
  * igc_set_interrupt_capability - set MSI or MSI-X if supported
  * @adapter: Pointer to adapter structure
+ * @msix: boolean value for MSI-X capability
  *
  * Attempt to configure interrupts using the best available
  * capabilities of the hardware and kernel.
@@ -3907,6 +3908,7 @@ static void igc_cache_ring_register(struct igc_adapter *adapter)
 /**
  * igc_init_interrupt_scheme - initialize interrupts, allocate queues/vectors
  * @adapter: Pointer to adapter structure
+ * @msix: boolean for MSI-X capability
  *
  * This function initializes the interrupts and allocates all of the queues.
  */
@@ -4074,8 +4076,9 @@ static void igc_write_itr(struct igc_q_vector *q_vector)
 }
 
 /**
- * igc_open - Called when a network interface is made active
+ * __igc_open - Called when a network interface is made active
  * @netdev: network interface device structure
+ * @resuming: boolean indicating if the device is resuming
  *
  * Returns 0 on success, negative value on failure
  *
@@ -4165,8 +4168,9 @@ static int igc_open(struct net_device *netdev)
 }
 
 /**
- * igc_close - Disables a network interface
+ * __igc_close - Disables a network interface
  * @netdev: network interface device structure
+ * @suspending: boolean indicating the device is suspending
  *
  * Returns 0, this is not allowed to fail
  *
-- 
2.11.0

