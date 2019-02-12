From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@gmail.com>
Date: Tue, 12 Feb 2019 09:52:04 +0100
Subject: [Intel-wired-lan] [PATCH 1/2] i40e: move i40e_xsk_umem function
In-Reply-To: <20190212085205.7848-1-bjorn.topel@gmail.com>
References: <20190212085205.7848-1-bjorn.topel@gmail.com>
Message-ID: <20190212085205.7848-2-bjorn.topel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bj?rn T?pel <bjorn.topel@intel.com>

The i40e_xsk_umem function was explicitly inlined in i40e.h. There is
no reason for that, so move it to i40e_main.c instead.

Signed-off-by: Bj?rn T?pel <bjorn.topel@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h      | 14 --------------
 drivers/net/ethernet/intel/i40e/i40e_main.c | 20 ++++++++++++++++++++
 2 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index d684998ba2b0..cc583ad5236b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -1096,20 +1096,6 @@ static inline bool i40e_enabled_xdp_vsi(struct i40e_vsi *vsi)
 	return !!vsi->xdp_prog;
 }
 
-static inline struct xdp_umem *i40e_xsk_umem(struct i40e_ring *ring)
-{
-	bool xdp_on = i40e_enabled_xdp_vsi(ring->vsi);
-	int qid = ring->queue_index;
-
-	if (ring_is_xdp(ring))
-		qid -= ring->vsi->alloc_queue_pairs;
-
-	if (!xdp_on)
-		return NULL;
-
-	return xdp_get_umem_from_qid(ring->vsi->netdev, qid);
-}
-
 int i40e_create_queue_channel(struct i40e_vsi *vsi, struct i40e_channel *ch);
 int i40e_set_bw_limit(struct i40e_vsi *vsi, u16 seid, u64 max_tx_rate);
 int i40e_add_del_cloud_filter(struct i40e_vsi *vsi,
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 44856a84738d..ba1a84a2c8e5 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -3063,6 +3063,26 @@ static void i40e_config_xps_tx_ring(struct i40e_ring *ring)
 			    ring->queue_index);
 }
 
+/**
+ * i40e_xsk_umem - Retrieve the AF_XDP ZC if XDP and ZC is enabled
+ * @ring: The Tx or Rx ring
+ *
+ * Returns the UMEM or NULL.
+ **/
+static struct xdp_umem *i40e_xsk_umem(struct i40e_ring *ring)
+{
+	bool xdp_on = i40e_enabled_xdp_vsi(ring->vsi);
+	int qid = ring->queue_index;
+
+	if (ring_is_xdp(ring))
+		qid -= ring->vsi->alloc_queue_pairs;
+
+	if (!xdp_on)
+		return NULL;
+
+	return xdp_get_umem_from_qid(ring->vsi->netdev, qid);
+}
+
 /**
  * i40e_configure_tx_ring - Configure a transmit ring context and rest
  * @ring: The Tx ring to configure
-- 
2.19.1

