From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri,  4 Jun 2021 09:53:27 -0700
Subject: [Intel-wired-lan] [PATCH net-next 07/15] iavf: Restore non MAC
 filters after link down
In-Reply-To: <20210604165335.33329-1-anthony.l.nguyen@intel.com>
References: <20210604165335.33329-1-anthony.l.nguyen@intel.com>
Message-ID: <20210604165335.33329-7-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>

Restore VLAN filters after the link is brought down, and up - since all
filters are deleted from HW during the netdev link down routine.

Signed-off-by: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf.h      |  1 +
 drivers/net/ethernet/intel/iavf/iavf_main.c | 35 ++++++++++++++++++---
 2 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf.h b/drivers/net/ethernet/intel/iavf/iavf.h
index 1e996d9c1351..9ccb88e7fc65 100644
--- a/drivers/net/ethernet/intel/iavf/iavf.h
+++ b/drivers/net/ethernet/intel/iavf/iavf.h
@@ -39,6 +39,7 @@
 #include "iavf_txrx.h"
 #include "iavf_fdir.h"
 #include "iavf_adv_rss.h"
+#include <linux/bitmap.h>
 
 #define DEFAULT_DEBUG_LEVEL_SHIFT 3
 #define PFX "iavf: "
diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 1904000943dc..06db563a6190 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -666,6 +666,23 @@ static void iavf_del_vlan(struct iavf_adapter *adapter, u16 vlan)
 	spin_unlock_bh(&adapter->mac_vlan_list_lock);
 }
 
+/**
+ * iavf_restore_filters
+ * @adapter: board private structure
+ *
+ * Restore existing non MAC filters when VF netdev comes back up
+ **/
+static void iavf_restore_filters(struct iavf_adapter *adapter)
+{
+	/* re-add all VLAN filters */
+	if (VLAN_ALLOWED(adapter)) {
+		u16 vid;
+
+		for_each_set_bit(vid, adapter->vsi.active_vlans, VLAN_N_VID)
+			iavf_add_vlan(adapter, vid);
+	}
+}
+
 /**
  * iavf_vlan_rx_add_vid - Add a VLAN filter to a device
  * @netdev: network device struct
@@ -679,8 +696,11 @@ static int iavf_vlan_rx_add_vid(struct net_device *netdev,
 
 	if (!VLAN_ALLOWED(adapter))
 		return -EIO;
+
 	if (iavf_add_vlan(adapter, vid) == NULL)
 		return -ENOMEM;
+
+	set_bit(vid, adapter->vsi.active_vlans);
 	return 0;
 }
 
@@ -695,11 +715,13 @@ static int iavf_vlan_rx_kill_vid(struct net_device *netdev,
 {
 	struct iavf_adapter *adapter = netdev_priv(netdev);
 
-	if (VLAN_ALLOWED(adapter)) {
-		iavf_del_vlan(adapter, vid);
-		return 0;
-	}
-	return -EIO;
+	if (!VLAN_ALLOWED(adapter))
+		return -EIO;
+
+	iavf_del_vlan(adapter, vid);
+	clear_bit(vid, adapter->vsi.active_vlans);
+
+	return 0;
 }
 
 /**
@@ -3243,6 +3265,9 @@ static int iavf_open(struct net_device *netdev)
 
 	spin_unlock_bh(&adapter->mac_vlan_list_lock);
 
+	/* Restore VLAN filters that were removed with IFF_DOWN */
+	iavf_restore_filters(adapter);
+
 	iavf_configure(adapter);
 
 	iavf_up_complete(adapter);
-- 
2.20.1

