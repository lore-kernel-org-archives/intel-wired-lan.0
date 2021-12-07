From: Sasha Neftin <sasha.neftin@intel.com>
Date: Tue,  7 Dec 2021 13:23:42 +0200
Subject: [Intel-wired-lan] [PATCH v1 2/2] e1000e: Handshake with CSME starts
 from ADL platforms
Message-ID: <20211207112342.1290154-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Update the handshake with CSME flow to works starts from the ADL
platform.

Fixes: 3e55d231716e ("e1000e: Add handshake with the CSME to support S0ix")
Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 2cfd03c6b37e..c063128ed1df 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -6346,7 +6346,8 @@ static void e1000e_s0ix_entry_flow(struct e1000_adapter *adapter)
 	u32 mac_data;
 	u16 phy_data;
 
-	if (er32(FWSM) & E1000_ICH_FWSM_FW_VALID) {
+	if (er32(FWSM) & E1000_ICH_FWSM_FW_VALID &&
+	    hw->mac.type >= e1000_pch_adp) {
 		/* Request ME configure the device for S0ix */
 		mac_data = er32(H2ME);
 		mac_data |= E1000_H2ME_START_DPG;
@@ -6495,7 +6496,8 @@ static void e1000e_s0ix_exit_flow(struct e1000_adapter *adapter)
 	u16 phy_data;
 	u32 i = 0;
 
-	if (er32(FWSM) & E1000_ICH_FWSM_FW_VALID) {
+	if (er32(FWSM) & E1000_ICH_FWSM_FW_VALID &&
+	    hw->mac.type >= e1000_pch_adp) {
 		/* Request ME unconfigure the device from S0ix */
 		mac_data = er32(H2ME);
 		mac_data &= ~E1000_H2ME_START_DPG;
-- 
2.25.1

