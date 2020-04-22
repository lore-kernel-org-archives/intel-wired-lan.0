From: Sasha Neftin <sasha.neftin@intel.com>
Date: Wed, 22 Apr 2020 11:41:55 +0300
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Remove header redirection
 register
Message-ID: <20200422084155.36971-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Header redirection missed packet counter not applicable for i225 device.
This patch comes to clean up this register.

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_regs.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_regs.h b/drivers/net/ethernet/intel/igc/igc_regs.h
index f2654f379d88..79bd104363ed 100644
--- a/drivers/net/ethernet/intel/igc/igc_regs.h
+++ b/drivers/net/ethernet/intel/igc/igc_regs.h
@@ -199,7 +199,6 @@
 #define IGC_HGOTCL	0x04130  /* Host Good Octets Transmit Count Low */
 #define IGC_HGOTCH	0x04134  /* Host Good Octets Transmit Count High */
 #define IGC_LENERRS	0x04138  /* Length Errors Count */
-#define IGC_HRMPC	0x0A018  /* Header Redirection Missed Packet Count */
 
 /* Time sync registers */
 #define IGC_TSICR	0x0B66C  /* Time Sync Interrupt Cause */
-- 
2.11.0

