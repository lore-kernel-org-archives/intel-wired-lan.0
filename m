From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Mon, 13 Jul 2020 13:53:16 -0700
Subject: [Intel-wired-lan] [PATCH S50 13/15] ice: reduce scope of variable
In-Reply-To: <20200713205318.32425-1-anthony.l.nguyen@intel.com>
References: <20200713205318.32425-1-anthony.l.nguyen@intel.com>
Message-ID: <20200713205318.32425-13-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bruce Allan <bruce.w.allan@intel.com>

The scope of the macro local variable 'i' can be reduced.  Do so to avoid
static analysis tools from complaining.

Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_controlq.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_controlq.c b/drivers/net/ethernet/intel/ice/ice_controlq.c
index 1e18021aa073..1f46a7828be8 100644
--- a/drivers/net/ethernet/intel/ice/ice_controlq.c
+++ b/drivers/net/ethernet/intel/ice/ice_controlq.c
@@ -312,9 +312,10 @@ ice_cfg_rq_regs(struct ice_hw *hw, struct ice_ctl_q_info *cq)
 
 #define ICE_FREE_CQ_BUFS(hw, qi, ring)					\
 do {									\
-	int i;								\
 	/* free descriptors */						\
-	if ((qi)->ring.r.ring##_bi)					\
+	if ((qi)->ring.r.ring##_bi) {					\
+		int i;							\
+									\
 		for (i = 0; i < (qi)->num_##ring##_entries; i++)	\
 			if ((qi)->ring.r.ring##_bi[i].pa) {		\
 				dmam_free_coherent(ice_hw_to_dev(hw),	\
@@ -325,6 +326,7 @@ do {									\
 					(qi)->ring.r.ring##_bi[i].pa = 0;\
 					(qi)->ring.r.ring##_bi[i].size = 0;\
 		}							\
+	}								\
 	/* free the buffer info list */					\
 	if ((qi)->ring.cmd_buf)						\
 		devm_kfree(ice_hw_to_dev(hw), (qi)->ring.cmd_buf);	\
-- 
2.20.1

