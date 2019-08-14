From: Magnus Karlsson <magnus.karlsson@intel.com>
Date: Wed, 14 Aug 2019 09:27:22 +0200
Subject: [Intel-wired-lan] [PATCH bpf-next v4 7/8] net/mlx5e: Move the SW
 XSK code from NAPI poll to a separate function
In-Reply-To: <1565767643-4908-1-git-send-email-magnus.karlsson@intel.com>
References: <1565767643-4908-1-git-send-email-magnus.karlsson@intel.com>
Message-ID: <1565767643-4908-8-git-send-email-magnus.karlsson@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Maxim Mikityanskiy <maximmi@mellanox.com>

Two XSK tasks are performed during NAPI polling, that are not bound to
hardware interrupts: TXing packets and polling for frames in the Fill
Ring. They are special in a way that the hardware doesn't know about
these tasks, so it doesn't trigger interrupts if there is still some
work to be done, it's our driver's responsibility to ensure NAPI will be
rescheduled if needed.

Create a new function to handle these tasks and move the corresponding
code from mlx5e_napi_poll to the new function to improve modularity and
prepare for the changes in the following patch.

Signed-off-by: Maxim Mikityanskiy <maximmi@mellanox.com>
Reviewed-by: Tariq Toukan <tariqt@mellanox.com>
Reviewed-by: Saeed Mahameed <saeedm@mellanox.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
index 49b06b2..6d16dee 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
@@ -81,6 +81,16 @@ void mlx5e_trigger_irq(struct mlx5e_icosq *sq)
 	mlx5e_notify_hw(wq, sq->pc, sq->uar_map, &nopwqe->ctrl);
 }
 
+static bool mlx5e_napi_xsk_post(struct mlx5e_xdpsq *xsksq, struct mlx5e_rq *xskrq)
+{
+	bool busy_xsk = false;
+
+	busy_xsk |= mlx5e_xsk_tx(xsksq, MLX5E_TX_XSK_POLL_BUDGET);
+	busy_xsk |= xskrq->post_wqes(xskrq);
+
+	return busy_xsk;
+}
+
 int mlx5e_napi_poll(struct napi_struct *napi, int budget)
 {
 	struct mlx5e_channel *c = container_of(napi, struct mlx5e_channel,
@@ -122,8 +132,7 @@ int mlx5e_napi_poll(struct napi_struct *napi, int budget)
 	if (xsk_open) {
 		mlx5e_poll_ico_cq(&c->xskicosq.cq);
 		busy |= mlx5e_poll_xdpsq_cq(&xsksq->cq);
-		busy_xsk |= mlx5e_xsk_tx(xsksq, MLX5E_TX_XSK_POLL_BUDGET);
-		busy_xsk |= xskrq->post_wqes(xskrq);
+		busy_xsk |= mlx5e_napi_xsk_post(xsksq, xskrq);
 	}
 
 	busy |= busy_xsk;
-- 
2.7.4

