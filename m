From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Wed,  2 Dec 2020 16:07:23 +0100
Subject: [Intel-wired-lan] [PATCH net-next 2/3] ixgbe: optimize for
 XDP_REDIRECT in xsk path
In-Reply-To: <20201202150724.31439-1-magnus.karlsson@gmail.com>
References: <20201202150724.31439-1-magnus.karlsson@gmail.com>
Message-ID: <20201202150724.31439-3-magnus.karlsson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Magnus Karlsson <magnus.karlsson@intel.com>

Optimize ixgbe_run_xdp_zc() for the XDP program verdict being
XDP_REDIRECT in the zsk zero-copy path. This path is only used when
having AF_XDP zero-copy on and in that case most packets will be
directed to user space. This provides a little under 100k extra
packets in throughput on my server when running l2fwd in xdpsock.

Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
index 3771857cf887..91ad5b902673 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
@@ -104,6 +104,13 @@ static int ixgbe_run_xdp_zc(struct ixgbe_adapter *adapter,
 	xdp_prog = READ_ONCE(rx_ring->xdp_prog);
 	act = bpf_prog_run_xdp(xdp_prog, xdp);
 
+	if (likely(act == XDP_REDIRECT)) {
+		err = xdp_do_redirect(rx_ring->netdev, xdp, xdp_prog);
+		result = !err ? IXGBE_XDP_REDIR : IXGBE_XDP_CONSUMED;
+		rcu_read_unlock();
+		return result;
+	}
+
 	switch (act) {
 	case XDP_PASS:
 		break;
@@ -115,10 +122,6 @@ static int ixgbe_run_xdp_zc(struct ixgbe_adapter *adapter,
 		}
 		result = ixgbe_xmit_xdp_ring(adapter, xdpf);
 		break;
-	case XDP_REDIRECT:
-		err = xdp_do_redirect(rx_ring->netdev, xdp, xdp_prog);
-		result = !err ? IXGBE_XDP_REDIR : IXGBE_XDP_CONSUMED;
-		break;
 	default:
 		bpf_warn_invalid_xdp_action(act);
 		fallthrough;
-- 
2.29.0

