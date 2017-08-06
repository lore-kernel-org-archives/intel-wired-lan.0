From: Sasha Neftin <sasha.neftin@intel.com>
Date: Sun,  6 Aug 2017 16:49:18 +0300
Subject: [Intel-wired-lan] [PATCH v1 1/1] e1000e: fix buffer overrun while
	the I219 is processing DMA transactions
Message-ID: <20170806134918.9222-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Description: Intel? 100/200 Series Chipset platforms
reduced the round-trip latency for the LAN Controller
DMA accesses, causing in some high performance cases a buffer
overrun while the I219 LAN Connected Device is processing
the DMA transactions. I219LM and I219V devices can fall into
unrecovered Tx hang under very stressfully UDP traffic and multiple
reconnection of Ethernet cable. This Tx hang of the LAN Controller
is only recovered if the system is rebooted. Slightly slow down
DMA access by reducing the number of outstanding requests.
This workaround could have an impact on TCP traffic performance
on the platform. Disabling TSO eliminates performance loss for TCP
traffic without a noticeable impact on CPU performance.

Please, refer to I218/I219 specification update:
https://www.intel.com/content/www/us/en/embedded/products/networking/
ethernet-connection-i218-family-documentation.html

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
Reviewed-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
Reviewed-by: Raanan Avargil <raanan.avargil@intel.com>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 2dcb5463d9b8..ea20c3fc542f 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -3004,8 +3004,8 @@ static void e1000_configure_tx(struct e1000_adapter *adapter)
 
 	hw->mac.ops.config_collision_dist(hw);
 
-	/* SPT and CNP Si errata workaround to avoid data corruption */
-	if (hw->mac.type >= e1000_pch_spt) {
+	/* SPT and KBL Si errata workaround to avoid data corruption */
+	if (hw->mac.type == e1000_pch_spt) {
 		u32 reg_val;
 
 		reg_val = er32(IOSFPC);
@@ -3013,7 +3013,9 @@ static void e1000_configure_tx(struct e1000_adapter *adapter)
 		ew32(IOSFPC, reg_val);
 
 		reg_val = er32(TARC(0));
-		reg_val |= E1000_TARC0_CB_MULTIQ_3_REQ;
+		/* SPT and KBL Si errata workaround to avoid Tx hang */
+		reg_val &= ~BIT(28);
+		reg_val |= BIT(29);
 		ew32(TARC(0), reg_val);
 	}
 }
-- 
2.11.0

