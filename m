From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Date: Fri, 17 Dec 2021 14:29:05 +0000
Subject: [Intel-wired-lan] [PATCH net v3] i40e: Fix incorrect netdev's real
 number of RX/TX queues
Message-ID: <20211217142905.41053-1-jedrzej.jagielski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

There was a wrong queues representation in sysfs during
driver's reinitialization in case of online cpus number is
less than combined queues. It was caused by stopped
NetworkManager, which is responsible for calling vsi_open
function during driver's initialization.
In specific situation (ex. 12 cpus online) there were 16 queues
in /sys/class/net/<iface>/queues. In case of modifying queues with
value higher, than number of online cpus, then it caused write
errors and other errors.
Add updating of sysfs's queues representation during driver
initialization.

Fixes: 41c445ff0f48 ("i40e: main driver core")
Signed-off-by: Lukasz Cieplicki <lukaszx.cieplicki@intel.com>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
---
v2:Fix "CHECK: Lines should not end with a '('" warning
v3:Add error check and make i40e_vsi_open() to use new function
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 35 ++++++++++++++++-----
 1 file changed, 28 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 4ff1c9b9217b..bfa134c52b6e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -8778,6 +8778,30 @@ int i40e_open(struct net_device *netdev)
 	return 0;
 }
 
+/**
+ * i40e_netif_set_realnum_tx_rx_queues - Update number of tx/rx queues
+ * @vsi: vsi structure
+ *
+ * This updates netdev's number of tx/rx queues
+ *
+ * Returns status of setting tx/rx queues
+ **/
+static int i40e_netif_set_realnum_tx_rx_queues(struct i40e_vsi *vsi)
+{
+	int ret;
+
+	if (!vsi)
+		return I40E_ERR_PARAM;
+
+	ret = netif_set_real_num_rx_queues(vsi->netdev,
+					   vsi->num_queue_pairs);
+	if (ret)
+		return ret;
+
+	return netif_set_real_num_tx_queues(vsi->netdev,
+					    vsi->num_queue_pairs);
+}
+
 /**
  * i40e_vsi_open -
  * @vsi: the VSI to open
@@ -8814,13 +8838,7 @@ int i40e_vsi_open(struct i40e_vsi *vsi)
 			goto err_setup_rx;
 
 		/* Notify the stack of the actual queue counts. */
-		err = netif_set_real_num_tx_queues(vsi->netdev,
-						   vsi->num_queue_pairs);
-		if (err)
-			goto err_set_queues;
-
-		err = netif_set_real_num_rx_queues(vsi->netdev,
-						   vsi->num_queue_pairs);
+		err = i40e_netif_set_realnum_tx_rx_queues(vsi);
 		if (err)
 			goto err_set_queues;
 
@@ -14203,6 +14221,9 @@ struct i40e_vsi *i40e_vsi_setup(struct i40e_pf *pf, u8 type,
 	case I40E_VSI_MAIN:
 	case I40E_VSI_VMDQ2:
 		ret = i40e_config_netdev(vsi);
+		if (ret)
+			goto err_netdev;
+		ret = i40e_netif_set_realnum_tx_rx_queues(vsi);
 		if (ret)
 			goto err_netdev;
 		ret = register_netdev(vsi->netdev);
-- 
2.27.0

