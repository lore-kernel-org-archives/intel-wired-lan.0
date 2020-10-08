From: Mateusz Palczewski <mateusz.palczewski@intel.com>
Date: Thu,  8 Oct 2020 07:13:05 +0000
Subject: [Intel-wired-lan] [PATCH net v1] i40e-linux: Fix removing driver
 while bare-metal VFs pass traffic
Message-ID: <20201008071305.23277-1-mateusz.palczewski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Sylwester Dziedziuch <sylwesterx.dziedziuch@intel.com>

Prevent VFs from resetting when PF driver is being unloaded:
- introduce new pf state: __I40E_VF_RESETS_DISABLED;
- check if pf state has __I40E_VF_RESETS_DISABLED state set,
  if so, disable any further VFLR event notifications;
- when i40e_remove (rmmod i40e) is called, disable any resets on
  the VFs;

Previously if there were bare-metal VFs passing traffic and PF
driver was removed, there was a possibility of VFs triggering a Tx
timeout right before iavf_remove. This was causing iavf_close to
not be called because there is a check in the beginning of  iavf_remove
that bails out early if adapter->state < IAVF_DOWN_PENDING. This
makes it so some resources do not get cleaned up.

Fixes: 6a9ddb36eeb8 ("i40e: disable IOV before freeing resources")
Signed-off-by: Slawomir Laba <slawomirx.laba@intel.com>
Signed-off-by: Brett Creeley <brett.creeley@intel.com>
Signed-off-by: Sylwester Dziedziuch <sylwesterx.dziedziuch@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h        |  1 +
 drivers/net/ethernet/intel/i40e/i40e_main.c   | 22 +++++++++++-----
 .../ethernet/intel/i40e/i40e_virtchnl_pf.c    | 26 +++++++++++--------
 3 files changed, 31 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index c517c47..4cfaacc 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -140,6 +140,7 @@ enum i40e_state_t {
 	__I40E_CLIENT_RESET,
 	__I40E_VIRTCHNL_OP_PENDING,
 	__I40E_RECOVERY_MODE,
+	__I40E_VF_RESETS_DISABLED,	/* disable resets during i40e_remove */
 	/* This must be last as it determines the size of the BITMAP */
 	__I40E_STATE_SIZE__,
 };
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 1e6f222..56cc5e2 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -4033,8 +4033,16 @@ static irqreturn_t i40e_intr(int irq, void *data)
 	}
 
 	if (icr0 & I40E_PFINT_ICR0_VFLR_MASK) {
-		ena_mask &= ~I40E_PFINT_ICR0_ENA_VFLR_MASK;
-		set_bit(__I40E_VFLR_EVENT_PENDING, pf->state);
+		/* disable any further VFLR event notifications */
+		if (test_bit(__I40E_VF_RESETS_DISABLED, pf->state)) {
+			u32 reg = rd32(hw, I40E_PFINT_ICR0_ENA);
+
+			reg &= ~I40E_PFINT_ICR0_VFLR_MASK;
+			wr32(hw, I40E_PFINT_ICR0_ENA, reg);
+		} else {
+			ena_mask &= ~I40E_PFINT_ICR0_ENA_VFLR_MASK;
+			set_bit(__I40E_VFLR_EVENT_PENDING, pf->state);
+		}
 	}
 
 	if (icr0 & I40E_PFINT_ICR0_GRST_MASK) {
@@ -15386,6 +15394,11 @@ static void i40e_remove(struct pci_dev *pdev)
 	while (test_bit(__I40E_RESET_RECOVERY_PENDING, pf->state))
 		usleep_range(1000, 2000);
 
+	if (pf->flags & I40E_FLAG_SRIOV_ENABLED) {
+		set_bit(__I40E_VF_RESETS_DISABLED, pf->state);
+		i40e_free_vfs(pf);
+		pf->flags &= ~I40E_FLAG_SRIOV_ENABLED;
+	}
 	/* no more scheduling of any task */
 	set_bit(__I40E_SUSPENDED, pf->state);
 	set_bit(__I40E_DOWN, pf->state);
@@ -15412,11 +15425,6 @@ static void i40e_remove(struct pci_dev *pdev)
 	 */
 	i40e_notify_client_of_netdev_close(pf->vsi[pf->lan_vsi], false);
 
-	if (pf->flags & I40E_FLAG_SRIOV_ENABLED) {
-		i40e_free_vfs(pf);
-		pf->flags &= ~I40E_FLAG_SRIOV_ENABLED;
-	}
-
 	i40e_fdir_teardown(pf);
 
 	/* If there is a switch structure or any orphans, remove them.
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index b70706d..210d4f9 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -1403,7 +1403,8 @@ static void i40e_cleanup_reset_vf(struct i40e_vf *vf)
  * @vf: pointer to the VF structure
  * @flr: VFLR was issued or not
  *
- * Returns true if the VF is reset, false otherwise.
+ * Returns true if the VF is in reset, resets successfully, or resets
+ * are disabled and false otherwise.
  **/
 bool i40e_reset_vf(struct i40e_vf *vf, bool flr)
 {
@@ -1413,11 +1414,14 @@ bool i40e_reset_vf(struct i40e_vf *vf, bool flr)
 	u32 reg;
 	int i;
 
+	if (test_bit(__I40E_VF_RESETS_DISABLED, pf->state))
+		return true;
+
 	/* If the VFs have been disabled, this means something else is
 	 * resetting the VF, so we shouldn't continue.
 	 */
 	if (test_and_set_bit(__I40E_VF_DISABLE, pf->state))
-		return false;
+		return true;
 
 	i40e_trigger_vf_reset(vf, flr);
 
@@ -1581,6 +1585,15 @@ void i40e_free_vfs(struct i40e_pf *pf)
 
 	i40e_notify_client_of_vf_enable(pf, 0);
 
+	/* Disable IOV before freeing resources. This lets any VF drivers
+	 * running in the host get themselves cleaned up before we yank
+	 * the carpet out from underneath their feet.
+	 */
+	if (!pci_vfs_assigned(pf->pdev))
+		pci_disable_sriov(pf->pdev);
+	else
+		dev_warn(&pf->pdev->dev, "VFs are assigned - not disabling SR-IOV\n");
+
 	/* Amortize wait time by stopping all VFs at the same time */
 	for (i = 0; i < pf->num_alloc_vfs; i++) {
 		if (test_bit(I40E_VF_STATE_INIT, &pf->vf[i].vf_states))
@@ -1596,15 +1609,6 @@ void i40e_free_vfs(struct i40e_pf *pf)
 		i40e_vsi_wait_queues_disabled(pf->vsi[pf->vf[i].lan_vsi_idx]);
 	}
 
-	/* Disable IOV before freeing resources. This lets any VF drivers
-	 * running in the host get themselves cleaned up before we yank
-	 * the carpet out from underneath their feet.
-	 */
-	if (!pci_vfs_assigned(pf->pdev))
-		pci_disable_sriov(pf->pdev);
-	else
-		dev_warn(&pf->pdev->dev, "VFs are assigned - not disabling SR-IOV\n");
-
 	/* free up VF resources */
 	tmp = pf->num_alloc_vfs;
 	pf->num_alloc_vfs = 0;
-- 
2.17.1

---------------------------------------------------------------------
Intel Technology Poland sp. z o.o.
ul. Sowackiego 173 | 80-298 Gdask | Sd Rejonowy Gdask Pnoc | VII Wydzia Gospodarczy Krajowego Rejestru Sdowego - KRS 101882 | NIP 957-07-52-316 | Kapita zakadowy 200.000 PLN.
Ta wiadomo wraz z zacznikami jest przeznaczona dla okrelonego adresata i moe zawiera informacje poufne. W razie przypadkowego otrzymania tej wiadomoci, prosimy o powiadomienie nadawcy oraz trwae jej usunicie; jakiekolwiek przegldanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by others is strictly prohibited.
 

