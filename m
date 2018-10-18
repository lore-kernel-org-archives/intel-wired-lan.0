From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Thu, 18 Oct 2018 08:37:06 -0700
Subject: [Intel-wired-lan] [PATCH 4/7] ice: Use capability count returned by
 the firmware
In-Reply-To: <20181018153709.32664-1-anirudh.venkataramanan@intel.com>
References: <20181018153709.32664-1-anirudh.venkataramanan@intel.com>
Message-ID: <20181018153709.32664-5-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The firmware now returns the capability count in the command buffer.
Use it.

Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index c52f450f2c0d..78df54b25bf1 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -1531,9 +1531,7 @@ ice_aq_discover_caps(struct ice_hw *hw, void *buf, u16 buf_size, u32 *cap_count,
 	if (!status)
 		ice_parse_caps(hw, buf, le32_to_cpu(cmd->count), opc);
 	else if (hw->adminq.sq_last_status == ICE_AQ_RC_ENOMEM)
-		*cap_count =
-			DIV_ROUND_UP(le16_to_cpu(desc.datalen),
-				     sizeof(struct ice_aqc_list_caps_elem));
+		*cap_count = le32_to_cpu(cmd->count);
 	return status;
 }
 
-- 
2.14.3

