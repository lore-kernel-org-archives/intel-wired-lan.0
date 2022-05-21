From: Julia Lawall <Julia.Lawall@inria.fr>
Date: Sat, 21 May 2022 13:11:00 +0200
Subject: [Intel-wired-lan] [PATCH] drivers/net/ethernet/intel: fix typos in
 comments
Message-ID: <20220521111145.81697-50-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Spelling mistakes (triple letters) in comments.
Detected with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 drivers/net/ethernet/intel/fm10k/fm10k_mbx.c   |    2 +-
 drivers/net/ethernet/intel/ice/ice_lib.c       |    2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_mbx.c b/drivers/net/ethernet/intel/fm10k/fm10k_mbx.c
index 30ca9ee1900b..f2fba6e1d0f7 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_mbx.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_mbx.c
@@ -1825,7 +1825,7 @@ static void fm10k_sm_mbx_process_error(struct fm10k_mbx_info *mbx)
 		fm10k_sm_mbx_connect_reset(mbx);
 		break;
 	case FM10K_STATE_CONNECT:
-		/* try connnecting at lower version */
+		/* try connecting at lower version */
 		if (mbx->remote) {
 			while (mbx->local > 1)
 				mbx->local--;
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 454e01ae09b9..70961c0343e7 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -2403,7 +2403,7 @@ static void ice_set_agg_vsi(struct ice_vsi *vsi)
 				agg_id);
 			return;
 		}
-		/* aggregator node is created, store the neeeded info */
+		/* aggregator node is created, store the needed info */
 		agg_node->valid = true;
 		agg_node->agg_id = agg_id;
 	}
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
index 3e74ab82868b..3f5ef5269bb2 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
@@ -77,7 +77,7 @@ static int __ixgbe_enable_sriov(struct ixgbe_adapter *adapter,
 	IXGBE_WRITE_REG(hw, IXGBE_PFDTXGSWC, IXGBE_PFDTXGSWC_VT_LBEN);
 	adapter->bridge_mode = BRIDGE_MODE_VEB;
 
-	/* limit trafffic classes based on VFs enabled */
+	/* limit traffic classes based on VFs enabled */
 	if ((adapter->hw.mac.type == ixgbe_mac_82599EB) && (num_vfs < 16)) {
 		adapter->dcb_cfg.num_tcs.pg_tcs = MAX_TRAFFIC_CLASS;
 		adapter->dcb_cfg.num_tcs.pfc_tcs = MAX_TRAFFIC_CLASS;

