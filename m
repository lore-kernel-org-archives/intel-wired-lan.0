From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Thu, 16 Nov 2017 11:54:47 -0800
Subject: [Intel-wired-lan] [RFC PATCH jkirsher/next-queue 9/9] ixgbe: add
 init and remove ipsec support
In-Reply-To: <1510862087-1924-1-git-send-email-shannon.nelson@oracle.com>
References: <1510862087-1924-1-git-send-email-shannon.nelson@oracle.com>
Message-ID: <1510862087-1924-10-git-send-email-shannon.nelson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Link in the ipsec initialization and removal code, as well as the
table restore after a device reset.  This registers itself with
the XFRM subsystem and enables the driver's offload processing.

With this the ipsec offload support should be operational.

Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 2bb4c5f..35f2d2a 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -5483,6 +5483,7 @@ static void ixgbe_configure(struct ixgbe_adapter *adapter)
 
 	ixgbe_set_rx_mode(adapter->netdev);
 	ixgbe_restore_vlan(adapter);
+	ixgbe_ipsec_restore(adapter);
 
 	switch (hw->mac.type) {
 	case ixgbe_mac_82599EB:
@@ -6171,6 +6172,9 @@ static int ixgbe_sw_init(struct ixgbe_adapter *adapter,
 	adapter->fcoe.up = IXGBE_FCOE_DEFTC;
 #endif /* CONFIG_IXGBE_DCB */
 #endif /* IXGBE_FCOE */
+#ifdef CONFIG_XFRM_OFFLOAD
+	adapter->flags2 |= IXGBE_FLAG2_IPSEC_CAPABLE;
+#endif /* CONFIG_XFRM_OFFLOAD */
 
 	/* initialize static ixgbe jump table entries */
 	adapter->jump_tables[0] = kzalloc(sizeof(*adapter->jump_tables[0]),
@@ -10543,6 +10547,9 @@ static int ixgbe_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	}
 #endif /* IXGBE_FCOE */
 
+	if (adapter->flags2 & IXGBE_FLAG2_IPSEC_CAPABLE)
+		ixgbe_init_ipsec_offload(adapter);
+
 	if (adapter->flags2 & IXGBE_FLAG2_RSC_CAPABLE)
 		netdev->hw_features |= NETIF_F_LRO;
 	if (adapter->flags2 & IXGBE_FLAG2_RSC_ENABLED)
@@ -10755,6 +10762,11 @@ static void ixgbe_remove(struct pci_dev *pdev)
 	set_bit(__IXGBE_REMOVING, &adapter->state);
 	cancel_work_sync(&adapter->service_task);
 
+#ifdef CONFIG_XFRM_OFFLOAD
+	kfree(adapter->rx_ip_sa_tbl);
+	kfree(adapter->rx_sa_tbl);
+	kfree(adapter->tx_sa_tbl);
+#endif /* CONFIG_XFRM_OFFLOAD */
 
 #ifdef CONFIG_IXGBE_DCA
 	if (adapter->flags & IXGBE_FLAG_DCA_ENABLED) {
-- 
2.7.4

