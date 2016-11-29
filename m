From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Mon, 28 Nov 2016 16:06:01 -0800
Subject: [Intel-wired-lan] [next PATCH S55 04/14] i40e: remove unused
	function
In-Reply-To: <1480377971-23412-1-git-send-email-bimmy.pujari@intel.com>
References: <1480377971-23412-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1480377971-23412-5-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

After refactoring the client open and close code, this is no longer
needed. Remove it.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Change-ID: If8e6e32baa354d857c2fd8b2f19404f1786011c4
---
Testing Hints : No functional change, just dead
code.

 drivers/net/ethernet/intel/i40e/i40e.h        |  1 -
 drivers/net/ethernet/intel/i40e/i40e_client.c | 35 ---------------------------
 2 files changed, 36 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 05552b0..eb01dac 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -831,7 +831,6 @@ int i40e_lan_add_device(struct i40e_pf *pf);
 int i40e_lan_del_device(struct i40e_pf *pf);
 void i40e_client_subtask(struct i40e_pf *pf);
 void i40e_notify_client_of_l2_param_changes(struct i40e_vsi *vsi);
-void i40e_notify_client_of_netdev_open(struct i40e_vsi *vsi);
 void i40e_notify_client_of_netdev_close(struct i40e_vsi *vsi, bool reset);
 void i40e_notify_client_of_vf_enable(struct i40e_pf *pf, u32 num_vfs);
 void i40e_notify_client_of_vf_reset(struct i40e_pf *pf, u32 vf_id);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_client.c b/drivers/net/ethernet/intel/i40e/i40e_client.c
index 7fe72ab..7ca048f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_client.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_client.c
@@ -201,41 +201,6 @@ void i40e_notify_client_of_l2_param_changes(struct i40e_vsi *vsi)
 }
 
 /**
- * i40e_notify_client_of_netdev_open - call the client open callback
- * @vsi: the VSI with netdev opened
- *
- * If there is a client to this netdev, call the client with open
- **/
-void i40e_notify_client_of_netdev_open(struct i40e_vsi *vsi)
-{
-	struct i40e_client_instance *cdev;
-	int ret = 0;
-
-	if (!vsi)
-		return;
-	mutex_lock(&i40e_client_instance_mutex);
-	list_for_each_entry(cdev, &i40e_client_instances, list) {
-		if (cdev->lan_info.netdev == vsi->netdev) {
-			if (!cdev->client ||
-			    !cdev->client->ops || !cdev->client->ops->open) {
-				dev_dbg(&vsi->back->pdev->dev,
-					"Cannot locate client instance open routine\n");
-				continue;
-			}
-			if (!(test_bit(__I40E_CLIENT_INSTANCE_OPENED,
-				       &cdev->state))) {
-				ret = cdev->client->ops->open(&cdev->lan_info,
-							      cdev->client);
-				if (!ret)
-					set_bit(__I40E_CLIENT_INSTANCE_OPENED,
-						&cdev->state);
-			}
-		}
-	}
-	mutex_unlock(&i40e_client_instance_mutex);
-}
-
-/**
  * i40e_client_release_qvlist
  * @ldev: pointer to L2 context.
  *
-- 
2.4.11

