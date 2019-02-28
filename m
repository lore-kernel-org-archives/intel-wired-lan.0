From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Thu, 28 Feb 2019 15:25:49 -0800
Subject: [Intel-wired-lan] [PATCH S17 03/17] ice: Return configuration error
 without queue to disable
In-Reply-To: <20190228232603.32156-1-anirudh.venkataramanan@intel.com>
References: <20190228232603.32156-1-anirudh.venkataramanan@intel.com>
Message-ID: <20190228232603.32156-4-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>

If there is no queue to disable, return appropriate configuration error
earlier without acquiring the lock.

Signed-off-by: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 0a57b726b1f0..9e2171b93d77 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -2932,14 +2932,17 @@ ice_dis_vsi_txq(struct ice_port_info *pi, u16 vsi_handle, u8 tc, u8 num_queues,
 	if (!pi || pi->port_state != ICE_SCHED_PORT_STATE_READY)
 		return ICE_ERR_CFG;
 
-	/* if queue is disabled already yet the disable queue command has to be
-	 * sent to complete the VF reset, then call ice_aq_dis_lan_txq without
-	 * any queue information
-	 */
 
-	if (!num_queues && rst_src)
-		return ice_aq_dis_lan_txq(pi->hw, 0, NULL, 0, rst_src, vmvf_num,
-					  NULL);
+	if (!num_queues) {
+		/* if queue is disabled already yet the disable queue command
+		 * has to be sent to complete the VF reset, then call
+		 * ice_aq_dis_lan_txq without any queue information
+		 */
+		if (rst_src)
+			return ice_aq_dis_lan_txq(pi->hw, 0, NULL, 0, rst_src,
+						  vmvf_num, NULL);
+		return ICE_ERR_CFG;
+	}
 
 	mutex_lock(&pi->sched_lock);
 
-- 
2.14.5

