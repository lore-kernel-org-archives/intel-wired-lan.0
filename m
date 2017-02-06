From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon,  6 Feb 2017 14:38:48 -0800
Subject: [Intel-wired-lan] [PART2 PATCH 5/9] i40e: partition the ring_cookie
	to get VF index
In-Reply-To: <20170206223852.31177-1-jacob.e.keller@intel.com>
References: <20170206223852.31177-1-jacob.e.keller@intel.com>
Message-ID: <20170206223852.31177-6-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Do not use the user-def field for determining the VF target. Instead,
similar to ixgbe, partition the ring_cookie value into 8bits of VF
index, along with 32bits of queue number. This is better than using the
user-def field, because it leaves the field open for extension in
a future patch which will enable flexible data. Also, this matches with
convention used by ixgbe and other drivers.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Change-Id: e36745186d817216b12f0313b99ec95cb8a9130c
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 74 ++++++++++++++------------
 1 file changed, 40 insertions(+), 34 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 595ede664c56..f6cca3254fd4 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -2420,8 +2420,13 @@ static int i40e_get_ethtool_fdir_entry(struct i40e_pf *pf,
 
 		vsi = i40e_find_vsi_from_id(pf, rule->dest_vsi);
 		if (vsi && vsi->type == I40E_VSI_SRIOV) {
-			fsp->h_ext.data[1] = htonl(vsi->vf_id);
-			fsp->m_ext.data[1] = htonl(0x1);
+			/* VFs are zero-indexed by the driver, but ethtool
+			 * expects them to be one-indexed, so add one here
+			 */
+			u64 ring_vf = vsi->vf_id + 1;
+
+			ring_vf <<= ETHTOOL_RX_FLOW_SPEC_RING_VF_OFF;
+			fsp->ring_cookie |= ring_vf;
 		}
 	}
 
@@ -3000,9 +3005,10 @@ static int i40e_add_fdir_ethtool(struct i40e_vsi *vsi,
 {
 	struct ethtool_rx_flow_spec *fsp;
 	struct i40e_fdir_filter *input;
+	u16 dest_vsi = 0, q_index = 0;
 	struct i40e_pf *pf;
 	int ret = -EINVAL;
-	u16 vf_id;
+	u8 dest_ctl;
 
 	if (!vsi)
 		return -EINVAL;
@@ -3036,9 +3042,32 @@ static int i40e_add_fdir_ethtool(struct i40e_vsi *vsi,
 		return -EINVAL;
 	}
 
-	if ((fsp->ring_cookie != RX_CLS_FLOW_DISC) &&
-	    (fsp->ring_cookie >= vsi->num_queue_pairs))
-		return -EINVAL;
+	/* ring_cookie is either the drop index, or is a mask of the queue
+	 * index and VF id we wish to target.
+	 */
+	if (fsp->ring_cookie == RX_CLS_FLOW_DISC) {
+		dest_ctl = I40E_FILTER_PROGRAM_DESC_DEST_DROP_PACKET;
+	} else {
+		u32 ring = ethtool_get_flow_spec_ring(fsp->ring_cookie);
+		u8 vf = ethtool_get_flow_spec_ring_vf(fsp->ring_cookie);
+
+		if (!vf) {
+			if (ring >= vsi->num_queue_pairs)
+				return -EINVAL;
+			dest_vsi = vsi->id;
+		} else {
+			/* VFs are zero-indexed, so we subtract one here */
+			vf--;
+
+			if (vf >= pf->num_alloc_vfs)
+				return -EINVAL;
+			if (ring >= pf->vf[vf].num_queue_pairs)
+				return -EINVAL;
+			dest_vsi = pf->vf[vf].lan_vsi_id;
+		}
+		dest_ctl = I40E_FILTER_PROGRAM_DESC_DEST_DIRECT_PACKET_QINDEX;
+		q_index = ring;
+	}
 
 	input = kzalloc(sizeof(*input), GFP_KERNEL);
 
@@ -3046,19 +3075,13 @@ static int i40e_add_fdir_ethtool(struct i40e_vsi *vsi,
 		return -ENOMEM;
 
 	input->fd_id = fsp->location;
-
-	if (fsp->ring_cookie == RX_CLS_FLOW_DISC)
-		input->dest_ctl = I40E_FILTER_PROGRAM_DESC_DEST_DROP_PACKET;
-	else
-		input->dest_ctl =
-			     I40E_FILTER_PROGRAM_DESC_DEST_DIRECT_PACKET_QINDEX;
-
-	input->q_index = fsp->ring_cookie;
-	input->flex_off = 0;
-	input->pctype = 0;
-	input->dest_vsi = vsi->id;
+	input->q_index = q_index;
+	input->dest_vsi = dest_vsi;
+	input->dest_ctl = dest_ctl;
 	input->fd_status = I40E_FILTER_PROGRAM_DESC_FD_STATUS_FD_ID;
 	input->cnt_index  = I40E_FD_SB_STAT_IDX(pf->hw.pf_id);
+	input->dst_ip = fsp->h_u.tcp_ip4_spec.ip4src;
+	input->src_ip = fsp->h_u.tcp_ip4_spec.ip4dst;
 	input->flow_type = fsp->flow_type;
 	input->ip4_proto = fsp->h_u.usr_ip4_spec.proto;
 
@@ -3070,23 +3093,6 @@ static int i40e_add_fdir_ethtool(struct i40e_vsi *vsi,
 	input->dst_ip = fsp->h_u.tcp_ip4_spec.ip4src;
 	input->src_ip = fsp->h_u.tcp_ip4_spec.ip4dst;
 
-	if (ntohl(fsp->m_ext.data[1])) {
-		vf_id = ntohl(fsp->h_ext.data[1]);
-		if (vf_id >= pf->num_alloc_vfs) {
-			netif_info(pf, drv, vsi->netdev,
-				   "Invalid VF id %d\n", vf_id);
-			goto free_input;
-		}
-		/* Find vsi id from vf id and override dest vsi */
-		input->dest_vsi = pf->vf[vf_id].lan_vsi_id;
-		if (input->q_index >= pf->vf[vf_id].num_queue_pairs) {
-			netif_info(pf, drv, vsi->netdev,
-				   "Invalid queue id %d for VF %d\n",
-				   input->q_index, vf_id);
-			goto free_input;
-		}
-	}
-
 	ret = i40e_add_del_fdir(vsi, input, true);
 	if (ret)
 		goto free_input;
-- 
2.12.0.rc0.151.g8a5726c42288

