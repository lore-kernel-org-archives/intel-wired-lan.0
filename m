From: Sasha Neftin <sasha.neftin@intel.com>
Date: Sun, 10 May 2020 18:52:00 +0300
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Remove unused flags
Message-ID: <20200510155200.21068-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Transmit underrun, late and excess collision flags not in use.
This patch comes to clean up these flags.

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_defines.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
index aa1d012b3e2a..80b664e64465 100644
--- a/drivers/net/ethernet/intel/igc/igc_defines.h
+++ b/drivers/net/ethernet/intel/igc/igc_defines.h
@@ -269,13 +269,9 @@
 #define IGC_TXD_CMD_DEXT	0x20000000 /* Desc extension (0 = legacy) */
 #define IGC_TXD_CMD_VLE		0x40000000 /* Add VLAN tag */
 #define IGC_TXD_STAT_DD		0x00000001 /* Descriptor Done */
-#define IGC_TXD_STAT_EC		0x00000002 /* Excess Collisions */
-#define IGC_TXD_STAT_LC		0x00000004 /* Late Collisions */
-#define IGC_TXD_STAT_TU		0x00000008 /* Transmit underrun */
 #define IGC_TXD_CMD_TCP		0x01000000 /* TCP packet */
 #define IGC_TXD_CMD_IP		0x02000000 /* IP packet */
 #define IGC_TXD_CMD_TSE		0x04000000 /* TCP Seg enable */
-#define IGC_TXD_STAT_TC		0x00000004 /* Tx Underrun */
 #define IGC_TXD_EXTCMD_TSTAMP	0x00000010 /* IEEE1588 Timestamp packet */
 
 /* IPSec Encrypt Enable */
-- 
2.11.0

