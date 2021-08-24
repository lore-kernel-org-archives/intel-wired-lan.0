From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Mon, 23 Aug 2021 17:01:54 -0700
Subject: [Intel-wired-lan] [next-queue v4 09/13] ice: convert clk_freq
 capability into time_ref
In-Reply-To: <20210824000158.1928482-1-anthony.l.nguyen@intel.com>
References: <20210824000158.1928482-1-anthony.l.nguyen@intel.com>
Message-ID: <20210824000158.1928482-10-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

Convert the clk_freq value into the associated time_ref frequency value
for E822 devices. This simplifies determining the time reference value
for the clock.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c | 12 +++++++++++
 drivers/net/ethernet/intel/ice/ice_type.h   | 23 ++++++++++++++++++++-
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 2fb81e359cdf..f63912797548 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -2129,6 +2129,18 @@ ice_parse_1588_func_caps(struct ice_hw *hw, struct ice_hw_func_caps *func_p,
 	info->clk_freq = (number & ICE_TS_CLK_FREQ_M) >> ICE_TS_CLK_FREQ_S;
 	info->clk_src = ((number & ICE_TS_CLK_SRC_M) != 0);
 
+	if (info->clk_freq < NUM_ICE_TIME_REF_FREQ) {
+		info->time_ref = (enum ice_time_ref_freq)info->clk_freq;
+	} else {
+		/* Unknown clock frequency, so assume a (probably incorrect)
+		 * default to avoid out-of-bounds look ups of frequency
+		 * related information.
+		 */
+		ice_debug(hw, ICE_DBG_INIT, "1588 func caps: unknown clock frequency %u\n",
+			  info->clk_freq);
+		info->time_ref = ICE_TIME_REF_FREQ_25_000;
+	}
+
 	ice_debug(hw, ICE_DBG_INIT, "func caps: ieee_1588 = %u\n",
 		  func_p->common_cap.ieee_1588);
 	ice_debug(hw, ICE_DBG_INIT, "func caps: src_tmr_owned = %u\n",
diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
index b59076f2dbde..fadc68f74d95 100644
--- a/drivers/net/ethernet/intel/ice/ice_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_type.h
@@ -294,9 +294,30 @@ struct ice_hw_common_caps {
 #define ICE_TS_TMR_IDX_ASSOC_S		24
 #define ICE_TS_TMR_IDX_ASSOC_M		BIT(24)
 
+/* TIME_REF clock rate specification */
+enum ice_time_ref_freq {
+	ICE_TIME_REF_FREQ_25_000	= 0,
+	ICE_TIME_REF_FREQ_122_880	= 1,
+	ICE_TIME_REF_FREQ_125_000	= 2,
+	ICE_TIME_REF_FREQ_153_600	= 3,
+	ICE_TIME_REF_FREQ_156_250	= 4,
+	ICE_TIME_REF_FREQ_245_760	= 5,
+
+	NUM_ICE_TIME_REF_FREQ
+};
+
+/* Clock source specification */
+enum ice_clk_src {
+	ICE_CLK_SRC_TCX0	= 0, /* Temperature compensated oscillator  */
+	ICE_CLK_SRC_TIME_REF	= 1, /* Use TIME_REF reference clock */
+
+	NUM_ICE_CLK_SRC
+};
+
 struct ice_ts_func_info {
 	/* Function specific info */
-	u32 clk_freq;
+	enum ice_time_ref_freq time_ref;
+	u8 clk_freq;
 	u8 clk_src;
 	u8 tmr_index_assoc;
 	u8 ena;
-- 
2.26.2

