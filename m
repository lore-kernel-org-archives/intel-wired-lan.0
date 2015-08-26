From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Wed, 26 Aug 2015 15:14:07 -0400
Subject: [Intel-wired-lan] [next PATCH S11 01/15] i40e: Increase the amount
	of time we wait for reset to be done
In-Reply-To: <1440616461-110869-1-git-send-email-catherine.sullivan@intel.com>
References: <1440616461-110869-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1440616461-110869-2-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>

In some rare cases the reset can take longer to complete so increase the
amount of time we wait.

Signed-off-by: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
Change-ID: Ib5628ec54b526a811ee33d1214fe763226406671
---
 drivers/net/ethernet/intel/i40e/i40e_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index 6833717..1e81f4e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -1256,7 +1256,7 @@ i40e_status i40e_pf_reset(struct i40e_hw *hw)
 	grst_del = (rd32(hw, I40E_GLGEN_RSTCTL) &
 		    I40E_GLGEN_RSTCTL_GRSTDEL_MASK) >>
 		    I40E_GLGEN_RSTCTL_GRSTDEL_SHIFT;
-	for (cnt = 0; cnt < grst_del + 2; cnt++) {
+	for (cnt = 0; cnt < grst_del + 10; cnt++) {
 		reg = rd32(hw, I40E_GLGEN_RSTAT);
 		if (!(reg & I40E_GLGEN_RSTAT_DEVSTATE_MASK))
 			break;
-- 
1.9.3

