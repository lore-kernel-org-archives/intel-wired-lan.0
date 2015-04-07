From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Tue,  7 Apr 2015 19:45:35 -0400
Subject: [Intel-wired-lan] [net-next S3 06/13] i40e: For VF reset (VFR and
	VFLR) add some more delay
In-Reply-To: <1428450342-48517-1-git-send-email-catherine.sullivan@intel.com>
References: <1428450342-48517-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1428450342-48517-6-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Anjali Singhai Jain <anjali.singhai@intel.com>

With a HW issue that was recently discovered, after a VFLR HW might be
indicating to us a reset completion little too early. So wait another 10
msec for cache to be cleaned up.

Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
Change-ID: I6a24dcf5dd7ffcd6500246e717411ef58532d1e9
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 98e0921..78d1c4f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -812,6 +812,9 @@ void i40e_reset_vf(struct i40e_vf *vf, bool flr)
 		}
 	}
 
+	if (flr)
+		usleep_range(10000, 20000);
+
 	if (!rsd)
 		dev_err(&pf->pdev->dev, "VF reset check timeout on VF %d\n",
 			vf->vf_id);
-- 
1.9.3

