From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Thu, 27 Aug 2015 11:42:42 -0400
Subject: [Intel-wired-lan] [next PATCH S12 14/15] i40e/i40evf: save aq
	writeback for future inspection
In-Reply-To: <1440690163-128213-1-git-send-email-catherine.sullivan@intel.com>
References: <1440690163-128213-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1440690163-128213-15-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Shannon Nelson <shannon.nelson@intel.com>

Add the ability to save the AdminQ write back descriptor if a
caller supplies a buffer for it to be saved into.

Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
Change-ID: I3d1301d26360b39a2d66dc8569e851f54133a3af
---
 drivers/net/ethernet/intel/i40e/i40e_adminq.c   | 4 ++++
 drivers/net/ethernet/intel/i40e/i40e_adminq.h   | 1 +
 drivers/net/ethernet/intel/i40evf/i40e_adminq.c | 4 ++++
 drivers/net/ethernet/intel/i40evf/i40e_adminq.h | 1 +
 4 files changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq.c b/drivers/net/ethernet/intel/i40e/i40e_adminq.c
index f5692e1..00404fe 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_adminq.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_adminq.c
@@ -891,6 +891,10 @@ i40e_status i40e_asq_send_command(struct i40e_hw *hw,
 		   "AQTX: desc and buffer writeback:\n");
 	i40e_debug_aq(hw, I40E_DEBUG_AQ_COMMAND, (void *)desc, buff, buff_size);
 
+	/* save writeback aq if requested */
+	if (details->wb_desc)
+		*details->wb_desc = *desc_on_ring;
+
 	/* update the error if time out occurred */
 	if ((!cmd_completed) &&
 	    (!details->async && !details->postpone)) {
diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq.h b/drivers/net/ethernet/intel/i40e/i40e_adminq.h
index fa5c2cd..12fbbdd 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_adminq.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_adminq.h
@@ -69,6 +69,7 @@ struct i40e_asq_cmd_details {
 	u16 flags_dis;
 	bool async;
 	bool postpone;
+	struct i40e_aq_desc *wb_desc;
 };
 
 #define I40E_ADMINQ_DETAILS(R, i)   \
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_adminq.c b/drivers/net/ethernet/intel/i40evf/i40e_adminq.c
index 21ce9a1..48cce43f 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_adminq.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_adminq.c
@@ -832,6 +832,10 @@ i40e_status i40evf_asq_send_command(struct i40e_hw *hw,
 	i40evf_debug_aq(hw, I40E_DEBUG_AQ_COMMAND, (void *)desc, buff,
 			buff_size);
 
+	/* save writeback aq if requested */
+	if (details->wb_desc)
+		*details->wb_desc = *desc_on_ring;
+
 	/* update the error if time out occurred */
 	if ((!cmd_completed) &&
 	    (!details->async && !details->postpone)) {
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_adminq.h b/drivers/net/ethernet/intel/i40evf/i40e_adminq.h
index 81f9ffa..a3eae5d 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_adminq.h
+++ b/drivers/net/ethernet/intel/i40evf/i40e_adminq.h
@@ -69,6 +69,7 @@ struct i40e_asq_cmd_details {
 	u16 flags_dis;
 	bool async;
 	bool postpone;
+	struct i40e_aq_desc *wb_desc;
 };
 
 #define I40E_ADMINQ_DETAILS(R, i)   \
-- 
1.9.3

