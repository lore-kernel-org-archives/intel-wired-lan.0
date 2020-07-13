From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Mon, 13 Jul 2020 13:53:17 -0700
Subject: [Intel-wired-lan] [PATCH S50 14/15] ice: disable no longer needed
 workaround for FW logging
In-Reply-To: <20200713205318.32425-1-anthony.l.nguyen@intel.com>
References: <20200713205318.32425-1-anthony.l.nguyen@intel.com>
Message-ID: <20200713205318.32425-14-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Ben Shelton <benjamin.h.shelton@intel.com>

For the FW logging info AQ command, we currently set the ICE_AQ_FLAG_RD
in order to work around a FW issue. This issue has been fixed so remove the
workaround.

Signed-off-by: Ben Shelton <benjamin.h.shelton@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index d1d827a69271..63cff81d234f 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -611,8 +611,6 @@ static enum ice_status ice_get_fw_log_cfg(struct ice_hw *hw)
 
 	ice_fill_dflt_direct_cmd_desc(&desc, ice_aqc_opc_fw_logging_info);
 
-	desc.flags |= cpu_to_le16(ICE_AQ_FLAG_RD);
-
 	status = ice_aq_send_cmd(hw, &desc, config, size, NULL);
 	if (!status) {
 		u16 i;
-- 
2.20.1

