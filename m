From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri,  2 Aug 2019 01:25:29 -0700
Subject: [Intel-wired-lan] [PATCH S26 11/15] ice: add needed PFR during
 driver unload
In-Reply-To: <20190802082533.23083-1-anthony.l.nguyen@intel.com>
References: <20190802082533.23083-1-anthony.l.nguyen@intel.com>
Message-ID: <20190802082533.23083-11-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bruce Allan <bruce.w.allan@intel.com>

According to the specification, a PF Reset must be done as part of the
driver unload flow.

Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 805a6379c605..6b8055ab566f 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -2674,6 +2674,11 @@ static void ice_remove(struct pci_dev *pdev)
 	ice_deinit_pf(pf);
 	ice_deinit_hw(&pf->hw);
 	ice_clear_interrupt_scheme(pf);
+	/* Issue a PFR as part of the prescribed driver unload flow.  Do not
+	 * do it via ice_schedule_reset() since there is no need to rebuild
+	 * and the service task is already stopped.
+	 */
+	ice_reset(&pf->hw, ICE_RESET_PFR);
 	pci_disable_pcie_error_reporting(pdev);
 }
 
-- 
2.20.1

