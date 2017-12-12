From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Tue, 12 Dec 2017 15:36:56 -0800
Subject: [Intel-wired-lan] [PATCH v2 next-queue 03/10] ixgbe: add ipsec
 engine start and stop routines
In-Reply-To: <1513121823-27944-1-git-send-email-shannon.nelson@oracle.com>
References: <1513121823-27944-1-git-send-email-shannon.nelson@oracle.com>
Message-ID: <1513121823-27944-4-git-send-email-shannon.nelson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Add in the code for running and stopping the hardware ipsec
encryption/decryption engine.  It is good to keep the engine
off when not in use in order to save on the power draw.

Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
---
v2: add limiter to do-while loop waiting for paths to drain

 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c | 142 +++++++++++++++++++++++++
 1 file changed, 142 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
index 4d71517..a45e6b7 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
@@ -152,10 +152,152 @@ void ixgbe_ipsec_clear_hw_tables(struct ixgbe_adapter *adapter)
 }
 
 /**
+ * ixgbe_ipsec_stop_data
+ * @adapter: board private structure
+ **/
+static void ixgbe_ipsec_stop_data(struct ixgbe_adapter *adapter)
+{
+	struct ixgbe_hw *hw = &adapter->hw;
+	bool link = adapter->link_up;
+	u32 t_rdy, r_rdy;
+	u32 limit;
+	u32 reg;
+
+	/* halt data paths */
+	reg = IXGBE_READ_REG(hw, IXGBE_SECTXCTRL);
+	reg |= IXGBE_SECTXCTRL_TX_DIS;
+	IXGBE_WRITE_REG(hw, IXGBE_SECTXCTRL, reg);
+
+	reg = IXGBE_READ_REG(hw, IXGBE_SECRXCTRL);
+	reg |= IXGBE_SECRXCTRL_RX_DIS;
+	IXGBE_WRITE_REG(hw, IXGBE_SECRXCTRL, reg);
+
+	IXGBE_WRITE_FLUSH(hw);
+
+	/* If the tx fifo doesn't have link, but still has data,
+	 * we can't clear the tx sec block.  Set the MAC loopback
+	 * before block clear
+	 */
+	if (!link) {
+		reg = IXGBE_READ_REG(hw, IXGBE_MACC);
+		reg |= IXGBE_MACC_FLU;
+		IXGBE_WRITE_REG(hw, IXGBE_MACC, reg);
+
+		reg = IXGBE_READ_REG(hw, IXGBE_HLREG0);
+		reg |= IXGBE_HLREG0_LPBK;
+		IXGBE_WRITE_REG(hw, IXGBE_HLREG0, reg);
+
+		IXGBE_WRITE_FLUSH(hw);
+		mdelay(3);
+	}
+
+	/* wait for the paths to empty */
+	limit = 20;
+	do {
+		mdelay(10);
+		t_rdy = IXGBE_READ_REG(hw, IXGBE_SECTXSTAT) &
+			IXGBE_SECTXSTAT_SECTX_RDY;
+		r_rdy = IXGBE_READ_REG(hw, IXGBE_SECRXSTAT) &
+			IXGBE_SECRXSTAT_SECRX_RDY;
+	} while (!t_rdy && !r_rdy && limit--);
+
+	/* undo loopback if we played with it earlier */
+	if (!link) {
+		reg = IXGBE_READ_REG(hw, IXGBE_MACC);
+		reg &= ~IXGBE_MACC_FLU;
+		IXGBE_WRITE_REG(hw, IXGBE_MACC, reg);
+
+		reg = IXGBE_READ_REG(hw, IXGBE_HLREG0);
+		reg &= ~IXGBE_HLREG0_LPBK;
+		IXGBE_WRITE_REG(hw, IXGBE_HLREG0, reg);
+
+		IXGBE_WRITE_FLUSH(hw);
+	}
+}
+
+/**
+ * ixgbe_ipsec_stop_engine
+ * @adapter: board private structure
+ **/
+static void ixgbe_ipsec_stop_engine(struct ixgbe_adapter *adapter)
+{
+	struct ixgbe_hw *hw = &adapter->hw;
+	u32 reg;
+
+	ixgbe_ipsec_stop_data(adapter);
+
+	/* disable Rx and Tx SA lookup */
+	IXGBE_WRITE_REG(hw, IXGBE_IPSTXIDX, 0);
+	IXGBE_WRITE_REG(hw, IXGBE_IPSRXIDX, 0);
+
+	/* disable the Rx and Tx engines and full packet store-n-forward */
+	reg = IXGBE_READ_REG(hw, IXGBE_SECTXCTRL);
+	reg |= IXGBE_SECTXCTRL_SECTX_DIS;
+	reg &= ~IXGBE_SECTXCTRL_STORE_FORWARD;
+	IXGBE_WRITE_REG(hw, IXGBE_SECTXCTRL, reg);
+
+	reg = IXGBE_READ_REG(hw, IXGBE_SECRXCTRL);
+	reg |= IXGBE_SECRXCTRL_SECRX_DIS;
+	IXGBE_WRITE_REG(hw, IXGBE_SECRXCTRL, reg);
+
+	/* restore the "tx security buffer almost full threshold" to 0x250 */
+	IXGBE_WRITE_REG(hw, IXGBE_SECTXBUFFAF, 0x250);
+
+	/* Set minimum IFG between packets back to the default 0x1 */
+	reg = IXGBE_READ_REG(hw, IXGBE_SECTXMINIFG);
+	reg = (reg & 0xfffffff0) | 0x1;
+	IXGBE_WRITE_REG(hw, IXGBE_SECTXMINIFG, reg);
+
+	/* final set for normal (no ipsec offload) processing */
+	IXGBE_WRITE_REG(hw, IXGBE_SECTXCTRL, IXGBE_SECTXCTRL_SECTX_DIS);
+	IXGBE_WRITE_REG(hw, IXGBE_SECRXCTRL, IXGBE_SECRXCTRL_SECRX_DIS);
+
+	IXGBE_WRITE_FLUSH(hw);
+}
+
+/**
+ * ixgbe_ipsec_start_engine
+ * @adapter: board private structure
+ *
+ * NOTE: this increases power consumption whether being used or not
+ **/
+static void ixgbe_ipsec_start_engine(struct ixgbe_adapter *adapter)
+{
+	struct ixgbe_hw *hw = &adapter->hw;
+	u32 reg;
+
+	ixgbe_ipsec_stop_data(adapter);
+
+	/* Set minimum IFG between packets to 3 */
+	reg = IXGBE_READ_REG(hw, IXGBE_SECTXMINIFG);
+	reg = (reg & 0xfffffff0) | 0x3;
+	IXGBE_WRITE_REG(hw, IXGBE_SECTXMINIFG, reg);
+
+	/* Set "tx security buffer almost full threshold" to 0x15 so that the
+	 * almost full indication is generated only after buffer contains at
+	 * least an entire jumbo packet.
+	 */
+	reg = IXGBE_READ_REG(hw, IXGBE_SECTXBUFFAF);
+	reg = (reg & 0xfffffc00) | 0x15;
+	IXGBE_WRITE_REG(hw, IXGBE_SECTXBUFFAF, reg);
+
+	/* restart the data paths by clearing the DISABLE bits */
+	IXGBE_WRITE_REG(hw, IXGBE_SECRXCTRL, 0);
+	IXGBE_WRITE_REG(hw, IXGBE_SECTXCTRL, IXGBE_SECTXCTRL_STORE_FORWARD);
+
+	/* enable Rx and Tx SA lookup */
+	IXGBE_WRITE_REG(hw, IXGBE_IPSTXIDX, IXGBE_RXTXIDX_IPS_EN);
+	IXGBE_WRITE_REG(hw, IXGBE_IPSRXIDX, IXGBE_RXTXIDX_IPS_EN);
+
+	IXGBE_WRITE_FLUSH(hw);
+}
+
+/**
  * ixgbe_init_ipsec_offload - initialize security registers for IPSec operation
  * @adapter: board private structure
  **/
 void ixgbe_init_ipsec_offload(struct ixgbe_adapter *adapter)
 {
 	ixgbe_ipsec_clear_hw_tables(adapter);
+	ixgbe_ipsec_stop_engine(adapter);
 }
-- 
2.7.4

