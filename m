From: Avinash Dayanand <avinash.dayanand@intel.com>
Date: Wed, 17 Feb 2016 16:12:13 -0800
Subject: [Intel-wired-lan] [next PATCH S29 03/14] i40e: Increase timeout
	when checking GLGEN_RSTAT_DEVSTATE bit
In-Reply-To: <1455754344-6372-1-git-send-email-avinash.dayanand@intel.com>
References: <1455754344-6372-1-git-send-email-avinash.dayanand@intel.com>
Message-ID: <1455754344-6372-4-git-send-email-avinash.dayanand@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Kevin Scott <kevin.c.scott@intel.com>

When linking with particular PHY types (ex: copper PHY), the amount of
time it takes for the GLGEN_RSTAT_DEVSTATE to be set increases greatly,
which can lead to a timeout and failure to load the driver.

Signed-off-by: Kevin Scott <kevin.c.scott@intel.com>
Change-ID: If02be0dfcd7c57fdde2d5c81cd63651260cd2029
---
 drivers/net/ethernet/intel/i40e/i40e_common.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index d417193..3a57e59 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -1239,7 +1239,13 @@ i40e_status i40e_pf_reset(struct i40e_hw *hw)
 	grst_del = (rd32(hw, I40E_GLGEN_RSTCTL) &
 		    I40E_GLGEN_RSTCTL_GRSTDEL_MASK) >>
 		    I40E_GLGEN_RSTCTL_GRSTDEL_SHIFT;
-	for (cnt = 0; cnt < grst_del + 10; cnt++) {
+
+	/* It can take upto 15 secs for GRST steady state.
+	 * Bump it to 16 secs max to be safe.
+	 */
+	grst_del = grst_del * 20;
+
+	for (cnt = 0; cnt < grst_del; cnt++) {
 		reg = rd32(hw, I40E_GLGEN_RSTAT);
 		if (!(reg & I40E_GLGEN_RSTAT_DEVSTATE_MASK))
 			break;
-- 
2.1.0

