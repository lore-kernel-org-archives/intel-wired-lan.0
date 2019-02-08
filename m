From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Fri,  8 Feb 2019 12:50:29 -0800
Subject: [Intel-wired-lan] [PATCH S11 02/16] ice: Fix the calculation of
 ICE_MAX_MTU
In-Reply-To: <20190208205043.11975-1-anirudh.venkataramanan@intel.com>
References: <20190208205043.11975-1-anirudh.venkataramanan@intel.com>
Message-ID: <20190208205043.11975-3-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Currently ICE_MAX_MTU subtracts only ETH_HLEN from max frame size and
adds ETH_FCS_LEN and VLAN_HLEN, which is not what was intended.
The ETH_HLEN + ETH_FCS_LEN + VLAN_HLEN expression should be surrounded
with parentheses.

Wrap mentioned expression and take into account VLAN double tagging.

Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 55944e089558..89440775aea1 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -83,7 +83,7 @@ extern const char ice_drv_ver[];
 #define ICE_DFLT_NETIF_M (NETIF_MSG_DRV | NETIF_MSG_PROBE | NETIF_MSG_LINK)
 
 #define ICE_MAX_MTU	(ICE_AQ_SET_MAC_FRAME_SIZE_MAX - \
-			 ETH_HLEN + ETH_FCS_LEN + VLAN_HLEN)
+			(ETH_HLEN + ETH_FCS_LEN + (VLAN_HLEN * 2)))
 
 #define ICE_UP_TABLE_TRANSLATE(val, i) \
 		(((val) << ICE_AQ_VSI_UP_TABLE_UP##i##_S) & \
-- 
2.14.5

