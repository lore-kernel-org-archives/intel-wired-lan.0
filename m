From: Sasha Levin <sashal@kernel.org>
Date: Mon,  8 Jun 2020 19:05:11 -0400
Subject: [Intel-wired-lan] [PATCH AUTOSEL 5.7 218/274] ice: Fix resource
 leak on early exit from function
In-Reply-To: <20200608230607.3361041-1-sashal@kernel.org>
References: <20200608230607.3361041-1-sashal@kernel.org>
Message-ID: <20200608230607.3361041-218-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Eric Joyner <eric.joyner@intel.com>

[ Upstream commit 857a4f0e9f4956fffc0cedcaa2ba187a2e987153 ]

Memory allocated in the ice_add_prof_id_vsig() function wasn't being
properly freed if an error occurred inside the for-loop in the function.

In particular, 'p' wasn't being freed if an error occurred before it was
added to the resource list at the end of the for-loop.

Signed-off-by: Eric Joyner <eric.joyner@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_flex_pipe.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_flex_pipe.c b/drivers/net/ethernet/intel/ice/ice_flex_pipe.c
index e7a2671222d2..abfec38bb483 100644
--- a/drivers/net/ethernet/intel/ice/ice_flex_pipe.c
+++ b/drivers/net/ethernet/intel/ice/ice_flex_pipe.c
@@ -3705,8 +3705,10 @@ ice_add_prof_id_vsig(struct ice_hw *hw, enum ice_block blk, u16 vsig, u64 hdl,
 					      t->tcam[i].prof_id,
 					      t->tcam[i].ptg, vsig, 0, 0,
 					      vl_msk, dc_msk, nm_msk);
-		if (status)
+		if (status) {
+			devm_kfree(ice_hw_to_dev(hw), p);
 			goto err_ice_add_prof_id_vsig;
+		}
 
 		/* log change */
 		list_add(&p->list_entry, chg);
-- 
2.25.1

