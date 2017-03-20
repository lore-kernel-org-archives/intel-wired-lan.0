From: Colin King <colin.king@canonical.com>
Date: Mon, 20 Mar 2017 14:46:27 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: fix memcpy with swapped arguments
Message-ID: <20170320144627.11524-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Colin Ian King <colin.king@canonical.com>

The current code copies an uninitialized params into
cdev->lan_info.params and then passes the uninitialized params
to the call cdev->client->ops->l2_param_change.  I believe the
order of the source and destination in the memcpy is the wrong
way around and should be swapped.

Detected with static analysis by cppcheck

Fixes: 0ef2d5afb12d ("i40e: KISS the client interface")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/ethernet/intel/i40e/i40e_client.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_client.c b/drivers/net/ethernet/intel/i40e/i40e_client.c
index a9f0d22a7cf4..191580ed946d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_client.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_client.c
@@ -147,7 +147,7 @@ void i40e_notify_client_of_l2_param_changes(struct i40e_vsi *vsi)
 		dev_dbg(&vsi->back->pdev->dev, "Client is not open, abort l2 param change\n");
 		return;
 	}
-	memcpy(&cdev->lan_info.params, &params, sizeof(struct i40e_params));
+	memcpy(&params, &cdev->lan_info.params, sizeof(struct i40e_params));
 	cdev->client->ops->l2_param_change(&cdev->lan_info, cdev->client,
 					   &params);
 }
-- 
2.11.0

