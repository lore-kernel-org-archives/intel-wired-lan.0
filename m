From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Wed,  6 Nov 2019 02:05:38 -0800
Subject: [Intel-wired-lan] [PATCH S32 v3 12/15] ice: remove unnecessary
 conditional check
In-Reply-To: <20191106100541.48639-1-anthony.l.nguyen@intel.com>
References: <20191106100541.48639-1-anthony.l.nguyen@intel.com>
Message-ID: <20191106100541.48639-12-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bruce Allan <bruce.w.allan@intel.com>

There is no reason to do this conditional check before the assignment so
simply remove it.

Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_switch.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
index 1acdd43a2edd..77d211ea3aae 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.c
+++ b/drivers/net/ethernet/intel/ice/ice_switch.c
@@ -416,8 +416,7 @@ ice_add_vsi(struct ice_hw *hw, u16 vsi_handle, struct ice_vsi_ctx *vsi_ctx,
 		ice_save_vsi_ctx(hw, vsi_handle, tmp_vsi_ctx);
 	} else {
 		/* update with new HW VSI num */
-		if (tmp_vsi_ctx->vsi_num != vsi_ctx->vsi_num)
-			tmp_vsi_ctx->vsi_num = vsi_ctx->vsi_num;
+		tmp_vsi_ctx->vsi_num = vsi_ctx->vsi_num;
 	}
 
 	return 0;
-- 
2.20.1

