From: Joshua Hay <joshua.a.hay@intel.com>
Date: Wed,  9 Dec 2015 15:50:24 -0800
Subject: [Intel-wired-lan] [next PATCH S23 04/13] i40e/i40evf: Fix RSS
	rx-flow-hash configuration through ethtool
In-Reply-To: <1449705033-4968-1-git-send-email-joshua.a.hay@intel.com>
References: <1449705033-4968-1-git-send-email-joshua.a.hay@intel.com>
Message-ID: <1449705033-4968-5-git-send-email-joshua.a.hay@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Anjali Singhai Jain <anjali.singhai@intel.com>

This patch fixes the Hash PCTYPE enable for X722 since it supports
a broader selection of PCTYPES for TCP and UDP.

This patch also fixes a bug in XL710, X710, X722 support for RSS,
as of now we cannot reduce the (4)tuple for RSS for TCP/IPv4/IPV6 or
UDP/IPv4/IPv6 packets since this requires a product feature change
that comes in a later release.

A VF should never be allowed to change the tuples for RSS for any
PCTYPE since that's a global setting for the device in case of i40e
devices.

Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
Change-ID: I0ee7203c9b24813260f58f3220798bc9d9ac4a12
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c     | 14 +++-----
 drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c | 40 +++++-----------------
 2 files changed, 12 insertions(+), 42 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 29d5833..c8b9dca 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -2166,8 +2166,7 @@ static int i40e_set_rss_hash_opt(struct i40e_pf *pf, struct ethtool_rxnfc *nfc)
 	case TCP_V4_FLOW:
 		switch (nfc->data & (RXH_L4_B_0_1 | RXH_L4_B_2_3)) {
 		case 0:
-			hena &= ~BIT_ULL(I40E_FILTER_PCTYPE_NONF_IPV4_TCP);
-			break;
+			return -EINVAL;
 		case (RXH_L4_B_0_1 | RXH_L4_B_2_3):
 			hena |= BIT_ULL(I40E_FILTER_PCTYPE_NONF_IPV4_TCP);
 			break;
@@ -2178,8 +2177,7 @@ static int i40e_set_rss_hash_opt(struct i40e_pf *pf, struct ethtool_rxnfc *nfc)
 	case TCP_V6_FLOW:
 		switch (nfc->data & (RXH_L4_B_0_1 | RXH_L4_B_2_3)) {
 		case 0:
-			hena &= ~BIT_ULL(I40E_FILTER_PCTYPE_NONF_IPV6_TCP);
-			break;
+			return -EINVAL;
 		case (RXH_L4_B_0_1 | RXH_L4_B_2_3):
 			hena |= BIT_ULL(I40E_FILTER_PCTYPE_NONF_IPV6_TCP);
 			break;
@@ -2190,9 +2188,7 @@ static int i40e_set_rss_hash_opt(struct i40e_pf *pf, struct ethtool_rxnfc *nfc)
 	case UDP_V4_FLOW:
 		switch (nfc->data & (RXH_L4_B_0_1 | RXH_L4_B_2_3)) {
 		case 0:
-			hena &= ~(BIT_ULL(I40E_FILTER_PCTYPE_NONF_IPV4_UDP) |
-				  BIT_ULL(I40E_FILTER_PCTYPE_FRAG_IPV4));
-			break;
+			return -EINVAL;
 		case (RXH_L4_B_0_1 | RXH_L4_B_2_3):
 			hena |= (BIT_ULL(I40E_FILTER_PCTYPE_NONF_IPV4_UDP) |
 				 BIT_ULL(I40E_FILTER_PCTYPE_FRAG_IPV4));
@@ -2204,9 +2200,7 @@ static int i40e_set_rss_hash_opt(struct i40e_pf *pf, struct ethtool_rxnfc *nfc)
 	case UDP_V6_FLOW:
 		switch (nfc->data & (RXH_L4_B_0_1 | RXH_L4_B_2_3)) {
 		case 0:
-			hena &= ~(BIT_ULL(I40E_FILTER_PCTYPE_NONF_IPV6_UDP) |
-				  BIT_ULL(I40E_FILTER_PCTYPE_FRAG_IPV6));
-			break;
+			return -EINVAL;
 		case (RXH_L4_B_0_1 | RXH_L4_B_2_3):
 			hena |= (BIT_ULL(I40E_FILTER_PCTYPE_NONF_IPV6_UDP) |
 				 BIT_ULL(I40E_FILTER_PCTYPE_FRAG_IPV6));
diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c b/drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c
index a4c9feb..8906785 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c
@@ -477,54 +477,30 @@ static int i40evf_set_rss_hash_opt(struct i40evf_adapter *adapter,
 
 	switch (nfc->flow_type) {
 	case TCP_V4_FLOW:
-		switch (nfc->data & (RXH_L4_B_0_1 | RXH_L4_B_2_3)) {
-		case 0:
-			hena &= ~BIT_ULL(I40E_FILTER_PCTYPE_NONF_IPV4_TCP);
-			break;
-		case (RXH_L4_B_0_1 | RXH_L4_B_2_3):
+		if (nfc->data & (RXH_L4_B_0_1 | RXH_L4_B_2_3))
 			hena |= BIT_ULL(I40E_FILTER_PCTYPE_NONF_IPV4_TCP);
-			break;
-		default:
+		else
 			return -EINVAL;
-		}
 		break;
 	case TCP_V6_FLOW:
-		switch (nfc->data & (RXH_L4_B_0_1 | RXH_L4_B_2_3)) {
-		case 0:
-			hena &= ~BIT_ULL(I40E_FILTER_PCTYPE_NONF_IPV6_TCP);
-			break;
-		case (RXH_L4_B_0_1 | RXH_L4_B_2_3):
+		if (nfc->data & (RXH_L4_B_0_1 | RXH_L4_B_2_3))
 			hena |= BIT_ULL(I40E_FILTER_PCTYPE_NONF_IPV6_TCP);
-			break;
-		default:
+		else
 			return -EINVAL;
-		}
 		break;
 	case UDP_V4_FLOW:
-		switch (nfc->data & (RXH_L4_B_0_1 | RXH_L4_B_2_3)) {
-		case 0:
-			hena &= ~(BIT_ULL(I40E_FILTER_PCTYPE_NONF_IPV4_UDP) |
-				  BIT_ULL(I40E_FILTER_PCTYPE_FRAG_IPV4));
-			break;
-		case (RXH_L4_B_0_1 | RXH_L4_B_2_3):
+		if (nfc->data & (RXH_L4_B_0_1 | RXH_L4_B_2_3)) {
 			hena |= (BIT_ULL(I40E_FILTER_PCTYPE_NONF_IPV4_UDP) |
 				 BIT_ULL(I40E_FILTER_PCTYPE_FRAG_IPV4));
-			break;
-		default:
+		} else {
 			return -EINVAL;
 		}
 		break;
 	case UDP_V6_FLOW:
-		switch (nfc->data & (RXH_L4_B_0_1 | RXH_L4_B_2_3)) {
-		case 0:
-			hena &= ~(BIT_ULL(I40E_FILTER_PCTYPE_NONF_IPV6_UDP) |
-				  BIT_ULL(I40E_FILTER_PCTYPE_FRAG_IPV6));
-			break;
-		case (RXH_L4_B_0_1 | RXH_L4_B_2_3):
+		if (nfc->data & (RXH_L4_B_0_1 | RXH_L4_B_2_3)) {
 			hena |= (BIT_ULL(I40E_FILTER_PCTYPE_NONF_IPV6_UDP) |
 				 BIT_ULL(I40E_FILTER_PCTYPE_FRAG_IPV6));
-			break;
-		default:
+		} else {
 			return -EINVAL;
 		}
 		break;
-- 
2.1.0

