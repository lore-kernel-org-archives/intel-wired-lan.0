From: Alice Michael <alice.michael@intel.com>
Date: Wed,  7 Jun 2017 05:43:06 -0400
Subject: [Intel-wired-lan] [next PATCH S72-V3 06/13] i40e: Support firmware
	CEE DCB UP to TC map re-definition
In-Reply-To: <20170607094313.32060-1-alice.michael@intel.com>
References: <20170607094313.32060-1-alice.michael@intel.com>
Message-ID: <20170607094313.32060-6-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Changes parsing of FW 4.33 AQ command Get CEE DCBX OPER CFG (0x0A07).
Change is required because FW now creates the oper_prio_tc
nibbles reversed from those in the CEE Priority Group sub-TLV.
This change will only apply to FW 4.33 as future FW versions will use a
different function to parse the CEE data.

Signed-off-by: Greg Bowers <gregory.j.bowers@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_dcb.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_dcb.c b/drivers/net/ethernet/intel/i40e/i40e_dcb.c
index bf1d67e..55079fe 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_dcb.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_dcb.c
@@ -620,14 +620,17 @@ static void i40e_cee_to_dcb_v1_config(
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
+		dcbcfg->etscfg.prioritytable[i * 2] =  tc;
+		tc = (u8)((cee_cfg->oper_prio_tc[i] &
+			 I40E_CEE_PGID_PRIO_1_MASK) >>
+			 I40E_CEE_PGID_PRIO_1_SHIFT);
 		dcbcfg->etscfg.prioritytable[i*2 + 1] = tc;
 	}
 
-- 
2.9.3

