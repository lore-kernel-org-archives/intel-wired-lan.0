From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Thu,  9 Aug 2018 06:28:53 -0700
Subject: [Intel-wired-lan] [PATCH v4 03/13] ice: Cleanup magic number
In-Reply-To: <20180809132903.22819-1-anirudh.venkataramanan@intel.com>
References: <20180809132903.22819-1-anirudh.venkataramanan@intel.com>
Message-ID: <20180809132903.22819-4-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Use define for the unit size shift of the Rx LAN context descriptor base
address instead of the magic number 7.

Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h | 1 +
 drivers/net/ethernet/intel/ice/ice_main.c      | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h b/drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h
index d23a91665b46..068dbc740b76 100644
--- a/drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h
+++ b/drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h
@@ -265,6 +265,7 @@ enum ice_rx_flex_desc_status_error_0_bits {
 struct ice_rlan_ctx {
 	u16 head;
 	u16 cpuid; /* bigger than needed, see above for reason */
+#define ICE_RLAN_BASE_S 7
 	u64 base;
 	u16 qlen;
 #define ICE_RLAN_CTX_DBUF_S 7
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 186e764a469a..7d65e0ed3588 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3983,7 +3983,7 @@ static int ice_setup_rx_ctx(struct ice_ring *ring)
 	/* clear the context structure first */
 	memset(&rlan_ctx, 0, sizeof(rlan_ctx));
 
-	rlan_ctx.base = ring->dma >> 7;
+	rlan_ctx.base = ring->dma >> ICE_RLAN_BASE_S;
 
 	rlan_ctx.qlen = ring->count;
 
-- 
2.17.1

