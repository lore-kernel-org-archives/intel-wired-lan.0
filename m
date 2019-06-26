From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Wed, 26 Jun 2019 02:20:20 -0700
Subject: [Intel-wired-lan] [PATCH S22 09/16] ice: Set up Tx scheduling tree
 based on alloc VSI Tx queues
In-Reply-To: <20190626092027.52845-1-anthony.l.nguyen@intel.com>
References: <20190626092027.52845-1-anthony.l.nguyen@intel.com>
Message-ID: <20190626092027.52845-9-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>

This patch uses allocated number of Tx queues per VSI to set up its
scheduling tree instead of using total number of available Tx queues.
Only PF VSIs have total number of allocated Tx queues equal to number
of available Tx queues, other VSIs have different number of queues
configured.

Signed-off-by: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 9aa1f285b17f..85fb1e4640ca 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -2605,7 +2605,7 @@ ice_vsi_setup(struct ice_pf *pf, struct ice_port_info *pi,
 
 	/* configure VSI nodes based on number of queues and TC's */
 	for (i = 0; i < vsi->tc_cfg.numtc; i++)
-		max_txqs[i] = pf->num_lan_tx;
+		max_txqs[i] = vsi->alloc_txq;
 
 	status = ice_cfg_vsi_lan(vsi->port_info, vsi->idx, vsi->tc_cfg.ena_tc,
 				 max_txqs);
@@ -3131,7 +3131,7 @@ int ice_vsi_rebuild(struct ice_vsi *vsi)
 
 	/* configure VSI nodes based on number of queues and TC's */
 	for (i = 0; i < vsi->tc_cfg.numtc; i++) {
-		max_txqs[i] = pf->num_lan_tx;
+		max_txqs[i] = vsi->alloc_txq;
 
 		if (ice_is_xdp_ena_vsi(vsi))
 			max_txqs[i] += vsi->num_xdp_txq;
@@ -3252,7 +3252,7 @@ int ice_vsi_cfg_tc(struct ice_vsi *vsi, u8 ena_tc)
 		if (ena_tc & BIT(i))
 			num_tc++;
 		/* populate max_txqs per TC */
-		max_txqs[i] = pf->num_lan_tx;
+		max_txqs[i] = vsi->alloc_txq;
 	}
 
 	vsi->tc_cfg.ena_tc = ena_tc;
-- 
2.20.1

