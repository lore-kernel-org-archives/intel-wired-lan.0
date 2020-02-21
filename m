From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Fri, 21 Feb 2020 14:15:27 -0800
Subject: [Intel-wired-lan] [next-queue] ice: Cleanup unneeded parenthesis
Message-ID: <20200221221527.393892-1-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Sergei Shtylyov pointed out that two instances of parenthesis are not
needed, so remove them.

Suggested-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
index 81b13781e0e8..49e05f8ad93e 100644
--- a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
@@ -77,9 +77,9 @@ static u8 ice_dcb_get_mode(struct ice_port_info *port_info, bool host)
 		mode = DCB_CAP_DCBX_LLD_MANAGED;
 
 	if (port_info->local_dcbx_cfg.dcbx_mode & ICE_DCBX_MODE_CEE)
-		return (mode | DCB_CAP_DCBX_VER_CEE);
+		return mode | DCB_CAP_DCBX_VER_CEE;
 	else
-		return (mode | DCB_CAP_DCBX_VER_IEEE);
+		return mode | DCB_CAP_DCBX_VER_IEEE;
 }
 
 /**
-- 
2.24.1

