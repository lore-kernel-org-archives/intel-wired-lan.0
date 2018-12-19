From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Wed, 19 Dec 2018 10:03:22 -0800
Subject: [Intel-wired-lan] [PATCH S10 03/15] ice: Configure RSS LUT and HASH
 KEY in rebuild path
In-Reply-To: <20181219180334.1104-1-anirudh.venkataramanan@intel.com>
References: <20181219180334.1104-1-anirudh.venkataramanan@intel.com>
Message-ID: <20181219180334.1104-4-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Md Fahad Iqbal Polash <md.fahad.iqbal.polash@intel.com>

This patch configures the RSS lookup table and hash key post reset.

Signed-off-by: Md Fahad Iqbal Polash <md.fahad.iqbal.polash@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 29b1dcfd4331..3bd24173b39c 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -2581,6 +2581,12 @@ int ice_vsi_rebuild(struct ice_vsi *vsi)
 			goto err_vectors;
 
 		ice_vsi_map_rings_to_vectors(vsi);
+		/* Do not exit if configuring RSS had an issue, at least
+		 * receive traffic on first queue. Hence no need to capture
+		 * return value
+		 */
+		if (test_bit(ICE_FLAG_RSS_ENA, vsi->back->flags))
+			ice_vsi_cfg_rss_lut_key(vsi);
 		break;
 	case ICE_VSI_VF:
 		ret = ice_vsi_alloc_q_vectors(vsi);
-- 
2.14.5

