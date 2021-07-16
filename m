From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri, 16 Jul 2021 15:16:38 -0700
Subject: [Intel-wired-lan] [PATCH net-next 1/7] ice: Fix static analyzer hit
In-Reply-To: <20210716221644.45946-1-anthony.l.nguyen@intel.com>
References: <20210716221644.45946-1-anthony.l.nguyen@intel.com>
Message-ID: <20210716221644.45946-2-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>

Static analysis reports that the pointer returned by ice_get_main_vsi is
not checked. Fix it.

Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_devlink.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_devlink.c b/drivers/net/ethernet/intel/ice/ice_devlink.c
index 792a3972dec3..4f709d71cc33 100644
--- a/drivers/net/ethernet/intel/ice/ice_devlink.c
+++ b/drivers/net/ethernet/intel/ice/ice_devlink.c
@@ -621,7 +621,10 @@ int ice_devlink_create_pf_port(struct ice_pf *pf)
 	dev = ice_pf_to_dev(pf);
 
 	devlink_port = &pf->devlink_port;
+
 	vsi = ice_get_main_vsi(pf);
+	if (!vsi)
+		return -EIO;
 
 	attrs.flavour = DEVLINK_PORT_FLAVOUR_PHYSICAL;
 	attrs.phys.port_number = pf->hw.bus.func;
-- 
2.20.1

