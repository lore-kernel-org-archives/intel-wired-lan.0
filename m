From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Mon,  4 Nov 2019 01:31:04 -0800
Subject: [Intel-wired-lan] [PATCH S32 v2 11/15] ice: Update enum
 ice_flg64_bits to current specification
In-Reply-To: <20191104093108.21542-1-anthony.l.nguyen@intel.com>
References: <20191104093108.21542-1-anthony.l.nguyen@intel.com>
Message-ID: <20191104093108.21542-11-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Brett Creeley <brett.creeley@intel.com>

Currently the VLAN ice_flg64_bits are off by 1. Fix this by
setting the ICE_FLG_EVLAN_x8100 flag to 14, which also updates
ICE_FLG_EVLAN_x9100 to 15 and ICE_FLG_VLAN_x8100 to 16.

Signed-off-by: Brett Creeley <brett.creeley@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h b/drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h
index 2aac8f13daeb..ad34f22d44ef 100644
--- a/drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h
+++ b/drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h
@@ -211,7 +211,7 @@ enum ice_flex_rx_mdid {
 /* Rx/Tx Flag64 packet flag bits */
 enum ice_flg64_bits {
 	ICE_FLG_PKT_DSI		= 0,
-	ICE_FLG_EVLAN_x8100	= 15,
+	ICE_FLG_EVLAN_x8100	= 14,
 	ICE_FLG_EVLAN_x9100,
 	ICE_FLG_VLAN_x8100,
 	ICE_FLG_TNL_MAC		= 22,
-- 
2.20.1

