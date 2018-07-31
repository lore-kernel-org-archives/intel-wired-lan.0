From: Alice Michael <alice.michael@intel.com>
Date: Tue, 31 Jul 2018 03:41:46 -0700
Subject: [Intel-wired-lan] [next PATCH S93 09/11] i40e: Add additional
 return code to i40e_asq_send_command
In-Reply-To: <20180731104148.11896-1-alice.michael@intel.com>
References: <20180731104148.11896-1-alice.michael@intel.com>
Message-ID: <20180731104148.11896-9-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Piotr Azarewicz <piotr.azarewicz@intel.com>

Firmware can return a busy state, so the function return
I40E_ERR_NOT_READY.

Signed-off-by: Piotr Azarewicz <piotr.azarewicz@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_adminq.c   | 2 ++
 drivers/net/ethernet/intel/i40evf/i40e_adminq.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq.c b/drivers/net/ethernet/intel/i40e/i40e_adminq.c
index ddbea79..501ee71 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_adminq.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_adminq.c
@@ -868,6 +868,8 @@ i40e_status i40e_asq_send_command(struct i40e_hw *hw,
 		cmd_completed = true;
 		if ((enum i40e_admin_queue_err)retval == I40E_AQ_RC_OK)
 			status = 0;
+		else if ((enum i40e_admin_queue_err)retval == I40E_AQ_RC_EBUSY)
+			status = I40E_ERR_NOT_READY;
 		else
 			status = I40E_ERR_ADMIN_QUEUE_ERROR;
 		hw->aq.asq_last_status = (enum i40e_admin_queue_err)retval;
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_adminq.c b/drivers/net/ethernet/intel/i40evf/i40e_adminq.c
index c355120..21a0dbf 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_adminq.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_adminq.c
@@ -797,6 +797,8 @@ i40e_status i40evf_asq_send_command(struct i40e_hw *hw,
 		cmd_completed = true;
 		if ((enum i40e_admin_queue_err)retval == I40E_AQ_RC_OK)
 			status = 0;
+		else if ((enum i40e_admin_queue_err)retval == I40E_AQ_RC_EBUSY)
+			status = I40E_ERR_NOT_READY;
 		else
 			status = I40E_ERR_ADMIN_QUEUE_ERROR;
 		hw->aq.asq_last_status = (enum i40e_admin_queue_err)retval;
-- 
2.9.5

