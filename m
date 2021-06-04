From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri,  4 Jun 2021 09:48:53 -0700
Subject: [Intel-wired-lan] [PATCH net 1/8] iavf: check for null in
 iavf_fix_features
Message-ID: <20210604164900.33156-1-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Nicholas Nunley <nicholas.d.nunley@intel.com>

If the driver has lost contact with the PF then it enters a disabled state
and frees adapter->vf_res. However, ndo_fix_features can still be called on
the interface, so we need to check for this condition first. Since we have
no information on the features at this time simply leave them unmodified
and return.

Fixes: c4445aedfe09 ("i40evf: Fix VLAN features")
Signed-off-by: Nicholas Nunley <nicholas.d.nunley@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index fb4e3fe5cd1b..ad3f804f0e14 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -3437,7 +3437,8 @@ static netdev_features_t iavf_fix_features(struct net_device *netdev,
 {
 	struct iavf_adapter *adapter = netdev_priv(netdev);
 
-	if (!(adapter->vf_res->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_VLAN))
+	if (adapter->vf_res &&
+	    !(adapter->vf_res->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_VLAN))
 		features &= ~(NETIF_F_HW_VLAN_CTAG_TX |
 			      NETIF_F_HW_VLAN_CTAG_RX |
 			      NETIF_F_HW_VLAN_CTAG_FILTER);
-- 
2.20.1

