From: Alice Michael <alice.michael@intel.com>
Date: Tue, 28 May 2019 10:59:20 -0700
Subject: [Intel-wired-lan] [next PATCH S6 6/7] i40e: Fix descriptor count
 manipulation
In-Reply-To: <20190528175921.30534-1-alice.michael@intel.com>
References: <20190528175921.30534-1-alice.michael@intel.com>
Message-ID: <20190528175921.30534-6-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Changing descriptor count via 'ethtool -G' is not persistent across resets.
When PF reset occurs, we roll back to the default value of vsi->num_desc,
which is used then in i40e_alloc_rings to set descriptor count. XDP does a
PF reset so when user has changed the descriptor count and load XDP
program, the default count will be back there.

To fix this:
  * introduce new VSI members - num_tx_desc and num_rx_desc in favour of
    num_desc
  * set them in i40e_set_ringparam to user's values
  * set them to default values in i40e_set_num_rings_in_vsi only when they
    don't have previous values

Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h        |  3 +-
 .../net/ethernet/intel/i40e/i40e_debugfs.c    |  5 +--
 .../net/ethernet/intel/i40e/i40e_ethtool.c    |  4 +++
 drivers/net/ethernet/intel/i40e/i40e_main.c   | 36 +++++++++++++------
 4 files changed, 34 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 1da53c0d49ca..423ee9fa94d6 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -795,7 +795,8 @@ struct i40e_vsi {
 	u16 alloc_queue_pairs;	/* Allocated Tx/Rx queues */
 	u16 req_queue_pairs;	/* User requested queue pairs */
 	u16 num_queue_pairs;	/* Used tx and rx pairs */
-	u16 num_desc;
+	u16 num_tx_desc;
+	u16 num_rx_desc;
 	enum i40e_vsi_type type;  /* VSI type, e.g., LAN, FCoE, etc */
 	s16 vf_id;		/* Virtual function ID for SRIOV VSIs */
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
index dc5b40013e61..55d20acfcf70 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
@@ -333,8 +333,9 @@ static void i40e_dbg_dump_vsi_seid(struct i40e_pf *pf, int seid)
 		 "    seid = %d, id = %d, uplink_seid = %d\n",
 		 vsi->seid, vsi->id, vsi->uplink_seid);
 	dev_info(&pf->pdev->dev,
-		 "    base_queue = %d, num_queue_pairs = %d, num_desc = %d\n",
-		 vsi->base_queue, vsi->num_queue_pairs, vsi->num_desc);
+		 "    base_queue = %d, num_queue_pairs = %d, num_tx_desc = %d, num_rx_desc = %d\n",
+		 vsi->base_queue, vsi->num_queue_pairs, vsi->num_tx_desc,
+		 vsi->num_rx_desc);
 	dev_info(&pf->pdev->dev, "    type = %i\n", vsi->type);
 	if (vsi->type == I40E_VSI_SRIOV)
 		dev_info(&pf->pdev->dev, "    VF ID = %i\n", vsi->vf_id);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index bc70b0d581a1..b7f4ac9a423c 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -1982,6 +1982,8 @@ static int i40e_set_ringparam(struct net_device *netdev,
 			if (i40e_enabled_xdp_vsi(vsi))
 				vsi->xdp_rings[i]->count = new_tx_count;
 		}
+		vsi->num_tx_desc = new_tx_count;
+		vsi->num_rx_desc = new_rx_count;
 		goto done;
 	}
 
@@ -2118,6 +2120,8 @@ static int i40e_set_ringparam(struct net_device *netdev,
 		rx_rings = NULL;
 	}
 
+	vsi->num_tx_desc = new_tx_count;
+	vsi->num_rx_desc = new_rx_count;
 	i40e_up(vsi);
 
 free_tx:
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 1dd5fcf256ef..fb25e8222fb5 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -10550,8 +10550,12 @@ static int i40e_set_num_rings_in_vsi(struct i40e_vsi *vsi)
 	switch (vsi->type) {
 	case I40E_VSI_MAIN:
 		vsi->alloc_queue_pairs = pf->num_lan_qps;
-		vsi->num_desc = ALIGN(I40E_DEFAULT_NUM_DESCRIPTORS,
-				      I40E_REQ_DESCRIPTOR_MULTIPLE);
+		if (!vsi->num_tx_desc)
+			vsi->num_tx_desc = ALIGN(I40E_DEFAULT_NUM_DESCRIPTORS,
+						 I40E_REQ_DESCRIPTOR_MULTIPLE);
+		if (!vsi->num_rx_desc)
+			vsi->num_rx_desc = ALIGN(I40E_DEFAULT_NUM_DESCRIPTORS,
+						 I40E_REQ_DESCRIPTOR_MULTIPLE);
 		if (pf->flags & I40E_FLAG_MSIX_ENABLED)
 			vsi->num_q_vectors = pf->num_lan_msix;
 		else
@@ -10561,22 +10565,32 @@ static int i40e_set_num_rings_in_vsi(struct i40e_vsi *vsi)
 
 	case I40E_VSI_FDIR:
 		vsi->alloc_queue_pairs = 1;
-		vsi->num_desc = ALIGN(I40E_FDIR_RING_COUNT,
-				      I40E_REQ_DESCRIPTOR_MULTIPLE);
+		vsi->num_tx_desc = ALIGN(I40E_FDIR_RING_COUNT,
+					 I40E_REQ_DESCRIPTOR_MULTIPLE);
+		vsi->num_rx_desc = ALIGN(I40E_FDIR_RING_COUNT,
+					 I40E_REQ_DESCRIPTOR_MULTIPLE);
 		vsi->num_q_vectors = pf->num_fdsb_msix;
 		break;
 
 	case I40E_VSI_VMDQ2:
 		vsi->alloc_queue_pairs = pf->num_vmdq_qps;
-		vsi->num_desc = ALIGN(I40E_DEFAULT_NUM_DESCRIPTORS,
-				      I40E_REQ_DESCRIPTOR_MULTIPLE);
+		if (!vsi->num_tx_desc)
+			vsi->num_tx_desc = ALIGN(I40E_DEFAULT_NUM_DESCRIPTORS,
+						 I40E_REQ_DESCRIPTOR_MULTIPLE);
+		if (!vsi->num_rx_desc)
+			vsi->num_rx_desc = ALIGN(I40E_DEFAULT_NUM_DESCRIPTORS,
+						 I40E_REQ_DESCRIPTOR_MULTIPLE);
 		vsi->num_q_vectors = pf->num_vmdq_msix;
 		break;
 
 	case I40E_VSI_SRIOV:
 		vsi->alloc_queue_pairs = pf->num_vf_qps;
-		vsi->num_desc = ALIGN(I40E_DEFAULT_NUM_DESCRIPTORS,
-				      I40E_REQ_DESCRIPTOR_MULTIPLE);
+		if (!vsi->num_tx_desc)
+			vsi->num_tx_desc = ALIGN(I40E_DEFAULT_NUM_DESCRIPTORS,
+						 I40E_REQ_DESCRIPTOR_MULTIPLE);
+		if (!vsi->num_rx_desc)
+			vsi->num_rx_desc = ALIGN(I40E_DEFAULT_NUM_DESCRIPTORS,
+						 I40E_REQ_DESCRIPTOR_MULTIPLE);
 		break;
 
 	default:
@@ -10852,7 +10866,7 @@ static int i40e_alloc_rings(struct i40e_vsi *vsi)
 		ring->vsi = vsi;
 		ring->netdev = vsi->netdev;
 		ring->dev = &pf->pdev->dev;
-		ring->count = vsi->num_desc;
+		ring->count = vsi->num_tx_desc;
 		ring->size = 0;
 		ring->dcb_tc = 0;
 		if (vsi->back->hw_features & I40E_HW_WB_ON_ITR_CAPABLE)
@@ -10869,7 +10883,7 @@ static int i40e_alloc_rings(struct i40e_vsi *vsi)
 		ring->vsi = vsi;
 		ring->netdev = NULL;
 		ring->dev = &pf->pdev->dev;
-		ring->count = vsi->num_desc;
+		ring->count = vsi->num_tx_desc;
 		ring->size = 0;
 		ring->dcb_tc = 0;
 		if (vsi->back->hw_features & I40E_HW_WB_ON_ITR_CAPABLE)
@@ -10885,7 +10899,7 @@ static int i40e_alloc_rings(struct i40e_vsi *vsi)
 		ring->vsi = vsi;
 		ring->netdev = vsi->netdev;
 		ring->dev = &pf->pdev->dev;
-		ring->count = vsi->num_desc;
+		ring->count = vsi->num_rx_desc;
 		ring->size = 0;
 		ring->dcb_tc = 0;
 		ring->itr_setting = pf->rx_itr_default;
-- 
2.19.2

