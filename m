From: Sasha Neftin <sasha.neftin@intel.com>
Date: Mon,  2 May 2022 16:15:56 +0300
Subject: [Intel-wired-lan] [PATCH v1 1/1] e1000e: Enable the GPT clock
 before sending message to the CSME
Message-ID: <20220502131556.349753-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Enable the dynamic GPT clock. The clock is always ticking is the guarantee
CSME receive the H2ME message and exit from the DMoff state.
This clock cleared upon HW initialization (D3 -> D0 transition).

Fixes: 3e55d231716e ("e1000e: Add handshake with the CSME to support s0ix")
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=214821
Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index fa06f68c8c80..e29a718469ee 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -6494,6 +6494,10 @@ static void e1000e_s0ix_exit_flow(struct e1000_adapter *adapter)
 
 	if (er32(FWSM) & E1000_ICH_FWSM_FW_VALID &&
 	    hw->mac.type >= e1000_pch_adp) {
+		/* Keep the gpt_clk_enable_d clock for CSME*/
+		mac_data = er32(FEXTNVM);
+		mac_data |= BIT(3);
+		ew32(FEXTNVM, mac_data);
 		/* Request ME unconfigure the device from S0ix */
 		mac_data = er32(H2ME);
 		mac_data &= ~E1000_H2ME_START_DPG;
-- 
2.30.2

