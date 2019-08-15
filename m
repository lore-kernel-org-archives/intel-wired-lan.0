From: Sridhar Samudrala <sridhar.samudrala@intel.com>
Date: Wed, 14 Aug 2019 20:46:21 -0700
Subject: [Intel-wired-lan] [PATCH bpf-next 3/5] i40e: Enable XDP_SKIP_BPF
 option for AF_XDP sockets
In-Reply-To: <1565840783-8269-1-git-send-email-sridhar.samudrala@intel.com>
References: <1565840783-8269-1-git-send-email-sridhar.samudrala@intel.com>
Message-ID: <1565840783-8269-4-git-send-email-sridhar.samudrala@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch skips calling BPF program in the receive path if
the queue is associated with UMEM that is not shared and
bound to an AF_XDP socket that has enabled skip bpf during
bind() call.

Here are some performance numbers collected on 
  - 2 socket 28 core Intel(R) Xeon(R) Platinum 8180 CPU @ 2.50GHz
  - Intel 40Gb Ethernet NIC (i40e)

All tests use 2 cores and the results are in Mpps.

turbo on (default)
---------------------------------------------	
                      no-skip-bpf    skip-bpf
---------------------------------------------	
rxdrop zerocopy           21.9         38.5 
l2fwd  zerocopy           17.0         20.5
rxdrop copy               11.1         13.3
l2fwd  copy                1.9          2.0

no turbo :  echo 1 > /sys/devices/system/cpu/intel_pstate/no_turbo
---------------------------------------------	
                      no-skip-bpf    skip-bpf
---------------------------------------------	
rxdrop zerocopy           15.4         29.0
l2fwd  zerocopy           11.8         18.2
rxdrop copy                8.2         10.5
l2fwd  copy                1.7          1.7
---------------------------------------------	

Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c | 22 +++++++++++++++++++--
 drivers/net/ethernet/intel/i40e/i40e_xsk.c  |  6 ++++++
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index e3f29dc8b290..5e63e3644e87 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -2199,6 +2199,7 @@ static struct sk_buff *i40e_run_xdp(struct i40e_ring *rx_ring,
 	int err, result = I40E_XDP_PASS;
 	struct i40e_ring *xdp_ring;
 	struct bpf_prog *xdp_prog;
+	struct xdp_umem *umem;
 	u32 act;
 
 	rcu_read_lock();
@@ -2209,6 +2210,13 @@ static struct sk_buff *i40e_run_xdp(struct i40e_ring *rx_ring,
 
 	prefetchw(xdp->data_hard_start); /* xdp_frame write */
 
+	umem = xdp_get_umem_from_qid(rx_ring->netdev, rx_ring->queue_index);
+	if (xsk_umem_skip_bpf(umem)) {
+		err = xsk_umem_rcv(umem, xdp);
+		result = !err ? I40E_XDP_REDIR : I40E_XDP_CONSUMED;
+		goto xdp_out;
+	}
+
 	act = bpf_prog_run_xdp(xdp_prog, xdp);
 	switch (act) {
 	case XDP_PASS:
@@ -2303,8 +2311,18 @@ void i40e_update_rx_stats(struct i40e_ring *rx_ring,
  **/
 void i40e_finalize_xdp_rx(struct i40e_ring *rx_ring, unsigned int xdp_res)
 {
-	if (xdp_res & I40E_XDP_REDIR)
-		xdp_do_flush_map();
+	if (xdp_res & I40E_XDP_REDIR) {
+		struct xdp_umem *umem;
+
+		umem = rx_ring->xsk_umem;
+		if (!umem)
+			umem = xdp_get_umem_from_qid(rx_ring->netdev,
+						     rx_ring->queue_index);
+		if (xsk_umem_skip_bpf(umem))
+			xsk_umem_flush(umem);
+		else
+			xdp_do_flush_map();
+	}
 
 	if (xdp_res & I40E_XDP_TX) {
 		struct i40e_ring *xdp_ring =
diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
index 32bad014d76c..cc538479c95d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
@@ -195,6 +195,12 @@ static int i40e_run_xdp_zc(struct i40e_ring *rx_ring, struct xdp_buff *xdp)
 	struct bpf_prog *xdp_prog;
 	u32 act;
 
+	if (xsk_umem_skip_bpf(rx_ring->xsk_umem)) {
+		err = xsk_umem_rcv(rx_ring->xsk_umem, xdp);
+		result = !err ? I40E_XDP_REDIR : I40E_XDP_CONSUMED;
+		return result;
+	}
+
 	rcu_read_lock();
 	/* NB! xdp_prog will always be !NULL, due to the fact that
 	 * this path is enabled by setting an XDP program.
-- 
2.20.1

