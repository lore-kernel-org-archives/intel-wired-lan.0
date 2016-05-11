From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 11 May 2016 11:23:35 -0700
Subject: [Intel-wired-lan] [PATCH] igb: properly start/stop PTP during
	suspend/resume
Message-ID: <20160511182335.12453-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Reported-by: Vidya Sagar <sagar.tv@gmail.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 21727692bef6..8f740bc69fc3 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -7527,6 +7527,8 @@ static int __igb_shutdown(struct pci_dev *pdev, bool *enable_wake,
 	if (netif_running(netdev))
 		__igb_close(netdev, true);
 
+	igb_ptp_stop(adapter);
+
 	igb_clear_interrupt_scheme(adapter);
 
 #ifdef CONFIG_PM
@@ -7637,6 +7639,8 @@ static int igb_resume(struct device *dev)
 		return -ENOMEM;
 	}
 
+	igb_ptp_init(adapter);
+
 	igb_reset(adapter);
 
 	/* let the f/w know that the h/w is now under the control of the
-- 
2.8.1.493.g7b22612

