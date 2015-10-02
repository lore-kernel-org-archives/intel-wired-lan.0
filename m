From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Fri, 02 Oct 2015 06:12:34 -0000
Subject: [Intel-wired-lan] [next PATCH v2 1/2] i40evf: fix overlong BIT
	defines
In-Reply-To: <1442455270-6681-1-git-send-email-jesse.brandeburg@intel.com>
References: <1442455270-6681-1-git-send-email-jesse.brandeburg@intel.com>
Message-ID: <1442455270-6681-2-git-send-email-jesse.brandeburg@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The defines from the RSS enabling call were mistakenly
missed in the patches to the i40e which should have been
to i40evf as well.

this is a follow up to (commit ed921559886dd40528) "fix
32 bit build warnings".

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
 drivers/net/ethernet/intel/i40evf/i40e_common.c |  5 -----
 drivers/net/ethernet/intel/i40evf/i40e_txrx.h   | 14 +++++++-------
 2 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40evf/i40e_common.c b/drivers/net/ethernet/intel/i40evf/i40e_common.c
index b98b642..a98a31f 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_common.c
@@ -443,9 +443,6 @@ static i40e_status i40e_aq_get_set_rss_lut(struct i40e_hw *hw,
 					I40E_AQC_SET_RSS_LUT_TABLE_TYPE_SHIFT) &
 					I40E_AQC_SET_RSS_LUT_TABLE_TYPE_MASK));
 
-	cmd_resp->addr_high = cpu_to_le32(high_16_bits((u64)lut));
-	cmd_resp->addr_low = cpu_to_le32(lower_32_bits((u64)lut));
-
 	status = i40evf_asq_send_command(hw, &desc, lut, lut_size, NULL);
 
 	return status;
@@ -520,8 +517,6 @@ static i40e_status i40e_aq_get_set_rss_key(struct i40e_hw *hw,
 					  I40E_AQC_SET_RSS_KEY_VSI_ID_SHIFT) &
 					  I40E_AQC_SET_RSS_KEY_VSI_ID_MASK));
 	cmd_resp->vsi_id |= cpu_to_le16((u16)I40E_AQC_SET_RSS_KEY_VSI_VALID);
-	cmd_resp->addr_high = cpu_to_le32(high_16_bits((u64)key));
-	cmd_resp->addr_low = cpu_to_le32(lower_32_bits((u64)key));
 
 	status = i40evf_asq_send_command(hw, &desc, key, key_size, NULL);
 
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_txrx.h b/drivers/net/ethernet/intel/i40evf/i40e_txrx.h
index 26fc85f..e8185c0 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.h
+++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.h
@@ -79,16 +79,16 @@ enum i40e_dyn_idx_t {
 	BIT_ULL(I40E_FILTER_PCTYPE_L2_PAYLOAD))
 
 #define I40E_DEFAULT_RSS_HENA_EXPANDED (I40E_DEFAULT_RSS_HENA | \
-		BIT(I40E_FILTER_PCTYPE_NONF_IPV4_TCP_SYN_NO_ACK) | \
-		BIT(I40E_FILTER_PCTYPE_NONF_UNICAST_IPV4_UDP) | \
-		BIT(I40E_FILTER_PCTYPE_NONF_MULTICAST_IPV4_UDP) | \
-		BIT(I40E_FILTER_PCTYPE_NONF_IPV6_TCP_SYN_NO_ACK) | \
-		BIT(I40E_FILTER_PCTYPE_NONF_UNICAST_IPV6_UDP) | \
-		BIT(I40E_FILTER_PCTYPE_NONF_MULTICAST_IPV6_UDP))
+	BIT_ULL(I40E_FILTER_PCTYPE_NONF_IPV4_TCP_SYN_NO_ACK) | \
+	BIT_ULL(I40E_FILTER_PCTYPE_NONF_UNICAST_IPV4_UDP) | \
+	BIT_ULL(I40E_FILTER_PCTYPE_NONF_MULTICAST_IPV4_UDP) | \
+	BIT_ULL(I40E_FILTER_PCTYPE_NONF_IPV6_TCP_SYN_NO_ACK) | \
+	BIT_ULL(I40E_FILTER_PCTYPE_NONF_UNICAST_IPV6_UDP) | \
+	BIT_ULL(I40E_FILTER_PCTYPE_NONF_MULTICAST_IPV6_UDP))
 
 #define i40e_pf_get_default_rss_hena(pf) \
 	(((pf)->flags & I40E_FLAG_MULTIPLE_TCP_UDP_RSS_PCTYPE) ? \
-		I40E_DEFAULT_RSS_HENA_EXPANDED : I40E_DEFAULT_RSS_HENA)
+	  I40E_DEFAULT_RSS_HENA_EXPANDED : I40E_DEFAULT_RSS_HENA)
 
 /* Supported Rx Buffer Sizes */
 #define I40E_RXBUFFER_512   512    /* Used for packet split */
-- 
2.1.0


