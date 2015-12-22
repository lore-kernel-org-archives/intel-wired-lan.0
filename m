From: Deepthi Kavalur <deepthi.kavalur@intel.com>
Date: Tue, 22 Dec 2015 14:25:05 -0800
Subject: [Intel-wired-lan] [next PATCH S24 03/12] i40e/i40evf: Fix for
	UDP/TCP RSS for X722
In-Reply-To: <1450823114-29514-1-git-send-email-deepthi.kavalur@intel.com>
References: <1450823114-29514-1-git-send-email-deepthi.kavalur@intel.com>
Message-ID: <1450823114-29514-4-git-send-email-deepthi.kavalur@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Anjali Singhai Jain <anjali.singhai@intel.com>

The PCTYPES for the X710 and X722 families are different. This patch
makes adjustments for that.

Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c     | 18 ++++++++++++++
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  6 +++++
 drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c | 29 +++++++++++++++++++---
 drivers/net/ethernet/intel/i40evf/i40evf_main.c    |  8 +++---
 4 files changed, 54 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 80c3f20..29eb718 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -2169,6 +2169,10 @@ static int i40e_set_rss_hash_opt(struct i40e_pf *pf, struct ethtool_rxnfc *nfc)
 		case 0:
 			return -EINVAL;
 		case (RXH_L4_B_0_1 | RXH_L4_B_2_3):
+			if (pf->flags & I40E_FLAG_MULTIPLE_TCP_UDP_RSS_PCTYPE)
+				hena |=
+			   BIT_ULL(I40E_FILTER_PCTYPE_NONF_IPV4_TCP_SYN_NO_ACK);
+
 			hena |= BIT_ULL(I40E_FILTER_PCTYPE_NONF_IPV4_TCP);
 			break;
 		default:
@@ -2180,6 +2184,10 @@ static int i40e_set_rss_hash_opt(struct i40e_pf *pf, struct ethtool_rxnfc *nfc)
 		case 0:
 			return -EINVAL;
 		case (RXH_L4_B_0_1 | RXH_L4_B_2_3):
+			if (pf->flags & I40E_FLAG_MULTIPLE_TCP_UDP_RSS_PCTYPE)
+				hena |=
+			   BIT_ULL(I40E_FILTER_PCTYPE_NONF_IPV6_TCP_SYN_NO_ACK);
+
 			hena |= BIT_ULL(I40E_FILTER_PCTYPE_NONF_IPV6_TCP);
 			break;
 		default:
@@ -2191,6 +2199,11 @@ static int i40e_set_rss_hash_opt(struct i40e_pf *pf, struct ethtool_rxnfc *nfc)
 		case 0:
 			return -EINVAL;
 		case (RXH_L4_B_0_1 | RXH_L4_B_2_3):
+			if (pf->flags & I40E_FLAG_MULTIPLE_TCP_UDP_RSS_PCTYPE)
+				hena |=
+			    BIT_ULL(I40E_FILTER_PCTYPE_NONF_UNICAST_IPV4_UDP) |
+			    BIT_ULL(I40E_FILTER_PCTYPE_NONF_MULTICAST_IPV4_UDP);
+
 			hena |= (BIT_ULL(I40E_FILTER_PCTYPE_NONF_IPV4_UDP) |
 				 BIT_ULL(I40E_FILTER_PCTYPE_FRAG_IPV4));
 			break;
@@ -2203,6 +2216,11 @@ static int i40e_set_rss_hash_opt(struct i40e_pf *pf, struct ethtool_rxnfc *nfc)
 		case 0:
 			return -EINVAL;
 		case (RXH_L4_B_0_1 | RXH_L4_B_2_3):
+			if (pf->flags & I40E_FLAG_MULTIPLE_TCP_UDP_RSS_PCTYPE)
+				hena |=
+			    BIT_ULL(I40E_FILTER_PCTYPE_NONF_UNICAST_IPV6_UDP) |
+			    BIT_ULL(I40E_FILTER_PCTYPE_NONF_MULTICAST_IPV6_UDP);
+
 			hena |= (BIT_ULL(I40E_FILTER_PCTYPE_NONF_IPV6_UDP) |
 				 BIT_ULL(I40E_FILTER_PCTYPE_FRAG_IPV6));
 			break;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index aa58a49..3cc98b0 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -1213,6 +1213,12 @@ static int i40e_vc_get_vf_resources_msg(struct i40e_vf *vf, u8 *msg)
 		vfres->vf_offload_flags |= I40E_VIRTCHNL_VF_OFFLOAD_RSS_REG;
 	}
 
+	if (pf->flags & I40E_FLAG_MULTIPLE_TCP_UDP_RSS_PCTYPE) {
+		if (vf->driver_caps & I40E_VIRTCHNL_VF_OFFLOAD_RSS_PCTYPE_V2)
+			vfres->vf_offload_flags |=
+				I40E_VIRTCHNL_VF_OFFLOAD_RSS_PCTYPE_V2;
+	}
+
 	if (vf->driver_caps & I40E_VIRTCHNL_VF_OFFLOAD_RX_POLLING)
 		vfres->vf_offload_flags |= I40E_VIRTCHNL_VF_OFFLOAD_RX_POLLING;
 
diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c b/drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c
index 8906785..bd1c272 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c
@@ -459,6 +459,7 @@ static int i40evf_set_rss_hash_opt(struct i40evf_adapter *adapter,
 				   struct ethtool_rxnfc *nfc)
 {
 	struct i40e_hw *hw = &adapter->hw;
+	u32 flags = adapter->vf_res->vf_offload_flags;
 
 	u64 hena = (u64)rd32(hw, I40E_VFQF_HENA(0)) |
 		   ((u64)rd32(hw, I40E_VFQF_HENA(1)) << 32);
@@ -477,19 +478,34 @@ static int i40evf_set_rss_hash_opt(struct i40evf_adapter *adapter,
 
 	switch (nfc->flow_type) {
 	case TCP_V4_FLOW:
-		if (nfc->data & (RXH_L4_B_0_1 | RXH_L4_B_2_3))
+		if (nfc->data & (RXH_L4_B_0_1 | RXH_L4_B_2_3)) {
+			if (flags & I40E_VIRTCHNL_VF_OFFLOAD_RSS_PCTYPE_V2)
+				hena |=
+			   BIT_ULL(I40E_FILTER_PCTYPE_NONF_IPV4_TCP_SYN_NO_ACK);
+
 			hena |= BIT_ULL(I40E_FILTER_PCTYPE_NONF_IPV4_TCP);
-		else
+		} else {
 			return -EINVAL;
+		}
 		break;
 	case TCP_V6_FLOW:
-		if (nfc->data & (RXH_L4_B_0_1 | RXH_L4_B_2_3))
+		if (nfc->data & (RXH_L4_B_0_1 | RXH_L4_B_2_3)) {
+			if (flags & I40E_VIRTCHNL_VF_OFFLOAD_RSS_PCTYPE_V2)
+				hena |=
+			   BIT_ULL(I40E_FILTER_PCTYPE_NONF_IPV6_TCP_SYN_NO_ACK);
+
 			hena |= BIT_ULL(I40E_FILTER_PCTYPE_NONF_IPV6_TCP);
-		else
+		} else {
 			return -EINVAL;
+		}
 		break;
 	case UDP_V4_FLOW:
 		if (nfc->data & (RXH_L4_B_0_1 | RXH_L4_B_2_3)) {
+			if (flags & I40E_VIRTCHNL_VF_OFFLOAD_RSS_PCTYPE_V2)
+				hena |=
+			    BIT_ULL(I40E_FILTER_PCTYPE_NONF_UNICAST_IPV4_UDP) |
+			    BIT_ULL(I40E_FILTER_PCTYPE_NONF_MULTICAST_IPV4_UDP);
+
 			hena |= (BIT_ULL(I40E_FILTER_PCTYPE_NONF_IPV4_UDP) |
 				 BIT_ULL(I40E_FILTER_PCTYPE_FRAG_IPV4));
 		} else {
@@ -498,6 +514,11 @@ static int i40evf_set_rss_hash_opt(struct i40evf_adapter *adapter,
 		break;
 	case UDP_V6_FLOW:
 		if (nfc->data & (RXH_L4_B_0_1 | RXH_L4_B_2_3)) {
+			if (flags & I40E_VIRTCHNL_VF_OFFLOAD_RSS_PCTYPE_V2)
+				hena |=
+			    BIT_ULL(I40E_FILTER_PCTYPE_NONF_UNICAST_IPV6_UDP) |
+			    BIT_ULL(I40E_FILTER_PCTYPE_NONF_MULTICAST_IPV6_UDP);
+
 			hena |= (BIT_ULL(I40E_FILTER_PCTYPE_NONF_IPV6_UDP) |
 				 BIT_ULL(I40E_FILTER_PCTYPE_FRAG_IPV6));
 		} else {
diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index 2817b54..7bdb9f9 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -1456,7 +1456,11 @@ static int i40evf_init_rss(struct i40evf_adapter *adapter)
 	int ret;
 
 	/* Enable PCTYPES for RSS, TCP/UDP with IPv4/IPv6 */
-	hena = I40E_DEFAULT_RSS_HENA;
+	if (adapter->vf_res->vf_offload_flags &
+					I40E_VIRTCHNL_VF_OFFLOAD_RSS_PCTYPE_V2)
+		hena = I40E_DEFAULT_RSS_HENA_EXPANDED;
+	else
+		hena = I40E_DEFAULT_RSS_HENA;
 	wr32(hw, I40E_VFQF_HENA(0), (u32)hena);
 	wr32(hw, I40E_VFQF_HENA(1), (u32)(hena >> 32));
 
@@ -2507,8 +2511,6 @@ static void i40evf_init_task(struct work_struct *work)
 	if (adapter->vf_res->vf_offload_flags &
 		    I40E_VIRTCHNL_VF_OFFLOAD_WB_ON_ITR)
 		adapter->flags |= I40EVF_FLAG_WB_ON_ITR_CAPABLE;
-	if (!RSS_AQ(adapter))
-		i40evf_init_rss(adapter);
 	err = i40evf_request_misc_irq(adapter);
 	if (err)
 		goto err_sw_init;
-- 
2.1.0

