From: Maxim Mikityanskiy <maximmi@mellanox.com>
Date: Thu, 5 Dec 2019 15:51:15 +0000
Subject: [Intel-wired-lan] [PATCH bpf 3/4] net/i40e: Fix concurrency issues
 between config flow and XSK
In-Reply-To: <20191205155028.28854-1-maximmi@mellanox.com>
References: <20191205155028.28854-1-maximmi@mellanox.com>
Message-ID: <20191205155028.28854-4-maximmi@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Use synchronize_rcu to wait until the XSK wakeup function finishes
before destroying the resources it uses:

1. i40e_down already calls synchronize_rcu. On i40e_down either
__I40E_VSI_DOWN or __I40E_CONFIG_BUSY is set. Check the latter in
i40e_xsk_async_xmit (the former is already checked there).

2. After switching the XDP program, call synchronize_rcu to let
i40e_xsk_async_xmit exit before the XDP program is freed.

3. Changing the number of channels brings the interface down (see
i40e_prep_for_reset and i40e_pf_quiesce_all_vsi).

4. Disabling UMEM sets __I40E_CONFIG_BUSY, too.

Signed-off-by: Maxim Mikityanskiy <maximmi@mellanox.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 7 +++++--
 drivers/net/ethernet/intel/i40e/i40e_xsk.c  | 4 ++++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 1ccabeafa44c..afa3a99e68e1 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -6823,8 +6823,8 @@ void i40e_down(struct i40e_vsi *vsi)
 	for (i = 0; i < vsi->num_queue_pairs; i++) {
 		i40e_clean_tx_ring(vsi->tx_rings[i]);
 		if (i40e_enabled_xdp_vsi(vsi)) {
-			/* Make sure that in-progress ndo_xdp_xmit
-			 * calls are completed.
+			/* Make sure that in-progress ndo_xdp_xmit and
+			 * ndo_xsk_async_xmit calls are completed.
 			 */
 			synchronize_rcu();
 			i40e_clean_tx_ring(vsi->xdp_rings[i]);
@@ -12545,6 +12545,9 @@ static int i40e_xdp_setup(struct i40e_vsi *vsi,
 		i40e_prep_for_reset(pf, true);
 
 	old_prog = xchg(&vsi->xdp_prog, prog);
+	if (old_prog)
+		/* Wait until ndo_xsk_async_xmit completes. */
+		synchronize_rcu();
 
 	if (need_reset)
 		i40e_reset_and_rebuild(pf, true, true);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
index d07e1a890428..f73cd917c44f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
@@ -787,8 +787,12 @@ int i40e_xsk_wakeup(struct net_device *dev, u32 queue_id, u32 flags)
 {
 	struct i40e_netdev_priv *np = netdev_priv(dev);
 	struct i40e_vsi *vsi = np->vsi;
+	struct i40e_pf *pf = vsi->back;
 	struct i40e_ring *ring;
 
+	if (test_bit(__I40E_CONFIG_BUSY, pf->state))
+		return -ENETDOWN;
+
 	if (test_bit(__I40E_VSI_DOWN, vsi->state))
 		return -ENETDOWN;
 
-- 
2.20.1

