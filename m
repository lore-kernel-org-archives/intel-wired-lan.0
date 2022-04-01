From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Date: Fri,  1 Apr 2022 14:54:38 +0200
Subject: [Intel-wired-lan] [PATCH intel-net] ice: allow creating VFs for
 !CONFIG_NET_SWITCHDEV
Message-ID: <20220401125438.292649-1-maciej.fijalkowski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Currently for !CONFIG_NET_SWITCHDEV kernel builds it is not possible to
create VFs properly as call to ice_eswitch_configure() returns
-EOPNOTSUPP for us. This is because CONFIG_ICE_SWITCHDEV depends on
CONFIG_NET_SWITCHDEV.

Change the ice_eswitch_configure() implementation for
!CONFIG_ICE_SWITCHDEV to return 0 instead -EOPNOTSUPP and let
ice_ena_vfs() finish its work properly.

CC: Grzegorz Nitka <grzegorz.nitka@intel.com>
Fixes: 1a1c40df2e80 ("ice: set and release switchdev environment")
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_eswitch.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.h b/drivers/net/ethernet/intel/ice/ice_eswitch.h
index bd58d9d2e565..6a413331572b 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.h
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.h
@@ -52,7 +52,7 @@ static inline void ice_eswitch_update_repr(struct ice_vsi *vsi) { }
 
 static inline int ice_eswitch_configure(struct ice_pf *pf)
 {
-	return -EOPNOTSUPP;
+	return 0;
 }
 
 static inline int ice_eswitch_rebuild(struct ice_pf *pf)
-- 
2.27.0

