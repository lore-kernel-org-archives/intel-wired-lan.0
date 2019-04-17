From: Alice Michael <alice.michael@intel.com>
Date: Wed, 17 Apr 2019 15:17:31 -0700
Subject: [Intel-wired-lan] [next PATCH S4 iavf 3/9] iavf: rename i40e
 functions to be iavf
In-Reply-To: <20190417221737.11460-1-alice.michael@intel.com>
References: <20190417221737.11460-1-alice.michael@intel.com>
Message-ID: <20190417221737.11460-3-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Update the old i40e function names to be iavf

Signed-off-by: Alice Michael <alice.michael@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_adminq.c    | 6 +++---
 drivers/net/ethernet/intel/iavf/iavf_prototype.h | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_adminq.c b/drivers/net/ethernet/intel/iavf/iavf_adminq.c
index 22d3b79a6049..59025172f3fa 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_adminq.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_adminq.c
@@ -8,12 +8,12 @@
 #include "iavf_prototype.h"
 
 /**
- *  i40e_adminq_init_regs - Initialize AdminQ registers
+ *  iavf_adminq_init_regs - Initialize AdminQ registers
  *  @hw: pointer to the hardware structure
  *
  *  This assumes the alloc_asq and alloc_arq functions have already been called
  **/
-static void i40e_adminq_init_regs(struct iavf_hw *hw)
+static void iavf_adminq_init_regs(struct iavf_hw *hw)
 {
 	/* set head and tail registers in our local struct */
 	hw->aq.asq.tail = IAVF_VF_ATQT1;
@@ -519,7 +519,7 @@ enum iavf_status iavf_init_adminq(struct iavf_hw *hw)
 	}
 
 	/* Set up register offsets */
-	i40e_adminq_init_regs(hw);
+	iavf_adminq_init_regs(hw);
 
 	/* setup ASQ command write back timeout */
 	hw->aq.asq_cmd_timeout = I40E_ASQ_CMD_TIMEOUT;
diff --git a/drivers/net/ethernet/intel/iavf/iavf_prototype.h b/drivers/net/ethernet/intel/iavf/iavf_prototype.h
index 2ff49dc75e31..0dea4419c01f 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_prototype.h
+++ b/drivers/net/ethernet/intel/iavf/iavf_prototype.h
@@ -18,7 +18,7 @@
 /* adminq functions */
 enum iavf_status iavf_init_adminq(struct iavf_hw *hw);
 enum iavf_status iavf_shutdown_adminq(struct iavf_hw *hw);
-void i40e_adminq_init_ring_data(struct iavf_hw *hw);
+void iavf_adminq_init_ring_data(struct iavf_hw *hw);
 enum iavf_status iavf_clean_arq_element(struct iavf_hw *hw,
 					struct i40e_arq_event_info *e,
 					u16 *events_pending);
@@ -33,7 +33,7 @@ bool iavf_asq_done(struct iavf_hw *hw);
 void iavf_debug_aq(struct iavf_hw *hw, enum iavf_debug_mask mask,
 		   void *desc, void *buffer, u16 buf_len);
 
-void i40e_idle_aq(struct iavf_hw *hw);
+void iavf_idle_aq(struct iavf_hw *hw);
 void iavf_resume_aq(struct iavf_hw *hw);
 bool iavf_check_asq_alive(struct iavf_hw *hw);
 enum iavf_status iavf_aq_queue_shutdown(struct iavf_hw *hw, bool unloading);
-- 
2.19.2

