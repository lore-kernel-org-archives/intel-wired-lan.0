From: Andre Guedes <andre.guedes@intel.com>
Date: Fri, 30 Oct 2020 14:03:44 -0700
Subject: [Intel-wired-lan] [PATCH v3 2/9] igc: Remove unused argument from
 igc_tx_cmd_type()
In-Reply-To: <20201030210351.46482-1-andre.guedes@intel.com>
References: <20201030210351.46482-1-andre.guedes@intel.com>
Message-ID: <20201030210351.46482-3-andre.guedes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The 'skb' argument from igc_tx_cmd_type() is not used so this patch
removes it.

Signed-off-by: Andre Guedes <andre.guedes@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 240565aee2a3..5ce9253cca19 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -1042,7 +1042,7 @@ static inline int igc_maybe_stop_tx(struct igc_ring *tx_ring, const u16 size)
 	 ((u32)((_input) & (_flag)) * ((_result) / (_flag))) :	\
 	 ((u32)((_input) & (_flag)) / ((_flag) / (_result))))
 
-static u32 igc_tx_cmd_type(struct sk_buff *skb, u32 tx_flags)
+static u32 igc_tx_cmd_type(u32 tx_flags)
 {
 	/* set type for advanced descriptor with frame checksum insertion */
 	u32 cmd_type = IGC_ADVTXD_DTYP_DATA |
@@ -1091,7 +1091,7 @@ static int igc_tx_map(struct igc_ring *tx_ring,
 	u16 i = tx_ring->next_to_use;
 	unsigned int data_len, size;
 	dma_addr_t dma;
-	u32 cmd_type = igc_tx_cmd_type(skb, tx_flags);
+	u32 cmd_type = igc_tx_cmd_type(tx_flags);
 
 	tx_desc = IGC_TX_DESC(tx_ring, i);
 
-- 
2.28.0

