From: Sasha Neftin <sasha.neftin@intel.com>
Date: Mon,  4 May 2020 09:29:25 +0300
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Remove unused descriptor's
 flags
Message-ID: <20200504062925.18819-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Enable Tidv register, Report Packet Sent, Report Status and
Ethernet CRC flags not in use.
This patch comes to clean up these flags.

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_defines.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
index 95de1eb515cb..aa1d012b3e2a 100644
--- a/drivers/net/ethernet/intel/igc/igc_defines.h
+++ b/drivers/net/ethernet/intel/igc/igc_defines.h
@@ -265,13 +265,9 @@
 #define IGC_TXD_POPTS_IXSM	0x01       /* Insert IP checksum */
 #define IGC_TXD_POPTS_TXSM	0x02       /* Insert TCP/UDP checksum */
 #define IGC_TXD_CMD_EOP		0x01000000 /* End of Packet */
-#define IGC_TXD_CMD_IFCS	0x02000000 /* Insert FCS (Ethernet CRC) */
 #define IGC_TXD_CMD_IC		0x04000000 /* Insert Checksum */
-#define IGC_TXD_CMD_RS		0x08000000 /* Report Status */
-#define IGC_TXD_CMD_RPS		0x10000000 /* Report Packet Sent */
 #define IGC_TXD_CMD_DEXT	0x20000000 /* Desc extension (0 = legacy) */
 #define IGC_TXD_CMD_VLE		0x40000000 /* Add VLAN tag */
-#define IGC_TXD_CMD_IDE		0x80000000 /* Enable Tidv register */
 #define IGC_TXD_STAT_DD		0x00000001 /* Descriptor Done */
 #define IGC_TXD_STAT_EC		0x00000002 /* Excess Collisions */
 #define IGC_TXD_STAT_LC		0x00000004 /* Late Collisions */
-- 
2.11.0

