From: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
Date: Tue, 12 Apr 2016 08:30:42 -0700
Subject: [Intel-wired-lan] [next PATCH S33 03/13] i40e: Code cleanup in
	i40e_add_fdir_ethtool
In-Reply-To: <1460475052-6348-1-git-send-email-harshitha.ramamurthy@intel.com>
References: <1460475052-6348-1-git-send-email-harshitha.ramamurthy@intel.com>
Message-ID: <1460475052-6348-4-git-send-email-harshitha.ramamurthy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Shannon Nelson <shannon.nelson@intel.com>

A little bit of code cleanup in prep for more cloud filter work.

Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
Change-ID: I0dc33ce0d4c207944336a07437640fef920c100c
---
Testing Hints :
	Compiles, FD filters still work

 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 8a83d45..8e56c43 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -2506,7 +2506,6 @@ static int i40e_add_fdir_ethtool(struct i40e_vsi *vsi,
 
 	if (!vsi)
 		return -EINVAL;
-
 	pf = vsi->back;
 
 	if (!(pf->flags & I40E_FLAG_FD_SB_ENABLED))
@@ -2564,15 +2563,18 @@ static int i40e_add_fdir_ethtool(struct i40e_vsi *vsi,
 	input->src_ip[0] = fsp->h_u.tcp_ip4_spec.ip4dst;
 
 	if (ntohl(fsp->m_ext.data[1])) {
-		if (ntohl(fsp->h_ext.data[1]) >= pf->num_alloc_vfs) {
-			netif_info(pf, drv, vsi->netdev, "Invalid VF id\n");
+		vf_id = ntohl(fsp->h_ext.data[1]);
+		if (vf_id >= pf->num_alloc_vfs) {
+			netif_info(pf, drv, vsi->netdev,
+				   "Invalid VF id %d\n", vf_id);
 			goto free_input;
 		}
-		vf_id = ntohl(fsp->h_ext.data[1]);
 		/* Find vsi id from vf id and override dest vsi */
 		input->dest_vsi = pf->vf[vf_id].lan_vsi_id;
 		if (input->q_index >= pf->vf[vf_id].num_queue_pairs) {
-			netif_info(pf, drv, vsi->netdev, "Invalid queue id\n");
+			netif_info(pf, drv, vsi->netdev,
+				   "Invalid queue id %d for VF %d\n",
+				   input->q_index, vf_id);
 			goto free_input;
 		}
 	}
-- 
2.4.3

