From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Tue, 16 Apr 2019 10:30:50 -0700
Subject: [Intel-wired-lan] [PATCH S20 13/15] ice: Configure RSS LUT key only
 if RSS is enabled
In-Reply-To: <20190416173052.28928-1-anirudh.venkataramanan@intel.com>
References: <20190416173052.28928-1-anirudh.venkataramanan@intel.com>
Message-ID: <20190416173052.28928-14-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Md Fahad Iqbal Polash <md.fahad.iqbal.polash@intel.com>

Call ice_vsi_cfg_rss_lut_key only if RSS is enabled.

Signed-off-by: Md Fahad Iqbal Polash <md.fahad.iqbal.polash@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 515b154547c5..74008d748f3a 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -2400,6 +2400,13 @@ ice_vsi_setup(struct ice_pf *pf, struct ice_port_info *pi,
 
 		pf->q_left_tx -= vsi->alloc_txq;
 		pf->q_left_rx -= vsi->alloc_rxq;
+
+		/* Do not exit if configuring RSS had an issue, at least
+		 * receive traffic on first queue. Hence no need to capture
+		 * return value
+		 */
+		if (test_bit(ICE_FLAG_RSS_ENA, pf->flags))
+			ice_vsi_cfg_rss_lut_key(vsi);
 		break;
 	case ICE_VSI_LB:
 		ret = ice_vsi_alloc_rings(vsi);
-- 
2.20.1

