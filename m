From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Date: Mon,  3 Jan 2022 07:41:21 +0100
Subject: [Intel-wired-lan] [PATCH net] ice: fix setting l4 port flag when
 adding filter
Message-ID: <20220103064121.2366-1-michal.swiatkowski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Accidentally filter flag for none encapsulated l4 port filed is always
set. Even if user wants to add encapsulated l4 port field.

Remove this unnecessary flag setting.

Fixes: 9e300987d4a81 ("ice: VXLAN and Geneve TC support")
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice_tc_lib.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_tc_lib.c b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
index e8aab664270a..65cf32eb4046 100644
--- a/drivers/net/ethernet/intel/ice/ice_tc_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
@@ -709,7 +709,7 @@ ice_tc_set_port(struct flow_match_ports match,
 			fltr->flags |= ICE_TC_FLWR_FIELD_ENC_DEST_L4_PORT;
 		else
 			fltr->flags |= ICE_TC_FLWR_FIELD_DEST_L4_PORT;
-		fltr->flags |= ICE_TC_FLWR_FIELD_DEST_L4_PORT;
+
 		headers->l4_key.dst_port = match.key->dst;
 		headers->l4_mask.dst_port = match.mask->dst;
 	}
@@ -718,7 +718,7 @@ ice_tc_set_port(struct flow_match_ports match,
 			fltr->flags |= ICE_TC_FLWR_FIELD_ENC_SRC_L4_PORT;
 		else
 			fltr->flags |= ICE_TC_FLWR_FIELD_SRC_L4_PORT;
-		fltr->flags |= ICE_TC_FLWR_FIELD_SRC_L4_PORT;
+
 		headers->l4_key.src_port = match.key->src;
 		headers->l4_mask.src_port = match.mask->src;
 	}
-- 
2.31.1

