From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Fri, 26 Oct 2018 10:40:59 -0700
Subject: [Intel-wired-lan] [PATCH S8 10/16] ice: Fix the bytecount sent to
 netdev_tx_sent_queue
In-Reply-To: <20181026174105.11628-1-anirudh.venkataramanan@intel.com>
References: <20181026174105.11628-1-anirudh.venkataramanan@intel.com>
Message-ID: <20181026174105.11628-11-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Brett Creeley <brett.creeley@intel.com>

Currently if the driver does a TSO offload the bytecount sent to
netdev_tx_sent_queue will be incorrect. This is because in ice_tso we
overwrite the initial value that we set in ice_tx_map. This creates a
mismatch between the Tx and Tx clean flow. In the Tx clean flow we
calculate the bytecount (called total_bytes) as we clean the
descriptors so the value used in the Tx clean path is correct. Fix this
by using += in ice_tso instead of =. This fixes the mismatch in
bytecount mentioned above.

Signed-off-by: Brett Creeley <brett.creeley@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_txrx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index 3387c67c848d..fe5bbabbb41e 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -1520,7 +1520,7 @@ int ice_tso(struct ice_tx_buf *first, struct ice_tx_offload_params *off)
 
 	/* update gso_segs and bytecount */
 	first->gso_segs = skb_shinfo(skb)->gso_segs;
-	first->bytecount = (first->gso_segs - 1) * off->header_len;
+	first->bytecount += (first->gso_segs - 1) * off->header_len;
 
 	cd_tso_len = skb->len - off->header_len;
 	cd_mss = skb_shinfo(skb)->gso_size;
-- 
2.14.3

