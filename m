From: Kiran Patil <kiran.patil@intel.com>
Date: Tue, 26 Jul 2016 22:49:23 -0700
Subject: [Intel-wired-lan] [PATCH V0] i40e: Program device correctly as part
	of adding flow director entry
Message-ID: <1469598563-42383-1-git-send-email-kiran.patil@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch fixes the problem where driver was not programming
underlying device correctly when user specifies less than full tuple
set as part of adding flow director entry (for flow-type tcp4/udp4)
using ethtool.

Signed-off-by: Kiran Patil <kiran.patil@intel.com>
Change-Id: I90052508f8c172c0da5a4b78b949704b4a59ea78
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 116 +++++++++++++++++++++++++
 1 file changed, 116 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index c912e04..e7613b2 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -2563,6 +2563,116 @@ static int i40e_del_fdir_entry(struct i40e_vsi *vsi,
 }
 
 /**
+ * i40e_handle_input_set - Detect and handle input set changes
+ * @vsi: pointer to the targeted VSI
+ * @fsp: pointer to RX flow classification spec
+ *
+ * Reads register, detect change in input set based on existing register
+ * value and what user has passed. Update input set mask register if needed.
+ **/
+static int i40e_handle_input_set(struct i40e_vsi *vsi,
+				 struct ethtool_rx_flow_spec *fsp)
+{
+	bool inset_mask_change = false;
+	struct i40e_pf *pf;
+	u64 val;
+	u8 idx;
+
+	if (unlikely(!vsi))
+		return -EINVAL;
+
+	pf = vsi->back;
+	switch (fsp->flow_type & ~FLOW_EXT) {
+	case TCP_V4_FLOW:
+		idx = I40E_FILTER_PCTYPE_NONF_IPV4_TCP;
+		break;
+	case UDP_V4_FLOW:
+		idx = I40E_FILTER_PCTYPE_NONF_IPV4_UDP;
+		break;
+	default:
+		/* for all other flow types */
+		return 0;
+	}
+
+	val = ((u64)i40e_read_rx_ctl(&pf->hw,
+				     I40E_PRTQF_FD_INSET(idx, 1)) << 32) |
+	       (u64)i40e_read_rx_ctl(&pf->hw,
+				     I40E_PRTQF_FD_INSET(idx, 0));
+
+	/* Default input set (TCP/UDP/SCTP) contains following
+	 * fields: srcip + dest ip + src port + dest port
+	 * For SCTP, there is one extra field, "verification tag"
+	 */
+	if (val & I40E_L3_SRC_MASK) {
+		if (!fsp->h_u.tcp_ip4_spec.ip4src) {
+			val &= ~I40E_L3_SRC_MASK;
+			inset_mask_change = true;
+		}
+	} else {
+		if (fsp->h_u.tcp_ip4_spec.ip4src) {
+			val |= I40E_L3_SRC_MASK;
+			inset_mask_change = true;
+		}
+	}
+	if (val & I40E_L3_DST_MASK) {
+		if (!fsp->h_u.tcp_ip4_spec.ip4dst) {
+			val &= ~I40E_L3_DST_MASK;
+			inset_mask_change = true;
+		}
+	} else {
+		if (fsp->h_u.tcp_ip4_spec.ip4dst) {
+			val |= I40E_L3_DST_MASK;
+			inset_mask_change = true;
+		}
+	}
+	if (val & I40E_L4_SRC_MASK) {
+		if (!fsp->h_u.tcp_ip4_spec.psrc) {
+			val &= ~I40E_L4_SRC_MASK;
+			inset_mask_change = true;
+		}
+	} else {
+		if (fsp->h_u.tcp_ip4_spec.psrc) {
+			val |= I40E_L4_SRC_MASK;
+			inset_mask_change = true;
+		}
+	}
+	if (val & I40E_L4_DST_MASK) {
+		if (!fsp->h_u.tcp_ip4_spec.pdst) {
+			val &= ~I40E_L4_DST_MASK;
+			inset_mask_change = true;
+		}
+	} else {
+		if (fsp->h_u.tcp_ip4_spec.pdst) {
+			val |= I40E_L4_DST_MASK;
+			inset_mask_change = true;
+		}
+	}
+
+	if (inset_mask_change) {
+		if (pf->flags & I40E_FLAG_MFP_ENABLED) {
+			netif_err(pf, drv, vsi->netdev, "Change of input set is not supported when MFP mode is enabled\n");
+			return -EOPNOTSUPP;
+		}
+		if (pf->fdir_pf_active_filters) {
+			netif_err(pf, drv, vsi->netdev, "Change of input set is not supported when there are existing filters. Please delete them and re-try\n");
+			return -EOPNOTSUPP;
+		}
+
+		if (I40E_DEBUG_FD & pf->hw.debug_mask)
+			netif_info(pf, drv, vsi->netdev, "FD_INSET mask is changing to 0x%016llx\n",
+				   val);
+		/* Update input mask register since input set mask changed */
+		i40e_write_rx_ctl(&pf->hw, I40E_PRTQF_FD_INSET(idx, 1),
+				  (u32)(val >> 32));
+		i40e_write_rx_ctl(&pf->hw, I40E_PRTQF_FD_INSET(idx, 0),
+				  (u32)val);
+		netif_info(pf, drv, vsi->netdev, "Input set mask change has been successful. Please note that this and all other interfaces on (related and derived from) this part are affected as well.\n");
+	}
+
+	return 0;
+}
+
+/**
  * i40e_add_fdir_ethtool - Add/Remove Flow Director filters
  * @vsi: pointer to the targeted VSI
  * @cmd: command to get or set RX flow classification rules
@@ -2637,6 +2747,12 @@ static int i40e_add_fdir_ethtool(struct i40e_vsi *vsi,
 	input->dst_ip[0] = fsp->h_u.tcp_ip4_spec.ip4src;
 	input->src_ip[0] = fsp->h_u.tcp_ip4_spec.ip4dst;
 
+	ret = i40e_handle_input_set(vsi, fsp);
+	if (ret) {
+		netif_err(pf, drv, vsi->netdev, "Unable to handle change in input set mask\n");
+		goto free_input;
+	}
+
 	if (ntohl(fsp->m_ext.data[1])) {
 		vf_id = ntohl(fsp->h_ext.data[1]);
 		if (vf_id >= pf->num_alloc_vfs) {
-- 
1.8.3.1

