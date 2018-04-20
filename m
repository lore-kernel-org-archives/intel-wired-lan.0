From: Alice Michael <alice.michael@intel.com>
Date: Fri, 20 Apr 2018 01:41:36 -0700
Subject: [Intel-wired-lan] [next PATCH S90 4/8] i40evf: Fix turning TSO,
 GSO and GRO on after
In-Reply-To: <20180420084140.8081-1-alice.michael@intel.com>
References: <20180420084140.8081-1-alice.michael@intel.com>
Message-ID: <20180420084140.8081-4-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Pawe? Jab?o?ski <pawel.jablonski@intel.com>

This patch fixes the problem where each MTU change turns TSO,
GSO and GRO on from off state.

Now when TSO, GSO or GRO is turned off, MTU change does not
turn them on.

Signed-off-by: Pawe? Jab?o?ski <pawel.jablonski@intel.com>
---
 drivers/net/ethernet/intel/i40evf/i40evf_main.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index 28a8cc4..3f04a182 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -3357,6 +3357,24 @@ int i40evf_process_config(struct i40evf_adapter *adapter)
 	if (vfres->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_VLAN)
 		netdev->features |= NETIF_F_HW_VLAN_CTAG_FILTER;
 
+	/* Do not turn on offloads when they are requested to be turned off.
+	 * TSO needs minimum 576 bytes to work correctly.
+	 */
+	if (netdev->wanted_features) {
+		if (!(netdev->wanted_features & NETIF_F_TSO) ||
+		    netdev->mtu < 576)
+			netdev->features &= ~NETIF_F_TSO;
+		if (!(netdev->wanted_features & NETIF_F_TSO6) ||
+		    netdev->mtu < 576)
+			netdev->features &= ~NETIF_F_TSO6;
+		if (!(netdev->wanted_features & NETIF_F_TSO_ECN))
+			netdev->features &= ~NETIF_F_TSO_ECN;
+		if (!(netdev->wanted_features & NETIF_F_GRO))
+			netdev->features &= ~NETIF_F_GRO;
+		if (!(netdev->wanted_features & NETIF_F_GSO))
+			netdev->features &= ~NETIF_F_GSO;
+	}
+
 	adapter->vsi.id = adapter->vsi_res->vsi_id;
 
 	adapter->vsi.back = adapter;
-- 
2.9.5

