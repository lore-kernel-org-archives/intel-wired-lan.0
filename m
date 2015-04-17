From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Thu, 16 Apr 2015 20:05:58 -0400
Subject: [Intel-wired-lan] [net-next S4 01/15] i40e: Collect PFC XOFF RX
	stats even in single TC case
In-Reply-To: <1429229172-143692-1-git-send-email-catherine.sullivan@intel.com>
References: <1429229172-143692-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1429229172-143692-2-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Neerav Parikh <neerav.parikh@intel.com>

When PFC is enabled for any UP in single TC configuration the driver didn't
collect the PFC XOFF RX stats. Though a single TC with PFC enabled is not a
common scenario do not prevent the driver from collecting stats if firmware
indicates that PFC is enabled.

Signed-off-by: Neerav Parikh <neerav.parikh@intel.com>
Change-ID: Ie20bd58b07608b528f3c6d95894c9ae56b00077a
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 24481cd..c48c8d6 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -772,9 +772,8 @@ static void i40e_update_prio_xoff_rx(struct i40e_pf *pf)
 
 	dcb_cfg = &hw->local_dcbx_config;
 
-	/* See if DCB enabled with PFC TC */
-	if (!(pf->flags & I40E_FLAG_DCB_ENABLED) ||
-	    !(dcb_cfg->pfc.pfcenable)) {
+	/* Collect Link XOFF stats when PFC is disabled */
+	if (!dcb_cfg->pfc.pfcenable) {
 		i40e_update_link_xoff_rx(pf);
 		return;
 	}
-- 
1.9.3

