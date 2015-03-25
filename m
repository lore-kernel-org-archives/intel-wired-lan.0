From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Tue, 24 Mar 2015 20:49:44 -0700
Subject: [Intel-wired-lan] [PATCH] ixgbe: Remove NETIF_F_HW_VLAN_CTAG_FILTER
	from hw_features
Message-ID: <1427255384-23806-1-git-send-email-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alexander Duyck <alexander.h.duyck@redhat.com>

This change makes it so that the HW_VLAN_CTAG_FILTER bit is not falsely
advertised as being a feature that can be toggled on ixgbe parts.  The
driver was setting the bit in features and letting it be inherited by
hw_features, however the driver was actually ignoring the value of the bit
and just assuming it was always set.  As a result VLAN filtering was always
enabled which is a requirement for SR-IOV, VMDq, DCB, FCoE, and possibly
other features within the adapters.

Signed-off-by: Alexander Duyck <alexander.h.duyck@redhat.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index c696ad72..0b38be8 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -8455,7 +8455,6 @@ skip_sriov:
 			   NETIF_F_IPV6_CSUM |
 			   NETIF_F_HW_VLAN_CTAG_TX |
 			   NETIF_F_HW_VLAN_CTAG_RX |
-			   NETIF_F_HW_VLAN_CTAG_FILTER |
 			   NETIF_F_TSO |
 			   NETIF_F_TSO6 |
 			   NETIF_F_RXHASH |
@@ -8477,6 +8476,7 @@ skip_sriov:
 	}
 
 	netdev->hw_features |= NETIF_F_RXALL;
+	netdev->features |= NETIF_F_HW_VLAN_CTAG_FILTER;
 
 	netdev->vlan_features |= NETIF_F_TSO;
 	netdev->vlan_features |= NETIF_F_TSO6;
-- 
1.9.3

