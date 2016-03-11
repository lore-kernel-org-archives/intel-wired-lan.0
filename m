From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri, 11 Mar 2016 09:52:31 -0800
Subject: [Intel-wired-lan] [PATCH v2] rework of "fm10k: prevent RCU issues
	during AER events
Message-ID: <1457718752-8678-1-git-send-email-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This is a rework of the original patch 308f3d5aad0e ("fm10k: prevent RCU
issues during AER events", 2016-03-09), and the following email is a
direct rework which replaces it in the queue. Thus, the previously
mentioned version should be dropped from the queue.

Patch interdiff for review:

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
index a10b98025c69..7dc8292546e1 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
@@ -2353,11 +2353,13 @@ static void fm10k_io_resume(struct pci_dev *pdev)
 	/* reset statistics starting values */
 	hw->mac.ops.rebind_hw_stats(hw, &interface->stats);
 
+	rtnl_lock();
+
 	err = fm10k_init_queueing_scheme(interface);
 	if (err) {
 		dev_err(&interface->pdev->dev,
 			"init_queueing_scheme failed: %d\n", err);
-		return;
+		goto unlock;
 	}
 
 	/* reassociate interrupts */
@@ -2374,6 +2376,9 @@ static void fm10k_io_resume(struct pci_dev *pdev)
 
 	if (!err)
 		netif_device_attach(netdev);
+
+unlock:
+	rtnl_unlock();
 }
 
 static const struct pci_error_handlers fm10k_err_handler = {

Jacob Keller (1):
  fm10k: prevent RCU issues during AER events

 drivers/net/ethernet/intel/fm10k/fm10k_pci.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

-- 
2.8.0.rc1.177.g5628860

