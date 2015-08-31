From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Mon, 31 Aug 2015 19:54:47 -0400
Subject: [Intel-wired-lan] [next PATCH S14 07/15] i40e: remove redundant call
In-Reply-To: <1441065295-234333-1-git-send-email-catherine.sullivan@intel.com>
References: <1441065295-234333-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1441065295-234333-8-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

This function call isn't needed here; the same function is already
called by i40e_reset_vf.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Change-ID: I96ccbf91b752965c9e28fe895d4c7d4c46e3ba44
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 9065d40..e27430d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -964,8 +964,6 @@ int i40e_alloc_vfs(struct i40e_pf *pf, u16 num_alloc_vfs)
 		/* VF resources get allocated during reset */
 		i40e_reset_vf(&vfs[i], false);
 
-		/* enable VF vplan_qtable mappings */
-		i40e_enable_vf_mappings(&vfs[i]);
 	}
 	pf->num_alloc_vfs = num_alloc_vfs;
 
-- 
1.9.3

