From: Wojciech Drewek <wojciech.drewek@intel.com>
Date: Fri,  1 Oct 2021 23:11:15 +0200
Subject: [Intel-wired-lan] [PATCH net-next] ice: Fix switchdev environment
 cleanup
Message-ID: <20211001211115.2647-1-wojciech.drewek@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

ice_vsi_release should be called after ice_eswitch_release_reprs
because we are referring to the switchdev control VSI in
ice_eswitch_release_reprs.

Suggested-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
Reported-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_eswitch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
index c417aacd8579..f10d1fe63de4 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
@@ -443,8 +443,8 @@ static void ice_eswitch_disable_switchdev(struct ice_pf *pf)
 
 	ice_eswitch_napi_disable(pf);
 	ice_eswitch_release_env(pf);
-	ice_vsi_release(ctrl_vsi);
 	ice_eswitch_release_reprs(pf, ctrl_vsi);
+	ice_vsi_release(ctrl_vsi);
 	ice_repr_rem_from_all_vfs(pf);
 }
 
-- 
2.31.1

