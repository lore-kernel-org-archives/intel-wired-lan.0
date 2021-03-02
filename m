From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Tue,  2 Mar 2021 10:15:43 -0800
Subject: [Intel-wired-lan] [PATCH S56 11/13] ice: Correct comment block style
In-Reply-To: <20210302181545.51822-1-anthony.l.nguyen@intel.com>
References: <20210302181545.51822-1-anthony.l.nguyen@intel.com>
Message-ID: <20210302181545.51822-11-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The following is reported by checkpatch, correct it.

-----------------------------------------------
drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
-----------------------------------------------
WARNING:NETWORKING_BLOCK_COMMENT_STYLE: networking block comments don't use an empty /* line, use /* Comment...
FILE: drivers/net/ethernet/intel/ice/ice_adminq_cmd.h:1428:
+/*
+ * Send to PF command (indirect 0x0801) ID is only used by PF

Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_adminq_cmd.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
index 8c22d0cda153..0a5f4c230076 100644
--- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
@@ -1424,8 +1424,7 @@ struct ice_aqc_nvm_comp_tbl {
 	u8 cvs[]; /* Component Version String */
 } __packed;
 
-/*
- * Send to PF command (indirect 0x0801) ID is only used by PF
+/* Send to PF command (indirect 0x0801) ID is only used by PF
  *
  * Send to VF command (indirect 0x0802) ID is only used by PF
  *
-- 
2.20.1

