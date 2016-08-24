From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Wed, 24 Aug 2016 11:33:48 -0700
Subject: [Intel-wired-lan] [next PATCH S44 3/6] i40e: Change some init flow
	for the client
In-Reply-To: <1472063631-9033-1-git-send-email-bimmy.pujari@intel.com>
References: <1472063631-9033-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1472063631-9033-4-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Anjali Singhai Jain <anjali.singhai@intel.com>

This change makes a common flow for Client instance open during init
and reset path. The Client subtask can handle both the cases instead of
making a separate notify_client_of_open call.
Also it may fix a bug during reset where the service task was leaking
some memory and causing issues.

HSD-number: 7660752
Testing Hints :
The original bug related to the HSD was due the IWARP driver setting
LAUNCH_ON_PROBE flag on its sidem which should be fixed
in the IWARP driver. This is further cleanup.
Test with init/reset/up/down/remove combinations on both LAN and IWARP
driver side.

Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
Change-Id: I7232a32fd52b82e863abb54266fa83122f80a0cd
---
 drivers/net/ethernet/intel/i40e/i40e_client.c | 41 ++++++++++++++++++++-------
 drivers/net/ethernet/intel/i40e/i40e_main.c   |  1 -
 2 files changed, 30 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_client.c b/drivers/net/ethernet/intel/i40e/i40e_client.c
index 5404b32..250db0b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_client.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_client.c
@@ -209,6 +209,7 @@ void i40e_notify_client_of_l2_param_changes(struct i40e_vsi *vsi)
 void i40e_notify_client_of_netdev_open(struct i40e_vsi *vsi)
 {
 	struct i40e_client_instance *cdev;
+	int ret = 0;
 
 	if (!vsi)
 		return;
@@ -221,7 +222,14 @@ void i40e_notify_client_of_netdev_open(struct i40e_vsi *vsi)
 					"Cannot locate client instance open routine\n");
 				continue;
 			}
-			cdev->client->ops->open(&cdev->lan_info, cdev->client);
+			if (!(test_bit(__I40E_CLIENT_INSTANCE_OPENED,
+				       &cdev->state))) {
+				ret = cdev->client->ops->open(&cdev->lan_info,
+							      cdev->client);
+				if (!ret)
+					set_bit(__I40E_CLIENT_INSTANCE_OPENED,
+						&cdev->state);
+			}
 		}
 	}
 	mutex_unlock(&i40e_client_instance_mutex);
@@ -432,12 +440,14 @@ struct i40e_vsi *i40e_vsi_lookup(struct i40e_pf *pf,
  * i40e_client_add_instance - add a client instance struct to the instance list
  * @pf: pointer to the board struct
  * @client: pointer to a client struct in the client list.
+ * @existing: if there was already an existing instance
  *
- * Returns cdev ptr on success, NULL on failure
+ * Returns cdev ptr on success or if already exists, NULL on failure
  **/
 static
 struct i40e_client_instance *i40e_client_add_instance(struct i40e_pf *pf,
-						      struct i40e_client *client)
+						     struct i40e_client *client,
+						     bool *existing)
 {
 	struct i40e_client_instance *cdev;
 	struct netdev_hw_addr *mac = NULL;
@@ -446,7 +456,7 @@ struct i40e_client_instance *i40e_client_add_instance(struct i40e_pf *pf,
 	mutex_lock(&i40e_client_instance_mutex);
 	list_for_each_entry(cdev, &i40e_client_instances, list) {
 		if ((cdev->lan_info.pf == pf) && (cdev->client == client)) {
-			cdev = NULL;
+			*existing = true;
 			goto out;
 		}
 	}
@@ -530,6 +540,7 @@ void i40e_client_subtask(struct i40e_pf *pf)
 {
 	struct i40e_client_instance *cdev;
 	struct i40e_client *client;
+	bool existing = false;
 	int ret = 0;
 
 	if (!(pf->flags & I40E_FLAG_SERVICE_CLIENT_REQUESTED))
@@ -553,18 +564,25 @@ void i40e_client_subtask(struct i40e_pf *pf)
 			/* check if L2 VSI is up, if not we are not ready */
 			if (test_bit(__I40E_DOWN, &pf->vsi[pf->lan_vsi]->state))
 				continue;
+		} else {
+			dev_warn(&pf->pdev->dev, "This client %s is being instanciated at probe\n",
+				 client->name);
 		}
 
 		/* Add the client instance to the instance list */
-		cdev = i40e_client_add_instance(pf, client);
+		cdev = i40e_client_add_instance(pf, client, &existing);
 		if (!cdev)
 			continue;
 
-		/* Also up the ref_cnt of no. of instances of this client */
-		atomic_inc(&client->ref_cnt);
-		dev_info(&pf->pdev->dev, "Added instance of Client %s to PF%d bus=0x%02x func=0x%02x\n",
-			 client->name, pf->hw.pf_id,
-			 pf->hw.bus.device, pf->hw.bus.func);
+		if (!existing) {
+			/* Also up the ref_cnt for no. of instances of this
+			 * client.
+			 */
+			atomic_inc(&client->ref_cnt);
+			dev_info(&pf->pdev->dev, "Added instance of Client %s to PF%d bus=0x%02x func=0x%02x\n",
+				 client->name, pf->hw.pf_id,
+				 pf->hw.bus.device, pf->hw.bus.func);
+		}
 
 		mutex_lock(&i40e_client_instance_mutex);
 		/* Send an Open request to the client */
@@ -616,7 +634,8 @@ int i40e_lan_add_device(struct i40e_pf *pf)
 		 pf->hw.pf_id, pf->hw.bus.device, pf->hw.bus.func);
 
 	/* Since in some cases register may have happened before a device gets
-	 * added, we can schedule a subtask to go initiate the clients.
+	 * added, we can schedule a subtask to go initiate the clients if
+	 * they can be launched at probe time.
 	 */
 	pf->flags |= I40E_FLAG_SERVICE_CLIENT_REQUESTED;
 	i40e_service_event_schedule(pf);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 196a7750..47cf91c 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -5416,7 +5416,6 @@ int i40e_open(struct net_device *netdev)
 	wr32(&pf->hw, I40E_GLLAN_TSOMSK_L, be32_to_cpu(TCP_FLAG_CWR) >> 16);
 
 	udp_tunnel_get_rx_info(netdev);
-	i40e_notify_client_of_netdev_open(vsi);
 
 	return 0;
 }
-- 
2.4.11

