From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Wed,  7 Nov 2018 10:19:35 -0800
Subject: [Intel-wired-lan] [PATCH] ice: Fix possible NULL pointer
 de-reference
Message-ID: <20181107181935.10337-1-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bruce Allan <bruce.w.allan@intel.com>

A recent update to smatch is causing it to report the error "we previously
assumed 'm_entry->vsi_list_info' could be null". Fix that.

Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
[Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> cleaned up commit message]
---
 drivers/net/ethernet/intel/ice/ice_switch.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
index 091047f7ac02..2e5693107fa4 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.c
+++ b/drivers/net/ethernet/intel/ice/ice_switch.c
@@ -1247,6 +1247,9 @@ ice_add_update_vsi_list(struct ice_hw *hw,
 		u16 vsi_handle = new_fltr->vsi_handle;
 		enum ice_adminq_opc opcode;
 
+		if (!m_entry->vsi_list_info)
+			return ICE_ERR_CFG;
+
 		/* A rule already exists with the new VSI being added */
 		if (test_bit(vsi_handle, m_entry->vsi_list_info->vsi_map))
 			return 0;
-- 
2.14.3

