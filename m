From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 29 Oct 2018 10:52:43 -0700
Subject: [Intel-wired-lan] [net 2/2] i40e: enable NETIF_F_NTUPLE and
 NETIF_F_HW_TC at driver load
In-Reply-To: <20181029175243.13453-1-jacob.e.keller@intel.com>
References: <20181029175243.13453-1-jacob.e.keller@intel.com>
Message-ID: <20181029175243.13453-2-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The assignment of the feature flag NETIF_F_NTUPLE and NETIF_F_HW_TC
occurs prior to the initial setup of the local hw_features variable.

This means the features are set as user-changeable, but are not set in
the currently active feature list. This results in the features being
disabled at the driver's initial load.

Move the assignment after the initial assignment of hw_features, and
assign to the local variable. This ensures that NETIF_F_NTUPLE and
NETIF_F_HW_TC are marked as user-changeable, and also enables them by
default when the driver loads.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 3ff5ee49818b..21c2688d6308 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -12268,13 +12268,13 @@ static int i40e_config_netdev(struct i40e_vsi *vsi)
 	/* record features VLANs can make use of */
 	netdev->vlan_features |= hw_enc_features | NETIF_F_TSO_MANGLEID;
 
-	if (!(pf->flags & I40E_FLAG_MFP_ENABLED))
-		netdev->hw_features |= NETIF_F_NTUPLE | NETIF_F_HW_TC;
-
 	hw_features = hw_enc_features		|
 		      NETIF_F_HW_VLAN_CTAG_TX	|
 		      NETIF_F_HW_VLAN_CTAG_RX;
 
+	if (!(pf->flags & I40E_FLAG_MFP_ENABLED))
+		hw_features |= NETIF_F_NTUPLE | NETIF_F_HW_TC;
+
 	netdev->hw_features |= hw_features;
 
 	netdev->features |= hw_features | NETIF_F_HW_VLAN_CTAG_FILTER;
-- 
2.18.0.219.gaf81d287a9da

