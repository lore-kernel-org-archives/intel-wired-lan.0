From: Alexander Duyck <alexander.h.duyck@intel.com>
Date: Wed, 17 Jan 2018 16:49:10 -0500
Subject: [Intel-wired-lan] [net-queue PATCH] e1000e: Workaround for VMware
 emulated 82574 setting of LSC
Message-ID: <20180117214910.56422.26379.stgit@ahduyck-green-test.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch is meant to address the fact that after the patch for addressing
receive overrun interrupt bursts VMware emulated versions of the 82574 were
no longer able to bring up link. I believe this is due to the fact that the
emulation was based more on the driver implementation then on the actual
hardware behavior.

In order to resolve this we will need to modify the fix so that we only
force the LSC checks when the receiver overrun bit is set in the ICR
register. By doing this we can maintain the legacy behavior needed to keep
the emulated interfaces going while also addressing the issues with the RXO
interrupt cause seen with the physical hardware.

Fixes: 4aea7a5c5e94 ("e1000e: Avoid receiver overrun interrupt bursts")
Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
---
 drivers/net/ethernet/intel/e1000e/netdev.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 1298b69..74d5352 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -1927,8 +1927,15 @@ static irqreturn_t e1000_msix_other(int __always_unused irq, void *data)
 			adapter->total_rx_packets = 0;
 			__napi_schedule(&adapter->napi);
 		}
-	}
-	if (icr & E1000_ICR_LSC) {
+		if (icr & E1000_ICR_LSC)
+			goto update_link;
+	} else {
+		/* We assume if the RXO bit is not set that this is a
+		 * link status change event. This is needed due to emulated
+		 * versions of the device that may not correctly populate
+		 * the LSC bit.
+		 */
+update_link:
 		ew32(ICR, E1000_ICR_LSC);
 		hw->mac.get_link_status = true;
 		/* guard against interrupt when we're going down */

