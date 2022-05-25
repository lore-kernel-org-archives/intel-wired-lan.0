From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Wed, 25 May 2022 19:31:13 +0800
Subject: [Intel-wired-lan] [PATCH v2 2/2] igb: Make DMA faster when CPU is
 active on the PCIe link
In-Reply-To: <20220525113113.171746-1-kai.heng.feng@canonical.com>
References: <20220525113113.171746-1-kai.heng.feng@canonical.com>
Message-ID: <20220525113113.171746-2-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Intel I210 on some Intel Alder Lake platforms can only achieve ~750Mbps
Tx speed via iperf. The RR2DCDELAY shows around 0x2xxx DMA delay, which
will be significantly lower when 1) ASPM is disabled or 2) SoC package
c-state stays above PC3. When the RR2DCDELAY is around 0x1xxx the Tx
speed can reach to ~950Mbps.

According to the I210 datasheet "8.26.1 PCIe Misc. Register - PCIEMISC",
"DMA Idle Indication" doesn't seem to tie to DMA coalesce anymore, so
set it to 1b for "DMA is considered idle when there is no Rx or Tx AND
when there are no TLPs indicating that CPU is active detected on the
PCIe link (such as the host executes CSR or Configuration register read
or write operation)" and performing Tx should also fall under "active
CPU on PCIe link" case.

In addition to that, commit b6e0c419f040 ("igb: Move DMA Coalescing init
code to separate function.") seems to wrongly changed from enabling
E1000_PCIEMISC_LX_DECISION to disabling it, also fix that.

Fixes: b6e0c419f040 ("igb: Move DMA Coalescing init code to separate function.")
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 68be2976f539f..c0d93fd19c1ed 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -9898,11 +9898,10 @@ static void igb_init_dmac(struct igb_adapter *adapter, u32 pba)
 	struct e1000_hw *hw = &adapter->hw;
 	u32 dmac_thr;
 	u16 hwm;
+	u32 reg;
 
 	if (hw->mac.type > e1000_82580) {
 		if (adapter->flags & IGB_FLAG_DMAC) {
-			u32 reg;
-
 			/* force threshold to 0. */
 			wr32(E1000_DMCTXTH, 0);
 
@@ -9935,7 +9934,6 @@ static void igb_init_dmac(struct igb_adapter *adapter, u32 pba)
 			/* Disable BMC-to-OS Watchdog Enable */
 			if (hw->mac.type != e1000_i354)
 				reg &= ~E1000_DMACR_DC_BMC2OSW_EN;
-
 			wr32(E1000_DMACR, reg);
 
 			/* no lower threshold to disable
@@ -9952,12 +9950,12 @@ static void igb_init_dmac(struct igb_adapter *adapter, u32 pba)
 			 */
 			wr32(E1000_DMCTXTH, (IGB_MIN_TXPBSIZE -
 			     (IGB_TX_BUF_4096 + adapter->max_frame_size)) >> 6);
+		}
 
-			/* make low power state decision controlled
-			 * by DMA coal
-			 */
+		if (hw->mac.type >= e1000_i210 ||
+		    (adapter->flags & IGB_FLAG_DMAC)) {
 			reg = rd32(E1000_PCIEMISC);
-			reg &= ~E1000_PCIEMISC_LX_DECISION;
+			reg |= E1000_PCIEMISC_LX_DECISION;
 			wr32(E1000_PCIEMISC, reg);
 		} /* endif adapter->dmac is not disabled */
 	} else if (hw->mac.type == e1000_82580) {
-- 
2.34.1

