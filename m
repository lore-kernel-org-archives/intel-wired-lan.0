From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Wed, 26 Aug 2015 15:14:14 -0400
Subject: [Intel-wired-lan] [next PATCH S11 08/15] i40e/i40evf: assure clean
	asq status report
In-Reply-To: <1440616461-110869-1-git-send-email-catherine.sullivan@intel.com>
References: <1440616461-110869-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1440616461-110869-9-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Shannon Nelson <shannon.nelson@intel.com>

There was a possibility where the asq_last_status could get through without
update and thus report a previous error.  I don't think we've actually seen
this happen, but this patch will help make sure it doesn't.

Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
Signed-off-by: Christopher Pau <christopher.pau@intel.com>
Change-ID: I9e33927052a5ee6ea21f80b66d4c4b76c2760b17
---
 drivers/net/ethernet/intel/i40e/i40e_adminq.c   | 2 ++
 drivers/net/ethernet/intel/i40evf/i40e_adminq.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq.c b/drivers/net/ethernet/intel/i40e/i40e_adminq.c
index 3e0d200..f5692e1 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_adminq.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_adminq.c
@@ -742,6 +742,8 @@ i40e_status i40e_asq_send_command(struct i40e_hw *hw,
 	u16  retval = 0;
 	u32  val = 0;
 
+	hw->aq.asq_last_status = I40E_AQ_RC_OK;
+
 	val = rd32(hw, hw->aq.asq.head);
 	if (val >= hw->aq.num_asq_entries) {
 		i40e_debug(hw, I40E_DEBUG_AQ_MESSAGE,
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_adminq.c b/drivers/net/ethernet/intel/i40evf/i40e_adminq.c
index f08450b..21ce9a1 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_adminq.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_adminq.c
@@ -682,6 +682,8 @@ i40e_status i40evf_asq_send_command(struct i40e_hw *hw,
 	u16  retval = 0;
 	u32  val = 0;
 
+	hw->aq.asq_last_status = I40E_AQ_RC_OK;
+
 	val = rd32(hw, hw->aq.asq.head);
 	if (val >= hw->aq.num_asq_entries) {
 		i40e_debug(hw, I40E_DEBUG_AQ_MESSAGE,
-- 
1.9.3

