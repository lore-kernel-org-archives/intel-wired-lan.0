From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Date: Mon, 12 Jul 2021 01:07:51 -0400
Subject: [Intel-wired-lan] [PATCH net-next] ice: change devlink port number
 for pf
Message-ID: <20210712050751.20035-1-michal.swiatkowski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Using lport from VSI structure as physical port number for
PF devlink port introduces inconsistency with netdevice naming scheme
and PF attribute in VF devlink port.

Change this value to be the same for VF and PF devlink port.

Before this change:
- devlink phys_port_name for first netdevice (ending name "f0"): p1
- devlink phys_port_name for VF created on first netdevice: pf0vf0

After this change:
- devlink phys_port_name for first netdevice (ending name "f0"): p0
- devlink phys_port_name for VF created on first netdevice: pf0vf0

Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
This commit should be squashed with "ice: Move devlink port to PF/VF struct"

 drivers/net/ethernet/intel/ice/ice_devlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_devlink.c b/drivers/net/ethernet/intel/ice/ice_devlink.c
index 59ae94266fcf..792a3972dec3 100644
--- a/drivers/net/ethernet/intel/ice/ice_devlink.c
+++ b/drivers/net/ethernet/intel/ice/ice_devlink.c
@@ -624,7 +624,7 @@ int ice_devlink_create_pf_port(struct ice_pf *pf)
 	vsi = ice_get_main_vsi(pf);
 
 	attrs.flavour = DEVLINK_PORT_FLAVOUR_PHYSICAL;
-	attrs.phys.port_number = vsi->port_info->lport;
+	attrs.phys.port_number = pf->hw.bus.func;
 
 	devlink_port_attrs_set(devlink_port, &attrs);
 	devlink = priv_to_devlink(pf);
-- 
2.31.1

