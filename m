From: Sasha Levin <sashal@kernel.org>
Date: Sat, 11 Apr 2020 19:05:52 -0400
Subject: [Intel-wired-lan] [PATCH AUTOSEL 5.5 047/121] ice: Fix implicit
 queue mapping mode in ice_vsi_get_qs
In-Reply-To: <20200411230706.23855-1-sashal@kernel.org>
References: <20200411230706.23855-1-sashal@kernel.org>
Message-ID: <20200411230706.23855-47-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Brett Creeley <brett.creeley@intel.com>

[ Upstream commit 39066dc549cf8a688f6e105a4e9f2a8abefbcebe ]

Currently in ice_vsi_get_qs() we set the mapping_mode for Tx and Rx to
vsi->[tx|rx]_mapping_mode, but the problem is vsi->[tx|rx]_mapping_mode
have not been set yet. This was working because ICE_VSI_MAP_CONTIG is
defined to 0. Fix this by being explicit with our mapping mode by
initializing the Tx and Rx structure's mapping_mode to
ICE_VSI_MAP_CONTIG and then setting the vsi->[tx|rx]_mapping_mode to the
[tx|rx]_qs_cfg.mapping_mode values.

Also, only assign the vsi->[tx|rx]_mapping_mode when the queues are
successfully mapped to the VSI. With this change there was no longer a
need to initialize the ret variable to 0 so remove that.

Signed-off-by: Brett Creeley <brett.creeley@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_lib.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index b43bb51f6067a..04ced528d88a2 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -433,7 +433,7 @@ static int ice_vsi_get_qs(struct ice_vsi *vsi)
 		.scatter_count = ICE_MAX_SCATTER_TXQS,
 		.vsi_map = vsi->txq_map,
 		.vsi_map_offset = 0,
-		.mapping_mode = vsi->tx_mapping_mode
+		.mapping_mode = ICE_VSI_MAP_CONTIG
 	};
 	struct ice_qs_cfg rx_qs_cfg = {
 		.qs_mutex = &pf->avail_q_mutex,
@@ -443,18 +443,21 @@ static int ice_vsi_get_qs(struct ice_vsi *vsi)
 		.scatter_count = ICE_MAX_SCATTER_RXQS,
 		.vsi_map = vsi->rxq_map,
 		.vsi_map_offset = 0,
-		.mapping_mode = vsi->rx_mapping_mode
+		.mapping_mode = ICE_VSI_MAP_CONTIG
 	};
-	int ret = 0;
-
-	vsi->tx_mapping_mode = ICE_VSI_MAP_CONTIG;
-	vsi->rx_mapping_mode = ICE_VSI_MAP_CONTIG;
+	int ret;
 
 	ret = __ice_vsi_get_qs(&tx_qs_cfg);
-	if (!ret)
-		ret = __ice_vsi_get_qs(&rx_qs_cfg);
+	if (ret)
+		return ret;
+	vsi->tx_mapping_mode = tx_qs_cfg.mapping_mode;
 
-	return ret;
+	ret = __ice_vsi_get_qs(&rx_qs_cfg);
+	if (ret)
+		return ret;
+	vsi->rx_mapping_mode = rx_qs_cfg.mapping_mode;
+
+	return 0;
 }
 
 /**
-- 
2.20.1

