From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Fri, 26 Oct 2018 10:41:01 -0700
Subject: [Intel-wired-lan] [PATCH S8 12/16] ice: Check for q_vector when
 stopping rings
In-Reply-To: <20181026174105.11628-1-anirudh.venkataramanan@intel.com>
References: <20181026174105.11628-1-anirudh.venkataramanan@intel.com>
Message-ID: <20181026174105.11628-13-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Tony Nguyen <anthony.l.nguyen@intel.com>

There is a gap in time between a VF reset, which sets the q_vector to
NULL, and the VF requesting mapping of the q_vectors. If
ice_vsi_stop_tx_rings() is called during this time, a NULL pointer
dereference is encountered. Add a check in ice_vsi_stop_tx_rings()
to ensure the q_vector is set to avoid this situation from occurring.

Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 1041fa2a7767..11d0ab185dd2 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -1908,7 +1908,8 @@ int ice_vsi_stop_tx_rings(struct ice_vsi *vsi, enum ice_disq_rst_src rst_src,
 	ice_for_each_txq(vsi, i) {
 		u16 v_idx;
 
-		if (!vsi->tx_rings || !vsi->tx_rings[i]) {
+		if (!vsi->tx_rings || !vsi->tx_rings[i] ||
+		    !vsi->tx_rings[i]->q_vector) {
 			err = -EINVAL;
 			goto err_out;
 		}
-- 
2.14.3

