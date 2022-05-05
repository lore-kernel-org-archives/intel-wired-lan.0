From: Leon Romanovsky <leon@kernel.org>
Date: Thu,  5 May 2022 13:06:44 +0300
Subject: [Intel-wired-lan] [PATCH ipsec-next 7/8] net/mlx5e: Use XFRM state
 direction instead of flags
In-Reply-To: <cover.1651743750.git.leonro@nvidia.com>
References: <cover.1651743750.git.leonro@nvidia.com>
Message-ID: <a8e511b7d8446e4c1c5414c44a6a81de62f116eb.1651743750.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Leon Romanovsky <leonro@nvidia.com>

Convert mlx5 driver to use XFRM state direction.

Reviewed-by: Raed Salem <raeds@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c   | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
index 35e2bb301c26..2a8fd7020622 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
@@ -172,9 +172,9 @@ mlx5e_ipsec_build_accel_xfrm_attrs(struct mlx5e_ipsec_sa_entry *sa_entry,
 	}
 
 	/* action */
-	attrs->action = (!(x->xso.flags & XFRM_OFFLOAD_INBOUND)) ?
-			MLX5_ACCEL_ESP_ACTION_ENCRYPT :
-			MLX5_ACCEL_ESP_ACTION_DECRYPT;
+	attrs->action = (x->xso.dir == XFRM_DEV_OFFLOAD_OUT) ?
+				MLX5_ACCEL_ESP_ACTION_ENCRYPT :
+				      MLX5_ACCEL_ESP_ACTION_DECRYPT;
 	/* flags */
 	attrs->flags |= (x->props.mode == XFRM_MODE_TRANSPORT) ?
 			MLX5_ACCEL_ESP_FLAGS_TRANSPORT :
@@ -306,7 +306,7 @@ static int mlx5e_xfrm_add_state(struct xfrm_state *x)
 	if (err)
 		goto err_hw_ctx;
 
-	if (x->xso.flags & XFRM_OFFLOAD_INBOUND) {
+	if (x->xso.dir == XFRM_DEV_OFFLOAD_IN) {
 		err = mlx5e_ipsec_sadb_rx_add(sa_entry);
 		if (err)
 			goto err_add_rule;
@@ -333,7 +333,7 @@ static void mlx5e_xfrm_del_state(struct xfrm_state *x)
 {
 	struct mlx5e_ipsec_sa_entry *sa_entry = to_ipsec_sa_entry(x);
 
-	if (x->xso.flags & XFRM_OFFLOAD_INBOUND)
+	if (x->xso.dir == XFRM_DEV_OFFLOAD_IN)
 		mlx5e_ipsec_sadb_rx_del(sa_entry);
 }
 
-- 
2.35.1

