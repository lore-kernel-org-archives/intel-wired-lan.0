From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Wed, 29 Jul 2020 17:19:15 -0700
Subject: [Intel-wired-lan] [PATCH S51 06/13] ice: Clear and free XLT entries
 on reset
In-Reply-To: <20200730001922.52568-1-anthony.l.nguyen@intel.com>
References: <20200730001922.52568-1-anthony.l.nguyen@intel.com>
Message-ID: <20200730001922.52568-6-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Vignesh Sridhar <vignesh.sridhar@intel.com>

This fix has been added to address memory leak issues resulting from
triggering a sudden driver reset which does not allow us to follow our
normal removal flows for SW XLT entries for advanced features.

- Adding call to destroy flow profile locks when clearing SW XLT tables.

- Extraction sequence entries were not correctly cleared previously
which could cause ownership conflicts for repeated reset-replay calls.

Fixes: 31ad4e4ee1e4 ("ice: Allocate flow profile")
Signed-off-by: Vignesh Sridhar <vignesh.sridhar@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_flex_pipe.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_flex_pipe.c b/drivers/net/ethernet/intel/ice/ice_flex_pipe.c
index 3c217e51b27e..d59869b2c65e 100644
--- a/drivers/net/ethernet/intel/ice/ice_flex_pipe.c
+++ b/drivers/net/ethernet/intel/ice/ice_flex_pipe.c
@@ -2921,6 +2921,8 @@ static void ice_free_flow_profs(struct ice_hw *hw, u8 blk_idx)
 					   ICE_FLOW_ENTRY_HNDL(e));
 
 		list_del(&p->l_entry);
+
+		mutex_destroy(&p->entries_lock);
 		devm_kfree(ice_hw_to_dev(hw), p);
 	}
 	mutex_unlock(&hw->fl_profs_locks[blk_idx]);
@@ -3038,7 +3040,7 @@ void ice_clear_hw_tbls(struct ice_hw *hw)
 		memset(prof_redir->t, 0,
 		       prof_redir->count * sizeof(*prof_redir->t));
 
-		memset(es->t, 0, es->count * sizeof(*es->t));
+		memset(es->t, 0, es->count * sizeof(*es->t) * es->fvw);
 		memset(es->ref_count, 0, es->count * sizeof(*es->ref_count));
 		memset(es->written, 0, es->count * sizeof(*es->written));
 	}
-- 
2.20.1

