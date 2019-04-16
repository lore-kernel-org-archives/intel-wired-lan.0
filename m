From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Tue, 16 Apr 2019 10:30:40 -0700
Subject: [Intel-wired-lan] [PATCH S20 03/15] ice: Resolve static analysis
 warning
In-Reply-To: <20190416173052.28928-1-anirudh.venkataramanan@intel.com>
References: <20190416173052.28928-1-anirudh.venkataramanan@intel.com>
Message-ID: <20190416173052.28928-4-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bruce Allan <bruce.w.allan@intel.com>

Some static analysis tools can complain when doing a bitop assignment using
operands of different sizes. Fix that.

Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
[Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> cleaned up commit message]
---
 drivers/net/ethernet/intel/ice/ice_txrx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index e9a6c866f616..a19dde262dee 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -1879,10 +1879,10 @@ int ice_tso(struct ice_tx_buf *first, struct ice_tx_offload_params *off)
 	cd_mss = skb_shinfo(skb)->gso_size;
 
 	/* record cdesc_qw1 with TSO parameters */
-	off->cd_qw1 |= ICE_TX_DESC_DTYPE_CTX |
-			 (ICE_TX_CTX_DESC_TSO << ICE_TXD_CTX_QW1_CMD_S) |
-			 (cd_tso_len << ICE_TXD_CTX_QW1_TSO_LEN_S) |
-			 (cd_mss << ICE_TXD_CTX_QW1_MSS_S);
+	off->cd_qw1 |= (u64)(ICE_TX_DESC_DTYPE_CTX |
+			     (ICE_TX_CTX_DESC_TSO << ICE_TXD_CTX_QW1_CMD_S) |
+			     (cd_tso_len << ICE_TXD_CTX_QW1_TSO_LEN_S) |
+			     (cd_mss << ICE_TXD_CTX_QW1_MSS_S));
 	first->tx_flags |= ICE_TX_FLAGS_TSO;
 	return 1;
 }
-- 
2.20.1

