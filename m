From: Alexander Duyck <alexander.h.duyck@intel.com>
Date: Fri, 12 Aug 2016 09:53:39 -0700
Subject: [Intel-wired-lan] [net PATCH] ixgbe: Re-enable ability to toggle
	VLAN filtering
Message-ID: <147102081932.18173.913316945879981638.stgit@ahduyck-desk.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Back when I submitted the GSO code I messed up and dropped the support for
disabling the VLAN tag filtering via the feature bit.  This patch
re-enables the use of the NETIF_F_HW_VLAN_CTAG_FILTER to enable/disable the
VLAN filtering independent of toggling promiscuous mode.

Fixes: b83e30104b ("ixgbe/ixgbevf: Add support for GSO partial")
Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index fa7fa09..aa0e3e6 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -9595,6 +9595,7 @@ skip_sriov:
 
 	/* copy netdev features into list of user selectable features */
 	netdev->hw_features |= netdev->features |
+			       NETIF_F_HW_VLAN_CTAG_FILTER |
 			       NETIF_F_HW_VLAN_CTAG_RX |
 			       NETIF_F_HW_VLAN_CTAG_TX |
 			       NETIF_F_RXALL |

