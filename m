From: Sergey Nemov <sergey.nemov@intel.com>
Date: Thu, 19 Jul 2018 13:25:22 +0200
Subject: [Intel-wired-lan] [PATCH] i40e: Remove duplicated prepare call in
 i40e_shutdown
Message-ID: <20180719112522.GA16521@gklab-81-211.igk.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Function call to i40e_prep_for_reset() is duplicated in
i40e_shutdown routine and gets called before
i40e_enable_mc_magic_wake() which blocks it from being executed
correctly on system reboot or shutdown because adminq is already
disabled by first i40e_prep_for_reset() call.

Two register write calls are also duplicated.

Signed-off-by: Sergey Nemov <sergey.nemov@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index b5daa5c..71c69df 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -14355,12 +14355,6 @@ static void i40e_shutdown(struct pci_dev *pdev)
 
 	set_bit(__I40E_SUSPENDED, pf->state);
 	set_bit(__I40E_DOWN, pf->state);
-	rtnl_lock();
-	i40e_prep_for_reset(pf, true);
-	rtnl_unlock();
-
-	wr32(hw, I40E_PFPM_APM, (pf->wol_en ? I40E_PFPM_APM_APME_MASK : 0));
-	wr32(hw, I40E_PFPM_WUFC, (pf->wol_en ? I40E_PFPM_WUFC_MAG_MASK : 0));
 
 	del_timer_sync(&pf->service_timer);
 	cancel_work_sync(&pf->service_task);
-- 
1.8.3.1

-------------- next part --------------
From d986263b858e0e0349fb56fe7ea78cf4b3044769 Mon Sep 17 00:00:00 2001
From: Sergey Nemov <sergey.nemov@intel.com>
Date: Tue, 10 Jul 2018 16:05:58 +0200
Subject: [PATCH] i40e: Remove duplicated prepare call in i40e_shutdown
To: intel-wired-lan@lists.osuosl.org

Function call to i40e_prep_for_reset() is duplicated in
i40e_shutdown routine and gets called before
i40e_enable_mc_magic_wake() which blocks it from being executed
correctly on system reboot or shutdown because adminq is already
disabled by first i40e_prep_for_reset() call.

Two register write calls are also duplicated.

Signed-off-by: Sergey Nemov <sergey.nemov@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index b5daa5c..71c69df 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -14355,12 +14355,6 @@ static void i40e_shutdown(struct pci_dev *pdev)
 
 	set_bit(__I40E_SUSPENDED, pf->state);
 	set_bit(__I40E_DOWN, pf->state);
-	rtnl_lock();
-	i40e_prep_for_reset(pf, true);
-	rtnl_unlock();
-
-	wr32(hw, I40E_PFPM_APM, (pf->wol_en ? I40E_PFPM_APM_APME_MASK : 0));
-	wr32(hw, I40E_PFPM_WUFC, (pf->wol_en ? I40E_PFPM_WUFC_MAG_MASK : 0));
 
 	del_timer_sync(&pf->service_timer);
 	cancel_work_sync(&pf->service_task);
-- 
1.8.3.1

