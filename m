From: Jan Sokolowski <jan.sokolowski@intel.com>
Date: Wed, 20 Feb 2019 15:28:25 +0000
Subject: [Intel-wired-lan] [PATCH net-next 1/2] ixgbe: add tracking of
 AF_XDP zero-copy state for each queue pair
Message-ID: <20190220152826.14083-1-jan.sokolowski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Here, we add a bitmap to the ixgbe_adapter that tracks if a
certain queue pair has been "zero-copy enabled" via the ndo_bpf.
The bitmap is used in ixgbe_xsk_umem, and enables zero-copy if
and only if XDP is enabled, the corresponding qid in the bitmap
is set, and the umem is non-NULL;

Signed-off-by: Jan Sokolowski <jan.sokolowski@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe.h      | 1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 6 ++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c  | 5 ++++-
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
index 08d85e336bd4..5f5db6eb261e 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
@@ -635,6 +635,7 @@ struct ixgbe_adapter {
 	/* XDP */
 	int num_xdp_queues;
 	struct ixgbe_ring *xdp_ring[MAX_XDP_QUEUES];
+	unsigned long *af_xdp_zc_qps; /* tracks AF_XDP ZC enabled rings */
 
 	/* TX */
 	struct ixgbe_ring *tx_ring[MAX_TX_QUEUES] ____cacheline_aligned_in_smp;
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 38c430b94ae3..46fc6fb8bb1b 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -6284,6 +6284,10 @@ static int ixgbe_sw_init(struct ixgbe_adapter *adapter,
 	if (ixgbe_init_rss_key(adapter))
 		return -ENOMEM;
 
+	adapter->af_xdp_zc_qps = bitmap_zalloc(MAX_XDP_QUEUES, GFP_KERNEL);
+	if (!adapter->af_xdp_zc_qps)
+		return -ENOMEM;
+
 	/* Set MAC specific capability flags and exceptions */
 	switch (hw->mac.type) {
 	case ixgbe_mac_82598EB:
@@ -11153,6 +11157,7 @@ static int ixgbe_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	kfree(adapter->jump_tables[0]);
 	kfree(adapter->mac_table);
 	kfree(adapter->rss_key);
+	bitmap_free(adapter->af_xdp_zc_qps);
 err_ioremap:
 	disable_dev = !test_and_set_bit(__IXGBE_DISABLED, &adapter->state);
 	free_netdev(netdev);
@@ -11241,6 +11246,7 @@ static void ixgbe_remove(struct pci_dev *pdev)
 
 	kfree(adapter->mac_table);
 	kfree(adapter->rss_key);
+	bitmap_free(adapter->af_xdp_zc_qps);
 	disable_dev = !test_and_set_bit(__IXGBE_DISABLED, &adapter->state);
 	free_netdev(netdev);
 
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
index 51c29358c2a9..fccfb422e45c 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
@@ -15,7 +15,8 @@ struct xdp_umem *ixgbe_xsk_umem(struct ixgbe_adapter *adapter,
 	int qid = ring->ring_idx;
 
 	if (!adapter->xsk_umems || !adapter->xsk_umems[qid] ||
-	    qid >= adapter->num_xsk_umems || !xdp_on)
+	    qid >= adapter->num_xsk_umems || !xdp_on ||
+	    !test_bit(qid, adapter->af_xdp_zc_qps))
 		return NULL;
 
 	return adapter->xsk_umems[qid];
@@ -143,6 +144,7 @@ static int ixgbe_xsk_umem_enable(struct ixgbe_adapter *adapter,
 	if (if_running)
 		ixgbe_txrx_ring_disable(adapter, qid);
 
+	set_bit(qid, adapter->af_xdp_zc_qps);
 	err = ixgbe_add_xsk_umem(adapter, umem, qid);
 
 	if (if_running)
@@ -165,6 +167,7 @@ static int ixgbe_xsk_umem_disable(struct ixgbe_adapter *adapter, u16 qid)
 	if (if_running)
 		ixgbe_txrx_ring_disable(adapter, qid);
 
+	clear_bit(qid, adapter->af_xdp_zc_qps);
 	ixgbe_xsk_umem_dma_unmap(adapter, adapter->xsk_umems[qid]);
 	ixgbe_remove_xsk_umem(adapter, qid);
 
-- 
2.18.1

