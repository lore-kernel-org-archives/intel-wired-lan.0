From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@gmail.com>
Date: Tue, 12 Feb 2019 09:52:05 +0100
Subject: [Intel-wired-lan] [PATCH 2/2] i40e: add tracking of AF_XDP ZC state
 for each queue pair
In-Reply-To: <20190212085205.7848-1-bjorn.topel@gmail.com>
References: <20190212085205.7848-1-bjorn.topel@gmail.com>
Message-ID: <20190212085205.7848-3-bjorn.topel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bj?rn T?pel <bjorn.topel@intel.com>

In commit f3fef2b6e1cc ("i40e: Remove umem from VSI") a regression was
introduced; When the VSI was reset, the setup code would try to enable
AF_XDP ZC unconditionally (as long as there was a umem placed in the
netdev._rx struct). Here, we add a bitmap to the VSI that tracks if a
certain queue pair has been "zero-copy enabled" via the ndo_bpf. The
bitmap is used in i40e_xsk_umem, and enables zero-copy if and only if
XDP is enabled, the corresponding qid in the bitmap is set and the
umem is non-NULL.

Fixes: f3fef2b6e1cc ("i40e: Remove umem from VSI")
Signed-off-by: Bj?rn T?pel <bjorn.topel@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h      |  2 ++
 drivers/net/ethernet/intel/i40e/i40e_main.c | 10 +++++++++-
 drivers/net/ethernet/intel/i40e/i40e_xsk.c  |  3 +++
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index cc583ad5236b..d3cc3427caad 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -790,6 +790,8 @@ struct i40e_vsi {
 
 	/* VSI specific handlers */
 	irqreturn_t (*irq_handler)(int irq, void *data);
+
+	unsigned long *af_xdp_zc_qps; /* tracks AF_XDP ZC enabled qps */
 } ____cacheline_internodealigned_in_smp;
 
 struct i40e_netdev_priv {
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index ba1a84a2c8e5..0dd00d58c524 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -3077,7 +3077,7 @@ static struct xdp_umem *i40e_xsk_umem(struct i40e_ring *ring)
 	if (ring_is_xdp(ring))
 		qid -= ring->vsi->alloc_queue_pairs;
 
-	if (!xdp_on)
+	if (!xdp_on || !test_bit(qid, ring->vsi->af_xdp_zc_qps))
 		return NULL;
 
 	return xdp_get_umem_from_qid(ring->vsi->netdev, qid);
@@ -10076,6 +10076,12 @@ static int i40e_vsi_mem_alloc(struct i40e_pf *pf, enum i40e_vsi_type type)
 	hash_init(vsi->mac_filter_hash);
 	vsi->irqs_ready = false;
 
+	if (type == I40E_VSI_MAIN) {
+		vsi->af_xdp_zc_qps = bitmap_zalloc(pf->num_lan_qps, GFP_KERNEL);
+		if (!vsi->af_xdp_zc_qps)
+			goto err_rings;
+	}
+
 	ret = i40e_set_num_rings_in_vsi(vsi);
 	if (ret)
 		goto err_rings;
@@ -10094,6 +10100,7 @@ static int i40e_vsi_mem_alloc(struct i40e_pf *pf, enum i40e_vsi_type type)
 	goto unlock_pf;
 
 err_rings:
+	bitmap_free(vsi->af_xdp_zc_qps);
 	pf->next_vsi = i - 1;
 	kfree(vsi);
 unlock_pf:
@@ -10174,6 +10181,7 @@ static int i40e_vsi_clear(struct i40e_vsi *vsi)
 	i40e_put_lump(pf->qp_pile, vsi->base_queue, vsi->idx);
 	i40e_put_lump(pf->irq_pile, vsi->base_vector, vsi->idx);
 
+	bitmap_free(vsi->af_xdp_zc_qps);
 	i40e_vsi_free_arrays(vsi, true);
 	i40e_clear_rss_config_user(vsi);
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
index 96d849460d9b..2737fee338c4 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
@@ -102,6 +102,8 @@ static int i40e_xsk_umem_enable(struct i40e_vsi *vsi, struct xdp_umem *umem,
 	if (err)
 		return err;
 
+	set_bit(qid, vsi->af_xdp_zc_qps);
+
 	if_running = netif_running(vsi->netdev) && i40e_enabled_xdp_vsi(vsi);
 
 	if (if_running) {
@@ -143,6 +145,7 @@ static int i40e_xsk_umem_disable(struct i40e_vsi *vsi, u16 qid)
 			return err;
 	}
 
+	clear_bit(qid, vsi->af_xdp_zc_qps);
 	i40e_xsk_umem_dma_unmap(vsi, umem);
 
 	if (if_running) {
-- 
2.19.1

