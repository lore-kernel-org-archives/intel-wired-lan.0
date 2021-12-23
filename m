From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Date: Thu, 23 Dec 2021 10:03:37 +0100
Subject: [Intel-wired-lan] [PATCH] ice: Optimize a few bitmap operations
Message-ID: <b0cf67c12895e40b403a435192d47b0ac1a00def.1640250120.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

When a bitmap is local to a function, it is safe to use the non-atomic
__[set|clear]_bit(). No concurrent accesses can occur.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/net/ethernet/intel/ice/ice_flex_pipe.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_flex_pipe.c b/drivers/net/ethernet/intel/ice/ice_flex_pipe.c
index d29197ab3d02..4deb2c9446ec 100644
--- a/drivers/net/ethernet/intel/ice/ice_flex_pipe.c
+++ b/drivers/net/ethernet/intel/ice/ice_flex_pipe.c
@@ -4440,7 +4440,7 @@ ice_update_fd_swap(struct ice_hw *hw, u16 prof_id, struct ice_fv_word *es)
 		for (j = 0; j < ICE_FD_SRC_DST_PAIR_COUNT; j++)
 			if (es[i].prot_id == ice_fd_pairs[j].prot_id &&
 			    es[i].off == ice_fd_pairs[j].off) {
-				set_bit(j, pair_list);
+				__set_bit(j, pair_list);
 				pair_start[j] = i;
 			}
 	}
@@ -4710,7 +4710,7 @@ ice_add_prof(struct ice_hw *hw, enum ice_block blk, u64 id, u8 ptypes[],
 			if (test_bit(ptg, ptgs_used))
 				continue;
 
-			set_bit(ptg, ptgs_used);
+			__set_bit(ptg, ptgs_used);
 			/* Check to see there are any attributes for
 			 * this PTYPE, and add them if found.
 			 */
@@ -5339,7 +5339,7 @@ ice_adj_prof_priorities(struct ice_hw *hw, enum ice_block blk, u16 vsig,
 			}
 
 			/* keep track of used ptgs */
-			set_bit(t->tcam[i].ptg, ptgs_used);
+			__set_bit(t->tcam[i].ptg, ptgs_used);
 		}
 	}
 
-- 
2.32.0

