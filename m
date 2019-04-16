From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Tue, 16 Apr 2019 10:24:39 -0700
Subject: [Intel-wired-lan] [PATCH S19 15/15] ice: Fix LINE_SPACING style
 issue
In-Reply-To: <20190416172439.27908-1-anirudh.venkataramanan@intel.com>
References: <20190416172439.27908-1-anirudh.venkataramanan@intel.com>
Message-ID: <20190416172439.27908-16-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bruce Allan <bruce.w.allan@intel.com>

Fix a checkpatch "LINE_SPACING: Please don't use multiple blank lines"
issue that has snuck in to the code.

Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 5e2ec1eab5e5..87b75d42460b 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -2928,7 +2928,6 @@ ice_dis_vsi_txq(struct ice_port_info *pi, u16 vsi_handle, u8 tc, u8 num_queues,
 	if (!pi || pi->port_state != ICE_SCHED_PORT_STATE_READY)
 		return ICE_ERR_CFG;
 
-
 	if (!num_queues) {
 		/* if queue is disabled already yet the disable queue command
 		 * has to be sent to complete the VF reset, then call
-- 
2.20.1

