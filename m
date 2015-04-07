From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Tue,  7 Apr 2015 19:45:31 -0400
Subject: [Intel-wired-lan] [net-next S3 02/13] i40e: Add support to program
	FDir SB rules for VF from PF through ethtool
In-Reply-To: <1428450342-48517-1-git-send-email-catherine.sullivan@intel.com>
References: <1428450342-48517-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1428450342-48517-2-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Anjali Singhai Jain <anjali.singhai@intel.com>

With this patch we can now add Flow director Sideband rules for a VF from it's PF.
Here is an example on how it can be done when VF id = 5 and queue = 2
"ethtool -N ethx flow-type udp4 src-ip x.x.x.x dst-ip y.y.y.y src-port p1 dst-port p2 action 2 user-def 5"
User-def specifies VF id and action specifies queue.

Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
Change-ID: Ib37d6dff3823a4d85caffde638473891c38c2b89
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index c848b18..7d60587 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -1914,6 +1914,16 @@ static int i40e_get_ethtool_fdir_entry(struct i40e_pf *pf,
 	else
 		fsp->ring_cookie = rule->q_index;
 
+	if (rule->dest_vsi != pf->vsi[pf->lan_vsi]->id) {
+		struct i40e_vsi *vsi;
+
+		vsi = i40e_find_vsi_from_id(pf, rule->dest_vsi);
+		if (vsi && vsi->type == I40E_VSI_SRIOV) {
+			fsp->h_ext.data[1] = htonl(vsi->vf_id);
+			fsp->m_ext.data[1] = htonl(0x1);
+		}
+	}
+
 	return 0;
 }
 
@@ -2207,6 +2217,7 @@ static int i40e_add_fdir_ethtool(struct i40e_vsi *vsi,
 	struct i40e_fdir_filter *input;
 	struct i40e_pf *pf;
 	int ret = -EINVAL;
+	u16 vf_id;
 
 	if (!vsi)
 		return -EINVAL;
@@ -2267,7 +2278,22 @@ static int i40e_add_fdir_ethtool(struct i40e_vsi *vsi,
 	input->dst_ip[0] = fsp->h_u.tcp_ip4_spec.ip4src;
 	input->src_ip[0] = fsp->h_u.tcp_ip4_spec.ip4dst;
 
+	if (ntohl(fsp->m_ext.data[1])) {
+		if (ntohl(fsp->h_ext.data[1]) >= pf->num_alloc_vfs) {
+			netif_info(pf, drv, vsi->netdev, "Invalid VF id\n");
+			goto free_input;
+		}
+		vf_id = ntohl(fsp->h_ext.data[1]);
+		/* Find vsi id from vf id and override dest vsi */
+		input->dest_vsi = pf->vf[vf_id].lan_vsi_id;
+		if (input->q_index >= pf->vf[vf_id].num_queue_pairs) {
+			netif_info(pf, drv, vsi->netdev, "Invalid queue id\n");
+			goto free_input;
+		}
+	}
+
 	ret = i40e_add_del_fdir(vsi, input, true);
+free_input:
 	if (ret)
 		kfree(input);
 	else
-- 
1.9.3

