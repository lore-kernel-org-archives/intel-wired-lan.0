From: Alice Michael <alice.michael@intel.com>
Date: Thu, 10 May 2018 05:59:49 -0700
Subject: [Intel-wired-lan] [next PATCH S91-V1 11/11] i40evf: Fix a hardware
 reset support in VF driver
In-Reply-To: <20180510125949.79823-1-alice.michael@intel.com>
References: <20180510125949.79823-1-alice.michael@intel.com>
Message-ID: <20180510125949.79823-11-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Pawe? Jab?o?ski <pawel.jablonski@intel.com>

This patch fixes a hardware reset support in VF driver.
It is needed because when a hardware reset is detected
adapter->state is in __I40EVF_RESETTING state before
i40evf_reset_task is called. Without this patch
unloading VF driver after a hardware reset ends
with a system crash.

Signed-off-by: Pawe? Jab?o?ski <pawel.jablonski@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c     | 21 +++++++++++++++++++--
 drivers/net/ethernet/intel/i40evf/i40evf_main.c |  3 ++-
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index f17867a..b5daa5c 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -2841,6 +2841,23 @@ static int i40e_vlan_rx_add_vid(struct net_device *netdev,
 }
 
 /**
+ * i40e_vlan_rx_add_vid_up - Add a vlan id filter to HW offload in UP path
+ * @netdev: network interface to be adjusted
+ * @proto: unused protocol value
+ * @vid: vlan id to be added
+ **/
+static void i40e_vlan_rx_add_vid_up(struct net_device *netdev,
+				    __always_unused __be16 proto, u16 vid)
+{
+	struct i40e_netdev_priv *np = netdev_priv(netdev);
+	struct i40e_vsi *vsi = np->vsi;
+
+	if (vid >= VLAN_N_VID)
+		return;
+	set_bit(vid, vsi->active_vlans);
+}
+
+/**
  * i40e_vlan_rx_kill_vid - Remove a vlan id filter from HW offload
  * @netdev: network interface to be adjusted
  * @proto: unused protocol value
@@ -2882,8 +2899,8 @@ static void i40e_restore_vlan(struct i40e_vsi *vsi)
 		i40e_vlan_stripping_disable(vsi);
 
 	for_each_set_bit(vid, vsi->active_vlans, VLAN_N_VID)
-		i40e_vlan_rx_add_vid(vsi->netdev, htons(ETH_P_8021Q),
-				     vid);
+		i40e_vlan_rx_add_vid_up(vsi->netdev, htons(ETH_P_8021Q),
+					vid);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index 95a222d..a7b87f9 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -1925,7 +1925,8 @@ static void i40evf_reset_task(struct work_struct *work)
 	 * ndo_open() returning, so we can't assume it means all our open
 	 * tasks have finished, since we're not holding the rtnl_lock here.
 	 */
-	running = (adapter->state == __I40EVF_RUNNING);
+	running = ((adapter->state == __I40EVF_RUNNING) ||
+		   (adapter->state == __I40EVF_RESETTING));
 
 	if (running) {
 		netif_carrier_off(netdev);
-- 
2.9.5

