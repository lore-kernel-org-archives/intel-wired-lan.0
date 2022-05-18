From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Wed, 18 May 2022 14:27:59 -0700
Subject: [Intel-wired-lan] [PATCH RESEND net-next] ice: use
 eth_broadcast_addr() to set broadcast address
Message-ID: <20220518212759.2444376-1-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Lu Wei <luwei32@huawei.com>

Use eth_broadcast_addr() to set broadcast address instead of memset().

Signed-off-by: Lu Wei <luwei32@huawei.com>
---
Resending due to mail issues with Intel Wired LAN

 drivers/net/ethernet/intel/ice/ice_tc_lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_tc_lib.c b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
index 847b19f5ac0e..9a2050e98cce 100644
--- a/drivers/net/ethernet/intel/ice/ice_tc_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
@@ -1415,7 +1415,7 @@ ice_handle_tclass_action(struct ice_vsi *vsi,
 			   ICE_TC_FLWR_FIELD_ENC_DST_MAC)) {
 		ether_addr_copy(fltr->outer_headers.l2_key.dst_mac,
 				vsi->netdev->dev_addr);
-		memset(fltr->outer_headers.l2_mask.dst_mac, 0xff, ETH_ALEN);
+		eth_broadcast_addr(fltr->outer_headers.l2_mask.dst_mac);
 	}
 
 	/* validate specified dest MAC address, make sure either it belongs to
-- 
2.35.1

