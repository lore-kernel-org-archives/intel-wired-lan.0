From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Mon, 28 Sep 2015 14:12:39 -0400
Subject: [Intel-wired-lan] [next PATCH S16 10/15] i40e: reset the invalid
	msg counter in vf when a valid msg is received
In-Reply-To: <1443463964-148204-1-git-send-email-catherine.sullivan@intel.com>
References: <1443463964-148204-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1443463964-148204-11-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jingjing Wu <jingjing.wu@intel.com>

When the number of invalid messages from a VF is exceeded, the VF
will be disabled, due to the invalid messages.  This happens if
other VF drivers (like DPDK) send a message through the driver's
mailbox (aka virtchannel) interface, but the message is not
supported by the i40e pf driver, such as CONFIG_PROMISCUOUS_MODE.

This patch changes the num_invalid_msgs in struct i40e_vf to record
the continuous invalid msgs, and it will be reset when a valid msg
is received.

Signed-off-by: Jingjing Wu <jingjing.wu@intel.com>
Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Change-ID: Iaec42fd3dcdd281476b3518be23261dd46fc3718
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 2 ++
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 3ed8b98..d84b727 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -1105,6 +1105,8 @@ static int i40e_vc_send_msg_to_vf(struct i40e_vf *vf, u32 v_opcode,
 		}
 	} else {
 		vf->num_valid_msgs++;
+		/* reset the invalid counter, if a valid message is received. */
+		vf->num_invalid_msgs = 0;
 	}
 
 	aq_ret = i40e_aq_send_msg_to_vf(hw, abs_vf_id,	v_opcode, v_retval,
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
index 7fe94e8..da44995 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
@@ -96,7 +96,8 @@ struct i40e_vf {
 
 	u8 num_queue_pairs;	/* num of qps assigned to VF vsis */
 	u64 num_mdd_events;	/* num of mdd events detected */
-	u64 num_invalid_msgs;	/* num of malformed or invalid msgs detected */
+	/* num of continuous malformed or invalid msgs detected */
+	u64 num_invalid_msgs;
 	u64 num_valid_msgs;	/* num of valid msgs detected */
 
 	unsigned long vf_caps;	/* vf's adv. capabilities */
-- 
1.9.3

