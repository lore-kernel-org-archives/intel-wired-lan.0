From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Thu, 27 Feb 2020 10:15:00 -0800
Subject: [Intel-wired-lan] [PATCH S40 10/15] ice: Increase mailbox receive
 queue length to maximum
In-Reply-To: <20200227181505.61720-1-anthony.l.nguyen@intel.com>
References: <20200227181505.61720-1-anthony.l.nguyen@intel.com>
Message-ID: <20200227181505.61720-10-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Lukasz Czapnik <lukasz.czapnik@intel.com>

Currently the PF's mailbox receive queue is only 512 entries. This fine,
but considering that all VF's mailbox send queues funnel into the PF's
single mailbox receive queue, let's increase it to the maximum size. This
will help prevent any possible bottleneck/slowdown occurring from the PF's
mailbox receive queue being full.

Signed-off-by: Lukasz Czapnik <lukasz.czapnik@intel.com>
Signed-off-by: Brett Creeley <brett.creeley@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h      | 1 -
 drivers/net/ethernet/intel/ice/ice_main.c | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index b32d9ed35b21..f237df923ea1 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -66,7 +66,6 @@ extern const char ice_drv_ver[];
 #define ICE_INT_NAME_STR_LEN	(IFNAMSIZ + 16)
 #define ICE_AQ_LEN		64
 #define ICE_MBXSQ_LEN		64
-#define ICE_MBXRQ_LEN		512
 #define ICE_MIN_MSIX		2
 #define ICE_NO_VSI		0xffff
 #define ICE_VSI_MAP_CONTIG	0
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 13ac6073a75d..af1c2be5f6ff 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -1524,7 +1524,7 @@ static void ice_set_ctrlq_len(struct ice_hw *hw)
 	hw->adminq.num_sq_entries = ICE_AQ_LEN;
 	hw->adminq.rq_buf_size = ICE_AQ_MAX_BUF_LEN;
 	hw->adminq.sq_buf_size = ICE_AQ_MAX_BUF_LEN;
-	hw->mailboxq.num_rq_entries = ICE_MBXRQ_LEN;
+	hw->mailboxq.num_rq_entries = PF_MBX_ARQLEN_ARQLEN_M;
 	hw->mailboxq.num_sq_entries = ICE_MBXSQ_LEN;
 	hw->mailboxq.rq_buf_size = ICE_MBXQ_MAX_BUF_LEN;
 	hw->mailboxq.sq_buf_size = ICE_MBXQ_MAX_BUF_LEN;
-- 
2.20.1

