From: Sasha Neftin <sasha.neftin@intel.com>
Date: Tue,  7 Jul 2020 14:05:03 +0300
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Clean up the _mac_info
 structure
Message-ID: <20200707110503.32407-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

collision_delta, tx_packet_delta, txcw, adaptive_ifs and
fwsm fields not in use.
This patch come to clean up the driver code.

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_hw.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_hw.h b/drivers/net/ethernet/intel/igc/igc_hw.h
index 8066749a55d0..24412a6c2289 100644
--- a/drivers/net/ethernet/intel/igc/igc_hw.h
+++ b/drivers/net/ethernet/intel/igc/igc_hw.h
@@ -82,10 +82,7 @@ struct igc_mac_info {
 
 	enum igc_mac_type type;
 
-	u32 collision_delta;
 	u32 mc_filter_type;
-	u32 tx_packet_delta;
-	u32 txcw;
 
 	u16 mta_reg_count;
 	u16 uta_reg_count;
@@ -95,8 +92,6 @@ struct igc_mac_info {
 
 	u8 forced_speed_duplex;
 
-	bool adaptive_ifs;
-	bool has_fwsm;
 	bool asf_firmware_present;
 	bool arc_subsystem_valid;
 
-- 
2.11.0

