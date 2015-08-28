From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Fri, 28 Aug 2015 17:55:52 -0400
Subject: [Intel-wired-lan] [next PATCH S13 06/15] i40e: Support FW CEE DCB
	UP to TC map nibble swap
In-Reply-To: <1440798961-17326-1-git-send-email-catherine.sullivan@intel.com>
References: <1440798961-17326-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1440798961-17326-7-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Greg Bowers <gregory.j.bowers@intel.com>

Changes parsing of AQ command Get CEE DCBX OPER CFG (0x0A07). Change is
required because FW creates the oper_prio_tc nibbles reversed from those
in the CEE Priority Group sub-TLV.

Signed-off-by: Greg Bowers <gregory.j.bowers@intel.com>
Change-ID: I7d9d8641bb430d30e286fc3fac909866ef8a0de8
---
 drivers/net/ethernet/intel/i40e/i40e_dcb.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_dcb.c b/drivers/net/ethernet/intel/i40e/i40e_dcb.c
index fbec7d7..6fa07ef 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_dcb.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_dcb.c
@@ -681,15 +681,18 @@ static void i40e_cee_to_dcb_config(
 	/* CEE PG data to ETS config */
 	dcbcfg->etscfg.maxtcs = cee_cfg->oper_num_tc;
 
+	/* Note that the FW creates the oper_prio_tc nibbles reversed
+	 * from those in the CEE Priority Group sub-TLV.
+	 */
 	for (i = 0; i < 4; i++) {
 		tc = (u8)((cee_cfg->oper_prio_tc[i] &
-			 I40E_CEE_PGID_PRIO_1_MASK) >>
-			 I40E_CEE_PGID_PRIO_1_SHIFT);
-		dcbcfg->etscfg.prioritytable[i*2] =  tc;
-		tc = (u8)((cee_cfg->oper_prio_tc[i] &
 			 I40E_CEE_PGID_PRIO_0_MASK) >>
 			 I40E_CEE_PGID_PRIO_0_SHIFT);
-		dcbcfg->etscfg.prioritytable[i*2 + 1] = tc;
+		dcbcfg->etscfg.prioritytable[i * 2] =  tc;
+		tc = (u8)((cee_cfg->oper_prio_tc[i] &
+			 I40E_CEE_PGID_PRIO_1_MASK) >>
+			 I40E_CEE_PGID_PRIO_1_SHIFT);
+		dcbcfg->etscfg.prioritytable[i * 2 + 1] = tc;
 	}
 
 	for (i = 0; i < I40E_MAX_TRAFFIC_CLASS; i++)
-- 
1.9.3

