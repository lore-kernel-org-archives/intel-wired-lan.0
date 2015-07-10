From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Fri, 10 Jul 2015 19:35:59 -0400
Subject: [Intel-wired-lan] [intel-wired-lan][next PATCH S8 04/15] i40e: Move
	function calls to i40e_shutdown instead of i40e_suspend
In-Reply-To: <1436571370-103673-1-git-send-email-catherine.sullivan@intel.com>
References: <1436571370-103673-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1436571370-103673-4-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

We should be stopping the service task and flow director on
shutdown not on suspension.

Signed-off-by: Catherine Sullivan <catherine.sullivan@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 18bc8c5..ef99c16 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -10380,6 +10380,19 @@ static void i40e_shutdown(struct pci_dev *pdev)
 	wr32(hw, I40E_PFPM_APM, (pf->wol_en ? I40E_PFPM_APM_APME_MASK : 0));
 	wr32(hw, I40E_PFPM_WUFC, (pf->wol_en ? I40E_PFPM_WUFC_MAG_MASK : 0));
 
+	del_timer_sync(&pf->service_timer);
+	cancel_work_sync(&pf->service_task);
+	i40e_fdir_teardown(pf);
+
+	rtnl_lock();
+	i40e_prep_for_reset(pf);
+	rtnl_unlock();
+
+	wr32(hw, I40E_PFPM_APM,
+	     (pf->wol_en ? I40E_PFPM_APM_APME_MASK : 0));
+	wr32(hw, I40E_PFPM_WUFC,
+	     (pf->wol_en ? I40E_PFPM_WUFC_MAG_MASK : 0));
+
 	i40e_clear_interrupt_scheme(pf);
 
 	if (system_state == SYSTEM_POWER_OFF) {
@@ -10400,9 +10413,6 @@ static int i40e_suspend(struct pci_dev *pdev, pm_message_t state)
 
 	set_bit(__I40E_SUSPENDED, &pf->state);
 	set_bit(__I40E_DOWN, &pf->state);
-	del_timer_sync(&pf->service_timer);
-	cancel_work_sync(&pf->service_task);
-	i40e_fdir_teardown(pf);
 
 	rtnl_lock();
 	i40e_prep_for_reset(pf);
-- 
1.9.3

