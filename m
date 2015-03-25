From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Tue, 24 Mar 2015 21:30:21 -0700
Subject: [Intel-wired-lan] [next-queue S2 11/15] i40e: stop flow director on
	shutdown
In-Reply-To: <1427257825-24519-1-git-send-email-jeffrey.t.kirsher@intel.com>
References: <1427257825-24519-1-git-send-email-jeffrey.t.kirsher@intel.com>
Message-ID: <1427257825-24519-11-git-send-email-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

In some cases, the hardware would continue to try to access the FDIR
ring after entering D3Hot state, which would cause either PCIe errors or
NMIs, depending upon system configuration.

Explicitly stop FDIR in our shutdown routine to eliminate this
possibility.

Change-ID: Ib98060d6352ec595ab9a78bfe252675a9fa5d8bc
Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 15cee4d..5e79054 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -10210,6 +10210,8 @@ static int i40e_suspend(struct pci_dev *pdev, pm_message_t state)
 	set_bit(__I40E_DOWN, &pf->state);
 	del_timer_sync(&pf->service_timer);
 	cancel_work_sync(&pf->service_task);
+	i40e_fdir_teardown(pf);
+
 	rtnl_lock();
 	i40e_prep_for_reset(pf);
 	rtnl_unlock();
-- 
1.9.3

