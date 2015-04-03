From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Fri,  3 Apr 2015 13:27:02 -0700
Subject: [Intel-wired-lan] [net-next 12/25] fm10k: only increment
	tx_timeout_count in Tx hang path
In-Reply-To: <1428092835-16834-1-git-send-email-jeffrey.t.kirsher@intel.com>
References: <1428092835-16834-1-git-send-email-jeffrey.t.kirsher@intel.com>
Message-ID: <1428092835-16834-12-git-send-email-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

We were incrementing the tx_timeout_count for both the Tx hang
and then for all reset flows.  Instead, we should only increment
tx_timeout_count in the Tx hang path, so that our Tx hang counter
does not increment when it was not caused by a Tx hang.

Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Acked-by: Matthew Vick <matthew.vick@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
index 0ef1d71..d7af466 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
@@ -191,7 +191,6 @@ static void fm10k_reset_subtask(struct fm10k_intfc *interface)
 	interface->flags &= ~FM10K_FLAG_RESET_REQUESTED;
 
 	netdev_err(interface->netdev, "Reset interface\n");
-	interface->tx_timeout_count++;
 
 	fm10k_reinit(interface);
 }
-- 
1.9.3

