From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Date: Mon,  2 Aug 2021 18:12:45 -0400
Subject: [Intel-wired-lan] [PATCH net-next] ice: disable VLAN stripping on
 control VSI
Message-ID: <20210802221245.6056-1-michal.swiatkowski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Port representators don't support stripping VLAN tag. Control VSI should
reflect this setting. As default all VSIs have stripping enabled.
Disable it for control VSI to allow passing VLAN traffic in switchdev
mode.

Control VSI exists only in switchdev mode, so this change doesn't impact
legacy mode driver.

Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
This commit should be squashed with "ice: setting and releasing switchdev
environment"

 drivers/net/ethernet/intel/ice/ice_eswitch.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
index ec2aa789e214..21f3e72a9a35 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
@@ -22,6 +22,8 @@ static int ice_eswitch_setup_env(struct ice_pf *pf)
 	struct ice_port_info *pi = pf->hw.port_info;
 	bool rule_added = false;
 
+	ice_vsi_manage_vlan_stripping(ctrl_vsi, false);
+
 	ice_remove_vsi_fltr(&pf->hw, uplink_vsi->idx);
 
 	if (ice_vsi_add_vlan(uplink_vsi, 0, ICE_FWD_TO_VSI))
-- 
2.31.1

