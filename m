From: Sasha Neftin <sasha.neftin@intel.com>
Date: Mon,  6 Nov 2017 08:31:59 +0200
Subject: [Intel-wired-lan] [PATCH v2 1/1] e1000e: fix buffer overrun while
 the I219 is processing DMA transactions
Message-ID: <20171106063159.32289-1-sasha.neftin@intel.com>
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
Reviewed-by: Alexander H Duyck <alexander.h.duyck@intel.com>
Reviewed-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
Reviewed-by: Raanan Avargil <raanan.avargil@intel.com>
---
 drivers/net/ethernet/intel/e1000e/ich8lan.h | 3 ++-
 drivers/net/ethernet/intel/e1000e/netdev.c  | 9 ++++++---
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.h b/drivers/net/ethernet/intel/e1000e/ich8lan.h
index 67163ca898ba..e23d8da9b15b 100644
--- a/drivers/net/ethernet/intel/e1000e/ich8lan.h
+++ b/drivers/net/ethernet/intel/e1000e/ich8lan.h
@@ -113,7 +113,8 @@
 #define NVM_SIZE_MULTIPLIER 4096	/*multiplier for NVMS field */
 #define E1000_FLASH_BASE_ADDR 0xE000	/*offset of NVM access regs */
 #define E1000_CTRL_EXT_NVMVS 0x3	/*NVM valid sector */
-#define E1000_TARC0_CB_MULTIQ_3_REQ	(1 << 28 | 1 << 29)
+#define E1000_TARC0_CB_MULTIQ_3_REQ     0x30000000
+#define E1000_TARC0_CB_MULTIQ_2_REQ     0x20000000
 #define PCIE_ICH8_SNOOP_ALL	PCIE_NO_SNOOP_ALL
 
 #define E1000_ICH_RAR_ENTRIES	7
diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index f2f49239b015..9f18d39bdc8f 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -3034,9 +3034,12 @@ static void e1000_configure_tx(struct e1000_adapter *adapter)
 		ew32(IOSFPC, reg_val);
 
 		reg_val = er32(TARC(0));
-		/* SPT and KBL Si errata workaround to avoid Tx hang */
-		reg_val &= ~BIT(28);
-		reg_val |= BIT(29);
+		/* SPT and KBL Si errata workaround to avoid Tx hang.
+		 * Dropping the number of outstanding requests from
+		 * 3 to 2 in order to avoid a buffer overrun.
+		 */
+		reg_val &= ~E1000_TARC0_CB_MULTIQ_3_REQ;
+		reg_val |= E1000_TARC0_CB_MULTIQ_2_REQ;
 		ew32(TARC(0), reg_val);
 	}
 }
-- 
2.11.0

