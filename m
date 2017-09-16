From: Vincenzo Maffione <v.maffione@gmail.com>
Date: Sat, 16 Sep 2017 18:00:00 +0200
Subject: [Intel-wired-lan] [PATCH net] driver: e1000: fix race condition
	between e1000_down() and e1000_watchdog
Message-ID: <20170916160000.3560-1-v.maffione@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch fixes a race condition that can result into the interface being
up and carrier on, but with transmits disabled in the hardware.
The bug may show up by repeatedly IFF_DOWN+IFF_UP the interface, which
allows e1000_watchdog() interleave with e1000_down().

    CPU x                           CPU y
    --------------------------------------------------------------------
    e1000_down():
        netif_carrier_off()
                                    e1000_watchdog():
                                        if (carrier == off) {
                                            netif_carrier_on();
                                            enable_hw_transmit();
                                        }
        disable_hw_transmit();
                                    e1000_watchdog():
                                        /* carrier on, do nothing */

Signed-off-by: Vincenzo Maffione <v.maffione@gmail.com>
---
 drivers/net/ethernet/intel/e1000/e1000_main.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/ethernet/intel/e1000/e1000_main.c
index 98375e1e1185..1982f7917a8d 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_main.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
@@ -520,8 +520,6 @@ void e1000_down(struct e1000_adapter *adapter)
 	struct net_device *netdev = adapter->netdev;
 	u32 rctl, tctl;
 
-	netif_carrier_off(netdev);
-
 	/* disable receives in the hardware */
 	rctl = er32(RCTL);
 	ew32(RCTL, rctl & ~E1000_RCTL_EN);
@@ -537,6 +535,15 @@ void e1000_down(struct e1000_adapter *adapter)
 	E1000_WRITE_FLUSH();
 	msleep(10);
 
+	/* Set the carrier off after transmits have been disabled in the
+	 * hardware, to avoid race conditions with e1000_watchdog() (which
+	 * may be running concurrently to us, checking for the carrier
+	 * bit to decide whether it should enable transmits again). Such
+	 * a race condition would result into transmission being disabled
+	 * in the hardware until the next IFF_DOWN+IFF_UP cycle.
+	 */
+	netif_carrier_off(netdev);
+
 	napi_disable(&adapter->napi);
 
 	e1000_irq_disable(adapter);
-- 
2.14.1

