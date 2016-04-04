From: Alexander Duyck <aduyck@mirantis.com>
Date: Mon, 04 Apr 2016 16:03:27 -0700
Subject: [Intel-wired-lan] [PATCH] ixgbe: Fix flag issue in generic CSUM
	patch
Message-ID: <20160404230235.14334.80472.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch fixes a minor flags issue where we had lost NETIF_F_HW_TC and
were setting NETIF_F_SCTP_CRC in two different spots when we only wanted to
enable it in the if statement.

Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
---

This should fix both the one issue I saw and the NETIF_F_HW_TC issue that
Sridar saw with the generic CSUM patch.

 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 51ce426ce510..30903c5517af 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -9214,7 +9214,6 @@ skip_sriov:
 			   NETIF_F_RXHASH |
 			   NETIF_F_RXCSUM |
 			   NETIF_F_HW_CSUM |
-			   NETIF_F_SCTP_CRC |
 			   NETIF_F_HW_VLAN_CTAG_TX |
 			   NETIF_F_HW_VLAN_CTAG_RX |
 			   NETIF_F_HW_VLAN_CTAG_FILTER;
@@ -9228,7 +9227,8 @@ skip_sriov:
 			       NETIF_F_HW_L2FW_DOFFLOAD;
 
 	if (hw->mac.type >= ixgbe_mac_82599EB)
-		netdev->hw_features |= NETIF_F_NTUPLE;
+		netdev->hw_features |= NETIF_F_NTUPLE |
+				       NETIF_F_HW_TC;
 
 	netdev->vlan_features |= NETIF_F_SG |
 				 NETIF_F_TSO |

