From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Date: Fri, 27 May 2022 10:07:50 +0200
Subject: [Intel-wired-lan] [PATCH net v1] i40e: Fix dropped jumbo frames
 statistics
Message-ID: <20220527080750.2370502-1-jedrzej.jagielski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Lukasz Cieplicki <lukaszx.cieplicki@intel.com>

Dropped packets caused by too large frames were
not include in dropped RX packets statistics.
Issue was caused by avoid reading of GL_RXERR1 register.
Fixed by reading GL_RXERR1 register for each interface.

Fixes: 41a9e55c89be ("i40e: add missing VSI statistics")
Signed-off-by: Lukasz Cieplicki <lukaszx.cieplicki@intel.com>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h        | 15 ++++
 drivers/net/ethernet/intel/i40e/i40e_main.c   | 74 +++++++++++++++++++
 .../net/ethernet/intel/i40e/i40e_register.h   | 13 ++++
 drivers/net/ethernet/intel/i40e/i40e_type.h   |  1 +
 4 files changed, 103 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 55c6bce5da61..897bd57e2eb4 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -1091,6 +1091,21 @@ static inline void i40e_write_fd_input_set(struct i40e_pf *pf,
 			  (u32)(val & 0xFFFFFFFFULL));
 }
 
+/**
+ * i40e_get_pf_count - get PCI PF Count.
+ * @hw: pointer to a hw.
+ *
+ * Reports the function number of the highest PCI physical
+ * function plus 1 as it is loaded from the NVM.
+ *
+ * Return: PCI PF Count.
+ **/
+static inline int i40e_get_pf_count(struct i40e_hw *hw)
+{
+	return rd32(hw, I40E_GLGEN_PCIFCNCNT)
+		& I40E_GLGEN_PCIFCNCNT_PCIPFCNT_MASK;
+}
+
 /* needed by i40e_ethtool.c */
 int i40e_up(struct i40e_vsi *vsi);
 void i40e_down(struct i40e_vsi *vsi);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 46bb1169a004..94410b49995b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -549,6 +549,49 @@ void i40e_pf_reset_stats(struct i40e_pf *pf)
 	pf->hw_csum_rx_error = 0;
 }
 
+/**
+ * i40e_compute_pci_to_hw_id - compute index form PCI function.
+ * @vsi: ptr to the VSI to read from.
+ * @hw: ptr to the hardware info.
+ **/
+static u8 i40e_compute_pci_to_hw_id(struct i40e_vsi *vsi, struct i40e_hw *hw)
+{
+	int pf_count;
+
+	pf_count = i40e_get_pf_count(hw);
+
+	if (vsi->type == I40E_VSI_SRIOV)
+		return hw->port * BIT(7) / pf_count + vsi->vf_id;
+
+	return hw->port + BIT(7);
+}
+
+/**
+ * i40e_stat_update64 - read and update a 64 bit stat from the chip.
+ * @hw: ptr to the hardware info.
+ * @hireg: the high 32 bit reg to read.
+ * @loreg: the low 32 bit reg to read.
+ * @offset_loaded: has the initial offset been loaded yet.
+ * @offset: ptr to current offset value.
+ * @stat: ptr to the stat.
+ *
+ * Since the device stats are not reset at PFReset, they likely will not
+ * be zeroed when the driver starts.  We'll save the first values read
+ * and use them as offsets to be subtracted from the raw values in order
+ * to report stats that count from zero.
+ **/
+static void i40e_stat_update64(struct i40e_hw *hw, u32 hireg, u32 loreg,
+			       bool offset_loaded, u64 *offset, u64 *stat)
+{
+	u64 new_data;
+
+	new_data = rd64(hw, loreg);
+
+	if (!offset_loaded || new_data < *offset)
+		*offset = new_data;
+	*stat = new_data - *offset;
+}
+
 /**
  * i40e_stat_update48 - read and update a 48 bit stat from the chip
  * @hw: ptr to the hardware info
@@ -620,6 +663,33 @@ static void i40e_stat_update_and_clear32(struct i40e_hw *hw, u32 reg, u64 *stat)
 	*stat += new_data;
 }
 
+/**
+ * i40e_stats_update_rx_discards - update rx_discards.
+ * @vsi: ptr to the VSI to be updated.
+ * @hw: ptr to the hardware info.
+ * @stat_idx: VSI's stat_counter_idx.
+ * @offset_loaded: ptr to the VSI's stat_offsets_loaded.
+ * @stat_offset: ptr to stat_offset to store first read of specific register.
+ * @stat: ptr to VSI's stat to be updated.
+ **/
+static void i40e_stats_update_rx_discards(struct i40e_vsi *vsi,
+			struct i40e_hw *hw, int stat_idx, bool offset_loaded,
+			struct i40e_eth_stats *stat_offset,
+			struct i40e_eth_stats *stat)
+{
+	u64 rx_rdpc, rx_rxerr;
+
+	i40e_stat_update32(hw, I40E_GLV_RDPC(stat_idx), offset_loaded,
+			   &stat_offset->rx_discards, &rx_rdpc);
+	i40e_stat_update64(hw,
+			   I40E_GL_RXERR1H(i40e_compute_pci_to_hw_id(vsi, hw)),
+			   I40E_GL_RXERR1L(i40e_compute_pci_to_hw_id(vsi, hw)),
+			   offset_loaded, &stat_offset->rx_discards_other,
+			   &rx_rxerr);
+
+	stat->rx_discards = rx_rdpc + rx_rxerr;
+}
+
 /**
  * i40e_update_eth_stats - Update VSI-specific ethernet statistics counters.
  * @vsi: the VSI to be updated
@@ -679,6 +749,10 @@ void i40e_update_eth_stats(struct i40e_vsi *vsi)
 			   I40E_GLV_BPTCL(stat_idx),
 			   vsi->stat_offsets_loaded,
 			   &oes->tx_broadcast, &es->tx_broadcast);
+
+	i40e_stats_update_rx_discards(vsi, hw, stat_idx,
+		   vsi->stat_offsets_loaded, oes, es);
+
 	vsi->stat_offsets_loaded = true;
 }
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_register.h b/drivers/net/ethernet/intel/i40e/i40e_register.h
index 1908eed4fa5e..7339003aa17c 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_register.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_register.h
@@ -211,6 +211,11 @@
 #define I40E_GLGEN_MSRWD_MDIWRDATA_SHIFT 0
 #define I40E_GLGEN_MSRWD_MDIRDDATA_SHIFT 16
 #define I40E_GLGEN_MSRWD_MDIRDDATA_MASK I40E_MASK(0xFFFF, I40E_GLGEN_MSRWD_MDIRDDATA_SHIFT)
+#define I40E_GLGEN_PCIFCNCNT                0x001C0AB4 /* Reset: PCIR */
+#define I40E_GLGEN_PCIFCNCNT_PCIPFCNT_SHIFT 0
+#define I40E_GLGEN_PCIFCNCNT_PCIPFCNT_MASK  I40E_MASK(0x1F, I40E_GLGEN_PCIFCNCNT_PCIPFCNT_SHIFT)
+#define I40E_GLGEN_PCIFCNCNT_PCIVFCNT_SHIFT 16
+#define I40E_GLGEN_PCIFCNCNT_PCIVFCNT_MASK  I40E_MASK(0xFF, I40E_GLGEN_PCIFCNCNT_PCIVFCNT_SHIFT)
 #define I40E_GLGEN_RSTAT 0x000B8188 /* Reset: POR */
 #define I40E_GLGEN_RSTAT_DEVSTATE_SHIFT 0
 #define I40E_GLGEN_RSTAT_DEVSTATE_MASK I40E_MASK(0x3, I40E_GLGEN_RSTAT_DEVSTATE_SHIFT)
@@ -643,6 +648,14 @@
 #define I40E_VFQF_HKEY1_MAX_INDEX 12
 #define I40E_VFQF_HLUT1(_i, _VF) (0x00220000 + ((_i) * 1024 + (_VF) * 4)) /* _i=0...15, _VF=0...127 */ /* Reset: CORER */
 #define I40E_VFQF_HLUT1_MAX_INDEX 15
+#define I40E_GL_RXERR1H(_i)             (0x00318004 + ((_i) * 8)) /* _i=0...143 */ /* Reset: CORER */
+#define I40E_GL_RXERR1H_MAX_INDEX       143
+#define I40E_GL_RXERR1H_RXERR1H_SHIFT   0
+#define I40E_GL_RXERR1H_RXERR1H_MASK    I40E_MASK(0xFFFFFFFF, I40E_GL_RXERR1H_RXERR1H_SHIFT)
+#define I40E_GL_RXERR1L(_i)             (0x00318000 + ((_i) * 8)) /* _i=0...143 */ /* Reset: CORER */
+#define I40E_GL_RXERR1L_MAX_INDEX       143
+#define I40E_GL_RXERR1L_RXERR1L_SHIFT   0
+#define I40E_GL_RXERR1L_RXERR1L_MASK    I40E_MASK(0xFFFFFFFF, I40E_GL_RXERR1L_RXERR1L_SHIFT)
 #define I40E_GLPRT_BPRCH(_i) (0x003005E4 + ((_i) * 8)) /* _i=0...3 */ /* Reset: CORER */
 #define I40E_GLPRT_BPRCL(_i) (0x003005E0 + ((_i) * 8)) /* _i=0...3 */ /* Reset: CORER */
 #define I40E_GLPRT_BPTCH(_i) (0x00300A04 + ((_i) * 8)) /* _i=0...3 */ /* Reset: CORER */
diff --git a/drivers/net/ethernet/intel/i40e/i40e_type.h b/drivers/net/ethernet/intel/i40e/i40e_type.h
index 36a4ca1ffb1a..7b3f30beb757 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_type.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_type.h
@@ -1172,6 +1172,7 @@ struct i40e_eth_stats {
 	u64 tx_broadcast;		/* bptc */
 	u64 tx_discards;		/* tdpc */
 	u64 tx_errors;			/* tepc */
+	u64 rx_discards_other;          /* rxerr1 */
 };
 
 /* Statistics collected per VEB per TC */
-- 
2.27.0

