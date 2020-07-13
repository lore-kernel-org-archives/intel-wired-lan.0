From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Mon, 13 Jul 2020 13:53:09 -0700
Subject: [Intel-wired-lan] [PATCH S50 06/15] ice: fix overwriting TX/RX
 descriptor values when rebuilding VSI
In-Reply-To: <20200713205318.32425-1-anthony.l.nguyen@intel.com>
References: <20200713205318.32425-1-anthony.l.nguyen@intel.com>
Message-ID: <20200713205318.32425-6-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>

If a user sets the value of the TX or RX descriptors to some non-default
value using 'ethtool -G' then we need to not overwrite the values when
we rebuild the VSI. The VSI rebuild could happen as a result of a user
setting the number of queues via the 'ethtool -L' command. Fix this by
checking to see if the value we have stored is non-zero and if it is
then don't change the value.

Signed-off-by: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 01d742400f7f..aa77bedb61e4 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -127,8 +127,14 @@ static void ice_vsi_set_num_desc(struct ice_vsi *vsi)
 	case ICE_VSI_PF:
 	case ICE_VSI_CTRL:
 	case ICE_VSI_LB:
-		vsi->num_rx_desc = ICE_DFLT_NUM_RX_DESC;
-		vsi->num_tx_desc = ICE_DFLT_NUM_TX_DESC;
+		/* a user could change the values of num_[tr]x_desc using
+		 * ethtool -G so we should keep those values instead of
+		 * overwriting them with the defaults.
+		 */
+		if (!vsi->num_rx_desc)
+			vsi->num_rx_desc = ICE_DFLT_NUM_RX_DESC;
+		if (!vsi->num_tx_desc)
+			vsi->num_tx_desc = ICE_DFLT_NUM_TX_DESC;
 		break;
 	default:
 		dev_dbg(ice_pf_to_dev(vsi->back), "Not setting number of Tx/Rx descriptors for VSI type %d\n",
-- 
2.20.1

