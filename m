From: Alice Michael <alice.michael@intel.com>
Date: Fri,  3 Nov 2017 07:05:10 -0400
Subject: [Intel-wired-lan] [next PATCH S82 8/9] i40evf: fix client notify of
 l2 params
In-Reply-To: <20171103110511.76793-1-alice.michael@intel.com>
References: <20171103110511.76793-1-alice.michael@intel.com>
Message-ID: <20171103110511.76793-8-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alan Brady <alan.brady@intel.com>

The current method for notifying clients of l2 parameters is broken
because we fail to copy the new parameters to the client instance
struct, we need to do the notification before the client 'open' function
pointer gets called, and lastly we should set the l2 parameters when
first adding a client instance.

This patch first introduces the i40evf_client_get_params function to
prevent code duplication in the i40evf_client_add_instance and the
i40evf_notify_client_l2_params functions.  We then fix the notify l2
params function to actually copy the parameters to client instance
struct and do the same in the *_add_instance' function.  Lastly this
patch reorganizes the priority in which client tasks fire so that if the
flag for notifying l2 params is set, it will trigger before the open
because the client needs these new parameters as part of a client open
task.

Signed-off-by: Alan Brady <alan.brady@intel.com>
---
 drivers/net/ethernet/intel/i40evf/i40evf_client.c | 38 ++++++++++++++++-------
 drivers/net/ethernet/intel/i40evf/i40evf_main.c   | 10 +++---
 2 files changed, 31 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_client.c b/drivers/net/ethernet/intel/i40evf/i40evf_client.c
index 93cf5fd..3bcd1dc 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_client.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_client.c
@@ -25,6 +25,26 @@ static struct i40e_ops i40evf_lan_ops = {
 };
 
 /**
+ * i40evf_client_get_params - retrieve relevant client parameters
+ * @vsi: VSI with parameters
+ * @params: client param struct
+ **/
+static
+void i40evf_client_get_params(struct i40e_vsi *vsi, struct i40e_params *params)
+{
+	int i;
+
+	memset(params, 0, sizeof(struct i40e_params));
+	params->mtu = vsi->netdev->mtu;
+	params->link_up = vsi->back->link_up;
+
+	for (i = 0; i < I40E_MAX_USER_PRIORITY; i++) {
+		params->qos.prio_qos[i].tc = 0;
+		params->qos.prio_qos[i].qs_handle = vsi->qs_handle;
+	}
+}
+
+/**
  * i40evf_notify_client_message - call the client message receive callback
  * @vsi: the VSI associated with this client
  * @msg: message buffer
@@ -65,10 +85,6 @@ void i40evf_notify_client_l2_params(struct i40e_vsi *vsi)
 		return;
 
 	cinst = vsi->back->cinst;
-	memset(&params, 0, sizeof(params));
-	params.mtu = vsi->netdev->mtu;
-	params.link_up = vsi->back->link_up;
-	params.qos.prio_qos[0].qs_handle = vsi->qs_handle;
 
 	if (!cinst || !cinst->client || !cinst->client->ops ||
 	    !cinst->client->ops->l2_param_change) {
@@ -76,6 +92,8 @@ void i40evf_notify_client_l2_params(struct i40e_vsi *vsi)
 			"Cannot locate client instance l2_param_change function\n");
 		return;
 	}
+	i40evf_client_get_params(vsi, &params);
+	cinst->lan_info.params = params;
 	cinst->client->ops->l2_param_change(&cinst->lan_info, cinst->client,
 					    &params);
 }
@@ -165,9 +183,9 @@ static struct i40e_client_instance *
 i40evf_client_add_instance(struct i40evf_adapter *adapter)
 {
 	struct i40e_client_instance *cinst = NULL;
-	struct netdev_hw_addr *mac = NULL;
 	struct i40e_vsi *vsi = &adapter->vsi;
-	int i;
+	struct netdev_hw_addr *mac = NULL;
+	struct i40e_params params;
 
 	if (!vf_registered_client)
 		goto out;
@@ -191,18 +209,14 @@ i40evf_client_add_instance(struct i40evf_adapter *adapter)
 	cinst->lan_info.version.major = I40EVF_CLIENT_VERSION_MAJOR;
 	cinst->lan_info.version.minor = I40EVF_CLIENT_VERSION_MINOR;
 	cinst->lan_info.version.build = I40EVF_CLIENT_VERSION_BUILD;
+	i40evf_client_get_params(vsi, &params);
+	cinst->lan_info.params = params;
 	set_bit(__I40E_CLIENT_INSTANCE_NONE, &cinst->state);
 
 	cinst->lan_info.msix_count = adapter->num_iwarp_msix;
 	cinst->lan_info.msix_entries =
 			&adapter->msix_entries[adapter->iwarp_base_vector];
 
-	for (i = 0; i < I40E_MAX_USER_PRIORITY; i++) {
-		cinst->lan_info.params.qos.prio_qos[i].tc = 0;
-		cinst->lan_info.params.qos.prio_qos[i].qs_handle =
-								vsi->qs_handle;
-	}
-
 	mac = list_first_entry(&cinst->lan_info.netdev->dev_addrs.list,
 			       struct netdev_hw_addr, list);
 	if (mac)
diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index 5e27619..f92587a 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -2074,6 +2074,11 @@ static void i40evf_client_task(struct work_struct *work)
 		adapter->flags &= ~I40EVF_FLAG_SERVICE_CLIENT_REQUESTED;
 		goto out;
 	}
+	if (adapter->flags & I40EVF_FLAG_CLIENT_NEEDS_L2_PARAMS) {
+		i40evf_notify_client_l2_params(&adapter->vsi);
+		adapter->flags &= ~I40EVF_FLAG_CLIENT_NEEDS_L2_PARAMS;
+		goto out;
+	}
 	if (adapter->flags & I40EVF_FLAG_CLIENT_NEEDS_CLOSE) {
 		i40evf_notify_client_close(&adapter->vsi, false);
 		adapter->flags &= ~I40EVF_FLAG_CLIENT_NEEDS_CLOSE;
@@ -2082,11 +2087,6 @@ static void i40evf_client_task(struct work_struct *work)
 	if (adapter->flags & I40EVF_FLAG_CLIENT_NEEDS_OPEN) {
 		i40evf_notify_client_open(&adapter->vsi);
 		adapter->flags &= ~I40EVF_FLAG_CLIENT_NEEDS_OPEN;
-		goto out;
-	}
-	if (adapter->flags & I40EVF_FLAG_CLIENT_NEEDS_L2_PARAMS) {
-		i40evf_notify_client_l2_params(&adapter->vsi);
-		adapter->flags &= ~I40EVF_FLAG_CLIENT_NEEDS_L2_PARAMS;
 	}
 out:
 	clear_bit(__I40EVF_IN_CLIENT_TASK, &adapter->crit_section);
-- 
2.9.5

