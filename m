From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Mon, 23 Aug 2021 17:01:50 -0700
Subject: [Intel-wired-lan] [next-queue v4 05/13] ice: introduce
 ice_base_incval function
In-Reply-To: <20210824000158.1928482-1-anthony.l.nguyen@intel.com>
References: <20210824000158.1928482-1-anthony.l.nguyen@intel.com>
Message-ID: <20210824000158.1928482-6-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

A future change will add additional possible increment values for the
E822 device support. To handle this, we want to look up the increment
value to use instead of hard coding it to the nominal value for E810
devices. Introduce ice_base_incval as a function to get the best nominal
increment value to use.

For now, it just returns the E810 value, but will be refactored in the
future to look up the value based on the device type and configured
clock frequency.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 05cc5870e4ef..904ad94dd9db 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -435,6 +435,20 @@ static int ice_ptp_write_adj(struct ice_pf *pf, s32 adj)
 	return ice_ptp_adj_clock(hw, adj);
 }
 
+/**
+ * ice_base_incval - Get base timer increment value
+ * @pf: Board private structure
+ *
+ * Look up the base timer increment value for this device. The base increment
+ * value is used to define the nominal clock tick rate. This increment value
+ * is programmed during device initialization. It is also used as the basis
+ * for calculating adjustments using scaled_ppm.
+ */
+static u64 ice_base_incval(struct ice_pf *pf)
+{
+	return ICE_PTP_NOMINAL_INCVAL_E810;
+}
+
 /**
  * ice_ptp_adjfine - Adjust clock increment rate
  * @info: the driver's PTP info structure
@@ -452,7 +466,7 @@ static int ice_ptp_adjfine(struct ptp_clock_info *info, long scaled_ppm)
 	int neg_adj = 0;
 	int err;
 
-	incval = ICE_PTP_NOMINAL_INCVAL_E810;
+	incval = ice_base_incval(pf);
 
 	if (scaled_ppm < 0) {
 		neg_adj = 1;
@@ -1465,7 +1479,7 @@ static int ice_ptp_init_owner(struct ice_pf *pf)
 	}
 
 	/* Write the increment time value to PHY and LAN */
-	err = ice_ptp_write_incval(hw, ICE_PTP_NOMINAL_INCVAL_E810);
+	err = ice_ptp_write_incval(hw, ice_base_incval(pf));
 	if (err) {
 		ice_ptp_unlock(hw);
 		goto err_exit;
-- 
2.26.2

