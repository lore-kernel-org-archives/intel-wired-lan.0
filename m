From: Alexander Duyck <alexander.h.duyck@intel.com>
Date: Mon, 04 Jun 2018 16:51:25 -0400
Subject: [Intel-wired-lan] [net-queue PATCH v2 2/2] ixgbe: Move ipsec init
 function to before reset call
In-Reply-To: <20180604204931.5474.94068.stgit@ahduyck-green-test.jf.intel.com>
References: <20180604204931.5474.94068.stgit@ahduyck-green-test.jf.intel.com>
Message-ID: <20180604205125.5474.54894.stgit@ahduyck-green-test.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch moves the ipsec init function in ixgbe_sw_init. This way it is a
bit more consistent with the placement of similar initialization functions
and is placed before the reset_hw call which should allow us to clean up
any link issues that may be introduced by the fact that we force the link
up if somehow the device had ipsec still enabled before the driver was
loaded.

In addition to the function move it is necessary to change the assignment
of netdev->features. The easiest way to do this is to just test for the
existance of adapter->ipsec and if it is present we set the feature bits.

Fixes: 49a94d74d948 ("ixgbe: add ipsec engine start and stop routines")
Reported-by: Andre Tomt <andre@tomt.net>
Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c |    7 -------
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c  |   11 +++++++++--
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
index 344a1f2..38d8cf7 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
@@ -1001,13 +1001,6 @@ void ixgbe_init_ipsec_offload(struct ixgbe_adapter *adapter)
 
 	adapter->netdev->xfrmdev_ops = &ixgbe_xfrmdev_ops;
 
-#define IXGBE_ESP_FEATURES	(NETIF_F_HW_ESP | \
-				 NETIF_F_HW_ESP_TX_CSUM | \
-				 NETIF_F_GSO_ESP)
-
-	adapter->netdev->features |= IXGBE_ESP_FEATURES;
-	adapter->netdev->hw_enc_features |= IXGBE_ESP_FEATURES;
-
 	return;
 
 err2:
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 8cab0c5..e1d46e4 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -6128,6 +6128,7 @@ static int ixgbe_sw_init(struct ixgbe_adapter *adapter,
 #ifdef CONFIG_IXGBE_DCB
 	ixgbe_init_dcb(adapter);
 #endif
+	ixgbe_init_ipsec_offload(adapter);
 
 	/* default flow control settings */
 	hw->fc.requested_mode = ixgbe_fc_full;
@@ -10488,6 +10489,14 @@ static int ixgbe_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (hw->mac.type >= ixgbe_mac_82599EB)
 		netdev->features |= NETIF_F_SCTP_CRC | NETIF_F_GSO_UDP_L4;
 
+#ifdef CONFIG_XFRM_OFFLOAD
+#define IXGBE_ESP_FEATURES	(NETIF_F_HW_ESP | \
+				 NETIF_F_HW_ESP_TX_CSUM | \
+				 NETIF_F_GSO_ESP)
+
+	if (adapter->ipsec)
+		netdev->features |= IXGBE_ESP_FEATURES;
+#endif
 	/* copy netdev features into list of user selectable features */
 	netdev->hw_features |= netdev->features |
 			       NETIF_F_HW_VLAN_CTAG_FILTER |
@@ -10550,8 +10559,6 @@ static int ixgbe_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 					 NETIF_F_FCOE_MTU;
 	}
 #endif /* IXGBE_FCOE */
-	ixgbe_init_ipsec_offload(adapter);
-
 	if (adapter->flags2 & IXGBE_FLAG2_RSC_CAPABLE)
 		netdev->hw_features |= NETIF_F_LRO;
 	if (adapter->flags2 & IXGBE_FLAG2_RSC_ENABLED)

