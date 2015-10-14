From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 14 Oct 2015 09:32:36 -0700
Subject: [Intel-wired-lan] [next-queue v2 02/17] fm10k: set netdev features
	in one location
In-Reply-To: <1444840371-17328-1-git-send-email-jacob.e.keller@intel.com>
References: <1444840371-17328-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <1444840371-17328-2-git-send-email-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Don't change netdev hw_features later in fm10k_probe, instead set all
values inside fm10k_alloc_netdev. To do so, we need to know the MAC type
(whether it is PF or VF) in order to determine what to do. This helps
ensure that all logic regarding features is co-located.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k.h        |  2 +-
 drivers/net/ethernet/intel/fm10k/fm10k_netdev.c | 31 +++++++++++++++----------
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c    |  9 +------
 3 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k.h b/drivers/net/ethernet/intel/fm10k/fm10k.h
index aa9674a3d9ee..3495e9337745 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k.h
+++ b/drivers/net/ethernet/intel/fm10k/fm10k.h
@@ -484,7 +484,7 @@ void fm10k_netpoll(struct net_device *netdev);
 #endif
 
 /* Netdev */
-struct net_device *fm10k_alloc_netdev(void);
+struct net_device *fm10k_alloc_netdev(const struct fm10k_info *info);
 int fm10k_setup_rx_resources(struct fm10k_ring *);
 int fm10k_setup_tx_resources(struct fm10k_ring *);
 void fm10k_free_rx_resources(struct fm10k_ring *);
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c b/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
index 96364c7b7719..38fe2d8c8388 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
@@ -1391,8 +1391,9 @@ static const struct net_device_ops fm10k_netdev_ops = {
 
 #define DEFAULT_DEBUG_LEVEL_SHIFT 3
 
-struct net_device *fm10k_alloc_netdev(void)
+struct net_device *fm10k_alloc_netdev(const struct fm10k_info *info)
 {
+	netdev_features_t hw_features;
 	struct fm10k_intfc *interface;
 	struct net_device *dev;
 
@@ -1415,27 +1416,31 @@ struct net_device *fm10k_alloc_netdev(void)
 			 NETIF_F_TSO |
 			 NETIF_F_TSO6 |
 			 NETIF_F_TSO_ECN |
-			 NETIF_F_GSO_UDP_TUNNEL |
 			 NETIF_F_RXHASH |
 			 NETIF_F_RXCSUM;
 
+	/* Only the PF can support VXLAN and NVGRE tunnel offloads */
+	if (info->mac == fm10k_mac_pf) {
+		dev->hw_enc_features = NETIF_F_IP_CSUM |
+				       NETIF_F_TSO |
+				       NETIF_F_TSO6 |
+				       NETIF_F_TSO_ECN |
+				       NETIF_F_GSO_UDP_TUNNEL |
+				       NETIF_F_IPV6_CSUM |
+				       NETIF_F_SG;
+
+		dev->features |= NETIF_F_GSO_UDP_TUNNEL;
+	}
+
 	/* all features defined to this point should be changeable */
-	dev->hw_features |= dev->features;
+	hw_features = dev->features;
 
 	/* allow user to enable L2 forwarding acceleration */
-	dev->hw_features |= NETIF_F_HW_L2FW_DOFFLOAD;
+	hw_features |= NETIF_F_HW_L2FW_DOFFLOAD;
 
 	/* configure VLAN features */
 	dev->vlan_features |= dev->features;
 
-	/* configure tunnel offloads */
-	dev->hw_enc_features |= NETIF_F_IP_CSUM |
-				NETIF_F_TSO |
-				NETIF_F_TSO6 |
-				NETIF_F_TSO_ECN |
-				NETIF_F_GSO_UDP_TUNNEL |
-				NETIF_F_IPV6_CSUM;
-
 	/* we want to leave these both on as we cannot disable VLAN tag
 	 * insertion or stripping on the hardware since it is contained
 	 * in the FTAG and not in the frame itself.
@@ -1446,5 +1451,7 @@ struct net_device *fm10k_alloc_netdev(void)
 
 	dev->priv_flags |= IFF_UNICAST_FLT;
 
+	dev->hw_features |= hw_features;
+
 	return dev;
 }
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
index 0dece3c07727..a488bbade48b 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
@@ -1722,13 +1722,6 @@ static int fm10k_sw_init(struct fm10k_intfc *interface,
 					     pci_resource_len(pdev, 4));
 	hw->sw_addr = interface->sw_addr;
 
-	/* Only the PF can support VXLAN and NVGRE offloads */
-	if (hw->mac.type != fm10k_mac_pf) {
-		netdev->hw_enc_features = 0;
-		netdev->features &= ~NETIF_F_GSO_UDP_TUNNEL;
-		netdev->hw_features &= ~NETIF_F_GSO_UDP_TUNNEL;
-	}
-
 #ifdef CONFIG_DCB
 	/* initialize DCBNL interface */
 	fm10k_dcbnl_set_ops(netdev);
@@ -1896,7 +1889,7 @@ static int fm10k_probe(struct pci_dev *pdev,
 	pci_set_master(pdev);
 	pci_save_state(pdev);
 
-	netdev = fm10k_alloc_netdev();
+	netdev = fm10k_alloc_netdev(fm10k_info_tbl[ent->driver_data]);
 	if (!netdev) {
 		err = -ENOMEM;
 		goto err_alloc_netdev;
-- 
2.6.1.264.gbab76a9

