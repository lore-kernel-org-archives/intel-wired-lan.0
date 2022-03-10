From: Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>
Date: Thu, 10 Mar 2022 10:46:52 -0800
Subject: [Intel-wired-lan] [PATCH net v1] ice: destroy flow director filter
 mutex after releasing VSIs
Message-ID: <20220310184652.1596373-1-sudheer.mogilappagari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Currently fdir_fltr_lock is accessed in ice_vsi_release_all() function
after it is destroyed. Instead destroy mutex after ice_vsi_release_all.

Fixes: 40319796b732 ("ice: Add flow director support for channel mode")
Signed-off-by: Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index cd898af3f6b5..61ad9622f8ae 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -4870,7 +4870,6 @@ static void ice_remove(struct pci_dev *pdev)
 	ice_devlink_unregister_params(pf);
 	set_bit(ICE_DOWN, pf->state);
 
-	mutex_destroy(&(&pf->hw)->fdir_fltr_lock);
 	ice_deinit_lag(pf);
 	if (test_bit(ICE_FLAG_PTP_SUPPORTED, pf->flags))
 		ice_ptp_release(pf);
@@ -4878,6 +4877,7 @@ static void ice_remove(struct pci_dev *pdev)
 		ice_remove_arfs(pf);
 	ice_setup_mc_magic_wake(pf);
 	ice_vsi_release_all(pf);
+	mutex_destroy(&(&pf->hw)->fdir_fltr_lock);
 	ice_set_wake(pf);
 	ice_free_irq_msix_misc(pf);
 	ice_for_each_vsi(pf, i) {
-- 
2.27.0

