From: Jesper Dangaard Brouer <brouer@redhat.com>
Date: Mon, 16 Mar 2020 11:16:38 +0100
Subject: [Intel-wired-lan] [PATCH net-next] i40e: trivial fixup of comments
 in i40e_xsk.c
Message-ID: <158435379870.2479973.8293720099992666964.stgit@carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The comment above i40e_run_xdp_zc() was clearly copy-pasted from
function i40e_xsk_umem_setup, which is just above.

Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
---
 drivers/net/ethernet/intel/i40e/i40e_xsk.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
index 0b7d29192b2c..30dfb0d3d185 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
@@ -184,8 +184,6 @@ int i40e_xsk_umem_setup(struct i40e_vsi *vsi, struct xdp_umem *umem,
  * @rx_ring: Rx ring
  * @xdp: xdp_buff used as input to the XDP program
  *
- * This function enables or disables a UMEM to a certain ring.
- *
  * Returns any of I40E_XDP_{PASS, CONSUMED, TX, REDIR}
  **/
 static int i40e_run_xdp_zc(struct i40e_ring *rx_ring, struct xdp_buff *xdp)
@@ -474,7 +472,7 @@ void i40e_zca_free(struct zero_copy_allocator *alloc, unsigned long handle)
 }
 
 /**
- * i40e_construct_skb_zc - Create skbufff from zero-copy Rx buffer
+ * i40e_construct_skb_zc - Create skbuff from zero-copy Rx buffer
  * @rx_ring: Rx ring
  * @bi: Rx buffer
  * @xdp: xdp_buff


