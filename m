From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Thu,  7 May 2020 17:41:13 -0700
Subject: [Intel-wired-lan] [PATCH S41 15/15] ice: Rename build_ctob to
 ice_build_ctob
In-Reply-To: <20200508004113.39725-1-anthony.l.nguyen@intel.com>
References: <20200508004113.39725-1-anthony.l.nguyen@intel.com>
Message-ID: <20200508004113.39725-15-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

To make the function easier to identify as being part of the ice driver,
prepend ice to the function name.

Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_txrx.c     | 11 ++++++-----
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c |  4 ++--
 drivers/net/ethernet/intel/ice/ice_txrx_lib.h |  2 +-
 drivers/net/ethernet/intel/ice/ice_xsk.c      |  4 ++--
 4 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index fb4e4c529e2d..e3b72368af3c 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -1664,7 +1664,8 @@ ice_tx_map(struct ice_ring *tx_ring, struct ice_tx_buf *first,
 		 */
 		while (unlikely(size > ICE_MAX_DATA_PER_TXD)) {
 			tx_desc->cmd_type_offset_bsz =
-				build_ctob(td_cmd, td_offset, max_data, td_tag);
+				ice_build_ctob(td_cmd, td_offset, max_data,
+					       td_tag);
 
 			tx_desc++;
 			i++;
@@ -1684,8 +1685,8 @@ ice_tx_map(struct ice_ring *tx_ring, struct ice_tx_buf *first,
 		if (likely(!data_len))
 			break;
 
-		tx_desc->cmd_type_offset_bsz = build_ctob(td_cmd, td_offset,
-							  size, td_tag);
+		tx_desc->cmd_type_offset_bsz = ice_build_ctob(td_cmd, td_offset,
+							      size, td_tag);
 
 		tx_desc++;
 		i++;
@@ -1716,8 +1717,8 @@ ice_tx_map(struct ice_ring *tx_ring, struct ice_tx_buf *first,
 
 	/* write last descriptor with RS and EOP bits */
 	td_cmd |= (u64)ICE_TXD_LAST_DESC_CMD;
-	tx_desc->cmd_type_offset_bsz = build_ctob(td_cmd, td_offset, size,
-						  td_tag);
+	tx_desc->cmd_type_offset_bsz =
+			ice_build_ctob(td_cmd, td_offset, size, td_tag);
 
 	/* Force memory writes to complete before letting h/w know there
 	 * are new descriptors to fetch.
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
index 9d6512f96b8c..1ba97172d8d0 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
@@ -232,8 +232,8 @@ int ice_xmit_xdp_ring(void *data, u16 size, struct ice_ring *xdp_ring)
 
 	tx_desc = ICE_TX_DESC(xdp_ring, i);
 	tx_desc->buf_addr = cpu_to_le64(dma);
-	tx_desc->cmd_type_offset_bsz = build_ctob(ICE_TXD_LAST_DESC_CMD, 0,
-						  size, 0);
+	tx_desc->cmd_type_offset_bsz = ice_build_ctob(ICE_TXD_LAST_DESC_CMD, 0,
+						      size, 0);
 
 	/* Make certain all of the status bits have been updated
 	 * before next_to_watch is written.
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.h b/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
index af0fca5b91ff..58ff58f0f972 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
@@ -22,7 +22,7 @@ ice_test_staterr(union ice_32b_rx_flex_desc *rx_desc, const u16 stat_err_bits)
 }
 
 static inline __le64
-build_ctob(u64 td_cmd, u64 td_offset, unsigned int size, u64 td_tag)
+ice_build_ctob(u64 td_cmd, u64 td_offset, unsigned int size, u64 td_tag)
 {
 	return cpu_to_le64(ICE_TX_DESC_DTYPE_DATA |
 			   (td_cmd    << ICE_TXD_QW1_CMD_S) |
diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index 8279db15e870..1e9cc550ec98 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -986,8 +986,8 @@ static bool ice_xmit_zc(struct ice_ring *xdp_ring, int budget)
 
 		tx_desc = ICE_TX_DESC(xdp_ring, xdp_ring->next_to_use);
 		tx_desc->buf_addr = cpu_to_le64(dma);
-		tx_desc->cmd_type_offset_bsz = build_ctob(ICE_TXD_LAST_DESC_CMD,
-							  0, desc.len, 0);
+		tx_desc->cmd_type_offset_bsz =
+			ice_build_ctob(ICE_TXD_LAST_DESC_CMD, 0, desc.len, 0);
 
 		xdp_ring->next_to_use++;
 		if (xdp_ring->next_to_use == xdp_ring->count)
-- 
2.20.1

