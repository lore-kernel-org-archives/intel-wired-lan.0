From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Tue, 16 Apr 2019 10:35:00 -0700
Subject: [Intel-wired-lan] [PATCH S21 11/14] ice: Update function header
In-Reply-To: <20190416173503.29847-1-anirudh.venkataramanan@intel.com>
References: <20190416173503.29847-1-anirudh.venkataramanan@intel.com>
Message-ID: <20190416173503.29847-12-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Add some details to the function header for ice_deinit_hw.

Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 89204a289865..6d3b863e3302 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -862,6 +862,10 @@ enum ice_status ice_init_hw(struct ice_hw *hw)
 /**
  * ice_deinit_hw - unroll initialization operations done by ice_init_hw
  * @hw: pointer to the hardware structure
+ *
+ * This should be called only during nominal operation, not as a result of
+ * ice_init_hw() failing since ice_init_hw() will take care of unrolling
+ * applicable initializations if it fails for any reason.
  */
 void ice_deinit_hw(struct ice_hw *hw)
 {
-- 
2.20.1

