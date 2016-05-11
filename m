From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 11 May 2016 16:18:24 -0700
Subject: [Intel-wired-lan] [net v2 5/5] igb: call
	igb_ptp_suspend/igb_ptp_resume during suspend/resume cycle
In-Reply-To: <20160511231824.22542-1-jacob.e.keller@intel.com>
References: <20160511231824.22542-1-jacob.e.keller@intel.com>
Message-ID: <20160511231824.22542-6-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Properly stop the extra workqueue items and ensure that we resume
cleanly. This is better than using igb_ptp_init and igb_ptp_stop since
these functions destroy the PHC device, which will cause other problems
if we do so.

Reported-By: Vidya Sagar <sagar.tv@gmail.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 21727692bef6..16b9eb9b94b5 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -7527,6 +7527,8 @@ static int __igb_shutdown(struct pci_dev *pdev, bool *enable_wake,
 	if (netif_running(netdev))
 		__igb_close(netdev, true);
 
+	igb_ptp_suspend(adapter);
+
 	igb_clear_interrupt_scheme(adapter);
 
 #ifdef CONFIG_PM
@@ -7637,7 +7639,7 @@ static int igb_resume(struct device *dev)
 		return -ENOMEM;
 	}
 
-	igb_reset(adapter);
+	igb_ptp_resume(adapter);
 
 	/* let the f/w know that the h/w is now under the control of the
 	 * driver.
-- 
2.8.1.493.g7b22612

