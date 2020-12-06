From: Sasha Neftin <sasha.neftin@intel.com>
Date: Sun,  6 Dec 2020 11:37:07 +0200
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Remove MULR mask define
Message-ID: <20201206093707.3695380-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Multiple Tx Data Read Requests is hardware pipeline feature and
do not controlled by software

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_defines.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
index 21695476b8a5..efddb9012439 100644
--- a/drivers/net/ethernet/intel/igc/igc_defines.h
+++ b/drivers/net/ethernet/intel/igc/igc_defines.h
@@ -284,7 +284,6 @@
 #define IGC_TCTL_CT		0x00000ff0 /* collision threshold */
 #define IGC_TCTL_COLD		0x003ff000 /* collision distance */
 #define IGC_TCTL_RTLC		0x01000000 /* Re-transmit on late collision */
-#define IGC_TCTL_MULR		0x10000000 /* Multiple request support */
 
 /* Flow Control Constants */
 #define FLOW_CONTROL_ADDRESS_LOW	0x00C28001
-- 
2.25.1

