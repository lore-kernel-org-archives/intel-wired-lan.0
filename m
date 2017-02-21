From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Tue, 21 Feb 2017 15:55:46 -0800
Subject: [Intel-wired-lan] [next PATCH S61 08/10] i40e/i40evf: Clean-up
	process_skb_fields
In-Reply-To: <1487721348-25617-1-git-send-email-bimmy.pujari@intel.com>
References: <1487721348-25617-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1487721348-25617-9-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alexander Duyck <alexander.h.duyck@intel.com>

This is a minor clean-up to make the i40e/i40evf process_skb_fields
function look a little more like what we have in igb.  The Rx checksum
function called out a need for skb->protocol but I can't see where it
actually needs it.  I am assuming this is something that was likely
refactored out some time ago as the Rx checksum code has gone through a few
rewrites.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
Change-ID: I0b4668a34d90b61b66ded7c7c26e19a3e2d06251
---
Testing Hints:
        Basically just need to verify this builds and processes Rx
        checksums correctly.

 drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 8 +++-----
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 8 +++-----
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 558d7da..a540754 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -1431,8 +1431,6 @@ bool i40e_alloc_rx_buffers(struct i40e_ring *rx_ring, u16 cleaned_count)
  * @vsi: the VSI we care about
  * @skb: skb currently being received and modified
  * @rx_desc: the receive descriptor
- *
- * skb->protocol must be set before this function is called
  **/
 static inline void i40e_rx_checksum(struct i40e_vsi *vsi,
 				    struct sk_buff *skb,
@@ -1598,12 +1596,12 @@ void i40e_process_skb_fields(struct i40e_ring *rx_ring,
 
 	i40e_rx_hash(rx_ring, rx_desc, skb, rx_ptype);
 
-	/* modifies the skb - consumes the enet header */
-	skb->protocol = eth_type_trans(skb, rx_ring->netdev);
-
 	i40e_rx_checksum(rx_ring->vsi, skb, rx_desc);
 
 	skb_record_rx_queue(skb, rx_ring->queue_index);
+
+	/* modifies the skb - consumes the enet header */
+	skb->protocol = eth_type_trans(skb, rx_ring->netdev);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
index 9b9314a..7f02f62 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
@@ -764,8 +764,6 @@ bool i40evf_alloc_rx_buffers(struct i40e_ring *rx_ring, u16 cleaned_count)
  * @vsi: the VSI we care about
  * @skb: skb currently being received and modified
  * @rx_desc: the receive descriptor
- *
- * skb->protocol must be set before this function is called
  **/
 static inline void i40e_rx_checksum(struct i40e_vsi *vsi,
 				    struct sk_buff *skb,
@@ -917,12 +915,12 @@ void i40evf_process_skb_fields(struct i40e_ring *rx_ring,
 {
 	i40e_rx_hash(rx_ring, rx_desc, skb, rx_ptype);
 
-	/* modifies the skb - consumes the enet header */
-	skb->protocol = eth_type_trans(skb, rx_ring->netdev);
-
 	i40e_rx_checksum(rx_ring->vsi, skb, rx_desc);
 
 	skb_record_rx_queue(skb, rx_ring->queue_index);
+
+	/* modifies the skb - consumes the enet header */
+	skb->protocol = eth_type_trans(skb, rx_ring->netdev);
 }
 
 /**
-- 
2.4.11

