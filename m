From: Avinash Dayanand <avinash.dayanand@intel.com>
Date: Thu, 18 Feb 2016 09:19:25 -0800
Subject: [Intel-wired-lan] [v2 next PATCH S29 12/14] i40e: suspend
	scheduling during driver unload
In-Reply-To: <1455815965-9735-1-git-send-email-avinash.dayanand@intel.com>
References: <1455815965-9735-1-git-send-email-avinash.dayanand@intel.com>
Message-ID: <1455815965-9735-2-git-send-email-avinash.dayanand@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Pandi Kumar Maharajan <pandi.maharajan@intel.com>

We need to suspend scheduling or any pending service task during driver
unload process, so that new task will not be scheduled. This patch sets
the suspend flag bit during reload which avoids service task execution.

v2: change patch title

Signed-off-by: Pandi Kumar Maharajan <pandi.maharajan@intel.com>
Change-ID: I017c57b5d6656564556e3c5387da671369a572ac
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 7388c1a..50c2c71 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -11211,6 +11211,7 @@ static void i40e_remove(struct pci_dev *pdev)
 	i40e_write_rx_ctl(hw, I40E_PFQF_HENA(1), 0);
 
 	/* no more scheduling of any task */
+	set_bit(__I40E_SUSPENDED, &pf->state);
 	set_bit(__I40E_DOWN, &pf->state);
 	del_timer_sync(&pf->service_timer);
 	cancel_work_sync(&pf->service_task);
-- 
2.1.0

