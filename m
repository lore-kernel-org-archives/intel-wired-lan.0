From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Fri, 26 Oct 2018 11:44:40 -0700
Subject: [Intel-wired-lan] [PATCH S9 08/15] ice: Pass the return value of
 ice_init_def_sw_recp().
In-Reply-To: <20181026184447.13547-1-anirudh.venkataramanan@intel.com>
References: <20181026184447.13547-1-anirudh.venkataramanan@intel.com>
Message-ID: <20181026184447.13547-9-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jaroslaw Ilgiewicz <jaroslaw.ilgiewicz@intel.com>

Added check of return value for ice_init_def_sw_recp().
Now we know if memory was correctly allocated.

Signed-off-by: Jaroslaw Ilgiewicz <jaroslaw.ilgiewicz@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 9de5a3aac77d..0b528602c4c9 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -405,9 +405,7 @@ static enum ice_status ice_init_fltr_mgmt_struct(struct ice_hw *hw)
 
 	INIT_LIST_HEAD(&sw->vsi_list_map_head);
 
-	ice_init_def_sw_recp(hw);
-
-	return 0;
+	return ice_init_def_sw_recp(hw);
 }
 
 /**
-- 
2.14.3

