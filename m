From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Thu, 28 Feb 2019 15:25:52 -0800
Subject: [Intel-wired-lan] [PATCH S17 06/17] ice: Validate ring existence
 and its q_vector per VSI
In-Reply-To: <20190228232603.32156-1-anirudh.venkataramanan@intel.com>
References: <20190228232603.32156-1-anirudh.venkataramanan@intel.com>
Message-ID: <20190228232603.32156-7-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

When stopping Tx rings, we use 'i' as an ring array index for looking up
whether the ice_ring exists and have assigned a q_vector. This checks
rings only within a given TC and we need to go through every ring in
VSI. Use 'q_idx' instead.

Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
[Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> cleaned up commit message]
---
 drivers/net/ethernet/intel/ice/ice_lib.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 61bb9e92f6ce..57b2873a6123 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -2072,7 +2072,8 @@ ice_vsi_stop_tx_rings(struct ice_vsi *vsi, enum ice_disq_rst_src rst_src,
 		for (i = 0; i < vsi->tc_cfg.tc_info[tc].qcount_tx; i++) {
 			u16 v_idx;
 
-			if (!rings || !rings[i] || !rings[i]->q_vector) {
+			if (!rings || !rings[q_idx] ||
+			    !rings[q_idx]->q_vector) {
 				err = -EINVAL;
 				goto err_out;
 			}
-- 
2.14.5

