From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 18 May 2016 14:04:24 -0700
Subject: [Intel-wired-lan] [PATCH v3 5/5] igb: call igb_ptp_suspend during
	suspend/resume cycle
In-Reply-To: <20160518210424.20744-1-jacob.e.keller@intel.com>
References: <20160518210424.20744-1-jacob.e.keller@intel.com>
Message-ID: <20160518210424.20744-5-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Properly stop the extra workqueue items and ensure that we resume
cleanly. This is better than using igb_ptp_init and igb_ptp_stop since
these functions destroy the PHC device, which will cause other problems
if we do so. Since igb_ptp_reset now re-schedules the work-queue item we
don't need an equivalent igb_ptp_resume in the resume workflow.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 21727692bef6..b7258402cb59 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -7527,6 +7527,8 @@ static int __igb_shutdown(struct pci_dev *pdev, bool *enable_wake,
 	if (netif_running(netdev))
 		__igb_close(netdev, true);
 
+	igb_ptp_suspend(adapter);
+
 	igb_clear_interrupt_scheme(adapter);
 
 #ifdef CONFIG_PM
-- 
2.8.2.820.gd1c5f70

