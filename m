From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@gmail.com>
Date: Thu,  7 May 2020 12:42:43 +0200
Subject: [Intel-wired-lan] [PATCH bpf-next 05/14] i40e: refactor rx_bi
 accesses
In-Reply-To: <20200507104252.544114-1-bjorn.topel@gmail.com>
References: <20200507104252.544114-1-bjorn.topel@gmail.com>
Message-ID: <20200507104252.544114-6-bjorn.topel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bj?rn T?pel <bjorn.topel@intel.com>

As a first step to migrate i40e to the new MEM_TYPE_XSK_BUFF_POOL
APIs, code that accesses the rx_bi (SW/shadow ring) is refactored to
use an accessor function.

Cc: intel-wired-lan at lists.osuosl.org
Signed-off-by: Bj?rn T?pel <bjorn.topel@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c | 17 +++++++++++------
 drivers/net/ethernet/intel/i40e/i40e_xsk.c  | 18 ++++++++++++------
 2 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index b8496037ef7f..58daba8fabc8 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -1195,6 +1195,11 @@ static void i40e_update_itr(struct i40e_q_vector *q_vector,
 	rc->total_packets = 0;
 }
 
+static struct i40e_rx_buffer *i40e_rx_bi(struct i40e_ring *rx_ring, u32 idx)
+{
+	return &rx_ring->rx_bi[idx];
+}
+
 /**
  * i40e_reuse_rx_page - page flip buffer and store it back on the ring
  * @rx_ring: rx descriptor ring to store buffers on
@@ -1208,7 +1213,7 @@ static void i40e_reuse_rx_page(struct i40e_ring *rx_ring,
 	struct i40e_rx_buffer *new_buff;
 	u16 nta = rx_ring->next_to_alloc;
 
-	new_buff = &rx_ring->rx_bi[nta];
+	new_buff = i40e_rx_bi(rx_ring, nta);
 
 	/* update, and store next to alloc */
 	nta++;
@@ -1272,7 +1277,7 @@ struct i40e_rx_buffer *i40e_clean_programming_status(
 	ntc = rx_ring->next_to_clean;
 
 	/* fetch, update, and store next to clean */
-	rx_buffer = &rx_ring->rx_bi[ntc++];
+	rx_buffer = i40e_rx_bi(rx_ring, ntc++);
 	ntc = (ntc < rx_ring->count) ? ntc : 0;
 	rx_ring->next_to_clean = ntc;
 
@@ -1361,7 +1366,7 @@ void i40e_clean_rx_ring(struct i40e_ring *rx_ring)
 
 	/* Free all the Rx ring sk_buffs */
 	for (i = 0; i < rx_ring->count; i++) {
-		struct i40e_rx_buffer *rx_bi = &rx_ring->rx_bi[i];
+		struct i40e_rx_buffer *rx_bi = i40e_rx_bi(rx_ring, i);
 
 		if (!rx_bi->page)
 			continue;
@@ -1576,7 +1581,7 @@ bool i40e_alloc_rx_buffers(struct i40e_ring *rx_ring, u16 cleaned_count)
 		return false;
 
 	rx_desc = I40E_RX_DESC(rx_ring, ntu);
-	bi = &rx_ring->rx_bi[ntu];
+	bi = i40e_rx_bi(rx_ring, ntu);
 
 	do {
 		if (!i40e_alloc_mapped_page(rx_ring, bi))
@@ -1598,7 +1603,7 @@ bool i40e_alloc_rx_buffers(struct i40e_ring *rx_ring, u16 cleaned_count)
 		ntu++;
 		if (unlikely(ntu == rx_ring->count)) {
 			rx_desc = I40E_RX_DESC(rx_ring, 0);
-			bi = rx_ring->rx_bi;
+			bi = i40e_rx_bi(rx_ring, 0);
 			ntu = 0;
 		}
 
@@ -1965,7 +1970,7 @@ static struct i40e_rx_buffer *i40e_get_rx_buffer(struct i40e_ring *rx_ring,
 {
 	struct i40e_rx_buffer *rx_buffer;
 
-	rx_buffer = &rx_ring->rx_bi[rx_ring->next_to_clean];
+	rx_buffer = i40e_rx_bi(rx_ring, rx_ring->next_to_clean);
 	prefetchw(rx_buffer->page);
 
 	/* we are reusing so sync this buffer for CPU use */
diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
index 452bba7bc4ff..8d29477bb0b6 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
@@ -9,6 +9,11 @@
 #include "i40e_txrx_common.h"
 #include "i40e_xsk.h"
 
+static struct i40e_rx_buffer *i40e_rx_bi(struct i40e_ring *rx_ring, u32 idx)
+{
+	return &rx_ring->rx_bi[idx];
+}
+
 /**
  * i40e_xsk_umem_dma_map - DMA maps all UMEM memory for the netdev
  * @vsi: Current VSI
@@ -321,7 +326,7 @@ __i40e_alloc_rx_buffers_zc(struct i40e_ring *rx_ring, u16 count,
 	bool ok = true;
 
 	rx_desc = I40E_RX_DESC(rx_ring, ntu);
-	bi = &rx_ring->rx_bi[ntu];
+	bi = i40e_rx_bi(rx_ring, ntu);
 	do {
 		if (!alloc(rx_ring, bi)) {
 			ok = false;
@@ -340,7 +345,7 @@ __i40e_alloc_rx_buffers_zc(struct i40e_ring *rx_ring, u16 count,
 
 		if (unlikely(ntu == rx_ring->count)) {
 			rx_desc = I40E_RX_DESC(rx_ring, 0);
-			bi = rx_ring->rx_bi;
+			bi = i40e_rx_bi(rx_ring, 0);
 			ntu = 0;
 		}
 
@@ -402,7 +407,7 @@ static struct i40e_rx_buffer *i40e_get_rx_buffer_zc(struct i40e_ring *rx_ring,
 {
 	struct i40e_rx_buffer *bi;
 
-	bi = &rx_ring->rx_bi[rx_ring->next_to_clean];
+	bi = i40e_rx_bi(rx_ring, rx_ring->next_to_clean);
 
 	/* we are reusing so sync this buffer for CPU use */
 	dma_sync_single_range_for_cpu(rx_ring->dev,
@@ -424,7 +429,8 @@ static struct i40e_rx_buffer *i40e_get_rx_buffer_zc(struct i40e_ring *rx_ring,
 static void i40e_reuse_rx_buffer_zc(struct i40e_ring *rx_ring,
 				    struct i40e_rx_buffer *old_bi)
 {
-	struct i40e_rx_buffer *new_bi = &rx_ring->rx_bi[rx_ring->next_to_alloc];
+	struct i40e_rx_buffer *new_bi = i40e_rx_bi(rx_ring,
+						   rx_ring->next_to_alloc);
 	u16 nta = rx_ring->next_to_alloc;
 
 	/* update, and store next to alloc */
@@ -456,7 +462,7 @@ void i40e_zca_free(struct zero_copy_allocator *alloc, unsigned long handle)
 	mask = rx_ring->xsk_umem->chunk_mask;
 
 	nta = rx_ring->next_to_alloc;
-	bi = &rx_ring->rx_bi[nta];
+	bi = i40e_rx_bi(rx_ring, nta);
 
 	nta++;
 	rx_ring->next_to_alloc = (nta < rx_ring->count) ? nta : 0;
@@ -824,7 +830,7 @@ void i40e_xsk_clean_rx_ring(struct i40e_ring *rx_ring)
 	u16 i;
 
 	for (i = 0; i < rx_ring->count; i++) {
-		struct i40e_rx_buffer *rx_bi = &rx_ring->rx_bi[i];
+		struct i40e_rx_buffer *rx_bi = i40e_rx_bi(rx_ring, i);
 
 		if (!rx_bi->addr)
 			continue;
-- 
2.25.1

