From: Alice Michael <alice.michael@intel.com>
Date: Tue, 28 Aug 2018 10:16:08 -0700
Subject: [Intel-wired-lan] [next PATCH S96 8/9] i40evf: cancel workqueue
 sync for adminq when a VF is removed
In-Reply-To: <20180828171609.78242-1-alice.michael@intel.com>
References: <20180828171609.78242-1-alice.michael@intel.com>
Message-ID: <20180828171609.78242-8-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Lihong Yang <lihong.yang@intel.com>

If a VF is being removed, there is no need to continue with the
workqueue sync for the adminq task, thus cancel it. Without this call,
when VFs are created and removed right away, there might be a chance for
the driver to crash with events stuck in the adminq.

Signed-off-by: Lihong Yang <lihong.yang@intel.com>
---
 drivers/net/ethernet/intel/i40evf/i40evf_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index c7048cf..174d1da 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -3910,6 +3910,8 @@ static void i40evf_remove(struct pci_dev *pdev)
 	if (adapter->watchdog_timer.function)
 		del_timer_sync(&adapter->watchdog_timer);
 
+	cancel_work_sync(&adapter->adminq_task);
+
 	i40evf_free_rss(adapter);
 
 	if (hw->aq.asq.count)
-- 
2.9.5

