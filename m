From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Wed, 17 Nov 2021 15:55:05 -0800
Subject: [Intel-wired-lan] [PATCH v2 net-next] ice: Remove unused
 ICE_FLOW_SEG_HDRS_L2_MASK
Message-ID: <20211117235505.70783-1-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Remove the unused define ICE_FLOW_SEG_HDRS_L2_MASK.

Reported-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
v2: Reword title and description to be imperative

 drivers/net/ethernet/intel/ice/ice_flow.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_flow.c b/drivers/net/ethernet/intel/ice/ice_flow.c
index 2bfe9d9d7edc..ef10f0941231 100644
--- a/drivers/net/ethernet/intel/ice/ice_flow.c
+++ b/drivers/net/ethernet/intel/ice/ice_flow.c
@@ -609,8 +609,6 @@ struct ice_flow_prof_params {
 	ICE_FLOW_SEG_HDR_ESP | ICE_FLOW_SEG_HDR_AH | \
 	ICE_FLOW_SEG_HDR_NAT_T_ESP)
 
-#define ICE_FLOW_SEG_HDRS_L2_MASK	\
-	(ICE_FLOW_SEG_HDR_ETH | ICE_FLOW_SEG_HDR_VLAN)
 #define ICE_FLOW_SEG_HDRS_L3_MASK	\
 	(ICE_FLOW_SEG_HDR_IPV4 | ICE_FLOW_SEG_HDR_IPV6 | ICE_FLOW_SEG_HDR_ARP)
 #define ICE_FLOW_SEG_HDRS_L4_MASK	\
-- 
2.20.1

