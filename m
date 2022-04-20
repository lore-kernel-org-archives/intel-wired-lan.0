From: Wojciech Drewek <wojciech.drewek@intel.com>
Date: Wed, 20 Apr 2022 12:55:41 +0200
Subject: [Intel-wired-lan] [PATCH net-next v2] ice: return ENOSPC when
 exceeding ICE_MAX_CHAIN_WORDS
Message-ID: <20220420105541.275957-1-wojciech.drewek@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

When number of words exceeds ICE_MAX_CHAIN_WORDS, -ENOSPC
should be returned not -EINVAL. Do not overwrite this
error code in ice_add_tc_flower_adv_fltr.

Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
Suggested-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

---
v2: change title as Paul suggested
---
 drivers/net/ethernet/intel/ice/ice_switch.c | 5 ++++-
 drivers/net/ethernet/intel/ice/ice_tc_lib.c | 1 -
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
index 968b96a6e0ac..79ab2128857f 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.c
+++ b/drivers/net/ethernet/intel/ice/ice_switch.c
@@ -6265,9 +6265,12 @@ ice_add_adv_rule(struct ice_hw *hw, struct ice_adv_lkup_elem *lkups,
 				word_cnt++;
 	}
 
-	if (!word_cnt || word_cnt > ICE_MAX_CHAIN_WORDS)
+	if (!word_cnt)
 		return -EINVAL;
 
+	if (word_cnt > ICE_MAX_CHAIN_WORDS)
+		return -ENOSPC;
+
 	/* locate a dummy packet */
 	profile = ice_find_dummy_packet(lkups, lkups_cnt, rinfo->tun_type);
 
diff --git a/drivers/net/ethernet/intel/ice/ice_tc_lib.c b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
index 5b300c8cb009..ce6b5f31a1c8 100644
--- a/drivers/net/ethernet/intel/ice/ice_tc_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
@@ -781,7 +781,6 @@ ice_add_tc_flower_adv_fltr(struct ice_vsi *vsi,
 	} else if (ret) {
 		NL_SET_ERR_MSG_MOD(tc_fltr->extack,
 				   "Unable to add filter due to error");
-		ret = -EIO;
 		goto exit;
 	}
 
-- 
2.31.1

