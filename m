From: Sasha Levin <sashal@kernel.org>
Date: Mon,  8 Jun 2020 19:02:48 -0400
Subject: [Intel-wired-lan] [PATCH AUTOSEL 5.7 075/274] ice: Change number of
 XDP TxQ to 0 when destroying rings
In-Reply-To: <20200608230607.3361041-1-sashal@kernel.org>
References: <20200608230607.3361041-1-sashal@kernel.org>
Message-ID: <20200608230607.3361041-75-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Marta Plantykow <marta.a.plantykow@intel.com>

[ Upstream commit c8f135c6ee7851ad72bd4d877216950fcbd45fb6 ]

When XDP Tx rings are destroyed the number of XDP Tx queues
is not changing. This patch is changing this number to 0.

Signed-off-by: Marta Plantykow <marta.a.plantykow@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 5b190c257124..599dab844034 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -1898,6 +1898,9 @@ int ice_destroy_xdp_rings(struct ice_vsi *vsi)
 	for (i = 0; i < vsi->tc_cfg.numtc; i++)
 		max_txqs[i] = vsi->num_txq;
 
+	/* change number of XDP Tx queues to 0 */
+	vsi->num_xdp_txq = 0;
+
 	return ice_cfg_vsi_lan(vsi->port_info, vsi->idx, vsi->tc_cfg.ena_tc,
 			       max_txqs);
 }
-- 
2.25.1

