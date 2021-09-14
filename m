From: Wojciech Drewek <wojciech.drewek@intel.com>
Date: Tue, 14 Sep 2021 10:43:15 +0200
Subject: [Intel-wired-lan] [PATCH net-next] ice: Allow to enable/disable
 hw-tc-offload on PF
Message-ID: <20210914084315.25585-1-wojciech.drewek@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Set NETIF_F_HW_TC in netdev->hw_features so that user could
enable/disable hw-tc-offload feature.

Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index bdb473b9b24e..18a5de796270 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3214,6 +3214,9 @@ static void ice_set_netdev_features(struct net_device *netdev)
 
 	/* enable features */
 	netdev->features |= netdev->hw_features;
+
+	netdev->hw_features |= NETIF_F_HW_TC;
+
 	/* encap and VLAN devices inherit default, csumo and tso features */
 	netdev->hw_enc_features |= dflt_features | csumo_features |
 				   tso_features;
-- 
2.30.1

