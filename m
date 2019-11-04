From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Mon,  4 Nov 2019 01:31:08 -0800
Subject: [Intel-wired-lan] [PATCH S32 v2 15/15] ice: print opcode when
 printing controlq errors
In-Reply-To: <20191104093108.21542-1-anthony.l.nguyen@intel.com>
References: <20191104093108.21542-1-anthony.l.nguyen@intel.com>
Message-ID: <20191104093108.21542-15-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

To help aid in debugging, display the command opcode in debug messages
that print an error code. This makes it easier to see what command
failed if only ICE_DBG_AQ_MSG is enabled.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_controlq.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_controlq.c b/drivers/net/ethernet/intel/ice/ice_controlq.c
index 947728aada46..dd946866d7b8 100644
--- a/drivers/net/ethernet/intel/ice/ice_controlq.c
+++ b/drivers/net/ethernet/intel/ice/ice_controlq.c
@@ -1017,7 +1017,8 @@ ice_sq_send_cmd(struct ice_hw *hw, struct ice_ctl_q_info *cq,
 		retval = le16_to_cpu(desc->retval);
 		if (retval) {
 			ice_debug(hw, ICE_DBG_AQ_MSG,
-				  "Control Send Queue command completed with error 0x%x\n",
+				  "Control Send Queue command 0x%04X completed with error 0x%X\n",
+				  le16_to_cpu(desc->opcode),
 				  retval);
 
 			/* strip off FW internal code */
@@ -1121,7 +1122,8 @@ ice_clean_rq_elem(struct ice_hw *hw, struct ice_ctl_q_info *cq,
 	if (flags & ICE_AQ_FLAG_ERR) {
 		ret_code = ICE_ERR_AQ_ERROR;
 		ice_debug(hw, ICE_DBG_AQ_MSG,
-			  "Control Receive Queue Event received with error 0x%x\n",
+			  "Control Receive Queue Event 0x%04X received with error 0x%X\n",
+			  le16_to_cpu(desc->opcode),
 			  cq->rq_last_status);
 	}
 	memcpy(&e->desc, desc, sizeof(e->desc));
-- 
2.20.1

