From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Mon, 28 Nov 2016 16:06:04 -0800
Subject: [Intel-wired-lan] [next PATCH S55 07/14] i40e: don't check params
	until after checking for client instance
In-Reply-To: <1480377971-23412-1-git-send-email-bimmy.pujari@intel.com>
References: <1480377971-23412-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1480377971-23412-8-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

We can avoid the minor bit of work by calling check params after we
check for the client instance, since we're about to return early in
cases where we do not have a client.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Change-ID: I56f8ea2ba48d4f571fa331c9ace50819a022fa1c
---
 drivers/net/ethernet/intel/i40e/i40e_client.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_client.c b/drivers/net/ethernet/intel/i40e/i40e_client.c
index 7ca048f..f6409f9 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_client.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_client.c
@@ -174,8 +174,6 @@ void i40e_notify_client_of_l2_param_changes(struct i40e_vsi *vsi)
 
 	if (!vsi)
 		return;
-	memset(&params, 0, sizeof(params));
-	i40e_client_get_params(vsi, &params);
 	mutex_lock(&i40e_client_instance_mutex);
 	list_for_each_entry(cdev, &i40e_client_instances, list) {
 		if (cdev->lan_info.pf == vsi->back) {
@@ -186,6 +184,8 @@ void i40e_notify_client_of_l2_param_changes(struct i40e_vsi *vsi)
 					"Cannot locate client instance l2_param_change routine\n");
 				continue;
 			}
+	memset(&params, 0, sizeof(params));
+	i40e_client_get_params(vsi, &params);
 			if (!test_bit(__I40E_CLIENT_INSTANCE_OPENED,
 				      &cdev->state)) {
 				dev_dbg(&vsi->back->pdev->dev, "Client is not open, abort l2 param change\n");
-- 
2.4.11

