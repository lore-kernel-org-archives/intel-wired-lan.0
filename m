From: Mateusz Palczewski <mateusz.palczewski@intel.com>
Date: Fri, 27 Nov 2020 10:39:03 +0000
Subject: [Intel-wired-lan] [PATCH net v1] i40e: Fix addition of RX filters
 after enabling FW LLDP agent
Message-ID: <20201127103903.16603-1-mateusz.palczewski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Fix addition of VLAN filter for PF after enabling FW LLDP agent.
Changing LLDP Agent causes FW to re-initialize per NVM settings.
Remove default PF filter and move "Enable/Disable" to currently used
reset flag.
Without this patch PF would try to add MAC VLAN filter with default
switch filter present. This causes AQ error and sets promiscuous mode
on.

Fixes: c65e78f87f81 ("i40e: Further implementation of LLDP")
Signed-off-by: Przemyslaw Patynowski <przemyslawx.patynowski@intel.com>
Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
Reviewed-by: Sylwester Dziedziuch <sylwesterx.dziedziuch@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 16 +++++++++-------
 drivers/net/ethernet/intel/i40e/i40e_main.c    |  9 ++++-----
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 8a4dd77..2b6d887 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -5083,7 +5083,7 @@ static int i40e_set_priv_flags(struct net_device *dev, u32 flags)
 	enum i40e_admin_queue_err adq_err;
 	struct i40e_vsi *vsi = np->vsi;
 	struct i40e_pf *pf = vsi->back;
-	bool is_reset_needed;
+	u32 reset_needed = 0;
 	i40e_status status;
 	u32 i, j;
 
@@ -5128,9 +5128,11 @@ static int i40e_set_priv_flags(struct net_device *dev, u32 flags)
 flags_complete:
 	changed_flags = orig_flags ^ new_flags;
 
-	is_reset_needed = !!(changed_flags & (I40E_FLAG_VEB_STATS_ENABLED |
-		I40E_FLAG_LEGACY_RX | I40E_FLAG_SOURCE_PRUNING_DISABLED |
-		I40E_FLAG_DISABLE_FW_LLDP));
+	if (changed_flags & I40E_FLAG_DISABLE_FW_LLDP)
+		reset_needed = I40E_PF_RESET_AND_REBUILD_FLAG;
+	if (changed_flags & (I40E_FLAG_VEB_STATS_ENABLED |
+	    I40E_FLAG_LEGACY_RX | I40E_FLAG_SOURCE_PRUNING_DISABLED))
+		reset_needed = BIT(__I40E_PF_RESET_REQUESTED);
 
 	/* Before we finalize any flag changes, we need to perform some
 	 * checks to ensure that the changes are supported and safe.
@@ -5252,7 +5254,7 @@ flags_complete:
 				case I40E_AQ_RC_EEXIST:
 					dev_warn(&pf->pdev->dev,
 						 "FW LLDP agent is already running\n");
-					is_reset_needed = false;
+					reset_needed = 0;
 					break;
 				case I40E_AQ_RC_EPERM:
 					dev_warn(&pf->pdev->dev,
@@ -5281,8 +5283,8 @@ flags_complete:
 	/* Issue reset to cause things to take effect, as additional bits
 	 * are added we will need to create a mask of bits requiring reset
 	 */
-	if (is_reset_needed)
-		i40e_do_reset(pf, BIT(__I40E_PF_RESET_REQUESTED), true);
+	if (reset_needed)
+		i40e_do_reset(pf, reset_needed, true);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index d743bd7..5bee1de 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -8946,11 +8946,6 @@ void i40e_do_reset(struct i40e_pf *pf, u32 reset_flags, bool lock_acquired)
 		dev_dbg(&pf->pdev->dev, "PFR requested\n");
 		i40e_handle_reset_warning(pf, lock_acquired);
 
-		dev_info(&pf->pdev->dev,
-			 pf->flags & I40E_FLAG_DISABLE_FW_LLDP ?
-			 "FW LLDP is disabled\n" :
-			 "FW LLDP is enabled\n");
-
 	} else if (reset_flags & I40E_PF_RESET_AND_REBUILD_FLAG) {
 		/* Request a PF Reset
 		 *
@@ -8958,6 +8953,10 @@ void i40e_do_reset(struct i40e_pf *pf, u32 reset_flags, bool lock_acquired)
 		 */
 		i40e_prep_for_reset(pf);
 		i40e_reset_and_rebuild(pf, true, lock_acquired);
+		dev_info(&pf->pdev->dev,
+			 pf->flags & I40E_FLAG_DISABLE_FW_LLDP ?
+			 "FW LLDP is disabled\n" :
+			 "FW LLDP is enabled\n");
 
 	} else if (reset_flags & BIT_ULL(__I40E_REINIT_REQUESTED)) {
 		int v;
-- 
2.17.1

---------------------------------------------------------------------
Intel Technology Poland sp. z o.o.
ul. Sowackiego 173 | 80-298 Gdask | Sd Rejonowy Gdask Pnoc | VII Wydzia Gospodarczy Krajowego Rejestru Sdowego - KRS 101882 | NIP 957-07-52-316 | Kapita zakadowy 200.000 PLN.
Ta wiadomo wraz z zacznikami jest przeznaczona dla okrelonego adresata i moe zawiera informacje poufne. W razie przypadkowego otrzymania tej wiadomoci, prosimy o powiadomienie nadawcy oraz trwae jej usunicie; jakiekolwiek przegldanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by others is strictly prohibited.
 

