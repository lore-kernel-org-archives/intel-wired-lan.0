From: Avinash Dayanand <avinash.dayanand@intel.com>
Date: Thu, 17 Mar 2016 09:41:26 -0700
Subject: [Intel-wired-lan] [next PATCH S31 v3 08/12] i40evf: Fix get_rss_aq
In-Reply-To: <1458232890-110933-1-git-send-email-avinash.dayanand@intel.com>
References: <1458232890-110933-1-git-send-email-avinash.dayanand@intel.com>
Message-ID: <1458232890-110933-9-git-send-email-avinash.dayanand@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Catherine Sullivan <catherine.sullivan@intel.com>

We were passing in the seed where we should just be passing false
because we want the vsi table not the pf table.

Testing Hints: Make sure that ethtool -x gives the proper table.

Signed-off-by: Catherine Sullivan <catherine.sullivan@intel.com>
---
 drivers/net/ethernet/intel/i40evf/i40evf_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index 8598c5f..e66f47e 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -1341,7 +1341,7 @@ static int i40evf_get_rss_aq(struct i40e_vsi *vsi, const u8 *seed,
 	}
 
 	if (lut) {
-		ret = i40evf_aq_get_rss_lut(hw, vsi->id, seed, lut, lut_size);
+		ret = i40evf_aq_get_rss_lut(hw, vsi->id, false, lut, lut_size);
 		if (ret) {
 			dev_err(&adapter->pdev->dev,
 				"Cannot get RSS lut, err %s aq_err %s\n",
-- 
2.4.3

