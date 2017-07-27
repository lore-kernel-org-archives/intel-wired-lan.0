From: Lihong Yang <lihong.yang@intel.com>
Date: Thu, 27 Jul 2017 03:17:09 -0700
Subject: [Intel-wired-lan] [PATCH] i40e: remove logically dead code
Message-ID: <1501150629-20305-1-git-send-email-lihong.yang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch removes the !vf condition check that cannot be
true in i40e_ndo_set_vf_trust function

Detected by CoverityScan, CID 1397531 Logically dead code

Signed-off-by: Lihong Yang <lihong.yang@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index f78aa7e..a1d2391 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -3312,8 +3312,6 @@ int i40e_ndo_set_vf_trust(struct net_device *netdev, int vf_id, bool setting)
 
 	vf = &pf->vf[vf_id];
 
-	if (!vf)
-		return -EINVAL;
 	if (setting == vf->trusted)
 		goto out;
 
-- 
2.7.4

