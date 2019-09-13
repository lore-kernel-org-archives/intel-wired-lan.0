From: Ciara Loftus <ciara.loftus@intel.com>
Date: Fri, 13 Sep 2019 10:39:47 +0000
Subject: [Intel-wired-lan] [PATCH bpf-next v2 2/3] ixgbe: fix xdp handle
 calculations
In-Reply-To: <20190913103948.32053-1-ciara.loftus@intel.com>
References: <20190913103948.32053-1-ciara.loftus@intel.com>
Message-ID: <20190913103948.32053-3-ciara.loftus@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Commit 7cbbf9f1fa23 ("ixgbe: fix xdp handle calculations") reintroduced
the addition of the umem headroom to the xdp handle in the ixgbe_zca_free,
ixgbe_alloc_buffer_slow_zc and ixgbe_alloc_buffer_zc functions. However,
the headroom is already added to the handle in the function
ixgbe_run_xdp_zc. This commit removes the latter addition and fixes the
case where the headroom is non-zero.

Fixes: 7cbbf9f1fa23 ("ixgbe: fix xdp handle calculations")
Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
index ad802a8909e0..fd45d12b5a98 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
@@ -145,15 +145,15 @@ static int ixgbe_run_xdp_zc(struct ixgbe_adapter *adapter,
 {
 	struct xdp_umem *umem = rx_ring->xsk_umem;
 	int err, result = IXGBE_XDP_PASS;
-	u64 offset = umem->headroom;
 	struct bpf_prog *xdp_prog;
 	struct xdp_frame *xdpf;
+	u64 offset;
 	u32 act;
 
 	rcu_read_lock();
 	xdp_prog = READ_ONCE(rx_ring->xdp_prog);
 	act = bpf_prog_run_xdp(xdp_prog, xdp);
-	offset += xdp->data - xdp->data_hard_start;
+	offset = xdp->data - xdp->data_hard_start;
 
 	xdp->handle = xsk_umem_adjust_offset(umem, xdp->handle, offset);
 
-- 
2.17.1

