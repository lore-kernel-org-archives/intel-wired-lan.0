From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Tue, 23 Jul 2019 02:27:58 -0700
Subject: [Intel-wired-lan] [PATCH S24 11/12] ice: Don't clear auto_fec bit
 in ice_cfg_phy_fec()
In-Reply-To: <20190723092759.3614-1-anthony.l.nguyen@intel.com>
References: <20190723092759.3614-1-anthony.l.nguyen@intel.com>
Message-ID: <20190723092759.3614-11-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Chinh T Cao <chinh.t.cao@intel.com>

The driver should never clear the auto_fec_enable bit.

Signed-off-by: Chinh T Cao <chinh.t.cao@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 15648d4a8bab..4b43e6de847b 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -2181,27 +2181,24 @@ ice_cfg_phy_fec(struct ice_aqc_set_phy_cfg_data *cfg, enum ice_fec_mode fec)
 {
 	switch (fec) {
 	case ICE_FEC_BASER:
-		/* Clear auto FEC and RS bits, and AND BASE-R ability
+		/* Clear RS bits, and AND BASE-R ability
 		 * bits and OR request bits.
 		 */
-		cfg->caps &= ~ICE_AQC_PHY_EN_AUTO_FEC;
 		cfg->link_fec_opt &= ICE_AQC_PHY_FEC_10G_KR_40G_KR4_EN |
 				     ICE_AQC_PHY_FEC_25G_KR_CLAUSE74_EN;
 		cfg->link_fec_opt |= ICE_AQC_PHY_FEC_10G_KR_40G_KR4_REQ |
 				     ICE_AQC_PHY_FEC_25G_KR_REQ;
 		break;
 	case ICE_FEC_RS:
-		/* Clear auto FEC and BASE-R bits, and AND RS ability
+		/* Clear BASE-R bits, and AND RS ability
 		 * bits and OR request bits.
 		 */
-		cfg->caps &= ~ICE_AQC_PHY_EN_AUTO_FEC;
 		cfg->link_fec_opt &= ICE_AQC_PHY_FEC_25G_RS_CLAUSE91_EN;
 		cfg->link_fec_opt |= ICE_AQC_PHY_FEC_25G_RS_528_REQ |
 				     ICE_AQC_PHY_FEC_25G_RS_544_REQ;
 		break;
 	case ICE_FEC_NONE:
-		/* Clear auto FEC and all FEC option bits. */
-		cfg->caps &= ~ICE_AQC_PHY_EN_AUTO_FEC;
+		/* Clear all FEC option bits. */
 		cfg->link_fec_opt &= ~ICE_AQC_PHY_FEC_MASK;
 		break;
 	case ICE_FEC_AUTO:
-- 
2.20.1

